task-1: 

--To create a "Customers" table with the specified columns (customer ID, name, email, and location), you can use the following SQL query:

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL
);

--insert some dummy data into the "Customers" table. Here's an example SQL query:

INSERT INTO Customers (name, email, location)
VALUES
    ('John Doe', 'john.doe@example.com', 'New York'),
    ('Jane Smith', 'jane.smith@example.com', 'Los Angeles'),
    ('Bob Johnson', 'bob.johnson@example.com', 'Chicago'),
    ('Alice Williams', 'alice.williams@example.com', 'San Francisco');



task-2:

--Write a SQL query to create Order table where Contains details about orders, such as order ID, customer ID, order date, and total amount.

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Let's insert some dummy data into the "Orders" table.

INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES
    (1, '2023-01-01', 150.50),
    (2, '2023-01-02', 200.75),
    (3, '2023-01-03', 75.20),
    (4, '2023-01-04', 120.00);

--

Task-3:

--Write a SQL query to create a Products table to  Provides information about available products, including product ID, name, description, and price.

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL
);

--SQL query to insert some dummy data into the "Products" table:

INSERT INTO Products (name, description, price)
VALUES
    ('Product A', 'Description for Product A', 49.99),
    ('Product B', 'Description for Product B', 79.99),
    ('Product C', 'Description for Product C', 29.99),
    ('Product D', 'Description for Product D', 99.99);

Task-4:
--Write a SQL query to create a table for categories which Includes data on different product categories, identified by category ID and name.

SQL query to insert some dummy data into the "Categories" table:

INSERT INTO Categories (name)
VALUES
    ('Electronics'),
    ('Clothing'),
    ('Home and Garden'),
    ('Books');

Task-5:
--Write a SQL query to create a table for Order_Items Contains details about individual items within each order, including order item ID, order ID, product ID, quantity, and unit price.

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

--SQL query to insert some dummy data into the "Order_Items" table:

INSERT INTO Order_Items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 2, 25.99),
    (1, 2, 1, 49.99),
    (2, 3, 3, 15.75),
    (3, 4, 1, 99.99),
    (3, 2, 2, 49.99);


--1. To retrieve all customer information along with the total number of orders placed by each customer and display the result in descending order of the number of orders, you can use the following SQL query:
SELECT
    c.customer_id,
    c.name,
    c.email,
    c.location,
    COUNT(o.order_id) AS total_orders
FROM
    Customers c
LEFT JOIN
    Orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, c.name, c.email, c.location
ORDER BY
    total_orders DESC;

 
--2. Write a SQL query to retrieve the product name, quantity, and total amount for each order item. Display the result in ascending order of the order ID.
SELECT
    o.order_id,
    p.name AS product_name,
    oi.quantity,
    oi.quantity * oi.unit_price AS total_amount
FROM
    Orders o
JOIN
    Order_Items oi ON o.order_id = oi.order_id
JOIN
    Products p ON oi.product_id = p.product_id
ORDER BY
    o.order_id ASC;


--3. Write a SQL query to retrieve the total revenue generated by each product category. Display the category name along with the total revenue in descending order of the revenue.
SELECT
    c.name AS category_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM
    Categories c
JOIN
    Products p ON c.category_id = p.category_id
JOIN
    Order_Items oi ON p.product_id = oi.product_id
GROUP BY
    c.category_id, c.name
ORDER BY
    total_revenue DESC;


--4. Write a SQL query to retrieve the top 5 customers who have made the highest total purchase amount. Display the customer name along with the total purchase amount in descending order of the purchase amount.
SELECT
    c.name AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_purchase_amount
FROM
    Customers c
JOIN
    Orders o ON c.customer_id = o.customer_id
JOIN
    Order_Items oi ON o.order_id = oi.order_id
GROUP BY
    c.customer_id, c.name
ORDER BY
    total_purchase_amount DESC
LIMIT 5;


