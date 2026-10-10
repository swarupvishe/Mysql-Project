-- ============================================================
--  E-COMMERCE MANAGEMENT SYSTEM  (MySQL Project - IT Vedant)
--  Prepared by: Swarup Vishe
--  Run this whole script in MySQL Workbench (MySQL 8.0+)
-- ============================================================

-- ------------------------------------------------------------
--  STEP 1 : CREATE DATABASE
-- ------------------------------------------------------------
DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- ------------------------------------------------------------
--  STEP 2 : CREATE TABLES  (7 tables)
-- ------------------------------------------------------------
CREATE TABLE categories (
    category_id    INT AUTO_INCREMENT PRIMARY KEY,
    category_name  VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE customers (
    customer_id        INT AUTO_INCREMENT PRIMARY KEY,
    first_name         VARCHAR(40) NOT NULL,
    last_name          VARCHAR(40) NOT NULL,
    email              VARCHAR(100) NOT NULL UNIQUE,
    phone              VARCHAR(15),
    city               VARCHAR(50),
    registration_date  DATE
);

CREATE TABLE products (
    product_id      INT AUTO_INCREMENT PRIMARY KEY,
    product_name    VARCHAR(100) NOT NULL,
    category_id     INT NOT NULL,
    brand           VARCHAR(50),
    price           DECIMAL(10,2) NOT NULL,
    stock_quantity  INT NOT NULL DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id      INT AUTO_INCREMENT PRIMARY KEY,
    customer_id   INT NOT NULL,
    order_date    DATE NOT NULL,
    order_status  ENUM('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    total_amount  DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id  INT AUTO_INCREMENT PRIMARY KEY,
    order_id       INT NOT NULL,
    product_id     INT NOT NULL,
    quantity       INT NOT NULL,
    unit_price     DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id      INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT NOT NULL,
    payment_method  VARCHAR(30) NOT NULL,
    payment_date    DATE,
    amount          DECIMAL(10,2) NOT NULL,
    payment_status  ENUM('Success','Pending','Refunded') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE reviews (
    review_id    INT AUTO_INCREMENT PRIMARY KEY,
    customer_id  INT NOT NULL,
    product_id   INT NOT NULL,
    rating       INT NOT NULL,
    review_text  VARCHAR(200),
    review_date  DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)  REFERENCES products(product_id)
);

-- ------------------------------------------------------------
--  STEP 3 : INSERT SAMPLE DATA
-- ------------------------------------------------------------

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Mobiles'),
('Fashion'),
('Home & Kitchen'),
('Books'),
('Sports');

INSERT INTO customers (first_name, last_name, email, phone, city, registration_date) VALUES
('Aarav','Sharma','aarav.sharma@gmail.com','9876543201','Mumbai','2025-02-03'),
('Ananya','Patel','ananya.patel@gmail.com','9876543202','Pune','2025-03-05'),
('Rohan','Mehta','rohan.mehta@gmail.com','9876543203','Thane','2025-04-07'),
('Priya','Iyer','priya.iyer@gmail.com','9876543204','Bengaluru','2025-05-09'),
('Vivaan','Gupta','vivaan.gupta@gmail.com','9876543205','Delhi','2025-06-11'),
('Diya','Reddy','diya.reddy@gmail.com','9876543206','Hyderabad','2025-07-13'),
('Kabir','Singh','kabir.singh@gmail.com','9876543207','Nashik','2025-08-15'),
('Isha','Joshi','isha.joshi@gmail.com','9876543208','Nagpur','2025-09-17'),
('Arjun','Nair','arjun.nair@gmail.com','9876543209','Chennai','2025-10-19'),
('Meera','Kapoor','meera.kapoor@gmail.com','9876543210','Mumbai','2025-11-21'),
('Sai','Verma','sai.verma@gmail.com','9876543211','Pune','2025-12-23'),
('Riya','Das','riya.das@gmail.com','9876543212','Kolkata','2025-01-25'),
('Aditya','Rao','aditya.rao@gmail.com','9876543213','Ahmedabad','2025-02-27'),
('Neha','Chopra','neha.chopra@gmail.com','9876543214','Jaipur','2025-03-02'),
('Krishna','Malhotra','krishna.malhotra@gmail.com','9876543215','Surat','2025-04-04');

INSERT INTO products (product_name, category_id, brand, price, stock_quantity) VALUES
('Bluetooth Earbuds',1,'BoAt',1499.00,120),
('Smart LED TV 43 Inch',1,'Mi',24999.00,25),
('Portable Power Bank 20000mAh',1,'Ambrane',1799.00,80),
('Wireless Mouse',1,'Logitech',799.00,150),
('Redmi Note 5G',2,'Xiaomi',16999.00,60),
('Galaxy M Series 128GB',2,'Samsung',18999.00,45),
('Nord CE 5G',2,'OnePlus',24999.00,30),
('Realme Narzo 5G',2,'Realme',13999.00,70),
('Men''s Cotton Shirt',3,'Peter England',1299.00,100),
('Women''s Kurti Set',3,'Biba',1899.00,90),
('Slim Fit Jeans',3,'Levis',2499.00,75),
('Running Shoes',3,'Puma',3299.00,60),
('Non-Stick Cookware Set',4,'Prestige',2199.00,40),
('Mixer Grinder 750W',4,'Bajaj',3499.00,35),
('Air Fryer 4L',4,'Philips',7999.00,20),
('Cotton Bedsheet Set',4,'Bombay Dyeing',1599.00,55),
('Atomic Habits',5,'Penguin',499.00,200),
('Wings of Fire',5,'Universities Press',299.00,180),
('Rich Dad Poor Dad',5,'Manjul',350.00,160),
('Competitive Exam Guide',5,'Arihant',650.00,95),
('Yoga Mat',6,'Decathlon',899.00,110),
('Cricket Bat',6,'SG',2799.00,30),
('Football Size 5',6,'Nivia',799.00,85),
('Badminton Racket Set',6,'Yonex',1999.00,50);

INSERT INTO orders (customer_id, order_date, order_status, total_amount) VALUES
(10,'2026-07-02','Shipped',25597.00),
(7,'2026-03-18','Delivered',700.00),
(9,'2026-03-04','Delivered',12294.00),
(2,'2026-01-20','Cancelled',10395.00),
(13,'2026-06-15','Delivered',22995.00),
(2,'2026-05-17','Cancelled',18994.00),
(2,'2026-09-14','Delivered',38996.00),
(1,'2026-02-25','Delivered',7395.00),
(8,'2026-08-03','Delivered',2598.00),
(12,'2026-02-02','Delivered',3397.00),
(5,'2026-07-22','Cancelled',10997.00),
(10,'2026-02-16','Shipped',49998.00),
(3,'2026-04-13','Pending',63793.00),
(5,'2026-03-27','Delivered',5593.00),
(15,'2026-07-08','Pending',20798.00),
(11,'2026-04-01','Pending',20998.00),
(7,'2026-09-12','Shipped',53394.00),
(11,'2026-01-15','Delivered',9794.00),
(4,'2026-02-07','Delivered',60295.00),
(1,'2026-03-18','Pending',9897.00),
(1,'2026-02-28','Shipped',7247.00),
(5,'2026-06-20','Delivered',3197.00),
(8,'2026-08-16','Delivered',52796.00),
(6,'2026-05-16','Delivered',4996.00),
(6,'2026-03-23','Delivered',998.00),
(11,'2026-02-23','Delivered',7097.00),
(13,'2026-04-18','Shipped',16696.00),
(13,'2026-04-27','Delivered',83993.00),
(12,'2026-01-01','Delivered',5496.00),
(10,'2026-06-15','Delivered',5098.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1,2,1,24999.00),
(1,18,2,299.00),
(2,19,2,350.00),
(3,12,3,3299.00),
(3,4,3,799.00),
(4,16,3,1599.00),
(4,22,2,2799.00),
(5,12,1,3299.00),
(5,10,3,1899.00),
(5,8,1,13999.00),
(6,11,2,2499.00),
(6,24,3,1999.00),
(6,15,1,7999.00),
(7,11,2,2499.00),
(7,5,2,16999.00),
(8,11,2,2499.00),
(8,23,3,799.00),
(9,9,2,1299.00),
(10,21,3,899.00),
(10,19,2,350.00),
(11,1,2,1499.00),
(11,15,1,7999.00),
(12,7,2,24999.00),
(13,16,2,1599.00),
(13,3,2,1799.00),
(13,6,3,18999.00),
(14,18,2,299.00),
(14,9,2,1299.00),
(14,23,3,799.00),
(15,3,1,1799.00),
(15,6,1,18999.00),
(16,19,2,350.00),
(16,6,1,18999.00),
(16,9,1,1299.00),
(17,5,3,16999.00),
(17,23,3,799.00),
(18,13,3,2199.00),
(18,4,2,799.00),
(18,16,1,1599.00),
(19,6,3,18999.00),
(19,4,1,799.00),
(19,11,1,2499.00),
(20,12,3,3299.00),
(21,20,1,650.00),
(21,13,3,2199.00),
(22,16,1,1599.00),
(22,4,2,799.00),
(23,3,1,1799.00),
(23,5,3,16999.00),
(24,17,1,499.00),
(24,1,3,1499.00),
(25,17,2,499.00),
(26,17,1,499.00),
(26,12,2,3299.00),
(27,21,3,899.00),
(27,8,1,13999.00),
(28,24,3,1999.00),
(28,8,2,13999.00),
(28,7,2,24999.00),
(29,16,1,1599.00),
(29,9,3,1299.00),
(30,12,1,3299.00),
(30,3,1,1799.00);

INSERT INTO payments (order_id, payment_method, payment_date, amount, payment_status) VALUES
(1,'Credit Card','2026-07-02',25597.00,'Success'),
(2,'Debit Card','2026-03-18',700.00,'Success'),
(3,'Cash on Delivery','2026-03-04',12294.00,'Success'),
(4,'UPI','2026-01-20',10395.00,'Refunded'),
(5,'Credit Card','2026-06-15',22995.00,'Success'),
(6,'Debit Card','2026-05-17',18994.00,'Refunded'),
(7,'Cash on Delivery','2026-09-14',38996.00,'Success'),
(8,'UPI','2026-02-25',7395.00,'Success'),
(9,'Credit Card','2026-08-03',2598.00,'Success'),
(10,'Debit Card','2026-02-02',3397.00,'Success'),
(11,'Cash on Delivery','2026-07-22',10997.00,'Refunded'),
(12,'UPI','2026-02-16',49998.00,'Success'),
(13,'Credit Card','2026-04-13',63793.00,'Pending'),
(14,'Debit Card','2026-03-27',5593.00,'Success'),
(15,'Cash on Delivery','2026-07-08',20798.00,'Pending'),
(16,'UPI','2026-04-01',20998.00,'Pending'),
(17,'Credit Card','2026-09-12',53394.00,'Success'),
(18,'Debit Card','2026-01-15',9794.00,'Success'),
(19,'Cash on Delivery','2026-02-07',60295.00,'Success'),
(20,'UPI','2026-03-18',9897.00,'Pending'),
(21,'Credit Card','2026-02-28',7247.00,'Success'),
(22,'Debit Card','2026-06-20',3197.00,'Success'),
(23,'Cash on Delivery','2026-08-16',52796.00,'Success'),
(24,'UPI','2026-05-16',4996.00,'Success'),
(25,'Credit Card','2026-03-23',998.00,'Success'),
(26,'Debit Card','2026-02-23',7097.00,'Success'),
(27,'Cash on Delivery','2026-04-18',16696.00,'Success'),
(28,'UPI','2026-04-27',83993.00,'Success'),
(29,'Credit Card','2026-01-01',5496.00,'Success'),
(30,'Debit Card','2026-06-15',5098.00,'Success');

INSERT INTO reviews (customer_id, product_id, rating, review_text, review_date) VALUES
(4,16,4,'Value for money.','2026-05-16'),
(10,20,5,'Great quality and fast delivery.','2026-07-26'),
(11,3,5,'Great quality and fast delivery.','2026-05-16'),
(15,6,3,'Okay for the price.','2026-03-26'),
(12,13,2,'Quality is below average.','2026-03-24'),
(3,6,4,'Good product, happy with it.','2026-04-19'),
(15,15,4,'Value for money.','2026-07-05'),
(9,18,4,'Good product, happy with it.','2026-02-26'),
(12,21,5,'Excellent product, worth the price.','2026-08-28'),
(4,7,5,'Great quality and fast delivery.','2026-05-10'),
(9,8,3,'Okay for the price.','2026-08-27'),
(3,2,3,'Okay for the price.','2026-08-27'),
(15,17,4,'Good product, happy with it.','2026-02-28'),
(8,6,5,'Excellent product, worth the price.','2026-04-05'),
(8,20,5,'Excellent product, worth the price.','2026-07-22'),
(9,17,1,'Stopped working quickly.','2026-03-18'),
(1,8,4,'Value for money.','2026-02-25'),
(2,17,2,'Not as expected.','2026-03-15'),
(6,20,1,'Very disappointed.','2026-06-15'),
(13,16,1,'Very disappointed.','2026-06-18'),
(15,7,2,'Not as expected.','2026-08-04'),
(7,15,3,'Average, could be better.','2026-05-14'),
(2,7,4,'Good product, happy with it.','2026-04-23'),
(11,22,3,'Average, could be better.','2026-06-05'),
(8,8,5,'Great quality and fast delivery.','2026-09-06');

-- ------------------------------------------------------------
--  STEP 4 : VERIFY DATA  (row count of every table)
-- ------------------------------------------------------------
SELECT 'categories' AS table_name, COUNT(*) AS total_rows FROM categories
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'payments', COUNT(*) FROM payments
UNION ALL SELECT 'reviews', COUNT(*) FROM reviews;

-- ------------------------------------------------------------
--  STEP 5 : BUSINESS QUERIES
-- ------------------------------------------------------------
-- ==== BASIC QUERIES ====
-- Q1: Show all products costing more than Rs.10,000, highest price first.
SELECT product_name, brand, price FROM products WHERE price > 10000 ORDER BY price DESC;

-- Q2: Find customers who live in Mumbai or Pune.
SELECT first_name, last_name, city FROM customers WHERE city IN ('Mumbai','Pune');

-- Q3: Find the 5 cheapest products.
SELECT product_name, price FROM products ORDER BY price ASC LIMIT 5;

-- Q4: Find all orders that are still Pending.
SELECT order_id, customer_id, order_date, total_amount FROM orders WHERE order_status = 'Pending';

-- Q5: List all distinct cities our customers come from.
SELECT DISTINCT city FROM customers ORDER BY city;

-- ==== AGGREGATE QUERIES ====
-- Q6: Count total customers, products and orders.
SELECT (SELECT COUNT(*) FROM customers) AS total_customers,
       (SELECT COUNT(*) FROM products)  AS total_products,
       (SELECT COUNT(*) FROM orders)    AS total_orders;

-- Q7: What is the total revenue from non-cancelled orders?
SELECT SUM(total_amount) AS total_revenue FROM orders WHERE order_status <> 'Cancelled';

-- Q8: What is the average order value?
SELECT ROUND(AVG(total_amount), 2) AS average_order_value FROM orders;

-- Q9: Count how many orders are in each status.
SELECT order_status, COUNT(*) AS number_of_orders FROM orders GROUP BY order_status;

-- Q10: Show categories whose total sales are above Rs.50,000.
SELECT c.category_name, SUM(oi.quantity * oi.unit_price) AS total_sales
FROM categories c
JOIN products p     ON c.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_name HAVING SUM(oi.quantity * oi.unit_price) > 50000;

-- ==== JOIN QUERIES ====
-- Q11: Show each product with its category name.
SELECT p.product_name, c.category_name, p.price
FROM products p JOIN categories c ON p.category_id = c.category_id;

-- Q12: Show each order with the customer's name.
SELECT o.order_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, o.order_date, o.total_amount
FROM orders o JOIN customers c ON o.customer_id = c.customer_id;

-- Q13: Show the products inside every order.
SELECT o.order_id, p.product_name, oi.quantity, oi.unit_price, (oi.quantity * oi.unit_price) AS line_total
FROM order_items oi
JOIN orders o   ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
ORDER BY o.order_id;

-- Q14: Show each order with its payment method and payment status.
SELECT o.order_id, pay.payment_method, pay.amount, pay.payment_status
FROM orders o JOIN payments pay ON o.order_id = pay.order_id;

-- Q15: Revenue earned by each category.
SELECT c.category_name, SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM order_items oi
JOIN products p   ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name ORDER BY category_revenue DESC;

-- Q16: Customers with the number of orders they placed (including customers with zero orders).
SELECT c.first_name, c.last_name, COUNT(o.order_id) AS orders_placed
FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name ORDER BY orders_placed DESC;

-- Q17: Average rating of each product that has reviews.
SELECT p.product_name, COUNT(r.review_id) AS total_reviews, ROUND(AVG(r.rating), 2) AS average_rating
FROM products p JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name ORDER BY average_rating DESC;

-- ==== SUBQUERIES ====
-- Q18: Products priced above the average product price.
SELECT product_name, price FROM products WHERE price > (SELECT AVG(price) FROM products);

-- Q19: Customers who have placed at least one order.
SELECT first_name, last_name FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

-- Q20: Products that have never been ordered.
SELECT product_name FROM products
WHERE product_id NOT IN (SELECT product_id FROM order_items);

-- Q21: Orders whose value is higher than the average order value.
SELECT order_id, total_amount FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders) ORDER BY total_amount DESC;

-- ==== VIEW ====
-- Q22: Create a view that summarises every customer's spending, then use it.
CREATE VIEW customer_spending AS
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.city,
       COUNT(o.order_id) AS total_orders, COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.city;

SELECT * FROM customer_spending ORDER BY total_spent DESC;

-- ==== STORED PROCEDURE ====
-- Q23: Procedure that shows all orders of one customer.
DELIMITER $$
CREATE PROCEDURE get_customer_orders(IN p_customer_id INT)
BEGIN
    SELECT order_id, order_date, order_status, total_amount
    FROM orders WHERE customer_id = p_customer_id ORDER BY order_date;
END$$
DELIMITER ;

CALL get_customer_orders(1);
