-- Multi Joins
SELECT *
FROM actor;

SELECT *
FROM film;

SELECT *
FROM film_actor;


-- Inner Join from film to film_actor
SELECT *
FROM film f 
JOIN film_actor fa 
ON f.film_id = fa.film_id
ORDER BY f.film_id;


-- Inner Join from actor to film_actor
SELECT *
FROM actor a 
JOIN film_actor fa 
ON a.actor_id = fa.actor_id;


SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title, f.release_year
FROM actor a 
JOIN film_actor fa 
ON a.actor_id = fa.actor_id
JOIN film f
ON f.film_id = fa.film_id
ORDER BY f.film_id;




-- SUBQUERIES --
SELECT *
FROM payment;

-- Find all customers by id who have totaled more than $175 in payments
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC;

-- Get customer info based on above result
SELECT *
FROM customer 
WHERE customer_id IN (148,526,178,137,144,459);


-- Combine into subquery:
SELECT *
FROM customer 
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);


-- Add on:

SELECT *
FROM customer c
JOIN address a 
ON c.address_id = a.address_id
WHERE c.customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
ORDER BY last_name 
OFFSET 2
LIMIT 3;


-- BEWARE!
-- What categories were the most popular
SELECT category_id
FROM film_category 
GROUP BY category_id 
HAVING COUNT(*) > 60
ORDER BY COUNT(*) DESC;

SELECT *
FROM category
WHERE category_id IN (
	SELECT category_id
	FROM film_category 
	GROUP BY category_id 
	HAVING COUNT(*) > 60
	ORDER BY COUNT(*) DESC
);


SELECT *
FROM film
WHERE film_id IN (
	SELECT category_id
	FROM film_category 
	GROUP BY category_id 
	HAVING COUNT(*) > 60
	ORDER BY COUNT(*) DESC
);

--15
--9
--8
--6
--2
--1
--13
--7
--14
--10


-- Using Subquery for calculation
SELECT AVG(amount)
FROM payment;


-- Find all of the payments that were above average using subqery
SELECT *
FROM payment 
WHERE amount > (
	SELECT AVG(amount)
	FROM payment
)
ORDER BY amount;




-- Using Subquery in DML statements
SELECT *
FROM customer;

ALTER TABLE customer
ADD COLUMN loyalty_member BOOLEAN DEFAULT FALSE;


SELECT *
FROM customer
WHERE loyalty_member = False;


-- Set customers who have more than 25 payments become loyalty members
UPDATE customer 
SET loyalty_member = TRUE 
WHERE customer_id IN (
	SELECT customer_id
	FROM payment 
	GROUP BY customer_id 
	HAVING COUNT(*) > 25
);


SELECT * FROM customer
WHERE loyalty_member = True;


