-- Base data
INSERT INTO Majors VALUES
(1,'CS'),
(2,'EE'),
(3,'Math');

INSERT INTO Students VALUES
(1001,'Alice',20,3.90,1),
(1002,'alan',22,3.50,1),
(1003,'Bob',19,3.20,2),
(1004,'cara',21,3.70,2),
(1005,'DAVe',23,2.80,1),
(1006,'Sara',20,3.60,3),
(1007,'Kevin',24,3.60,3),
(1008,'Peter Parker',20,3.95,1),
(1009,'Dr. John',30,3.10,2),
(1010,'AL',18,3.40,3);

INSERT INTO Courses VALUES
(200,'DBMS','CS',3),
(201,'AI','CS',3),
(202,'Circuits','EE',4),
(203,'Calculus','MATH',4);

INSERT INTO Enrollment VALUES
(1001,200,'2026S','A'),
(1001,201,'2026S','A-'),
(1002,200,'2026S','B+'),
(1003,202,'2026S','B'),
(1004,202,'2026S','A'),
(1004,200,'2026S','B'),
(1005,201,'2026S','C+'),
(1006,203,'2026S','A-'),
(1007,203,'2026S','B+'),
(1007,200,'2026S','A'),
(1008,200,'2026S','A'),
(1009,202,'2026S','B-'),
(1010,203,'2026S','B');

INSERT INTO Drivers VALUES
(1,'Alan',6,25,'East'),
(2,'Bob',8,30,'East'),
(3,'Cara',12,45,'West'),
(4,'Dave',30,55,'West'),
(5,'Alan',8,30,'East'),
(6,'John',1,18,'West'),
(7,'Sara',12,55,'East'),
(8,'Kevin',6,22,'East'),
(9,'Peter',12,46,'West');

INSERT INTO Cars VALUES
(10,'Sedan'),
(20,'SUV'),
(30,'Truck');

INSERT INTO Reserves VALUES
(1,20,'2025-09-01'),
(2,20,'2025-09-02'),
(2,10,'2025-10-01'),
(3,30,'2025-09-05'),
(5,20,'2025-11-11'),
(8,20,'2025-09-21'),
(8,10,'2024-12-31'),
(7,10,'2025-05-05');

INSERT INTO Sales VALUES
('East','Apple',100),
('East','Apple',150),
('East','Orange',200),
('West','Apple',120),
('West','Orange',180);
