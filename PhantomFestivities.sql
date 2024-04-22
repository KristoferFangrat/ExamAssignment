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
    Active BIT NOT NULL
);

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
    CommunityID INT NOT NULL,
    Active BIT NOT NULL
    CHECK (Active IN (0,1))
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
    PRIMARY KEY(UserID, AdvertisementID)
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

CREATE TABLE Review (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    Rating VARCHAR(1) NOT NULL,
    Text NVARCHAR(300) NOT NULL,
    ReviewDate DATE NOT NULL,
    UserID INT NOT NULL,
    EventID INT NOT NULL
);


CREATE TABLE Booking (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    BookingDate DATE NOT NULL,
    NumberOfTickets INT NOT NULL
    CHECK (NumberOfTickets > 0),
    TotalPrice DECIMAL(10,2) NOT NULL
    CHECK (TotalPrice >= 0),
    UserID INT NOT NULL,
    EventID INT NOT NULL,
    HauntedPlaceID INT NOT NULL,
    Active BIT NOT NULL
    CHECK (Active IN (0,1))
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    PaymentDate DATETIME NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    UserID INT NOT NULL,
    BookingID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE HauntedPlace (
    HauntedPlaceID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(300) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    MultiMediaContent NVARCHAR(20) NOT NULL,
    BookingID INT NOT NULL,
    ResourceID INT NOT NULL,
    Partnership INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE HauntedPlaceReview (
    HauntedPlaceID INT,
    ReviewID INT,
    PRIMARY KEY (HauntedPlaceID, ReviewID)
);

CREATE TABLE HauntedPlaceLocation (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    Address NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    Zipcode NVARCHAR(20) NOT NULL,
    Latitude DECIMAL(7,5) NOT NULL,
    Longitude DECIMAL (8,5) NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE AdType (
    AdTypeID INT PRIMARY KEY IDENTITY(1,1),
    TypeName NVARCHAR(100) NOT NULL,
    HauntePlaceID INT NOT NULL,
    AdvertisementID INT NOT NULL
);

CREATE TABLE HauntedPlaceAdvertisement (
    AdvertisementID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Category NVARCHAR(100) NOT NULL,
    AdTypeID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE Resource (
    ResourceID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    ResourceTypeID INT NOT NULL,
    HauntedPlaceID INT NOT NULL
);

CREATE TABLE ResourceType (
    ResourceID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL
);

CREATE TABLE NotificationType (
    NotificationTypeID INT PRIMARY KEY IDENTITY(1,1),
    TypeName NVARCHAR(100) NOT NULL
);

CREATE TABLE Notification (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    NotificationTypeID INT NOT NULL,
    UserID INT NOT NULL,
    Active BIT NOT NULL,
    FOREIGN KEY (NotificationTypeID) REFERENCES NotificationType(NotificationTypeID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
);

CREATE TABLE PremiumPayment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    PaymentDate DATETIME NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    UserID INT NOT NULL,
    BookingID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE UserPremium (
    UserPremiumID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    PremiumID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE Premium (
    PremiumID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    UserID INT NOT NULL
);

CREATE TABLE EventLocation (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    EventID INT NOT NULL,
    Address NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    Zipcode NVARCHAR(20) NOT NULL,
    Latitude DECIMAL(7,5) NOT NULL,
    Longitude DECIMAL (8,5) NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE EventAdvertisement (
    EventAdvertisementID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Category NVARCHAR(100) NOT NULL,
    EventID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE EventAdType (
    EventAdType INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,    
);

CREATE TABLE Partnership (
    PartnershipID INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Description NVARCHAR(500) NOT NULL,
	HauntedPlaceID INT NOT NULL,
    PartnershipTypeID INT NOT NULL,
	Active BIT NOT NULL    
);

CREATE TABLE PartnershipType (
    PartnershipType INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(500) NOT NULL,    
);

CREATE TABLE PartnershipContact (
    ContactID INT PRIMARY KEY IDENTITY(1,1),
    ContactName NVARCHAR(100) NOT NULL,
    ContactEmail NVARCHAR(100),
    ContactPhone NVARCHAR(20),
    PartnershipID INT NOT NULL,
	Active BIT NOT NULL
);

CREATE TABLE PartnershipAdvertisement (
    PartnershipAdID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Category NVARCHAR(100) NOT NULL,
    AdTypeID INT NOT NULL,
	PartnershipTypeID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE PartnershipAdType (
    PartnershipAdTypeID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,    
);