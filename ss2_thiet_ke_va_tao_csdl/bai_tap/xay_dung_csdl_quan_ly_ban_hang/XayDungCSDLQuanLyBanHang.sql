create database quan_ly_ban_hang;
use quan_ly_ban_hang;

create table customer(
cus_id int auto_increment primary key,
cus_name varchar(50),
cus_age date
);

create table `order`(
order_id int auto_increment primary key,
cus_id int,
order_date date,
order_total_price float,
foreign key (cus_id) references customer(cus_id)
);

create table product(
product_id int auto_increment primary key,
product_name varchar(100),
product_price float
);

create table order_detail(
order_id int,
product_id int,
order_quantity int,
primary key (order_id,product_id),
foreign key (order_id) references `order`(order_id),
foreign key (product_id) references product(product_id)
);

