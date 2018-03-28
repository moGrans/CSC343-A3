--schema for storing car rental service database
-----------------------------------------------------------------------------
-- Document DDL choice
-- 1. What constrain from the domain could not be enforced
--
--
-- 2. What constraints that could have been enforced were not enforced? Why not?
--
--
--

-----------------------------------------------------------------------------

DROP SCHEMA IF EXISTS carschema CASCADE;
CREATE SCHEMA carschema;
SET SEARCH_PATH TO carschema;

-----------------------------------------------------------------------------
CREATE TABLE Customer(
  name VARCHAR(100) NOT NULL,
  age INT NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE
);

-- for each model number, there can be multiple number of cars all having the same name, type and capacity
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
  city VARCHAR(50) NOT NULL,
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
  reservation_id INT REFERENCES Reservation(id),
);