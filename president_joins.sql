-- Create a table for customers
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	address VARCHAR(50),
	state VARCHAR(2),
	zipcode VARCHAR(5)
);

SELECT *
FROM customer;

-- Alter statements
ALTER TABLE customer 
ALTER COLUMN zipcode TYPE INTEGER USING zipcode::integer;


ALTER TABLE customer 
ADD COLUMN city VARCHAR(50);


SELECT * FROM customer;


-- Orders Table
CREATE TABLE order_(
	order_id SERIAL PRIMARY KEY,
	order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	amount NUMERIC(5,2),
	cust_id INTEGER,
	FOREIGN KEY(cust_id) REFERENCES customer(customer_id)
);


SELECT *
FROM order_;


-- Insert data into customer table
INSERT INTO customer(
	first_name,
	last_name,
	email,
	address,
	city,
	state,
	zipcode
) VALUES (
	'George',
	'Washington',
	'gwash@usa.gov',
	'3200 Mt. Vernon Hwy',
	'Mt. Vernon',
	'VA',
	22122
);

SELECT * FROM customer;





INSERT INTO customer(
	first_name, last_name, email, address, city, state, zipcode
) VALUES ('John', 'Adams', 'jadams@usa.gov', '1200 Hancock Road', 'Quincy', 'MA', 21343),
('Thomas', 'Jefferson', 'tjeff@pres.com', '123 Monticello Drive', 'Monticello', 'VA', 32424),
('James', 'Madison', 'jamesm@constitution.gov', '1333 Congress Pkwy', 'Arlington', 'VA', 73434),
('James', 'Monroe', 'monroeyourboat@usa.gov', '3242 W Monroe Ave', 'Charlottesville', 'VA', 35335);


ALTER TABLE customer 
ALTER COLUMN zipcode TYPE VARCHAR(5);

SELECT * FROM customer;

SELECT * FROM order_;


INSERT INTO order_(amount, cust_id)
VALUES(99.99, 1);

INSERT INTO order_(amount, cust_id)
VALUES(15.75, 2),(32.75, 1);

INSERT INTO order_(amount, cust_id)
VALUES(55.55, 3), (32.23, null);


SELECT *
FROM order_;

SELECT * FROM customer;


-- Long way without joins
SELECT cust_id
FROM order_ 
WHERE order_id = 1 OR order_id = 4;


SELECT email
FROM customer 
WHERE customer_id IN (1, 3);


-- Using a join
SELECT *
FROM order_ 
JOIN customer
ON order_.cust_id = customer.customer_id;



ALTER TABLE order_ 
RENAME COLUMN cust_id TO customer_id;


-- Inner Join
SELECT customer.customer_id, order_date, amount, first_name, last_name
FROM customer
INNER JOIN order_ 
ON customer.customer_id = order_.customer_id;

-- INNER JOIN with a GROUP BY
SELECT order_.customer_id, customer.first_name, customer.last_name, SUM(amount) AS total_spent, COUNT(*) AS num_orders
FROM customer
JOIN order_ 
ON customer.customer_id = order_.customer_id
WHERE first_name LIKE '%h%'
GROUP BY order_.customer_id, customer.first_name, customer.last_name
HAVING SUM(amount) > 50
ORDER BY total_spent DESC;



-- Alias Table Names
SELECT c.first_name, c.last_name, o.order_date, o.amount
FROM order_ o
JOIN customer c 
ON  c.customer_id = o.customer_id;



-- LEFT Join
SELECT *
FROM customer c -- LEFT Table
LEFT JOIN order_ o  -- RIGHT Table
ON c.customer_id = o.customer_id;


-- RIGHT Join
SELECT *
FROM customer c -- LEFT Table
RIGHT JOIN order_ o  -- RIGHT Table
ON c.customer_id = o.customer_id;




-- Inner Join
SELECT *
FROM  order_ o -- LEFT Table
JOIN customer c  -- RIGHT Table
ON c.customer_id = o.customer_id;

-- Right Join
SELECT *
FROM  order_ o -- LEFT Table
RIGHT JOIN customer c  -- RIGHT Table
ON c.customer_id = o.customer_id;

-- Left Join
SELECT *
FROM  order_ o -- LEFT Table
LEFT JOIN customer c  -- RIGHT Table
ON c.customer_id = o.customer_id;

-- Full Join
SELECT *
FROM  order_ o -- LEFT Table
FULL JOIN customer c  -- RIGHT Table
ON c.customer_id = o.customer_id;




