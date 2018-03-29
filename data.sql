
INSERT INTO Customer VALUES
	('Sofia Jan',24,'j.s@mail.com'),
	('Atena Najm',39,'a.n@mail.com'),
	('Yu Chang',42,'y.c@mail.com'),
	('Ryan King',52,'r.k@mail.com'),
	('Thomas George',34,'t.g@gmail.com'),
	('Marie Smith',22,'ma.smith@mail.com'),
	('Jonah Swartz',28,'jj.swtz@mail.com'),
	('Terry Su',31,'terry.su@mail.com'),
	('David Chen',45,'dchen@mail.com'),
	('Cynthia Nguyen',27,'cyngu@mail.com'),
	('Malik Abdullah',27,'malik_aa@mail.com'),
	('John Parkinson',33,'jparki@mail.com'),
	('Stan Orlowski',26,'orlows@mail.com'),
	('Sanja Hilbert',23,'s.hilbert@mail.com'),
	('Ian Hsu',41,'shenian@mail.com');
INSERT INTO Model VALUES
	(1,'BMW X5','SUV',415,5),
	(2,'Mercedes E400','Luxury',1848,4),
	(3,'Chevrolet Spark','Economy',1521,4),
	(4,'Dodge Grand Caravan','Mini Van',2210,7),
	(5,'Chevrolet Suburban','SUV',1121,8),
	(6,'Toyota Inception','Sports',1631,2),
	(7,'Volvo V231','Economy',1737,4),
	(8,'Kia T21','Economy',1221,4);
INSERT INTO Rentalstation VALUES
	(1001,'SuperCar College','333 College St','M5T1P7','Toronto'),
	(1002,'SuperCar Billy Bishop Airport','200 Spadina Ave','M5V1A1','Toronto'),
	(1003,'SuperCar York','220 Eglinton St','M6E2G8','Toronto'),
	(1004,'SuperCar East Toronto','200 Richmond St E','M5A2P2','Toronto'),
	(1005,'SuperCar Parliament','200 Wellington St','K1A0G9','Ottawa'),
	(1006,'SuperCar Ottawa Airport','216 Airport Rd','K1V9B4','Ottawa'),
	(1007,'SuperCar Central Station','895 Rue Mansfield','H3B4G1','Montreal'),
	(1008,'SuperCar North Montreal','2351 Rue Masson','H1Y1V8','Montreal'),
	(1009,'SuperCar West Montreal','7000 Avenue Van Horne','H3S2B2','Montreal');
INSERT INTO Car VALUES
	(101,'torc566',1001,1),
	(102,'torc212',1001,8),
	(103,'torc631',1001,7),
	(104,'torc522',1001,4),
	(105,'torbb10',1002,2),
	(106,'torbb11',1002,7),
	(107,'torbb12',1002,8),
	(108,'tory011',1003,3),
	(109,'tory016',1003,4),
	(110,'tory017',1003,5),
	(111,'tore101',1004,5),
	(112,'tore102',1004,7),
	(113,'ottp111',1005,2),
	(114,'ottp112',1005,7),
	(115,'ottp113',1005,8),
	(116,'otta101',1006,1),
	(117,'otta102',1006,7),
	(118,'otta103',1006,6),
	(119,'mocs300',1007,3),
	(120,'mocs302',1007,7),
	(121,'mocs303',1007,7),
	(122,'mono201',1008,8),
	(123,'mono202',1008,4),
	(124,'mono203',1008,5),
	(125,'mowe501',1009,8),
	(126,'mowe502',1009,8),
	(127,'mowe503',1009,7),
	(128,'mowe504',1009,1);
