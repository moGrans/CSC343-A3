-- Find the list of all customers younger than 30 years old who changed at least 2 reservations in the past 18 months. 
-- Note: You’re required to return a list of customer IDs.
SET SEARCH_PATH TO carschema;
DROP TABLE IF EXISTS q4 CASCADE;

-- Final relation for answer 
create table q4(
customer_email VARCHAR(100)
);

--------------------------------------------------------------------------
--------------------------	Intermediate steps	--------------------------
--------------------------------------------------------------------------
-- idea for this question:
--		1. Find reservation that was changed in past 18 months 
--		2. Organize these reservation according to customers and filter to find one's who changed at least 2 times
--      3. Find which of the customers found from previous steps are younger than 30 years old
--------------------------------------------------------------------------
-- Find reservation that was changed in past 18 months
DROP VIEW IF EXISTS changed_resv CASCADE;
CREATE VIEW changed_resv AS
	SELECT *
	FROM Reserveration
	WHERE from_date < current_timestamp() AND from_date > (current_timestamp() - (interval '1 day' * 540)) AND old_reservation <> NULL;

--------------------------------------------------------------------------
-- Organize these reservation according to customers and filter to find one's who changed at least 2 times
DROP VIEW IF EXISTS changed_customer CASCADE;
CREATE VIEW changed_customer AS
	SELECT cu.customer_email, count(cu.reservation_id) as num_changed
	FROM changed_resv ch JOIN Customer_Reservation cu
			ON ch.id = cu.reservation_id
	GROUP BY cu.customer_email
	HAVING count(cu.reservation_id) > 1;


--------------------------------------------------------------------------
-- Find which of the customers found from previous steps are younger than 30 years old
DROP VIEW IF EXISTS changed_customer_thirty CASCADE;
CREATE VIEW changed_customer_thirty AS
	SELECT cc.customer_email
	FROM changed_customer cc JOIN Customer c
			ON cc.customer_email = c.email AND c.age < 30;

--------------------------------------------------------------------------
----------------------- End of Intermediate Steps ------------------------
--------------------------------------------------------------------------

-- the answer to the query 
INSERT INTO q4
	SELECT *
	FROM changed_customer_thirty;









