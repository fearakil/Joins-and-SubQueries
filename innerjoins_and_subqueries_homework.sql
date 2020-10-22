--1. List all customers who live in Texas (use JOINs) 
SELECT customer.first_name,customer.last_name,district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

--2. Get all payments above $6.99 with the Customer's Full Name 
SELECT customer.first_name,customer.last_name,amount
FROM customer
INNER JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;



--3. Show all customers names who have made payments over $175(use subqueries) 
SELECT customer.first_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

--4. List all customers that live in Nepal (use the city table) 
SELECT customer.first_name,customer.last_name,customer.email,country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

--5. Which staff member had the most transactions? 
SELECT staff_id, COUNT(payment_id)
FROM payment
GROUP BY staff_id 
ORDER BY staff_id DESC;

--6. How many movies of each rating are there? 
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY rating DESC;

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer.first_name,customer.last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 6.99
	ORDER BY SUM(amount) DESC
);

--8. How many free rentals did our stores give away?
SELECT COUNT(payment.amount)
FROM payment
WHERE amount = 0 AND customer_id IN (
	SELECT customer_id
	FROM customer
);
