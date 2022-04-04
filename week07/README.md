# Lab 7

# Task 1

Assume price is the total sum of the order.

## 1NF

```sql
CREATE TABLE IF NOT EXISTS Orders (
	orderId INTEGER,
	date TEXT,
	customerId INTEGER,
	customerName TEXT,
	city TEXT,
	itemId INTEGER,
	itemName TEXT,
	quant INTEGER,
	price REAL
);

insert into Orders (orderId, date, customerId, customerName, city, itemId, itemName, quant, price)
values (2301, '23/02/2011',     101, 'Martin', 'Prague', 3786, 'Net', 3, 35.00),
       (2301, '23/02/2011',     101, 'Martin', 'Prague', 4011, 'Racket', 6, 65.00),
       (2301, '23/02/2011',     101, 'Martin', 'Prague', 9132, 'Pac-3', 8, 4.75),
		   (2302, '25/02/2011',     107, 'Herman', 'Madrid', 5794, 'Pack-6', 4, 5.00),
       (2302, '27/02/2011',     110, 'Pedro', 'Moscow', 4011, 'Racket', 2, 65.00),
		   (2303, '27/02/2011',     110, 'Pedro', 'Moscow', 3141, 'Cover', 2, 10.00);

SELECT * FROM Orders
```

**Calculate the total number of items per order and the total amount to
pay for the order.**

```sql
SELECT 
  O.orderid, SUM(O.quant) AS totalQuant, SUM(O.price) AS totalPrice
FROM 
  Orders O
GROUP BY 
 O.orderid
```

**Obtain the customer whose purchase in terms of money has been
greater than the others.**

```sql
SELECT 
  DISTINCT F1.customerId, F2.customerId
FROM 
	(
SELECT 
  DISTINCT O.customerId, SUM(O.price) AS totalPrice
FROM 
  Orders O
GROUP BY 
 	O.customerId
	) as F1,
	(
SELECT 
  DISTINCT O.customerId, SUM(O.price) AS totalPrice
FROM 
  Orders O
GROUP BY 
 	O.customerId
	) as F2
WHERE
	F1.totalPrice > F2.totalPrice
```

## 2NF

```sql
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

CREATE TABLE IF NOT EXISTS Orders (
	customerId INTEGER,
	orderId INTEGER,
	date TEXT,
	customerName TEXT,
	city TEXT,
	itemId INTEGER,
	itemName TEXT,
	quant INTEGER,
	price REAL
);

CREATE TABLE IF NOT EXISTS Customers (
	customerId INTEGER,
	customerName TEXT,
	PRIMARY KEY(customerId)
);

insert into Customers (customerId, customerName)
values (101, 'Martin'),
       (107, 'Racket'),
       (110, 'Pedro');
	   
insert into Orders (orderId, date, customerId, city, itemId, itemName, quant, price)
values (2301, '23/02/2011',     101, 'Prague', 3786, 'Net', 3, 35.00),
       (2301, '23/02/2011',     101, 'Prague', 4011, 'Racket', 6, 65.00),
       (2301, '23/02/2011',     101, 'Prague', 9132, 'Pac-3', 8, 4.75),
	   (2302, '25/02/2011',     107, 'Madrid', 5794, 'Pack-6', 4, 5.00),
       (2302, '27/02/2011',     110, 'Moscow', 4011, 'Racket', 2, 65.00),
	   (2303, '27/02/2011',     110, 'Moscow', 3141, 'Cover', 2, 10.00);
```

**Calculate the total number of items per order and the total amount to
pay for the order.**

```sql
SELECT 
  O.orderid, SUM(O.quant) AS totalQuant, SUM(O.price) AS totalPrice
FROM 
  Orders O
GROUP BY 
 O.orderid
```

**Obtain the customer whose purchase in terms of money has been
greater than the others.**

