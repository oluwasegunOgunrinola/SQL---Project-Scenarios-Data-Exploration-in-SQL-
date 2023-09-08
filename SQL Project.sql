-- SQL PROJECT (Using 11 different tables) 

/* For this project, several tables were used ant the top 10 rows of each tables and their respective column names and attributes are displayed to give a feel of what each query line entails:
-- Also, find attached a picture of what the data output from final queries look like.

  i. film_table of 1000 rows with columns film_id, title, length, replacement_cost, and
  rating   
 ii. film_category_table of 1000 rows with columns film_id, category_id
iii. category_table of 16 rows with columns category_id, name
 iv. film_actor_table of 5462 rows with columns actor_id, film_id
  v. actor_table of 200 rows with columns actor_id, first_name, last_name
 vi. customer_table of 599 rows with columns customer_id, store_id, first_name, last_name,
     email, address_id
vii. address_table of 603 rows with columns address_id, district, city_id,
     postal_code, phone
viii.city_table of 600 rows with columns city_id, city, country_id
 ix. payment_table of 16049 rows with columns payment_id, customer_id, staff_id, 
     rental_id, amount
  x. inventory_table of 4581 rows with columns inventory_id, film_id, store_id
 xi. rental_table of 16044 rows with columns rental_id, rental_date, inventory_id,
     customer_id, return_date, staff_id      */


-- 1. Create a list of all the different (distinct) replacement costs of the films
select * from film

select distinct (replacement_cost)
from film

-- Question: What's the lowest replacement cost?
select min(distinct (replacement_cost))
from film
-- Answer: 9.99  (See data output snip)
-- Here, 'DISTINCT' Query was used


/* 2. Write a query that gives an overview of how many films 
       have replacements costs in the following cost ranges 
	 	low: 9.99 - 19.99
		medium: 20.00 - 24.99
		high: 25.00 - 29.99				*/

select * from film

select film_id, replacement_cost, 
case when replacement_cost <= 19.99 Then 'low'
when replacement_cost BETWEEN 20 and 24.99 Then 'medium'
when replacement_cost BETWEEN 24.99 and 29.99 Then 'high'
End as cost_category
from film

-- Question: How many films have a replacement cost in the "low" group?
select count('low'), 
case when replacement_cost <= 19.99 Then 'low'
when replacement_cost BETWEEN 20 and 24.99 Then 'medium'
when replacement_cost BETWEEN 24.99 and 29.99 Then 'high'
End as cost_category
from film
Group by cost_category
-- Answer: 514
-- Here, 'CASE + GROUP BY' Query was used


/* 3. Create a list of the film titles including their title, length, and category name 
      ordered descendingly by length. 
      Filter the results to only the movies in the category 'Drama' or 'Sports'  */

select * from film_category
select * from film
select * from category

select title, length, name
from
film fm inner join film_category fc
on fm.film_id = fc.film_id
inner join category ct
on fc.category_id = ct.category_id
where name LIKE '%Drama%' OR name LIKE '%Sports%'

-- Question: In which category is the longest film and how long is it?
select title, length, name
from
film fm inner join film_category fc
on fm.film_id = fc.film_id
inner join category ct
on fc.category_id = ct.category_id
where name LIKE '%Drama%' OR name LIKE '%Sports%'
ORDER BY length desc
-- Answer: Sports and 184
-- Here, 'JOIN' Query was used


/* 4. Create an overview of how many movies (titles) there are in each category (name) */

select count(title), name 
from
film fm inner join film_category fc
on fm.film_id = fc.film_id
inner join category ct
on fc.category_id = ct.category_id
group by name

-- Question: Which category (name) is the most common among the films?
select count(title), name 
from
film fm inner join film_category fc
on fm.film_id = fc.film_id
inner join category ct
on fc.category_id = ct.category_id
group by name
ORDER BY count(title)desc
-- Answer: Sports with 74 titles
-- Here, 'JOIN & GROUP BY' Query was used


/* 5. Create an overview of the actors' first and last names and in how many
movies they appear in   */

select * from film_actor
select * from actor
select* from film

select act.first_name, act.last_name, count(*)
from actor act inner join film_actor fa
on act.actor_id = fa.actor_id
inner join film fl
on fa.film_id = fl.film_id
group by act.first_name, act.last_name

