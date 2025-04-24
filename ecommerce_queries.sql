
-- Create database
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50)
);

-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create order_items table
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data into customers
INSERT INTO customers VALUES
(1, 'Raj Sharma', 'India'),
(2, 'Alice Jones', 'USA'),
(3, 'Mohit Verma', 'India');

-- Insert sample data into products
INSERT INTO products VALUES
(201, 'Laptop', 800.00),
(202, 'Headphones', 200.00),
(203, 'Mouse', 50.00);

-- Insert sample data into orders
INSERT INTO orders VALUES
(101, 1, '2024-01-01', 1250.00),
(102, 2, '2024-01-02', 200.00),
(103, 3, '2024-01-03', 850.00);

-- Insert sample data into order_items
INSERT INTO order_items VALUES
(1, 101, 201, 1),
(2, 101, 202, 2),
(3, 102, 202, 1),
(4, 103, 201, 1),
(5, 103, 203, 1);

-- Select all data from customers
SELECT * FROM customers;

-- Select total sales
SELECT SUM(orders.total_amount) AS total_sales FROM orders;

-- Select average price of products
SELECT AVG(price) FROM products;

-- Create a view for customer sales
CREATE VIEW customer_sales AS
SELECT customers.name, SUM(orders.total_amount) AS total_spent
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.name;

-- Select from the customer sales view
SELECT * FROM customer_sales;

-- Create index on customer_id in orders
CREATE INDEX idx_customer_id ON orders(customer_id);