INSERT INTO Reservation VALUES
	(22001,'2017-09-01 09:00:00','2017-09-03 17:00:00',101,NULL,'Completed'),
	(22002,'2018-03-17 16:00:00','2018-03-25 16:00:00',101,NULL,'Cancelled'),
	(22003,'2018-03-19 10:00:00','2018-03-23 20:00:00',101,22002,'Confirmed'),
	(22004,'2018-03-01 08:00:00','2018-03-10 20:00:00',101,NULL,'Ongoing'),
	(22005,'2017-12-15 13:30:00','2017-12-25 18:00:00',101,NULL,'Completed'),
	(22006,'2017-11-01 06:00:00','2017-11-04 12:00:00',102,NULL,'Completed'),
	(22007,'2018-02-23 10:00:00','2018-03-05 17:00:00',102,NULL,'Cancelled'),
	(22008,'2018-03-10 10:00:00','2018-03-16 20:00:00',102,22007,'Confirmed'),
	(22009,'2018-02-25 09:00:00','2018-03-10 21:00:00',103,NULL,'Ongoing'),
	(22010,'2017-12-09 14:00:00','2017-12-11 17:00:00',103,NULL,'Completed'),
	(22011,'2018-02-01 08:00:00','2018-02-05 16:00:00',104,NULL,'Cancelled'),
	(22012,'2017-12-25 09:00:00','2018-01-05 19:00:00',106,NULL,'Completed'),
	(22013,'2018-04-23 09:00:00','2018-05-01 14:00:00',106,NULL,'Confirmed'),
	(22014,'2018-02-19 08:00:00','2018-02-23 20:00:00',107,NULL,'Cancelled'),
	(22015,'2018-02-21 08:00:00','2018-03-10 20:00:00',107,22014,'Ongoing'),
	(22016,'2017-10-09 08:00:00','2017-10-09 21:00:00',107,NULL,'Completed'),
	(22017,'2018-06-03 07:00:00','2018-06-20 15:00:00',107,NULL,'Confirmed'),
	(22018,'2018-01-14 09:00:00','2018-01-20 14:00:00',109,NULL,'Cancelled'),
	(22019,'2018-02-01 09:00:00','2018-02-03 16:00:00',111,NULL,'Completed'),
	(22020,'2018-02-26 06:00:00','2018-03-07 12:00:00',113,NULL,'Cancelled'),
	(22021,'2018-02-28 11:00:00','2018-03-08 23:00:00',113,22020,'Ongoing'),
	(22022,'2017-07-02 09:00:00','2018-07-05 21:30:00',113,NULL,'Completed'),
	(22023,'2018-02-05 08:00:00','2018-02-08 18:00:00',114,NULL,'Completed'),
	(22024,'2018-04-02 16:00:00','2018-04-06 16:00:00',116,NULL,'Confirmed'),
	(22025,'2018-03-03 07:00:00','2018-03-15 23:30:00',116,NULL,'Ongoing'),
	(22026,'2018-01-01 07:00:00','2018-01-01 17:00:00',118,NULL,'Completed'),
	(22027,'2018-04-04 09:00:00','2018-04-06 15:00:00',119,NULL,'Cancelled'),
	(22028,'2018-02-14 13:00:00','2018-03-25 23:00:00',119,NULL,'Ongoing'),
	(22029,'2017-09-26 08:00:00','2017-10-03 20:00:00',119,NULL,'Completed'),
	(22030,'2018-03-26 10:00:00','2018-03-29 16:00:00',123,NULL,'Confirmed'),
	(22031,'2017-12-21 06:00:00','2017-12-28 22:00:00',124,NULL,'Completed'),
	(22032,'2017-09-22 16:00:00','2017-09-23 08:00:00',126,NULL,'Cancelled'),
	(22033,'2017-09-23 14:00:00','2017-09-23 17:00:00',126,22032,'Completed'),
	(22034,'2018-01-01 22:00:00','2018-04-05 14:00:00',127,NULL,'Ongoing'),
	(22035,'2017-12-07 09:00:00','2017-12-13 12:00:00',127,NULL,'Cancelled'),
	(22036,'2018-03-24 10:00:00','2018-04-02 21:00:00',128,NULL,'Confirmed'),
	(22037,'2017-09-25 09:00:00','2017-09-27 20:00:00',103,NULL,'Cancelled'),
	(22038,'2017-09-25 09:00:00','2017-09-27 20:00:00',104,22037,'Completed');
INSERT INTO Customer_Reservation VALUES
	('j.s@mail.com',22001),
	('terry.su@mail.com',22001),
	('s.hilbert@mail.com',22002),
	('s.hilbert@mail.com',22003),
	('dchen@mail.com',22004),
	('jj.swtz@mail.com',22005),
	('r.k@mail.com',22006),
	('cyngu@mail.com',22006),
	('ma.smith@mail.com',22007),
	('jparki@mail.com',22007),
	('ma.smith@mail.com',22008),
	('jparki@mail.com',22008),
	('orlows@mail.com',22009),
	('j.s@mail.com',22010),
	('malik_aa@mail.com',22011),
	('malik_aa@mail.com',22012),
	('jparki@mail.com',22013),
	('shenian@mail.com',22014),
	('shenian@mail.com',22015),
	('shenian@mail.com',22016),
	('shenian@mail.com',22017),
	('orlows@mail.com',22018),
	('t.g@gmail.com',22019),
	('t.g@gmail.com',22020),
	('t.g@gmail.com',22021),
	('orlows@mail.com',22022),
	('s.hilbert@mail.com',22023),
	('s.hilbert@mail.com',22024),
	('y.c@mail.com',22025),
	('y.c@mail.com',22026),
	('y.c@mail.com',22027),
	('cyngu@mail.com',22028),
	('dchen@mail.com',22029),
	('shenian@mail.com',22030),
	('dchen@mail.com',22030),
	('y.c@mail.com',22030),
	('t.g@gmail.com',22031),
	('malik_aa@mail.com',22032),
	('a.n@mail.com',22032),
	('malik_aa@mail.com',22033),
	('a.n@mail.com',22033),
	('terry.su@mail.com',22034),
	('jj.swtz@mail.com',22035),
	('cyngu@mail.com',22036),
	('s.hilbert@mail.com',22037),
	('s.hilbert@mail.com',22038);