--  Question: Which actor is part of most movies?
select act.first_name, act.last_name, count(*)
from actor act inner join film_actor fa
on act.actor_id = fa.actor_id
inner join film fl
on fa.film_id = fl.film_id
group by act.first_name, act.last_name
ORDER BY count(*) desc
-- Answer: Susan Davis with 54 movies
-- Here, 'JOIN & GROUP BY' Query was used


/* 6. Create an overview of the addresses that are not associated to any customer */

select * from customer
select * from address

select * from
customer right join address
on customer.address_id = address.address_id
where customer.address_id is null

-- Question: How many addresses are that?
select COUNT(*) from
customer right join address
on customer.address_id = address.address_id
where customer.address_id is null
-- Answer: 4
-- Here, 'LEFT JOIN & FILTERING' Query was used


/* 7. Create an overview of the cities and how much sales (sum of amount) 
      have occurred there  */
      -- selecting tables needed below and specifying their PRIMARY KEYS

select * from city     -- PK city id , FK country id
select * from payment  -- PK payment id, FK customer id
select * from customer -- PK customer id, FK address id
select * from address  -- PK address id, FK city id

select city, sum(amount)
from city cy inner join address ad
on cy.city_id = ad.city_id
inner join customer cs
on ad.address_id = cs.address_id
inner join payment pt
on cs.customer_id = pt.customer_id
group by city

-- Question: Which city has the most sales?
select city, sum(amount)
from city cy inner join address ad
on cy.city_id = ad.city_id
inner join customer cs
on ad.address_id = cs.address_id
inner join payment pt
on cs.customer_id = pt.customer_id
group by city
ORDER BY sum(amount) desc
-- Answer: Cape Coral with a total amount of 221.55
-- Here, 'JOIN & GROUP BY' Query was used


/* 8. Create an overview of the revenue (sum of amount) 
      grouped by a column in the format "country, city"  */
	  -- selecting tables needed below and specifying their PRIMARY KEYS
select * from city     -- PK city id , FK country id
select * from payment  -- PK payment id, FK customer id
select * from customer -- PK customer id, FK address id
select * from address  -- PK address id, FK city id
select * from country  -- PK country id

select country ||',' || ' ' || city as country_city, sum(amount)
from city cy inner join address ad
on cy.city_id = ad.city_id
inner join customer cs
on ad.address_id = cs.address_id
inner join payment pt
on cs.customer_id = pt.customer_id
inner join country co
on cy.country_id = co.country_id
group by country_city

-- Question: Which country, city has the least sales?
select country ||',' || ' ' || city as country_city, sum(amount)
from city cy inner join address ad
on cy.city_id = ad.city_id
inner join customer cs
on ad.address_id = cs.address_id
inner join payment pt
on cs.customer_id = pt.customer_id
inner join country co
on cy.country_id = co.country_id
group by country_city
ORDER BY sum asc
-- Answer: United States, Tallahassee with a total amount of 50.85.
-- Here, 'JOIN & GROUP BY' Query was used


/* 9. Create a list with the average of the sales amount each staff_id has per customer */

select staff_id, customer_id,
sum(amount)as total_sum
from payment
group by staff_id, customer_id

-- next, get the average of sales amount in a sub query each staff id has per customer
-- Grouping is only by staff_id alone
SELECT staff_id, avg(total_sum)
FROM
(select staff_id, customer_id,
sum(amount)as total_sum
from payment
group by staff_id, customer_id) AS Def
GROUP BY staff_id

-- Question: Which staff_id makes on average more revenue per customer?
SELECT staff_id, ROUND(avg(total_sum),3)
FROM
(select staff_id, customer_id,
sum(amount)as total_sum
from payment
group by staff_id, customer_id) AS ag
GROUP BY staff_id
ORDER BY avg(total_sum) desc
-- NOTE * subquery in FROM must have an alias which is "ag" above *
-- Answer: staff_id 2 with an average revenue of 56.639 per customer.
-- Here, 'Uncorrelated subquery' Query was used


/* 10. Create a query that shows average daily revenue of all Sundays  */

select * from payment
--First, arrive at the sum of amount by each payment date and group by payment date
select DATE(payment_date), sum(amount)
from payment
group by DATE(payment_date)

