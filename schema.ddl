--schema for storing car rental service database
-----------------------------------------------------------------------------
-- Document DDL choice
-- 1. What constrain from the domain could not be enforced
--       1) A car cannot be rented more than one time during a rental period. However, we cannot compare
--          a tuple that we want to insert with all the inserted data in the semi-complete relation with CHECK.
--          In another word, we can't make sure a car is available.
--       2) The requirement that a reservation can only be editted once cannot be enforced with the current ddl design. 
--          We can know that if a reservation is being changed by checking if the old_reservation attribute is NULL or not.
--          A possible way to impletement this function is to have an additional attribute to state the elligibility for
--          changing the reservation.
--       3) Area code, license plate should have special letter and number combination format. Random or incorrect format 
--          should not be accepted when inserting into the database. However, this cannot be achieved with CHECK in that it 
--          may require the use of conventional languages to parse.
--
--
-- 2. What constraints that could have been enforced were not enforced? Why not?
--       1) Age constrain of customer, a person has to be 17 years or older to get a G level driver's liscence in Canada and to rent a car.
--          However, different country has different age limit in term of getting a driver's liscence and renting a car. Therefore, we can't
--          have a specific age limit in this case.
--       2) Check number of shared reservation does not exists car capacity. However, number of shared customer does not
--          represents the true number of people inside the car.
--       3) Check customer have valid driver's liscence in order to rent a car, and the driver's lisence number can be used as a key in Customer
--          relation. However, we do not have the information in customer's driver's lisence.
--
-----------------------------------------------------------------------------
-- path set up and schema creation
DROP SCHEMA IF EXISTS carschema CASCADE;
CREATE SCHEMA carschema;
SET SEARCH_PATH TO carschema;

-----------------------------------------------------------------------------
CREATE TABLE Customer(
  name VARCHAR(100) NOT NULL,
  age INT NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE
);

-- for each model number, there can be multiple number of cars all having the same name, 
-- type and capacity
CREATE TABLE Model(
  id INT primary key,
  name VARCHAR(50) NOT NULL UNIQUE,
  vehicle_type VARCHAR(50) NOT NULL,
  model_number INT NOT NULL,
  capacity INT NOT NULL,
  UNIQUE(name, vehicle_type, model_number, capacity)
);

CREATE TABLE Rentalstation(
  station_code INT primary key,
  name VARCHAR(50) NOT NULL,
  address VARCHAR(100) NOT NULL,
  area_code VARCHAR(6) NOT NULL,
  city VARCHAR(50) NOT NULL
);

-- every car corresponse to a single rental station (need confirmation)
-- every car only have one liscense plate, station code and model id (need to implement)
CREATE TABLE Car(
  id INT primary key,
  license_plate VARCHAR(7) NOT NULL UNIQUE,
  station_code INT REFERENCES Rentalstation(station_code),
  model_id INT REFERENCES Model(id)
);

CREATE TYPE reservation_status AS ENUM(
	'Completed', 'Ongoing', 'Confirmed', 'Cancelled');

-- each reservation involves exactly one car (need confirmation)
CREATE TABLE Reservation(
  id INT primary key,
  from_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP NOT NULL,
  car_id INT REFERENCES Car(ID),
  old_reservation INT REFERENCES Reservation(id) DEFAULT NULL,
  status reservation_status NOT NULL,
  CHECK (end_date > from_date)
);

-- assume one customer per reservation, BUT it is valid to have multiple customer for same reservation
CREATE TABLE Customer_Reservation(
  customer_email VARCHAR(100) REFERENCES Customer(email),
  reservation_id INT REFERENCES Reservation(id)
);