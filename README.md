# SQL---Project-Scenarios-Data-Exploration-in-SQL-

Hello, at this time, allow me to show you my real project scenarios. I solved analytical problems using SQL. I used PostgreSQL, by the way.

A little bit introduction and reminder about SQL
“Structured query language (SQL) is a programming language for storing and processing information in a relational database. A relational database stores information in tabular form, with rows and columns representing different data attributes and the various relationships between the data values. You can use SQL statements to store, update, remove, search, and retrieve information from the database. You can also use SQL to maintain and optimize database performance.”

SELECT, FROM, COUNT, UNIQUE, DISTINCT, CASE-WHEN, LIKE, ALIASES, CONCATENATE, ORDER BY, GROUP BY, JOINS, AGGREGATE FUNCTIONS (SUM, AVG, etc.), DATE/TIME, EXTRACT, SUB QUERY (CORRELATED AND UNCORRELATED)

Stick close and enjoy and find useful comments in between query lines.

For this project, several tables were used ant the top 10 rows of each tables and their respective column names and attributes are displayed to give a feel of what each query line entails:
-- Also, find attached a picture of what the data output from final queries look like.

  i. film_table of 1000 rows with columns film_id, title, length, replacement_cost, and rating   
  
 ii. film_category_table of 1000 rows with columns film_id, category_id
 
iii. category_table of 16 rows with columns category_id, name

 iv. film_actor_table of 5462 rows with columns actor_id, film_id
 
  v. actor_table of 200 rows with columns actor_id, first_name, last_name
  
 vi. customer_table of 599 rows with columns customer_id, store_id, first_name, last_name, email, address_id
 
vii. address_table of 603 rows with columns address_id, district, city_id, postal_code, phone

viii.city_table of 600 rows with columns city_id, city, country_id

 ix. payment_table of 16049 rows with columns payment_id, customer_id, staff_id, rental_id, amount
 
  x. inventory_table of 4581 rows with columns inventory_id, film_id, store_id
  
 xi. rental_table of 16044 rows with columns rental_id, rental_date, inventory_id, customer_id, return_date, staff_id    
 
  */
