SELECT * FROM School;
SELECT * FROM Teachers;
SELECT * FROM Timetable_Teachers;
SELECT * FROM Profiles;
SELECT * FROM Profiles_Domain;
SELECT * FROM Classes;
SELECT * FROM Students;
SELECT * FROM Timetable_Class;
SELECT * FROM Buildings;
SELECT * FROM Catalogue;
SELECT * FROM Staff;
SELECT * FROM Costs;

--- Query to see all fields from all schools
SELECT DISTINCT Profile_Domain FROM Profiles_Domain;

--- Query to see all classes sorted by school id
SELECT * FROM Classes
ORDER BY id_school;

--- Add the column 'Day_Of_The_Week' to the 'Timetable Teachers' table
ALTER TABLE Timetable_Teachers ADD Day_Of_The_Week VARCHAR(30) NULL

/* Enter the days of the week in the column created above using the other 
columns that indicate which day of the week a certain teacher teaches */
UPDATE Timetable_Teachers 
SET Day_Of_The_Week= CASE	WHEN Day1=1 THEN 'Monday' 
							WHEN Day2=1 THEN 'Tuesday' 
							WHEN Day3=1 THEN 'Wednesday' 
							WHEN Day4=1 THEN 'Thursday' 
							WHEN Day5=1 THEN 'Friday' 
							ELSE NULL END

--- Information about the class to which the students from school number 1 belong
SELECT 
c.Name_Class AS [Name Class],
s.Name_Student AS [Name Student],
c.ID_School AS [ID School]
FROM Students s
JOIN Classes c
ON s.ID_Class=c.ID_Class AND c.ID_School=s.ID_School
WHERE c.ID_School='1'

--- We count how many different CNP there are in the student table
SELECT 
COUNT(DISTINCT CNP) AS [The number of different CNP]
FROM Students

--- We count how many different CNP there are in the student table
SELECT 
ID_Class AS [ID Class],
ID_School AS [ID School],
COUNT(DISTINCT CNP) AS [Distinct CNP]
FROM Students
GROUP BY ID_Class, ID_School

--- How many different phone numbers do we have in a class
SELECT 
ID_class AS [ID Class], 
ID_School AS [ID School], 
COUNT(DISTINCT Phone_Number) AS [The number of distinct phone numbers]
FROM Students
GROUP BY ID_Class,ID_School

--- We count how many phone numbers there are in the student table
SELECT 
COUNT(DISTINCT Phone_Number) AS [The number of distinct phone numbers in table Students]
FROM Students

--- We are looking for phone numbers that are repeated in the database in the student table
SELECT * FROM Students
WHERE Phone_Number in (
SELECT Phone_Number
FROM Students
GROUP BY Phone_Number
HAVING COUNT(*) >1) 

--- Who are the students of different nationality from the Romanian one in the students table
SELECT * FROM Students
WHERE Nationality_Student != 'Romanian'

--- The number of students of foreign nationality
SELECT 
COUNT(*) AS [The number of students of foreign nationality] 
FROM Students
WHERE Nationality_Student != 'Romanian'

--- How many female persons are in school number 1
SELECT 
COUNT(*) AS [The number of female persons in school number 1] 
FROM Students
WHERE Gender_Student='Woman' and ID_School=1

--- What are the names of the girls in school number 1
SELECT 
Name_Student AS [The names of the girls in school number 1] 
FROM Students
WHERE Gender_Student='Woman' and ID_School=1

--- Information about a particular student when you know the id
SELECT 
c.Name_class AS [Name Class],
s.Name_Student AS [Name Student],
c.domain_classes AS [Domain Classes],
ss.Name_School AS [Name School]
FROM students s
JOIN Classes c
ON s.ID_Class=c.ID_Class AND c.ID_School=s.ID_School
JOIN School ss
ON ss.ID_School=s.ID_School
WHERE ID_Student='539'

--- Information about the teachers' schedule
SELECT 
T.Name_Teacher AS [Name Teacher],
C.Name_Class AS [Name Class],
T.Domain,
TT.ID_School AS [ID School],
TT.ID_Teacher AS [ID Teacher],
TT.Hours_Intervals AS [Hours Intervals],
TT.Day1 AS Monday,
TT.Day2 AS Tuesday,
TT.Day3 AS Wednesday,
TT.Day4 AS Thursday,
TT.Day5 AS Friday
FROM Teachers T
JOIN Timetable_Teachers TT
ON TT.ID_Teacher=T.ID_Teacher AND T.ID_School=TT.ID_School
JOIN Classes C
ON C.ID_Class=TT.ID_Class AND C.ID_School=TT.ID_School

--- Information about a particular student when you know the name
SELECT 
s.Name_Student AS [Name Student],
s.Address_Student AS [Address Student],
c.Domain_Classes AS [Domain Classes],
c.Name_Class AS [Name Class],
ss.Name_School AS [Name School]
FROM Students s
JOIN Classes c
ON s.ID_School=c.ID_School AND s.ID_Class=c.ID_Class
JOIN School ss
ON ss.ID_School=s.ID_School
WHERE Name_Student= 'Smoleac Emilian'

