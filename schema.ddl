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
CREATE SCHEMA CARSCHEMA;
SET SEARCH_PATH TO carschema;

-----------------------------------------------------------------------------
CREATE TABLE Customer(
  Name VARCHAR(100) NOT NULL,
  Age INT NOT NULL,
  Email VARCHAR(100) NOT NULL
);

-- for each model number, there can be multiple number of cars all having the same name, type and capacity
CREATE TABLE Model(
  ID INT primary key,
  Name VARCHAR(50) NOT NULL UNIQUE,
  Vehicle_Type VARCHAR(50) NOT NULL,
  Model_Number INT NOT NULL,
  Capacity INT NOT NULL,
  UNIQUE(Name, Vehicle_Type, Model_Number, Capacity)
);

CREATE TABLE Rentalstation(
  Station_Code INT primary key,
  Name VARCHAR(50) NOT NULL,
  Address VARCHAR(100) NOT NULL,
  Area_Code VARCHAR(6) NOT NULL,
  City VARCHAR(50) NOT NULL,
);

-- every car corresponse to a single rental station (need confirmation)
-- every car only have one liscense plate, station code and model id (need to implement)
CREATE TABLE Car(
  ID INT primary key,
  License_Plate VARCHAR(7) NOT NULL UNIQUE,
  Station_Code INT REFERENCES Rentalstation(Station_Code),
  Model_ID INT REFERENCES Model(ID)
);

CREATE TYPE reservation_status AS ENUM(
	'Completed', 'Ongoing', 'Confirmed', 'Cancelled');

-- each reservation involves exactly one car (need confirmation)
CREATE TABLE Reservation(
  ID INT primary key,
  From TIMESTAMP NOT NULL,
  To TIMESTAMP NOT NULL,
  Car_ID INT REFERENCES Car(ID),
  Old_Reservation INT REFERENCES Reservation(ID) DEFAULT NULL,
  Status reservation_status NOT NULL
);

-- assume one customer per reservation, BUT it is valid to have multiple customer for same reservation
CREATE TABLE Customer_Reservation(
  Customer_Email VARCHAR(100) REFERENCES Customer(Email),
  Reservation_ID INT REFERENCES Reservation(ID),
);