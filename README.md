# E-commerce Database Project

This project creates a simple e-commerce database with three tables: `customers`, `orders`, and `products`. It also includes queries to retrieve and manipulate data within these tables.

## Database Structure

### `customers`

| Column     | Data Type     | Description                                |
|------------|---------------|--------------------------------------------|
| `id`       | INT           | Unique identifier for each customer (Primary Key, Auto-increment) |
| `name`     | VARCHAR(255)  | Customer's name                            |
| `email`    | VARCHAR(255)  | Customer's email address (Unique)          |
| `address`  | VARCHAR(255)  | Customer's address                           |

### `products`

| Column      | Data Type     | Description                                |
|-------------|---------------|--------------------------------------------|
| `id`        | INT           | Unique identifier for each product (Primary Key, Auto-increment) |
| `name`      | VARCHAR(255)  | Product's name                             |
| `price`     | DECIMAL(10, 2) | Product's price                            |
| `description`| TEXT          | Product's description                      |
| `discount` | DECIMAL(5,2)   | Product's discount (added via ALTER)      |

### `orders`

| Column        | Data Type     | Description                                |
|---------------|---------------|--------------------------------------------|
| `id`          | INT           | Unique identifier for each order (Primary Key, Auto-increment) |
| `customer_id` | INT           | Foreign key referencing `customers.id`       |
| `order_date`  | DATE          | Date the order was placed                  |
| `total_amount`| DECIMAL(10,2) | Total amount of the order (calculated)     |

### `order_items`

| Column        | Data Type     | Description                                |
|---------------|---------------|--------------------------------------------|
| `id`          | INT           | Unique identifier for each item (Primary Key, Auto-increment) |
| `order_id`    | INT           | Foreign key referencing `orders.id`          |
| `product_id`  | INT           | Foreign key referencing `products.id`        |
| `quantity`    | INT           | Quantity of the product ordered            |

## Setup Instructions

1.  **Install MySQL:** Ensure you have MySQL installed and running on your system.
2.  **Run the SQL Script:** Execute the provided SQL script (`ecommerce_database.sql`) in your MySQL client.
   This script will create the database, tables, and insert sample data. You can use any MySQL client, such as MySQL Workbench or the command-line client.

    ```bash
    mysql -u your_username -p < ecommerce_database.sql
    ```

    Replace `your_username` with your MySQL username.

## SQL Queries

The SQL script includes the following queries:

* **Retrieve customers with orders in the last 30 days:** Finds all customers who have placed an order within the past 30 days.
* **Total order amount per customer:** Calculates the total amount of orders for each customer.
* **Update product price:** Updates the price of a specific product.
* **Add discount column:** Adds a discount column to the products table.
* **Top 3 highest priced products:** Retrieves the top 3 products with the highest prices.
* **Customers who ordered Product A:** Finds the names of customers who have ordered a specific product.
* **Join orders and customers:** Joins the `orders` and `customers` tables to display customer names and order dates.
* **Orders with total amount > 150:** Retrieves orders with a total amount greater than 150.
* **Database Normalization**: Creates the `order_items` table, removes the `total_amount` from the `orders` table, and then adds it back as a calculated value.
* **Average order total:** Calculates the average total amount of all orders.

## File Contents

* `SQL Task.sql`: Contains the SQL script to create the database, tables, insert sample data, and run the queries.
* `README.md`: This file, providing project documentation.

## Notes

* The database is normalized by the creation of the order_items table. This helps to prevent data redundancy and improve data integrity.
* The `total_amount` in the `orders` table is calculated based on the data in the `order_items` and `products` tables.
* Make sure to change the mysql user and password in the command line instruction to match your local setup.
