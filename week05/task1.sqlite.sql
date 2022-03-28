-- TABLE
CREATE TABLE "Customer" (
    clientId int NOT NULL,
    balance FLOAT,
    creditLimit FLOAT,
    discount FLOAT,
    shippingAdresses TEXT,
    PRIMARY KEY (clientId)
);
CREATE TABLE "Item" (
    itemId int NOT NULL,
    description TEXT,
    PRIMARY KEY (itemId)
);
CREATE TABLE items_manufacturers (
    itemId INT,
    manufacturerId INT,
    quantity INT
);
CREATE TABLE "Menufacturer" (
    menufacturerId int NOT NULL,
    phonenumber TEXT,
    PRIMARY KEY (menufacturerId)
);
CREATE TABLE "Order" (
    orderId int NOT NULL,
    orderDate TIME,
    shippingAdresses TEXT,
    PRIMARY KEY (orderId)
);
CREATE TABLE orders_customers (
    clientId INT,
    orderId INT
);
CREATE TABLE orders_items (
    orderId INT,
    itemId INT
    quantity INT
);
CREATE TABLE "ShippingAdress" (
    shippingAdressId int NOT NULL,
    house INT,
    street TEXT,
    district TEXT,
    city TEXT,
    PRIMARY KEY (shippingAdressId)
);
 
-- INDEX
 
-- TRIGGER
 
-- VIEW
 
