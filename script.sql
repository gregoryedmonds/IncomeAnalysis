 :setvar SqlSamplesSourceDataPath "C:\Users\Gregory Edmonds\Google Drive\Uni\CITS3401\Project\Data\"

-- Create database --

IF EXISTS (SELECT [name] FROM [master].[sys].[databases] WHERE [name] = N'AdultIncomeDW')
DROP DATABASE AdultIncomeDW;
GO

Create database AdultIncomeDW
Go

Use AdultIncomeDW
Go

-- Create dimension tables --

Create table DimPerson
(
Age int primary key identity,
NativeCountry varchar(50) not null,
Race varchar(20),
Gender varchar(10)
)
Go

Create table DimJob
(
HoursPerWeek int primary key identity,
Occupation varchar(20) not null,
WorkClass varchar(20) not null,
Salary varchar(10)
)
Go

Create table DimSituation
(
SituationID int primary key identity,
Education varchar(20),
MartialStatus varchar(50),
Relationship varchar(20)
)
Go

Create table FactCountSalary
(
Age int not null,
HoursPerWeek int not null,
SituationID int not null,
CountSalaryLess float,
CountSalaryGreater float
)
Go

-- Add Fact table relations --

ALTER TABLE FactCountSalary ADD CONSTRAINT
Age FOREIGN KEY (Age) REFERENCES DimPerson(Age);

ALTER TABLE FactCountSalary ADD CONSTRAINT
HoursPerWeek FOREIGN KEY (HoursPerWeek) REFERENCES DimJob(HoursPerWeek);

ALTER TABLE FactCountSalary ADD CONSTRAINT
SituationID FOREIGN KEY (SituationID) REFERENCES DimSituation(SituationID);
Go

-- Insert data --

PRINT 'Loading [dbo].[DimPerson]';

BULK INSERT [dbo].DimPerson FROM '$(SqlSamplesSourceDataPath)DimPerson.csv'
WITH (
    CHECK_CONSTRAINTS,
   -- CODEPAGE='ACP',
    DATAFILETYPE = 'char',
    FIELDTERMINATOR= ',',
    ROWTERMINATOR = '\n',
	--KEEPIDENTITY
    TABLOCK
);

PRINT 'Loading [dbo].[DimJob]';

BULK INSERT [dbo].DimJob FROM '$(SqlSamplesSourceDataPath)DimJob.csv'
WITH (
    CHECK_CONSTRAINTS,
   -- CODEPAGE='ACP',
    DATAFILETYPE = 'char',
    FIELDTERMINATOR= ',',
    ROWTERMINATOR = '\n',
	--KEEPIDENTITY
    TABLOCK
);

PRINT 'Loading [dbo].[DimSituation]';

BULK INSERT [dbo].DimSituation FROM '$(SqlSamplesSourceDataPath)DimSituation.csv'
WITH (
    CHECK_CONSTRAINTS,
   -- CODEPAGE='ACP',
    DATAFILETYPE = 'char',
    FIELDTERMINATOR= ',',
    ROWTERMINATOR = '\n',
	--KEEPIDENTITY
    TABLOCK
);