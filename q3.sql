-- Find the most frequently rented car model in Toronto, where the reservation started and was fully completed in the year 2017.
SET SEARCH_PATH TO carschema;
DROP TABLE IF EXISTS q3 CASCADE;

-- Final relation for answer 
create table q3(
model_name VARCHAR(50),
num_rented INT
);

-- Define views for your intermediate steps here.
--------------------------------------------------------------------------
--------------------------	Intermediate steps	--------------------------
--------------------------------------------------------------------------
-- idea for this question:
--		1. Find reservation fully completed in 2017 (status = completed)
--		2. Find all car model that car's rental station location to Toronto
--      3. Find most frequently rented car model
--------------------------------------------------------------------------
-- Find reservation fully completed in 2017 (status = completed)
DROP VIEW IF EXISTS valid_resv CASCADE;
CREATE VIEW valid_resv AS
    SELECT id AS reservation_id, car_id
    FROM Reservation
    WHERE status = 'Completed' AND from_date > TIMESTAMP '2017-01-01 00:00:00' AND end_date < TIMESTAMP '2017-12-31 23:59:59';

--------------------------------------------------------------------------
-- Filter car's rental station location to Toronto
DROP VIEW IF EXISTS yyz_resv CASCADE;
CREATE VIEW yyz_resv AS
    SELECT c.id, c.model_id, vr.reservation_id
    FROM valid_resv vr JOIN Car c
            ON vr.car_id = c.id
        JOIN Rentalstation r 
            ON c.station_code = r.station_code
    WHERE r.city = 'Toronto';

--------------------------------------------------------------------------
-- Find frequency of rented car model
DROP VIEW IF EXISTS yyz_model CASCADE;
CREATE VIEW yyz_model AS
    SELECT model_id, COUNT(reservation_id) AS num_rent
    FROM yyz_resv
    GROUP BY model_id;

DROP VIEW IF EXISTS popular_model CASCADE;
CREATE VIEW popular_model AS
    SELECT yyz.model_id, yyz.num_rent
    FROM yyz_model yyz JOIN (SELECT max(num_rent) AS most_popular FROM yyz_model) popular
            ON yyz.num_rent = popular.most_popular;
--------------------------------------------------------------------------
----------------------- End of Intermediate Steps ------------------------
--------------------------------------------------------------------------

-- the answer to the query 
INSERT INTO q3
	SELECT m.name AS model_name, pm.num_rent AS num_rented
	FROM popular_model pm JOIN Model m
            ON pm.model_id = m.id
    ORDER BY pm.num_rent DESC, m.name
    LIMIT 1;