--- Student's Romanian language and literature notes
SELECT 
s.Name_Student AS [Name Student],
c.DATE_Note_Romanian_Language_and_Literature_Note AS [The date on which the note was registered],
c.Romanian_Language_and_Literature_Note_Thesis AS [Thesis on Romanian language and literature],
c.Romanian_Language_and_Literature_Note AS [Notes on the Romanian language and literature],
c.Romanian_Language_and_Literature_Absences AS [Absences in the Romanian language and literature]--- Every absence registered until the date when the last grade was registered
FROM Catalogue C
JOIN Students S
ON S.ID_Student= C.ID_Student
WHERE DATE_Note_Romanian_Language_and_Literature_Note IS NOT NULL AND c.ID_Student=16

--- The first formulas from which we started the process of creating the semiannual and annual average
SELECT (AVG(Romanian_Language_and_Literature_Note)*3+y)/4 FROM Catalogue
WHERE ID_Student=11 and DATE_Note_Romanian_Language_and_Literature_Note >='02-01-2012'

SELECT (AVG(Romanian_Language_and_Literature_Note)*3+y)/4 FROM Catalogue
WHERE ID_Student=11 and DATE_Note_Romanian_Language_and_Literature_Note <='02-01-2012'

--- The first formulas for calculating the semester average for each semester separately
SELECT (3*[Avg Note] + [Avg Thesis])/4 AS [Avg Per Semester 1] 
FROM (SELECT 
AVG(Romanian_Language_and_Literature_Note) as [Avg Note], 
AVG(Romanian_Language_and_Literature_Note_Thesis) as [Avg Thesis]
FROM Catalogue
WHERE id_student =10 AND DATE_Note_Romanian_Language_and_Literature_Note >='02-01-2012') AS [Formula For Semester 1]  


SELECT (3*[Avg Note] + [Avg Thesis])/4 AS [Avg Per Semester 2] 
FROM( 
SELECT 
AVG(Romanian_Language_and_Literature_Note) AS [Avg Note], 
AVG(Romanian_Language_and_Literature_Note_Thesis) AS [Avg Thesis]
FROM Catalogue
WHERE id_student =11 and DATE_Note_Romanian_Language_and_Literature_Note <='02-01-2012')as [Formula For Semester 2]  

--- I created the table with the 2 final averages for each semester
SELECT 'Semester 1' AS [Semester], (3*[Avg Note] + [Avg Thesis])/4 AS [Final Grade]
FROM (
  SELECT 
    AVG(Romanian_Language_and_Literature_Note) AS [Avg Note], 
    AVG(Romanian_Language_and_Literature_Note_Thesis) AS [Avg Thesis]
  FROM Catalogue
  WHERE id_student = 11 AND DATE_Note_Romanian_Language_and_Literature_Note >= '2012-02-01'
) AS [Formula For Semester 1]  
UNION
SELECT 'Semester 2' AS [Semester], (3*[Avg Note] + [Avg Thesis])/4/4 AS [Final Grade]
FROM (
  SELECT 
    AVG(Romanian_Language_and_Literature_Note) AS [Avg Note], 
    AVG(Romanian_Language_and_Literature_Note_Thesis) AS [Avg Thesis] 
  FROM Catalogue
  WHERE id_student = 11 AND DATE_Note_Romanian_Language_and_Literature_Note <= '2012-02-01'
) AS [Formula For Semester 2]


--- With the help of the previous formulas, we calculated the average for the whole year in the Romanian language and literature
SELECT AVG([Avg Per Semester]) AS [Avg Per Year]
FROM (
  SELECT (3*[Avg Note] + [Avg Thesis])/4 AS  [Avg Per Semester] 
  FROM (
    SELECT 
      AVG(Romanian_Language_and_Literature_Note) AS [Avg Note], 
      AVG(Romanian_Language_and_Literature_Note_Thesis) AS [Avg Thesis]
    FROM Catalogue
    WHERE id_student = 22 AND DATE_Note_Romanian_Language_and_Literature_Note >= '2012-02-01'
  ) AS [Formula For Semester 1]  
UNION
  SELECT (3*[Avg Note] + [Avg Thesis])/4 AS [Avg Per Semester]
  FROM (
    SELECT 
      AVG(Romanian_Language_and_Literature_Note) AS [Avg Note], 
      AVG(Romanian_Language_and_Literature_Note_Thesis) AS [Avg Thesis]
    FROM Catalogue
    WHERE id_student = 22 AND DATE_Note_Romanian_Language_and_Literature_Note <= '2012-02-01'
  ) AS [Formula For Semester 2]
 ) AS [Formula Per Year]

