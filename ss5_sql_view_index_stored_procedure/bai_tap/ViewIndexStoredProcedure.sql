create database demo;
use demo;

create table products(
id int primary key,
product_code int,
product_name varChar(50),
product_price double,
product_amount int,
product_description varchar(50),
product_status bit(1)
);
alter table products modify column id int auto_increment; 

insert into `products`(id,product_code,product_name,product_price,product_amount,product_description,product_status) 
values 
(1,1,"iphone8",100,10,null,1),
(2,2,"samsung",200,50,null,1),
(3,3,"nokia",300,30,null,1),
(4,4,"oppo",50,15,null,1);

create unique index product_id on products (product_code);
create index name_and_price on products(product_name,product_price);

EXPLAIN SELECT * FROM products WHERE  product_name = "iphone8" and product_price = 100;

create view product_view as
select product_code, product_name,product_price,product_status from products;

select * from product_view;

-- Tiến hành sửa đổi view
update product_view 
set product_price = 350
where product_code = 1;

-- Tiến hành xoá view
drop view product_view;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
DELIMITER //
create procedure show_all_product()
begin 
select * from products;
end //
DELIMITER ; 
call show_all_product();

-- Tạo store procedure thêm một sản phẩm mới
delimiter //
create procedure add_new_product(in `code` int, in `name` varchar(55), in price double, in amount int)
begin
insert into products (product_code,product_name,product_price,product_amount) value (`code`,`name`,price,amount);
end //
delimiter ;
call add_new_product(5,"book",5,100);

-- Tạo store procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure edit_product_by_id(in `id` int, in new_price double)
begin
update products
set product_price = new_price
where id = `id`;
end //
delimiter ;

set sql_safe_updates = 0;
call edit_product_by_id(1,111);
set sql_safe_updates = 1;

-- Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure delete_product_by_id(in `id` int)
begin 
delete from products
where id = `id`;
end; //  
delimiter ;

set sql_safe_updates = 0;
call delete_product_by_id(1);
set sql_safe_updates = 1;
