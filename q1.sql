-- Find the top 2 customers with the highest reservation cancellation ratio
SET SEARCH_PATH TO carschema;
DROP TABLE IF EXISTS q1 CASCADE;

-- Final relation for answer 
create table q1(
name VARCHAR(100),
email VARCHAR(100),
cancel_ratio INTEGER
);

-- Define views for your intermediate steps here.
--------------------------------------------------------------------------
--------------------------	Intermediate steps	--------------------------
--------------------------------------------------------------------------
-- idea for this question:
--		1. Find number of times these customer each cancelled a reservation
--		2. Compute cancellation ratio for each customer
--      3. Find top two 				
--------------------------------------------------------------------------
-- Find number of reservation that a customer have cancelled
DROP VIEW IF EXISTS customer_cancellation CASCADE;
CREATE VIEW customer_cancellation AS
    SELECT c.email, count(c.reservation_id) AS num_cancel
    FROM Reservation r JOIN Customer_Reservation cr
            ON r.id = cr.reservation_id
    WHERE r.status = 'Cancelled'
    GROUP BY c.email;

--------------------------------------------------------------------------
-- Compute cancellation ratio

-- find total number of reservation that are NOT cancelled for each customer
DROP VIEW IF EXISTS customer_resv CASCADE;
CREATE VIEW customer_resv AS
    SELECT cr.email, count(c.reservation_id) AS num_resv
    FROM Reservation r JOIN Customer_Reservation cr
            ON r.id = cr.reservation_id
    WHERE r.status <> 'Cancelled'
    GROUP BY cr.email;

-- find cancellation ratio for all customer who has cancelled a reservation before
-- NOTE: 1. customer who have never cancelled a reservation will not be included in this table, because ratio is 0
--       2. customer who have only reserved cancelled reservation will not be included in this table
DROP VIEW IF EXISTS cancel_ratio_pseudo CASCADE;
CREATE VIEW cancel_ratio_pseudo AS
    SELECT cr.email, (cc.num_resv / cr.num_resv) AS cancel_ratio
    FROM customer_resv cr JOIN customer_cancellation cc
            ON cr.email = cc.email;

-- handle case where a certain customer has only cancelled reservations in the system
DROP VIEW IF EXISTS only_cancel CASCADE;
CREATE VIEW only_cancel AS
    (SELECT c.email FROM customer_cancellation)
    EXCEPT
    (SELECT c.email FROM customer_resv);

-- final cancellation ratio
DROP VIEW IF EXISTS cancel_ratio CASCADE;
CREATE VIEW cancel_ratio AS
    (SELECT oc.email, cc.num_cancel AS cancel_ratio
    FROM only_cancel oc JOIN customer_cancellation cc
            ON oc.email = cc.email)
    UNION
    (SELECT *
    FROM cancel_ratio);

--------------------------------------------------------------------------
-- Find top 2 customers

-- find customers with highest ratios
DROP VIEW IF EXISTS top_cancel CASCADE;
CREATE VIEW top_cancel AS
    SELECT cr.email, cr.cancel_ratio
    FROM cancel_ratio cr JOIN (SELECT max(cancel_ratio) AS top_ratio FROM cancel_ratio) top
            ON cr.cancel_ratio = top.top_ratio;

-- cancellation ratios without top ratios
DROP VIEW IF EXISTS no_top CASCADE;
CREATE VIEW no_top AS
    (SELECT *
    FROM cancel_ratio)
    EXCEPT
    (SELECT *
    FROM top_cancel);

-- find customers with second highest ratios
DROP VIEW IF EXISTS second_cancel CASCADE;
CREATE VIEW second_cancel AS
    SELECT cr.email, cr.cancel_ratio
    FROM cancel_ratio cr JOIN (SELECT max(cancel_ratio) AS second_ratio FROM no_top) second
            ON cr.cancel_ratio = second.second_ratio;

-- join top and second highest results
DROP VIEW IF EXISTS top_two CASCADE;
CREATE VIEW top_two AS 
    (SELECT *
    FROM top_cancel)
    UNION
    (SELECT *
    FROM second_cancel);

 
--------------------------------------------------------------------------
----------------------- End of Intermediate Steps ------------------------
--------------------------------------------------------------------------

-- the answer to the query 
INSERT INTO q1 
	SELECT c.name, c.email, tt.cancel_ratio
	FROM top_two tt join Customer c
            ON tt.email = c.email
    ORDER BY tt.ratio_number [DESC], c.email;