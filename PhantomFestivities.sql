CREATE DATABASE PhantomFestivities;
GO
USE PhantomFestivities;
GO

CREATE TABLE [User] (
	UserID INT PRIMARY KEY IDENTITY(1,1),
	Username NVARCHAR(50) UNIQUE NOT NULL
	CHECK (LEN(Username) BETWEEN 3 AND 30),
	CHECK (Username LIKE '[a-zA-Z0-9]%'),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE NOT NULL
	CHECK (DateOfBirth < GETDATE()),
	Phonenumber VARCHAR(50) NOT NULL,
	Email NVARCHAR(50) NOT NULL
	CHECK (Email LIKE '%_@_%._%'),
	Role VARCHAR(10) NOT NULL
	CHECK (Role IN ('Admin', 'User', 'Guest')),
	Active BIT NOT NULL);

CREATE TABLE Login (
    LoginID INT PRIMARY KEY IDENTITY(1,1),
    HashedPassword VARCHAR(64) NOT NULL,
    Salt VARCHAR(64) NOT NULL,
    LastLogin DATETIME NOT NULL,
    FailedAttempt INT NOT NULL
	CHECK (FailedAttempt >= 0),
	UserID INT NOT NULL,
    Active BIT NOT NULL
	CHECK (Active IN (0,1))
);

CREATE TABLE Address (
	AddressID INT PRIMARY KEY IDENTITY(1,1),
	Street NVARCHAR(50) NOT NULL
	CHECK (LEN(Street) <= 50),
	City NVARCHAR(50) NOT NULL
	CHECK (LEN(City) <= 50),
	Region NVARCHAR(50) NOT NULL
	CHECK (LEN(Region) <= 50),
	Country NVARCHAR(50) NOT NULL
	CHECK (LEN(Country) <= 50),
	Zipcode NVARCHAR(11) NOT NULL
	CHECK (LEN(Zipcode) <= 10),
	UserID INT NOT NULL,
	Active BIT NOT NULL
	CHECK (Active IN (0,1))
);

CREATE TABLE UserCommunity (
	UserCommunityID INT PRIMARY KEY IDENTITY(1,1),
	JoinDate DATE NOT NULL
	CHECK (JoinDate <= GETDATE()),
	Role VARCHAR(20) NOT NULL
	CHECK (LEN(Role) <= 20),
	UserID INT NOT NULL,
	CommunityID INT NOT NULL
	);

CREATE TABLE Community (
	CommunityID INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(300) NOT NULL
	CHECK (LEN(Name) <= 300),
	Description NVARCHAR(500) NOT NULL
	CHECK (LEN(Description) <= 500),
	CreatedDate DATE NOT NULL
	CHECK (CreatedDate <= GETDATE()),
	CreatedBy NVARCHAR(50) NOT NULL
	CHECK (LEN(CreatedBy) <= 50),
	Active BIT NOT NULL
	CHECK (Active IN (0,1))
	);

CREATE TABLE UserAdvertisement (
	UserID INT,
	AdvertisementID INT,
	PRIMARY KEY(UserID, AdvertisementID),
	CONSTRAINT FK_UserAdvertisement FOREIGN KEY (UserID) REFERENCES [User](UserID),
	CONSTRAINT FK_UserAdvertisement_Advertisement FOREIGN KEY (AdvertisementID) 
	REFERENCES Advertisement(AdvertisementID)
	);

CREATE TABLE Advertisement (
	AdvertisementID INT PRIMARY KEY IDENTITY(1,1),
	Title NVARCHAR(100) NOT NULL,
	Description NVARCHAR(500) NOT NULL,
	StartDate DATE NOT NULL
	CHECK (StartDate <= EndDate),
	EndDate DATE NOT NULL,
	Price DECIMAL(10,2) NOT NULL
	CHECK (Price >= 0),
	Category NVARCHAR(100) NOT NULL
	CHECK (LEN(Category) <= 100),
	ImageURL NVARCHAR(500) NOT NULL
	CHECK (LEN(ImageURL) <= 500),
	UserID INT NOT NULL,
	Active BIT NOT NULL
	CHECK (Active IN (0,1))
);