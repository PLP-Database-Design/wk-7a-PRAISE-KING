-- ================================
-- SQL Assignment: Joins and Normalization
-- ================================

-- Question 1: INNER JOIN
-- Get firstName, lastName, email, and officeCode from employees joined with offices
SELECT e.firstName, e.lastName, e.email, e.officeCode
FROM employees e
INNER JOIN offices o ON e.officeCode = o.officeCode;

-- Question 2: LEFT JOIN
-- Get productName, productVendor, and productLine from products with productlines
SELECT p.productName, p.productVendor, p.productLine
FROM products p
LEFT JOIN productlines pl ON p.productLine = pl.productLine;

-- Question 3: RIGHT JOIN
-- Retrieve orderDate, shippedDate, status, and customerNumber for first 10 orders
SELECT o.orderDate, o.shippedDate, o.status, o.customerNumber
FROM customers c
RIGHT JOIN orders o ON c.customerNumber = o.customerNumber
LIMIT 10;

-- ================================
-- Normalization Section
-- ================================

-- 🛠Question 1: Achieving 1NF
-- Original table violates 1NF due to multi-valued Products field.
-- Convert to a normalized form: each row has only one product per order

-- Transformed Table: ProductDetail_1NF
CREATE TABLE ProductDetail_1NF (
  OrderID INT,
  CustomerName VARCHAR(100),
  Product VARCHAR(50)
);

-- Insert normalized data
INSERT INTO ProductDetail_1NF VALUES (101, 'John Doe', 'Laptop');
INSERT INTO ProductDetail_1NF VALUES (101, 'John Doe', 'Mouse');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Tablet');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Keyboard');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Mouse');
INSERT INTO ProductDetail_1NF VALUES (103, 'Emily Clark', 'Phone');

-- Question 2: Achieving 2NF
-- Remove partial dependency by splitting into two tables: Orders and OrderItems

-- Table 1: Orders (Customer info linked by OrderID)
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(100)
);

-- Table 2: OrderItems (Product and Quantity for each order)
CREATE TABLE OrderItems (
  OrderID INT,
  Product VARCHAR(50),
  Quantity INT,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders
INSERT INTO Orders VALUES (101, 'John Doe');
INSERT INTO Orders VALUES (102, 'Jane Smith');
INSERT INTO Orders VALUES (103, 'Emily Clark');

-- Insert data into OrderItems
INSERT INTO OrderItems VALUES (101, 'Laptop', 2);
INSERT INTO OrderItems VALUES (101, 'Mouse', 1);
INSERT INTO OrderItems VALUES (102, 'Tablet', 3);
INSERT INTO OrderItems VALUES (102, 'Keyboard', 1);
INSERT INTO OrderItems VALUES (102, 'Mouse', 2);
INSERT INTO OrderItems VALUES (103, 'Phone', 1);
