/*
Build an e-commerce database.
Create every table for database.
Insert data into every table.
*/


--Dropping a table before creating it to reset the table and to ensure that the table has a fresh start.
--To ensure changes make to table free of any errors or inconsistencies. 
--Drop table in order of last created to first created.

DROP TABLE IF EXISTS OrderSession;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS ProductSnapshot;
DROP TABLE IF EXISTS Ownership;
DROP TABLE IF EXISTS ShopOwner;
DROP TABLE IF EXISTS ProductRatings;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Shop;
DROP TABLE IF EXISTS ProductCategory;
DROP TABLE IF EXISTS UserAddress;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS UserStatusID;

--Create table UserStatusID

CREATE TABLE IF NOT EXISTS UserStatusID(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	status TEXT
);

--Insert data into table UserStatusID

INSERT INTO UserStatusID
	(status)
VALUES
	('Active'),
	('Not Active'),
	('Block');

--Create table User. Store user information.
	
CREATE TABLE IF NOT EXISTS User(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	username TEXT,
	passwords TEXT,
	first_name TEXT,
	last_name TEXT,
	telephone_no TEXT,
	user_status_id INTEGER,
	FOREIGN KEY (user_status_id) REFERENCES UserStatusID (id)
);

--Insert data into User table.

INSERT INTO User
	(username, passwords, first_name, last_name, telephone_no, user_status_id)
VALUES
	('Hermione1612', 'Wbdvljo', 'Hermione', 'Granger', '+601123450266', 1),
	('Ron253', 'djuofkckB', 'Ron', 'Weasely', '+10136957092', 1),
	('Harryyy' , 'gigsa14j@', 'Harry', 'Potter', '+70179833077', 3);

--Create table UserAddress. 
--Store user address. One user can have many address.	

CREATE TABLE IF NOT EXISTS UserAddress(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_id INTEGER,
	address_line_1 TEXT,
	address_line_2 TEXT,
	postal_code TEXT,
	city TEXT,
	country TEXT,
	FOREIGN KEY (user_id) REFERENCES User(id)
);

--Insert data into table UserAddress

INSERT INTO UserAddress
	(user_id, address_line_1, address_line_2, postal_code, city, country)
VALUES
	(1, '123 Main Street', 'Apt 4B', '12345', 'Exampleville', 'United States'),
	(2, '456 Elm Street', 'Suite 301', '54321', 'Sampletown', 'Canada'),
	(3, '789 Oak Avenue', '', '67890', 'Demo City', 'United Kingdom'),
	(3, '101 Pine Road', 'Unit 7', '98765', 'Testville', 'Australia');

--Create table ProductCategary.
--Store category info of every products.

CREATE TABLE IF NOT EXISTS ProductCategory(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	category TEXT,
	description TEXT
);

--Insert data into table Product Category

INSERT INTO ProductCategory
	(category, description)
VALUES
	('Fashion', 'Include attire for men and women'),
	('Home Appliances', 'TV, Speaker, etc'),
	('Sports', 'Include sport attire and appliances'),
	('Computer', 'Include computer and its accecories');

--Create table shop.
--Store information about every shop.

CREATE TABLE IF NOT EXISTS Shop(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	shop_name TEXT,
	location TEXT,
	year_operate INTEGER
);

--Insert data into table Shop.

INSERT INTO Shop
	(shop_name, location, year_operate)
VALUES
	('Happy Life', 'China', 2010),
	('Extreme Gaming', 'Germany', 2018),
	('Home Sweet Home', 'Kuala Lumpur', 2020);

--Create table Product.
--Store information of every product sold in various shop.
	
CREATE TABLE IF NOT EXISTS Product(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT,
	about TEXT,
	category_id INTEGER,
	price FLOAT,
	quantity INTEGER,
	shop_id INTEGER,
	FOREIGN KEY (category_id) REFERENCES ProductCategory(id),
	FOREIGN KEY (shop_id) REFERENCES Shop(id)
);

--Insert data into table Product

INSERT INTO Product
	(name, about, category_id, price, quantity,shop_id)
VALUES
	('Sneakers', 'Men Shoe', 1, 50.00, 10, 2),
	('Skipping Rope', 'Sports equipment', 3, 12.10, 35, 1),
	('Floral Dress', 'Women attire', 1, 149.90, 7, 3),
	('Microwave', 'Home appliances for heating food', 2, 840.50, 50, 2),
	('Keyboard', 'Gaming Keyboard', 4, 200.00, 69, 2);

