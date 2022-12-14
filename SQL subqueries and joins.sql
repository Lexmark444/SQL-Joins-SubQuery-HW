--1. List all customers who live in Texas (use JOINs)
select customer.customer_id, first_name, last_name
from customer
full join address
on customer.address_id = address.address_id
where district = 'Texas'

--2. Get all payments above $6.99 with the Customer's Full Name
select customer_id, first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 6.99)

--3. Show all customers names who have made payments over $175(use subqueries)
select store_id, first_name, last_name 
from customer
where customer_id in (
	select customer_id
	from payment
	group by customer_id
	having sum(amount) > 175
	order by sum(amount) desc
);

--4. List all customers that live in Nepal (use the city table)
select customer.first_name, customer.last_name, customer.email, country
from customer
full join address
on customer.address_id = address.address_id
full join city
on address.city_id = city.city_id
full join country
on city.country_id = country.country_id 
where country = 'Nepal';


--5. Which staff member had the most transactions?
select first_name, last_name, count(payment.staff_id)
from staff
inner join payment
on staff.staff_id = payment.staff_id
group by first_name, last_name
having count(payment.staff_id) > 7300


--6. How many movies of each rating are there?
select rating, count(rating)
from film
group by rating
order by count(rating) desc;


--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select distinct payment.customer_id, first_name, last_name, amount
from customer
inner join payment
on customer.customer_id = payment.customer_id
where amount in (
	select amount
	from payment
	where amount > 6.99
	)
order by payment.customer_id 

--8. How many free rentals did our store give away?

select payment.rental_id, payment_id, amount
from rental
full join payment
on rental.rental_id = payment.rental_id
where amount is null and payment.rental_id is not null 