-- Let's extract week day which is Sunday as requested using the EXTRACT function
SELECT DATE(payment_date), extract(dow from payment_date), sum(amount)
FROM payment
WHERE extract(dow from payment_date) = 0
group by DATE(payment_date), extract(dow from payment_date)
-- Note 1: The group by clause on multiple columns/conditions
-- Note 2: In date documentation sunday = 0

-- To further aggregate to get the average daily revenue of sundays, a sub query will be created
select ROUND(avg(total), 2) 
from
(SELECT DATE(payment_date), extract(dow from payment_date), sum(amount) as total
FROM payment
WHERE extract(dow from payment_date) = 0
group by DATE(payment_date), extract(dow from payment_date)) AS yeah
/*    Note sum(amount) should have an alias so as the sub query also, 
      'yeah' was used as an alias here */

-- Question: What is the daily average revenue of all Sundays?
-- Answer: 1423.05
-- Here, 'EXTRACT + Uncorrelated subquery' Query was used


/* 11. Create a list of movies - with their length and their replacement cost 
       that are longer than the average length in each replacement cost group  */

select title, length, replacement_cost
from film

-- This is a 'correlated sub query question'

select fl1.title, fl1.length, replacement_cost
from film fl1
where length > 
(select avg(length)
from film fl2
where fl1.replacement_cost = fl2.replacement_cost)
group by replacement_cost, fl1.title,  fl1.length

-- Question: Which two movies are the shortest on that list and how long are they?
select title, length, replacement_cost
from film fl1
where length > 
(select avg(length)
from film fl2
where fl1.replacement_cost = fl2.replacement_cost)
ORDER BY length asc
--Answer: CELEBRITY HORN and SEATTLE EXPECTATIONS with 110 minutes.
-- Here, 'Correlated subquery' Query was used


/*  12. Create a list that shows the "average customer lifetime value" 
        grouped by the different districts  */

select customer.customer_id, district, sum(amount) as total
from 
customer inner join payment
on customer.customer_id = payment.customer_id
inner join address 
on
customer.address_id = address.address_id
group by customer.customer_id, district
order by district

-- Now, a sub query will be used while the main query calculates the average amount spent
-- Also, subquery in FROM must have an alias

SELECT district, AVG(total)from
(select customer.customer_id, district, sum(amount) as total
from 
customer inner join payment
on customer.customer_id = payment.customer_id
inner join address 
on
customer.address_id = address.address_id
group by customer.customer_id, district
order by district) AS dub
GROUP BY district

-- Result can be rounded up
SELECT district, ROUND(AVG(total), 2) 
from
(select customer.customer_id, district, sum(amount) as total
from 
customer inner join payment
on customer.customer_id = payment.customer_id
inner join address 
on
customer.address_id = address.address_id
group by customer.customer_id, district
order by district) AS dub
GROUP BY district

-- Question: Which district has the highest average customer lifetime value?
SELECT district, ROUND(AVG(total), 2) as avg_value
from
(select customer.customer_id, district, sum(amount) as total
from 
customer inner join payment
on customer.customer_id = payment.customer_id
inner join address 
on
customer.address_id = address.address_id
group by customer.customer_id, district
order by district) AS dub
GROUP BY district
ORDER BY avg_value desc
-- NOTE * subquery in FROM must have an alias which is "dub" above *
-- Answer: Saint-Denis with an average customer lifetime value of 216.54.
-- In the above solution, "an Uncorrelated Subquery was used"


/*  13. Create a list that shows all payments including the payment_id, amount, and 
    the film category (name) plus the total amount that was made in this category.
    Order the results ascendingly by the category (name) 
    and as second order criterion by the payment_id ascendingly  */

select payment_id, 
amount, 
title, 
name
from payment

-- needed attributes below
-- Join sequence and primary keys
select* from payment       -- PK payment_id, FK rental_id (SELECT attributes needed here are i. PAYMENT_ID, ii. AMOUNT  )
select * from rental       -- PK rental_id, FK inventory_id (bridge/join connection table)
select * from inventory    -- PK inventory_id, FK film_id (bridge/join connection table)
select * from film         -- PK film_id  (SELECT attributes needed here is iii. TITLE)
select* from film_category -- PK film_id, FK category_id (bridge/join connection table)
select * from category     -- PK category_id (SELECT attributes needed here is iv. NAME)

-- First, a left join to return all from payment table join to the rental table
select *
from payment p left join rental r
on p.rental_id = r.rental_id
left join inventory iy
on r.inventory_id = iy.inventory_id