--Create table  ProductRatings
--Store rating for every product. One product have many rating by many user.
	
CREATE TABLE IF NOT EXISTS ProductRatings(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	product_id INTEGER,
	rating INTEGER,
	user_id INTEGER,
	FOREIGN KEY (product_id) REFERENCES Product(id),
	FOREIGN KEY (user_id) REFERENCES User(id)
);

--Insert data into table ProductRatings.

INSERT INTO ProductRatings
	(product_id, rating, user_id)
VALUES
	(2, 4, 2),
	(4, 1, 3),
	(2, 2, 1);

--Create table ShopOwner.
--Store information for every shop owner.

CREATE TABLE IF NOT EXISTS ShopOwner(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	username TEXT,
	passwords TEXT,
	first_name TEXT,
	last_name TEXT,
	telephone_no TEXT
);

--Insert data into table ShopOwner

INSERT INTO ShopOwner
	(username, passwords,first_name,last_name,telephone_no)
VALUES
	('meimei', 'JHVKS7Snssh', 'Lee', 'Albert','+10563729209'),
	('Ikhsan11', 'jwbdeiu38gf', 'Ahmad', 'Ikhsan','+60138393017'),
	('Baifern', 'gdhew5uh', 'Pimchanok', 'Luevisadpaibul','+49658921837');

--Create table Ownership.
--Store information about shop and its owner.
--One shop can have many owner. One owner can have many shops.

CREATE TABLE IF NOT EXISTS Ownership(
	shop_owner_id INTEGER,
	shop_id INTEGER,
	PRIMARY KEY(shop_owner_id, shop_id),
	FOREIGN KEY(shop_owner_id) REFERENCES ShopOwner(id),
	FOREIGN  KEY(shop_id) REFERENCES Shop(id)
);

--Insert data into table Ownership

INSERT INTO Ownership
	(shop_owner_id, shop_id)
VALUES
	(1, 1),
	(1, 2),
	(3, 1);

--Create table ProductSnapshot
--Show details of the product at the time user bought the product.
--Details remain the same even shop owner change the details (ex: price)

CREATE TABLE IF NOT EXISTS ProductSnapshot(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	product_id INTEGER,
	name TEXT,
	about TEXT,
	category_id INTEGER,
	price FLOAT,
	FOREIGN KEY (category_id) REFERENCES ProductCategory(id)
	FOREIGN KEY (product_id) REFERENCES Product(id)
);

--Insert data into table ProductSnapshot.

INSERT INTO ProductSnapshot
	(product_id, name, about, category_id, price)
VALUES
	(3, 'Floral Dress', 'Women attire', 1, 149.90),
	(3, 'Floral Dress', 'Women attire', 1, 160.00),
	(3, 'Floral Dress', 'Women attire', 1, 155.50),
	(4, 'Microwave', 'Home appliances for heating food', 2, 840.50),
	(2, 'Skipping Rope', 'Sports equipment', 3, 12.10),
	(2, 'Skipping Rope', 'Sports equipment', 3, 10.00);

--Create table Orders
--Store details of every order.
--One user can make many order.

CREATE TABLE IF NOT EXISTS Orders(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_id INTEGER,
	address_id INTEGER,
	order_date TEXT,
	FOREIGN KEY (user_id) REFERENCES User(id),
	FOREIGN KEY (address_id) REFERENCES UserAddress(id)
);

--Insert data into table Orders

INSERT INTO Orders
	(user_id, address_id, order_date)
VALUES
	(1, 1, '1 OCT 2020'),
	(3, 3, '16 DEC 2011'),
	(3, 3, '25 MAC 2001'),
	(2, 4, '3 APR 2021'),
	(1, 2, '31 AUG 2008'),
	(3, 3, '6 JAN 2023');

--Create table OrderSession.
--Store information of every buying session.
--One order can have many product snapshot.
--One product snapshot can have in many order.

CREATE TABLE IF NOT EXISTS OrderSession(
	order_id INTEGER,
	product_snapshot_id INTEGER,
	quantity INTEGER,
	PRIMARY KEY(order_id, product_snapshot_id),
	FOREIGN KEY (order_id) REFERENCES Orders(id),
	FOREIGN KEY(product_snapshot_id) REFERENCES ProductSnapshot(id)
);

--Insert data into table OrderSession 

INSERT INTO OrderSession
	(order_id, product_snapshot_id, quantity)
VALUES
	(1, 1, 3),
	(1, 5, 2),
	(2, 4, 1),
	(3, 4, 1),
	(4, 3, 4);