CREATE TABLE School (
	ID_School INT NOT NULL CONSTRAINT pk_School PRIMARY KEY,
	Name_School VARCHAR(50) NULL,
	Year_of_establishment DATE NULL,
	Nr_Buildings NUMERIC(10) NULL,
	Nr_Sport_Base NUMERIC(10) NULL
);
GO
CREATE TABLE Teachers (
	ID_Teacher INT NOT NULL,
	ID_School INT NOT NULL CONSTRAINT fk_SchoolTeacher REFERENCES School(ID_School),
	Name_Teacher VARCHAR(50) NULL,
	Date_birth DATE NULL,
	Domain VARCHAR(50) NULL,
	Phone_Number VARCHAR(10) NULL
	CONSTRAINT pk_ID_Buildings_And_ID_School PRIMARY KEY(ID_Teacher,ID_School)
);
GO

-----Posibil sa trebuiasca adaugata clasa la care preda profesorul

CREATE TABLE Profiles (
	ID_Profile INT NOT NULL CONSTRAINT pk_Profile PRIMARY KEY,
	ID_Teacher INT NOT NULL,
	ID_School INT NOT NULL,
	CONSTRAINT fk_TeacherProfilesSchool FOREIGN KEY(ID_Teacher,ID_School)
	REFERENCES Teachers(ID_Teacher,ID_School),
	Domain VARCHAR(50) NOT NULL
);
GO
CREATE TABLE Profiles_Domain (
	ID_Profile_Domain INT NOT NULL,
	ID_School INT NOT NULL CONSTRAINT fk_SchoolProfile_Domain REFERENCES School(ID_School),
	CONSTRAINT pk_Profile_Domain_And_ID_School PRIMARY KEY(Profile_Domain,ID_School),
	Profile_Domain VARCHAR(50) NOT NULL
);
GO
CREATE TABLE Classes (
	ID_Class INT NOT NULL,
	Name_Class VARCHAR(50) NOT NULL,
	ID_School INT NOT NULL CONSTRAINT fk_SchoolClass REFERENCES School(ID_School),
	CONSTRAINT pk_Class_And_ID_School PRIMARY KEY(ID_Class,ID_School),
	Domain_Classes VARCHAR(50) NOT NULL,
	Nr_Desks NUMERIC(2) NULL,
	Nr_Blackboards NUMERIC(1) NULL
);
GO

