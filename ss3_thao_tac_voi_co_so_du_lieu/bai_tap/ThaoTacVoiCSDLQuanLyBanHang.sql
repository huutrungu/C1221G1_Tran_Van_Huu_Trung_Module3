use quan_ly_ban_hang;

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select `order`.order_id,`order`.order_date,`order`.order_total_price from `order`;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select customer.*,product.* from product 
inner join order_detail on order_detail.product_id = product.product_id
inner join `order` on `order`.order_id = order_detail.order_id
inner join customer on customer.cus_id = `order`.cus_id;
-- tương tự (đi ngược lại)
select customer.*, product.* from customer
inner join `order` on `order`.cus_id = customer.cus_id
inner join order_detail on order_detail.order_id = `order`.order_id
inner join product on product.product_id = order_detail.product_id;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select customer.cus_id, customer.cus_name, `order`.order_id from customer
left join `order` on `order`.cus_id = customer.cus_id
where `order`.order_id is null;

/*
Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
(giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn.
Giá bán của từng loại được tính = odQTY*pPrice)
*/
select `order`.order_id,`order`.order_date, order_detail.order_quantity*product.product_price as total
from `order` 
inner join order_detail on order_detail.order_id = `order`.order_id
inner join product on product.product_id = order_detail.product_id


