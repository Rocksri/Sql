-- Create the database
CREATE database if not exists ECommerce ;

-- Use the ecommerce database
USE ecommerce;

-- Create the customers table
CREATE TABLE IF NOT EXISTS Customers (
	id int auto_increment primary key,
    name varchar(255) not null,
    email varchar(255) unique not null,
    CONSTRAINT email_check CHECK (email LIKE '%@%'),
    address varchar(255)
);


-- Create the products table
CREATE TABLE IF NOT EXISTS Products (
	id int auto_increment primary key,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);


-- Create the orders table
CREATE TABLE IF NOT EXISTS Orders (
	id int auto_increment primary key,
	customer_id INT,
    order_date date,
    total_amount decimal(10,2),
    foreign key (customer_id) references customers(id)
);


-- Insert sample data into customers table
INSERT INTO customers (name, email, address) VALUES
('Alice Smith', 'alice@example.com', '123 Main St'),
('Bob Johnson', 'bob@example.com', '456 Oak Ave'),
('Charlie Brown', 'charlie@example.com', '789 Pine Ln');


-- Insert sample data into products table
INSERT INTO products (name, price, description) VALUES
('Product A', 25.00, 'Description of Product A'),
('Product B', 50.00, 'Description of Product B'),
('Product C', 30.00, 'Description of Product C'),
('Product D', 100.00, 'Description of Product D');


-- Insert sample data into orders table
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-10-20', 75.00),
(2, '2023-11-15', 120.00),
(1, '2023-11-25', 55.00),
(3, '2023-12-01', 200.00),
(2, '2023-12-10', 30.00);


-- 1. Retrieve all customers who have placed an order in the last 30 days.
SELECT distinct c.* from customers c join orders o on c.id = o.customer_id
where o.order_date >= date_sub(curdate(), interval 30 day);


-- 2. Get the total amount of all orders placed by each customer.
SELECT c.name, sum(o.total_amount) as total_order_amount
from customers c left join orders o on c.id = o.customer_id 
group by c.name;


-- 3. Update the price of Product C to 45.00.
UPDATE products
SET price = 45.00
WHERE name = 'Product C';


-- 4. Add a new column discount to the products table.
ALTER table products add column discount decimal(5,2);


-- 5. Retrieve the top 3 products with the highest price.
SELECT name, price from products order by price desc limit 3;


-- 6. Get the names of customers who have ordered Product A.
SELECT distinct c.name from customers c join orders o on c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
where p.name = 'Product A';


-- 7. Join the orders and customers tables to retrieve the customer's name and order date for each order.
SELECT c.name , o.order_date from orders o join customers c on o.customer_id = o.id;


-- 8. Retrieve the orders with a total amount greater than 150.00.
SELECT * from orders where total_amount >150.00;


-- 9. Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table.
-- Create order_items table
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Modify the orders table to remove total_amount
ALTER TABLE orders DROP COLUMN total_amount;

-- insert data into order_items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1,1,2),
(1,2,1),
(2,4,1),
(3,3,1),
(3,1,1),
(4,4,2),
(5,3,1);

-- Modify the orders table to calculate total_amount based on order_items.
ALTER TABLE orders
ADD COLUMN total_amount DECIMAL (10,2);

-- Update orders table with calculated total amount.
UPDATE orders
SET total_amount = (
    SELECT SUM(oi.quantity * p.price)
    FROM order_items oi
    JOIN products p ON oi.product_id = p.id
    WHERE oi.order_id = orders.id
);


-- 10. Retrieve the average total of all orders.
SELECT AVG(total_amount) AS average_order_total FROM orders;