```sql
SELECT 
  DISTINCT F1.customerId, F2.customerId
FROM 
	(
SELECT 
  DISTINCT O.customerId, SUM(O.price) AS totalPrice
FROM 
  Orders O
GROUP BY 
 	O.customerId
	) as F1,
	(
SELECT 
  DISTINCT O.customerId, SUM(O.price) AS totalPrice
FROM 
  Orders O
GROUP BY 
 	O.customerId
	) as F2
WHERE
	F1.totalPrice > F2.totalPrice
```

## 3NF

```sql
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Customers;

CREATE TABLE IF NOT EXISTS Orders (
	orderId INTEGER,
	date TEXT,
	customerId INTEGER,
	customerName TEXT,
	cityId INTEGER,
	itemId INTEGER,
	quant INTEGER,
	price REAL
);

CREATE TABLE IF NOT EXISTS Items (
	itemId INTEGER,
	itemName TEXT,
	PRIMARY KEY(itemId)
);

CREATE TABLE IF NOT EXISTS Customers (
	customerId INTEGER,
	customerName TEXT,
	PRIMARY KEY(customerId)
);

CREATE TABLE IF NOT EXISTS Cities (
	cityId INTEGER,
	cityName TEXT,
	PRIMARY KEY(cityId)
);

insert into Items (itemId, itemName)
values (3786, 'Net'),
       (4011, 'Racket'),
       (9132, 'Pac-3'),
	   (5794, 'Pack-6'),
	   (3141, 'Cover');
	   
insert into Cities (cityId, cityName)
values (1, 'Prague'),
       (2, 'Madrid'),
       (3, 'Moscow');

insert into Customers (customerId, customerName)
values (101, 'Martin'),
       (107, 'Racket'),
       (110, 'Pedro');
	   
insert into Orders (orderId, date, customerId, cityId, itemId, quant, price)
values (2301, '23/02/2011',     101, 1, 3786, 3, 35.00),
       (2301, '23/02/2011',     101, 1, 4011, 6, 65.00),
       (2301, '23/02/2011',     101, 2, 9132, 8, 4.75),
	   (2302, '25/02/2011',     107, 2, 5794, 4, 5.00),
       (2302, '27/02/2011',     110, 3, 4011, 2, 65.00),
	   (2303, '27/02/2011',     110, 3, 3141, 2, 10.00);
```

**Calculate the total number of items per order and the total amount to
pay for the order.**

```sql
SELECT 
  O.orderid, SUM(O.quant) AS totalQuant, SUM(O.price) AS totalPrice
FROM 
  Orders O
GROUP BY 
 O.orderid
```

**Obtain the customer whose purchase in terms of money has been
greater than the others.**

```sql
SELECT 
  DISTINCT F1.customerId, F2.customerId
FROM 
	(
SELECT 
  DISTINCT O.customerId, SUM(O.price) AS totalPrice
FROM 
  Orders O
GROUP BY 
 	O.customerId
	) as F1,
	(
SELECT 
  DISTINCT O.customerId, SUM(O.price) AS totalPrice
FROM 
  Orders O
GROUP BY 
 	O.customerId
	) as F2
WHERE
	F1.totalPrice > F2.totalPrice
```

# Task 3

Lets consider NF one by one:

## 1NF

All attribute values are single atomic → relation CAR-SALE is in 1NF.

## 2NF

We know, that **salespersonId** → **comimission**.

Therefore, it is not fully functionally dependent on the primary key → not in 2 NF.

The 2 NF decomposition for this relation is:

- Table1
    - **carNumber**
    - **salespersonId**
    - **dateSold**
    - **discount**
- Table2
    - **salespersonId**
    - **comimission**

## 3NF

The given relationship is not in 3NF. Because we can say, that **dateSold** is neither a key itself nor a subset of a key and **discount** is not a prime attribute.

The 3NF decomposition are as follows:

- Table1
    - **carNumber**
    - **salespersonId**
    - **dateSold**
- Table2
    - **dateSold**
    - **discount**
- Table3
    - **salespersonId**
    - **comimission**