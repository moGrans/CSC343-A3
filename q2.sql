-- Find the top 2 customers who rent cars with driver(s) most frequently.
SET SEARCH_PATH TO carschema;
DROP TABLE IF EXISTS q2 CASCADE;

-- Final relation for answer 
create table q2(
name VARCHAR(100),
email VARCHAR(100),
num_share_reservation INTEGER
);

-- Define views for your intermediate steps here.
--------------------------------------------------------------------------
--------------------------	Intermediate steps	--------------------------
--------------------------------------------------------------------------
-- idea for this question:
--		1. Find all valid reservation (not cancel)
--		2. Determine which of these are shared with multiple customer
--      3. Find number of shared reservation for customers who has valid shared reservation
--      4. Find top 2 count among customers found in step 3		
--------------------------------------------------------------------------
-- Find all valid reservation (not cancel) which is total number of reservation that are NOT cancelled
DROP VIEW IF EXISTS valid_resv CASCADE;
CREATE VIEW valid_resv AS
    SELECT cr.customer_email, cr.reservation_id
    FROM Reservation r JOIN Customer_Reservation cr
            ON r.id = cr.reservation_id
    WHERE r.status <> 'Cancelled';

--------------------------------------------------------------------------
-- Determine which of these are shared with multiple customer
DROP VIEW IF EXISTS shared_resv CASCADE;
CREATE VIEW shared_resv AS
    SELECT reservation_id
    FROM valid_resv
    GROUP BY reservation_id
    HAVING count(customer_email) > 1;

--------------------------------------------------------------------------
-- Find number of shared reservation for customers who has valid shared reservation
DROP VIEW IF EXISTS num_shared CASCADE;
CREATE VIEW num_shared AS
    SELECT vr.customer_email, count(vr.reservation_id) AS num_share_reservation
    FROM shared_resv sv JOIN valid_resv vr
            ON sv.reservation_id = vr.reservation_id
    GROUP BY vr.customer_email;

--------------------------------------------------------------------------
-- -- Find top 2 count among customers found in previous step

-- -- find customers with most count
-- DROP VIEW IF EXISTS most_count CASCADE;
-- CREATE VIEW most_count AS
--     SELECT ns.email, ns.num_share_reservation
--     FROM num_shared ns JOIN (SELECT max(num_share_reservation) AS max_count FROM num_shared) top
--             ON ns.num_share_reservation = top.max_count;

-- -- num shared without max count
-- DROP VIEW IF EXISTS no_top CASCADE;
-- CREATE VIEW no_top AS
--     (SELECT *
--     FROM num_shared)
--     EXCEPT
--     (SELECT *
--     FROM most_count);

-- -- find customers with second highest count
-- DROP VIEW IF EXISTS second_count CASCADE;
-- CREATE VIEW second_count AS
--     SELECT ns.email, ns.num_share_reservation
--     FROM num_shared ns JOIN (SELECT max(num_share_reservation) AS sec_count FROM no_top) second
--             ON ns.num_share_reservation = second.sec_count;

-- -- join top and second highest results
-- DROP VIEW IF EXISTS top_two CASCADE;
-- CREATE VIEW top_two AS 
--     (SELECT *
--     FROM most_count)
--     UNION
--     (SELECT *
--     FROM second_count);


--------------------------------------------------------------------------
----------------------- End of Intermediate Steps ------------------------
--------------------------------------------------------------------------

-- the answer to the query 
INSERT INTO q2 
	SELECT c.name, c.email, ns.num_share_reservation
	FROM num_shared ns JOIN Customer c
            ON ns.customer_email = c.email
    ORDER BY ns.num_share_reservation DESC, c.email
    LIMIT 2;