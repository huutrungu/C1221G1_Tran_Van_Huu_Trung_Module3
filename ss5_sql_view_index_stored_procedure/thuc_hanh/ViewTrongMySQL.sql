use classicmodels;

create view customer_views as
select customerNumber, customername, phone
from customers;

select * from customer_views;

create or replace view customer_views as
select customerNumber, customerName, contactFirstName, contactLastName, phone
from customers
where city = 'nantes';

select * from customer_views;

drop view customer_views;