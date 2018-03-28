-- Find the most frequently rented car model in Toronto, where the reservation started and was fully completed in the year 2017.
SET SEARCH_PATH TO carschema;
DROP TABLE IF EXISTS q3 CASCADE;

-- Final relation for answer 
create table q3(
name VARCHAR(50),
model_number INT
);

-- Define views for your intermediate steps here.
--------------------------------------------------------------------------
--------------------------	Intermediate steps	--------------------------
--------------------------------------------------------------------------
-- idea for this question:
--		1. Find reservation fully completed in 2017 (status = completed)
--		2. Filter car's rental stationlocation to Toronto
--      3. 
--      4. 	
--------------------------------------------------------------------------























-- 
-- You should order by the total number of times the car model was rented (descending) and model name (ascending).
 