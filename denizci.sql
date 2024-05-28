CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    UserPassword VARCHAR(255) NOT NULL
);

CREATE TABLE Countries (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(50) NOT NULL
);

CREATE TABLE Cities (
    CityID INT PRIMARY KEY,
    CityName VARCHAR(50) NOT NULL,
    CountryID INT NOT NULL,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE Towns (
    TownID INT PRIMARY KEY,
    TownName VARCHAR(50) NOT NULL,
    CityID INT NOT NULL,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);

CREATE TABLE Districts (
    DistrictID INT PRIMARY KEY,
    DistrictName VARCHAR(50) NOT NULL,
    TownID INT NOT NULL,
    FOREIGN KEY (TownID) REFERENCES Towns(TownID)
);

CREATE TABLE AddressTexts (
    AddressTextID INT PRIMARY KEY,
    AddressLine VARCHAR(255) NOT NULL
);

CREATE TABLE AddressTypes (
    AddressTypeID INT PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE PaymentMethods (
    PaymentMethodID INT PRIMARY KEY,
    MethodName VARCHAR(50) NOT NULL
);

CREATE TABLE ProductCategories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE OrderStatuses (
    StatusID INT PRIMARY KEY,
    StatusName VARCHAR(50) NOT NULL
);

CREATE TABLE Coupons (
    CouponID INT PRIMARY KEY,
    CouponCode VARCHAR(50) NOT NULL,
    DiscountAmount DECIMAL(10, 2) NOT NULL,
    ExpiryDate DATE NOT NULL,
    IsActive BIT NOT NULL
);

CREATE TABLE UserRoles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL
);


CREATE TABLE ShippingMethods (
    ShippingMethodID INT PRIMARY KEY,
    MethodName VARCHAR(50) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    DeliveryTime VARCHAR(50) NOT NULL
);


CREATE TABLE Tags (
    TagID INT PRIMARY KEY,
    TagName VARCHAR(50) NOT NULL
);


CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY,
    UserID INT NOT NULL,
    SubscriptionType VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    IsActive BIT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY,
    UserID INT NOT NULL,
    FeedbackText TEXT NOT NULL,
    FeedbackDate DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY,
    CountryID INT NOT NULL,
    CityID INT NOT NULL,
    TownID INT NOT NULL,
    DistrictID INT NOT NULL,
    PostalCode VARCHAR(20) NOT NULL,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID),
    FOREIGN KEY (CityID) REFERENCES Cities(CityID),
    FOREIGN KEY (TownID) REFERENCES Towns(TownID),
    FOREIGN KEY (DistrictID) REFERENCES Districts(DistrictID)
);

CREATE TABLE UserAddresses (
    UserAddressID INT PRIMARY KEY,
    UserID INT NOT NULL,
    AddressID INT NOT NULL,
    AddressTextID INT NOT NULL,
    AddressTypeID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID),
    FOREIGN KEY (AddressTextID) REFERENCES AddressTexts(AddressTextID),
    FOREIGN KEY (AddressTypeID) REFERENCES AddressTypes(AddressTypeID)
);

CREATE TABLE ActivityLog (
    ActivityID INT PRIMARY KEY,
    UserID INT NOT NULL,
    ActivityType VARCHAR(50) NOT NULL,
    ActivityDate DATE NOT NULL,
    Description TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY,
    UserID INT NOT NULL,
    NotificationText VARCHAR(255) NOT NULL,
    IsRead BIT NOT NULL DEFAULT 0,
    CreatedAt DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE UserSettings (
    SettingID INT PRIMARY KEY,
    UserID INT NOT NULL,
    SettingName VARCHAR(50) NOT NULL,
    SettingValue VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Sessions (
    SessionID INT PRIMARY KEY,
    UserID INT NOT NULL,
    SessionToken VARCHAR(255) NOT NULL,
    CreatedAt DATE NOT NULL,
    ExpiresAt DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


CREATE TABLE OrderHistory (
    OrderHistoryID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    StatusID INT NOT NULL,
    StatusChangeDate DATE NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (StatusID) REFERENCES OrderStatuses(StatusID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentMethodID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID)
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    ParentCategoryID INT,
    CategoryName VARCHAR(50) NOT NULL,
    FOREIGN KEY (ParentCategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES ProductCategories(CategoryID)
);

CREATE TABLE ProductReviews (
    ReviewID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5) NOT NULL,
    ReviewText TEXT,
    ReviewDate DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE ProductImages (
    ImageID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    ImageURL VARCHAR(255) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    LastUpdated DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE UserRoleMappings (
    UserID INT NOT NULL,
    RoleID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES UserRoles(RoleID),
    PRIMARY KEY (UserID, RoleID)
);

CREATE TABLE Wishlists (
    WishlistID INT PRIMARY KEY,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    DateAdded DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE ProductTags (
    ProductID INT NOT NULL,
    TagID INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (TagID) REFERENCES Tags(TagID),
    PRIMARY KEY (ProductID, TagID)
);

CREATE TABLE Discounts (
    DiscountID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    DiscountPercentage DECIMAL(5, 2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Shippings (
    ShippingID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ShippingAddressID INT NOT NULL,
    ShippingDate DATE NOT NULL,
    DeliveryDate DATE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ShippingAddressID) REFERENCES Addresses(AddressID)
);