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
--
-- 2. What constraints that could have been enforced were not enforced? Why not?
--       1) Age constrain of customer, a person has to be 17 years or older to get a G level driver's liscence in Canada and to rent a car.
--          However, different country has different age limit in term of getting a driver's liscence and renting a car. Therefore, we can't
--          have a specific age limit in this case.
--       2) Check number of shared reservation does not exists car capacity. However, number of shared customer does not
--          represents the true number of people inside the car. In addition, this may require the use of trigger or assertion since it is
--          cross relation constraint.
--       3) Check customer have valid driver's liscence in order to rent a car, and the driver's lisence number can be used as a key in Customer
--          relation. However, we do not have the information in customer's driver's lisence.
--       4) Validity of the inserted city name. area code and address cannot be confirmed in this domain, since there is no
--          database information about geographic locations.
--
-----------------------------------------------------------------------------
-- path set up and schema creation
DROP SCHEMA IF EXISTS carschema CASCADE;
CREATE SCHEMA carschema;
SET SEARCH_PATH TO carschema;

-----------------------------------------------------------------------------
-- this relation records all the customers that is registered for this car rental service
CREATE TABLE Customer(
  -- full name of customer
  name VARCHAR(100) NOT NULL,
  -- customer's age
  age INT NOT NULL,
  -- customer's email address
  email VARCHAR(100) NOT NULL UNIQUE
);

-- this relation records all the car model in all rental stations.
-- for each model number, there can be multiple number of cars all having the same name, 
-- type and capacity
CREATE TABLE Model(
  -- model's id given for by this rental service company
  id INT primary key,
  -- model's name
  name VARCHAR(50) NOT NULL UNIQUE,
  -- model's vehicle type
  vehicle_type VARCHAR(50) NOT NULL,
  -- model number
  model_number INT NOT NULL,
  -- number of passengers that can be in the car
  capacity INT NOT NULL,
  -- avoid multiple inseration of same model in the system
  UNIQUE(name, vehicle_type, model_number, capacity)
);

-- this relation records all the rental station.
CREATE TABLE Rentalstation(
  -- station code number given by this rental service company
  station_code INT primary key,
  -- name of the rental station
  name VARCHAR(50) NOT NULL,
  -- address of the rental station
  address VARCHAR(100) NOT NULL,
  -- area code of the rental station
  area_code VARCHAR(6) NOT NULL,
  -- city that this rental station is located at
  city VARCHAR(50) NOT NULL
);

-- this relation records all the car available in this rental service company.
-- every car corresponse to a single rental station
-- every car only have one liscense plate, station code and model id
CREATE TABLE Car(
  -- car id given by this rental service company
  id INT primary key,
  -- licens plate number of this car
  license_plate VARCHAR(7) NOT NULL UNIQUE,
  -- rental station that this car can be picked up and dropped off
  station_code INT REFERENCES Rentalstation(station_code),
  -- car's model id
  model_id INT REFERENCES Model(id)
);

-- type of status of a rented car
CREATE TYPE reservation_status AS ENUM(
	'Completed', 'Ongoing', 'Confirmed', 'Cancelled');

-- this relation records all the reservations in this rental service company.
-- each reservation involves exactly one car
CREATE TABLE Reservation(
  -- reservation number
  id INT primary key,
  -- state date of the reservation
  from_date TIMESTAMP NOT NULL,
  -- end date of the reservation
  end_date TIMESTAMP NOT NULL,
  -- car involves with this reservation
  car_id INT REFERENCES Car(ID),
  -- if a reservation is changed, the original reservation id is considered as old reservation
  old_reservation INT REFERENCES Reservation(id) DEFAULT NULL,
  -- status of this reservation
  status reservation_status NOT NULL,
  -- when inserting data, end date must come after the start date
  CHECK (end_date > from_date)
);

-- this relation records which customer reserved a reservation.
-- assume one customer per reservation, BUT it is valid to have multiple customer for same reservation
CREATE TABLE Customer_Reservation(
  -- customer's email
  customer_email VARCHAR(100) REFERENCES Customer(email),
  -- corresponding reservation id number
  reservation_id INT REFERENCES Reservation(id)
);