-- Next, is a left join to the inventory table
select *
from payment p left join rental r
on p.rental_id = r.rental_id
left join inventory iy
on r.inventory_id = iy.inventory_id
left join film f
on iy.inventory_id = f.inventory_id

-- Next, is a left join to the film table
select *
from payment p left join rental r
on p.rental_id = r.rental_id
left join inventory iy
on r.inventory_id = iy.inventory_id
left join film f
on iy.film_id = f.film_id
left join film_category fc
on f.film_id = fc.film_id

-- Next, is to the film_ category also left join
select *
from payment p left join rental r
on p.rental_id = r.rental_id
left join inventory iy
on r.inventory_id = iy.inventory_id
left join film f
on iy.film_id = f.film_id
left join film_category fc
on f.film_id = fc.film_id

-- Last Join is a left join to the category table
select *
from payment p left join rental r
on p.rental_id = r.rental_id
left join inventory iy
on r.inventory_id = iy.inventory_id
left join film f
on iy.film_id = f.film_id
left join film_category fc
on f.film_id = fc.film_id
left join category ct
on fc.category_id = ct.category_id


select payment_id, 
amount, 
title, 
name
from payment p left join rental r
on p.rental_id = r.rental_id
left join inventory iy
on r.inventory_id = iy.inventory_id
left join film f
on iy.film_id = f.film_id
left join film_category fc
on f.film_id = fc.film_id
left join category ct
on fc.category_id = ct.category_id

--Next is the total amount for each category (name)
select name, p.payment_id, sum(amount) as total_amount
from payment p left join rental r
on p.rental_id = r.rental_id
left join inventory iy
on r.inventory_id = iy.inventory_id
left join film f
on iy.film_id = f.film_id
left join film_category fc
on f.film_id = fc.film_id
left join category ct
on fc.category_id = ct.category_id
GROUP BY name, p.payment_id 
ORDER BY name asc, p.payment_id asc

/* Question: What is the total revenue of the category 'Action' and
   what is the lowest payment_id in that category 'Action'?  */
select name, sum(amount) as total_amount
from payment p left join rental r
on p.rental_id = r.rental_id
left join inventory iy
on r.inventory_id = iy.inventory_id
left join film f
on iy.film_id = f.film_id
left join film_category fc
on f.film_id = fc.film_id
left join category ct
on fc.category_id = ct.category_id
GROUP BY name
ORDER BY name asc
-- Answer: Total revenue in the category 'Action' is 4375.85 and the lowest payment_id in that category is 16055.
-- In the above solution, "an Uncorrelated Subquery" was used


/* 14  Create a list with the top overall revenue of a film title (sum of amount per title)
       for each category (name)  */
	   
select name, f. title, sum(amount) as total_amount
from payment p left join rental r
on p.rental_id = r.rental_id
left join inventory iy
on r.inventory_id = iy.inventory_id
left join film f
on iy.film_id = f.film_id
left join film_category fc
on f.film_id = fc.film_id
left join category ct
on fc.category_id = ct.category_id
GROUP BY name, f.title

-- Question: Which is the top-performing film in the animation category?
select name, f. title, sum(amount) as total_amount
from payment p left join rental r
on p.rental_id = r.rental_id
left join inventory iy
on r.inventory_id = iy.inventory_id
left join film f
on iy.film_id = f.film_id
left join film_category fc
on f.film_id = fc.film_id
left join category ct
on fc.category_id = ct.category_id
GROUP BY name, f.title
HAVING sum(amount) = (SELECT max(total_amount) FROM
						   (select name, f. title, sum(amount) as total_amount
							from payment p left join rental r
							on p.rental_id = r.rental_id
							left join inventory iy
							on r.inventory_id = iy.inventory_id
							left join film f
							on iy.film_id = f.film_id
							left join film_category fc
							on f.film_id = fc.film_id
							left join category ct
							on fc.category_id = ct.category_id
							GROUP BY name, f.title) as dub
						   WHERE ct.name = dub.name)
						   order by total_amount desc
-- NOW, Selecting the max(amount) per category in a correlated subquery with a correlated condition "WHERE"
-- Also, name the sub query in the FROM clause with an aliase which is "dub" here

-- Answer: DOGMA FAMILY with 178.70.
-- In the above solution, "Correlated and Uncorrelated subqueries (nested) were used

