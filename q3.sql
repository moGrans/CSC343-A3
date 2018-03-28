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
    WHERE status = 'Completed' AND from_date > TIMESTAMP '2017-01-01 00:00:00' AND end_date < TIMESTAMP '2017-12-31-23:59:59';

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
-- Find most frequently rented car model
DROP VIEW IF EXISTS yyz_model CASCADE;
CREATE VIEW yyz_model AS
    SELECT model_id, MAX(COUNT(reservation_id)) AS num_rent
    FROM yyz_resv
    GROUP BY model_id;

--------------------------------------------------------------------------
----------------------- End of Intermediate Steps ------------------------
--------------------------------------------------------------------------

-- the answer to the query 
INSERT INTO q3
	SELECT m.name AS model_name, yyzm.num_rent AS num_rented
	FROM yyz_model yyzm JOIN Model m
            ON yyzm.model_id = m.model_id
    ORDER BY yyzm.num_rent [DESC], m.name;




















-- 
-- You should order by the total number of times the car model was rented (descending) and model name (ascending).
 