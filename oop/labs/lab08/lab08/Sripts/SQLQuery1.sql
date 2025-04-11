use CosmeticsShop;
CREATE TABLE PRODUCTS (
ProductID int NOT NULL,
Name nvarchar(50) NOT NULL,
Description nvarchar(150) NOT NULL,
Price int NOT NULL,
Category nvarchar(50) NOT NULL,
Image nvarchar(50),
CONSTRAINT PK_PRODUCTS PRIMARY KEY (ProductID)
)

 CREATE TABLE CLIENT (
ClientID int NOT NULL,
Name nvarchar(50) NOT NULL,
LastName nvarchar(50) NOT NULL,
Address nvarchar(50) NOT NULL,
Email nvarchar(50) NOT NULL,
Phone int NOT NULL,
CONSTRAINT PK_CLIENT PRIMARY KEY (ClientID)
)
CREATE TABLE ORDERS (
    OrderID int NOT NULL PRIMARY KEY,
    Client_ID int NOT NULL, 
    ProductID int NOT NULL, 
    DateOrder date NOT NULL, 
    Statuss nvarchar(50) NOT NULL, 
    CONSTRAINT FK_ORDERS_Client_ID FOREIGN KEY (Client_ID) REFERENCES CLIENT(ClientID) ON UPDATE CASCADE, 
    CONSTRAINT FK_ORDERS_ProductID FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductID) ON UPDATE CASCADE
);