--- We are looking for the name and phone number of the teacher who has the student with ID 11 as a student
SELECT DISTINCT
ST.Name_Student as [Name Student], 
C.Name_Class as [Name Class], 
T.Name_Teacher as [Name Teacher], 
T.Domain as [Domain Professor],
T.Phone_Number as [Phone Number]
FROM School S
JOIN Timetable_Teachers TT
ON TT.ID_School=S.ID_School
JOIN Teachers T
ON T.ID_School=S.ID_School AND T.ID_Teacher=TT.ID_Teacher
JOIN Classes C
ON C.ID_School=S.ID_School
JOIN Students ST
ON ST.ID_Class=C.ID_Class AND ST.ID_School=S.ID_School
WHERE TT.ID_Class=1 AND ID_Student=11

--- We use this query to be able to see in which tables the primary key from the School table is referred
--- dbo.School is referenced by dbo.Buildings, dbo.Classes, dbo.Profiles_Domain, dbo.Staff and dbo.Teachers
EXEC sp_fkeys @pktable_name = N'School'  
    ,@pktable_owner = N'dbo'; 

--- We use this query to be able to see which are the foreign keys in the Catalogue table
--- dbo.Catalogue is referenced by dbo.Classes and dbo.Students
EXEC sp_fkeys @fktable_name = N'Catalogue'  
    ,@fktable_owner = N'dbo'; 

CREATE or ALTER VIEW vRomanian_Language_and_Literature_Notes as
SELECT 
s.Name_Student AS [Name Student],
c.ID_Class AS [Nr Class],
c.Romanian_Language_and_Literature_Note_Thesis AS [Thesis on Romanian language and literature],
c.Romanian_Language_and_Literature_Note AS [Notes on the Romanian language and literature],
c.Romanian_Language_and_Literature_Absences AS [Absences in the Romanian language and literature]--- Every absence registered until the date when the last grade was registered
FROM Catalogue C
JOIN Students S
ON S.ID_Student= C.ID_Student
WHERE DATE_Note_Romanian_Language_and_Literature_Note IS NOT NULL AND DATE_Note_Romanian_Language_and_Literature_Note <= '2012-02-01'

/* With this function we can find, depending on the teacher's ID and the class where he teaches,
the time intervals in which he teaches and on which days*/
CREATE OR ALTER FUNCTION dbo.HoursIntervals (@IDTeacher INT, @IDClass INT)
RETURNS TABLE
AS
RETURN
SELECT 
C.Name_Class AS [Name Class],
TT.Hours_Intervals AS [Hours Intervals],
T.Name_Teacher AS [Name Teacher],
T.Domain,
TT.Day_Of_The_Week AS [Day Of The Week]
FROM Timetable_Teachers AS TT
JOIN Teachers T
ON T.ID_Teacher=TT.ID_Teacher AND T.ID_School=TT.ID_School
JOIN Classes C
ON C.ID_Class= TT.ID_Class AND C.ID_School=TT.ID_School
WHERE TT.ID_Teacher=@IDTeacher AND TT.ID_Class=@IDClass

SELECT * FROM dbo.HoursIntervals (1,1)

/*This while creates a table where the student's ID, the grade it has and the result (pass or fail) are inserted,
it calculates the average for each student in class 1 (grades 1,2,3...,15) in the language and Romanian literature*/
DECLARE @Table_Results TABLE (ID_Stundet INT,Note DECIMAL(4,2), Result VARCHAR(10))
DECLARE @AVG_Per_Semester_1 DECIMAL(4,2)
DECLARE @ID_Student INT = 0
DECLARE @Note DECIMAL(4,2)
DECLARE @Rezult_Pozitive VARCHAR(10)='PASSED'
DECLARE @Rezult_Negative VARCHAR(10)='REJECTED'
WHILE @ID_Student<=14
BEGIN
SET @ID_Student=@ID_Student+1
SET @Note=5.00
SET @AVG_Per_Semester_1=(SELECT (3*[Avg Note] + [Avg Thesis])/4 AS [Avg Per Semester 1] 
FROM (SELECT 
AVG(Romanian_Language_and_Literature_Note) as [Avg Note], 
AVG(Romanian_Language_and_Literature_Note_Thesis) as [Avg Thesis]
FROM Catalogue C
WHERE C.ID_Student=@ID_Student AND DATE_Note_Romanian_Language_and_Literature_Note >='02-01-2012') AS [Formula For Semester 1])
IF 
@Note < @AVG_Per_Semester_1
INSERT INTO @Table_Results (ID_Stundet,Note, Result)
VALUES (@ID_Student,@AVG_Per_Semester_1,@Rezult_Pozitive)
ELSE
INSERT INTO @Table_Results (ID_Stundet,Note, Result)
VALUES (@ID_Student,@AVG_Per_Semester_1,@Rezult_Negative)
END

SELECT * FROM @Table_Results


--- function/while/create procedure/tranzactii