CREATE TABLE Timetable_Teachers (
	ID_Timetable_Teacher INT NOT NULL CONSTRAINT pk_Timetable_Teachers PRIMARY KEY,
	ID_Teacher INT NOT NULL,
	ID_School INT NOT NULL,
	ID_Class INT NOT NULL, 
	CONSTRAINT fk_Timetable_Teachers_IDClass FOREIGN KEY(ID_Class,ID_School)
	REFERENCES Classes(ID_Class,ID_School),
	CONSTRAINT fk_TeacherTimetableSchool FOREIGN KEY(ID_Teacher,ID_School)
	REFERENCES Teachers(ID_Teacher,ID_School),
	Hours_Intervals VARCHAR(30) NOT NULL,
	Day1 BIT NOT NULL,
	Day2 BIT NOT NULL,
	Day3 BIT NOT NULL,
	Day4 BIT NOT NULL,
	Day5 BIT NOT NULL
);
GO
------ char cnp
CREATE TABLE Students (
	ID_Student INT NOT NULL CONSTRAINT pk_Student PRIMARY KEY,
	CNP CHAR(13) NOT NULL,
	ID_School INT NOT NULL,
	ID_Class INT NOT NULL,
	CONSTRAINT fk_IDSchool_IDClass_Students FOREIGN KEY(ID_Class,ID_School)
	REFERENCES Classes(ID_Class,ID_School),
	Name_Student VARCHAR(50) NOT NULL,
	Birth_DATE_Student DATE NOT NULL,
	Gender_Student VARCHAR(10) NULL,
	Nationality_Student VARCHAR(20) NULL,
	Email_Student VARCHAR(50) NULL,
	Phone_Number VARCHAR(10) NULL,
	Address_Student VARCHAR(50) NULL,
);
GO
CREATE TABLE Parents (
	ID_Parents INT NOT NULL CONSTRAINT pk_Parents PRIMARY KEY,
	ID_Student INT NOT NULL CONSTRAINT fk_ParentsStudent REFERENCES Students(ID_Student),
	Father_Name VARCHAR(50) NOT NULL,
	Father_Occupation VARCHAR(50) NULL,
	Father_Phone_Number NUMERIC(10) NOT NULL,
	Mother_Name VARCHAR(50) NOT NULL,
	Mother_Occupation VARCHAR(50) NULL,
	Mother_Phone_Number NUMERIC(10) NULL
);
GO
CREATE TABLE Timetable_Class (
	ID_Timetable_Student INT NOT NULL CONSTRAINT pk_Timetable_Class PRIMARY KEY,
	ID_Class INT NOT NULL,
	ID_Teacher INT NOT NULL,
	ID_School INT NOT NULL,
	CONSTRAINT fk_TeacherTimetableClass_School FOREIGN KEY(ID_Teacher,ID_School)
	REFERENCES Teachers(ID_Teacher,ID_School),
	CONSTRAINT fk_IDSchool_IDClass_Timetable_Class FOREIGN KEY(ID_Class,ID_School)
	REFERENCES Classes(ID_Class,ID_School),
	Hours_Intervals VARCHAR(30) NOT NULL,
	Day1 BIT NOT NULL,
	Day2 BIT NOT NULL,
	Day3 BIT NOT NULL,
	Day4 BIT NOT NULL,
	Day5 BIT NOT NULL
);
GO
----AI GRIJA CA LA NR DE CAMERE TREBUIE SA TE UITI LA CATE CLASE SUNT sa nu fie mai putin clase decat numar de camere
CREATE TABLE Buildings (
	ID_Buildings INT NOT NULL,
	ID_School INT NOT NULL CONSTRAINT fk_SchoolBuildings REFERENCES School(ID_School),
	Name_Building VARCHAR(30) NULL,
	Nr_rooms NUMERIC(2) NULL,
	Specifications VARCHAR(50) NULL
	CONSTRAINT pk_ID_BuildingsAnd_ID_School PRIMARY KEY(ID_Buildings,ID_School)
);
GO
CREATE TABLE Catalogue (
	ID_Catalogue INT NOT NULL,
	ID_School INT NOT NULL,
	ID_Class INT NOT NULL,
	CONSTRAINT fk_IDSchool_IDClass_Catalogue FOREIGN KEY(ID_Class,ID_School)
	REFERENCES Classes(ID_Class,ID_School),
	ID_Student INT NOT NULL CONSTRAINT fk_StudentsCatalogue REFERENCES Students(ID_Student),
	CONSTRAINT pk_ID_School_And_ID_Student PRIMARY KEY(ID_School,ID_Student,ID_Catalogue),
	DATE_Note_Romanian_Language_and_Literature_Note DATE NULL,
	Romanian_Language_and_Literature_Note DECIMAL(4,2) NULL,
	Romanian_Language_and_Literature_Note_Thesis DECIMAL(4,2) NULL,
	Romanian_Language_and_Literature_Absences NUMERIC(2) NULL,
	DATE_Note_Mathematics_Note DATE NULL,
	Mathematics_Note DECIMAL(4,2) NULL,
	Mathematics_Note_Thesis DECIMAL(4,2) NULL,
	Mathematics_Absences NUMERIC(2) NULL,
	DATE_Note_English_Note DATE NULL,
	English_Note DECIMAL(4,2) NULL,
	English_Absences DECIMAL(4,2) NULL,
	DATE_Note_French_Note DATE NULL,
	French_Note DECIMAL(4,2) NULL,
	French_Absences NUMERIC(2) NULL,
	DATE_Note_Physical_Science_Note DATE NULL,
	Physical_Science_Note DECIMAL(4,2) NULL,
	Physical_Science_Note_Thesis DECIMAL(4,2) NULL,
	Physical_Science_Absences NUMERIC(2) NULL,
	DATE_Note_Biology_Note DATE NULL,
	Biology_Note DECIMAL(4,2) NULL,
	Biology_Note_Thesis DECIMAL(4,2) NULL,
	Biology_Absences NUMERIC(2) NULL,
	DATE_Note_Chemistry_Note DATE NULL,
	Chemistry_Note DECIMAL(4,2) NULL,
	Chemistry_Note_Thesis DECIMAL(4,2) NULL,
	Chemistry_Absences NUMERIC(2)NULL,
	DATE_Note_History_Note DATE NULL,
	History_Note DECIMAL(4,2) NULL,
	History_Note_Thesis DECIMAL(4,2) NULL,
	History_Absences NUMERIC(2) NULL,
	DATE_Note_Geography_Note DATE NULL,
	Geography_Note DECIMAL(4,2) NULL,
	Geography_Note_Thesis DECIMAL(4,2) NULL,
	Geography_Absences NUMERIC(2) NULL,
	DATE_Note_Informatics_Note DATE NULL,
	Informatics_Note DECIMAL(4,2) NULL,
	Informatics_Note_Thesis DECIMAL(4,2) NULL,
	Informatics_Absences NUMERIC(2) NULL,
	DATE_Note_Religion_Note DATE NULL,
	Religion_Note DECIMAL(4,2) NULL,
	Religion_Absences NUMERIC(2) NULL,
	DATE_Note_Sports_Note DATE NULL,
	Sports_Note DECIMAL(4,2) NULL,
	Sports_Absences NUMERIC(2) NULL,
	DATE_Note_Music_Note DATE NULL,
	Music_Note DECIMAL(4,2) NULL,
	Music_Absences NUMERIC(2) NULL,
	DATE_Note_Drawing_Note DATE NULL,
	Drawing_Note DECIMAL(4,2) NULL,
	Drawing_Absences NUMERIC(2) NULL,
	DATE_Note_Coordination_Note DATE NULL,
	Coordination_Note DECIMAL(4,2) NULL,
	Coordination_Absences NUMERIC(2) NULL,
	DATE_Note_Latin_Note DATE NULL,
	Latin_Note DECIMAL(4,2) NULL,
	Latin_Absences NUMERIC(2) NULL,
	DATE_Note_Psychology_Note DATE NULL,
	Psychology_Note DECIMAL(4,2) NULL,
	Psychology_Absences NUMERIC(2) NULL,
	DATE_Note_Entrepreneurial_Education_Note DATE NULL,
	Entrepreneurial_Education_Note DECIMAL(4,2) NULL,
	Entrepreneurial_Education_Absences NUMERIC(2) NULL,
	DATE_Note_Economy_Note DATE NULL,
	Economy_Note DECIMAL(4,2) NULL,
	Economy_Note_Thesis DECIMAL(4,2) NULL,
	Economy_Absences NUMERIC(2) NULL,
	DATE_Note_Sociology_Note DATE NULL,
	Sociology_Note DECIMAL(4,2) NULL,
	Sociology_Absences NUMERIC(2) NULL,
	DATE_Note_Universal_Literature_Note DATE NULL,
	Universal_Literature_Note DECIMAL(4,2) NULL,
	Universal_Literature_Absences NUMERIC(2) NULL,
	DATE_Note_Applied_economics_Note DATE NULL,
	Applied_economics_Note DECIMAL(4,2) NULL,
	Applied_economics_Absences NUMERIC(2) NULL,
	DATE_Note_TIC_Note DATE NULL,
	TIC_Note DECIMAL(4,2) NULL,
	TIC_Absences NUMERIC(2) NULL,
	Absente_Total NUMERIC(3) NULL,
	General_Average DECIMAL(4,2) NULL
);
GO
CREATE TABLE Staff (
	ID_Staff INT NOT NULL CONSTRAINT pk_Staff PRIMARY KEY,
	ID_School INT NOT NULL CONSTRAINT fk_SchoolStaff REFERENCES School(ID_School),
	Job_Title VARCHAR(30) NOT NULL,
	Nume_Staff VARCHAR(30) NOT NULL
);
GO
CREATE TABLE Costs (
	ID_Costs INT NOT NULL CONSTRAINT pk_Costs PRIMARY KEY,
	ID_School INT NOT NULL,
	ID_Teacher INT NOT NULL,
	CONSTRAINT fk_TeacherCostsSchool FOREIGN KEY(ID_Teacher,ID_School)
	REFERENCES Teachers(ID_Teacher,ID_School),
	Teacher_Salary NUMERIC(10) NOT NULL,
	ID_Staff INT NOT NULL CONSTRAINT fk_StaffCosts REFERENCES Staff(ID_Staff),
	Staff_Salary NUMERIC(10) NOT NULL,
	Maintenance VARCHAR(50) NULL,
	Costs_Maintenance NUMERIC(10) NULL,
	Total_Costs NUMERIC(10) NULL
);
GO