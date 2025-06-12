CREATE DATABASE ecommerce;
USE ecommerce;

-- Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT
);

-- Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    description TEXT
);

-- Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- OrderItems table
CREATE TABLE OrderItems (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);


-- --inserting values
-- Insert Customers
INSERT INTO Customers VALUES
(1, 'Sai Venkat', 'sai@example.com', '9876543210', 'Hyderabad'),
(2, 'Priya Sharma', 'priya@example.com', '9876501234', 'Delhi'),
(3, 'Amit Rao', 'amit@example.com', '9823456789', 'Mumbai');

-- Insert Products
INSERT INTO Products VALUES
(101, 'Sneakers', 2999.00, 50, 'Stylish white sneakers'),
(102, 'Smartphone', 14999.00, 30, 'Budget Android phone'),
(103, 'Watch', 1999.00, 20, 'Analog wrist watch');

-- Insert Orders
INSERT INTO Orders VALUES
(1001, 1, '2025-06-01', 'Delivered'),
(1002, 2, '2025-06-03', 'Pending'),
(1003, 3, '2025-06-05', 'Shipped');

-- Insert OrderItems
INSERT INTO OrderItems VALUES
(1, 1001, 101, 2, 2999.00),
(2, 1001, 103, 1, 1999.00),
(3, 1002, 102, 1, 14999.00),
(4, 1003, 103, 2, 1999.00);

-- Insert Payments
INSERT INTO Payments VALUES
(501, 1001, '2025-06-01', 7997.00, 'Credit Card'),
(502, 1002, '2025-06-03', 14999.00, 'UPI'),
(503, 1003, '2025-06-05', 3998.00, 'Cash on Delivery');
-- --queries
SELECT o.order_id, c.name, o.order_date, o.status
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;
SELECT SUM(amount) AS total_revenue FROM Payments;
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 1;

