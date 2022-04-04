use furama_manager;

/*
2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
*/
select * from nhan_vien
where ho_ten regexp "^[HKT]"
having length(ho_ten) <= 15;

/*
3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
*/
select * from khach_hang
where  ( round(datediff(curdate(),ngay_sinh)/365) between 18 and 50) 
and (dia_chi like "%Đà Nẵng%" or dia_chi like "%Quảng Trị");

/*
4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 
Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
*/
select khach_hang.ma_khach_hang, khach_hang.ho_ten, count(hop_dong.ma_hop_dong) as "số lần đặt"
from khach_hang
inner join hop_dong on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
inner join loai_khach on loai_khach.ma_loai_khach = khach_hang.ma_loai_khach
where loai_khach.ten_loai_khach = "Diamond"
group by khach_hang.ma_khach_hang
order by count(hop_dong.ma_hop_dong) asc;

/*
5.Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien 
(Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) 
cho tất cả các khách hàng đã từng đặt phòng. 
(những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
*/
select khach_hang.ma_khach_hang,khach_hang.ho_ten,loai_khach.ten_loai_khach, hop_dong.ma_hop_dong,dich_vu.ten_dich_vu,
hop_dong.ngay_lam_hop_dong,hop_dong.ngay_ket_thuc, dich_vu.chi_phi_thue +coalesce((hop_dong_chi_tiet.so_luong*dich_vu_di_kem.gia),0) as "tong_tien"
from loai_khach 
left join khach_hang on khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
left join hop_dong on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
left join dich_vu on dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
left join loai_dich_vu on loai_dich_vu.ma_loai_dich_vu = dich_vu.ma_loai_dich_vu
left join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
left join dich_vu_di_kem on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
group by hop_dong.ma_hop_dong
order by khach_hang.ma_khach_hang asc, hop_dong.ngay_lam_hop_dong asc;

/* 
6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ
 chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).
*/
select dich_vu.ma_dich_vu, dich_vu.ten_dich_vu,dich_vu.dien_tich,  dich_vu.chi_phi_thue, loai_dich_vu.ten_loai_dich_vu
from loai_dich_vu 
inner join dich_vu on dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
inner join hop_dong on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
where dich_vu.ma_dich_vu not in (select hop_dong.ma_dich_vu
from hop_dong
where hop_dong.ngay_lam_hop_dong between '2021-01-01' and '2021-04-01')
group by dich_vu.ma_dich_vu;

/*
7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, 
ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 
nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
*/
select dich_vu.ma_dich_vu,dich_vu.ten_dich_vu,dich_vu.dien_tich,dich_vu.so_nguoi_toi_da,dich_vu.chi_phi_thue,
loai_dich_vu.ten_loai_dich_vu
from loai_dich_vu
inner join dich_vu on dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
inner join hop_dong on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
where dich_vu.ma_dich_vu in (select hop_dong.ma_dich_vu
from hop_dong
where hop_dong.ngay_lam_hop_dong between '2020-01-01' and '2020-12-31') 
and dich_vu.ma_dich_vu not in (select hop_dong.ma_dich_vu
from hop_dong
where hop_dong.ngay_lam_hop_dong between '2021-01-01' and '2021-12-31')
group by dich_vu.ma_dich_vu;

/*
8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
*/
-- cách 1
select khach_hang.ho_ten 
from khach_hang
group by ho_ten;
-- cách 2
select distinct ho_ten from khach_hang;
-- cách 3
select ho_ten from khach_hang
union 
select ho_ten from khach_hang;

/*
9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng 
trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
*/
select month(hop_dong.ngay_lam_hop_dong) as 'thang', count(hop_dong.ma_hop_dong) as 'so_luong_khach_hang'
from hop_dong
inner join khach_hang on khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
where year(hop_dong.ngay_lam_hop_dong) = 2021  
group by month(hop_dong.ngay_lam_hop_dong) 
order by month(hop_dong.ngay_lam_hop_dong) asc;

/*
10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. 
Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem 
(được tính dựa trên việc sum so_luong ở dich_vu_di_kem).
*/
select hop_dong.ma_hop_dong,hop_dong.ngay_lam_hop_dong,hop_dong.ngay_ket_thuc, hop_dong.tien_dat_coc, coalesce(sum(hop_dong_chi_tiet.so_luong),0) as 'so_luong_dich_vu_di_kem'
from hop_dong
left join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
group by hop_dong.ma_hop_dong;

/*
11.	Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng 
có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
*/
select dich_vu_di_kem.ma_dich_vu_di_kem,dich_vu_di_kem.ten_dich_vu_di_kem 
from loai_khach 
inner join khach_hang on khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
inner join hop_dong on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
inner join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
inner join dich_vu_di_kem on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
where loai_khach.ten_loai_khach = "Diamond" 
and (khach_hang.dia_chi like "%Vinh%" or khach_hang.dia_chi like "%Quảng Ngãi");

/*
12.	Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng),
 ten_dich_vu, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), 
 tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 
 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.
*/
select hop_dong.ma_hop_dong, nhan_vien.ho_ten as 'ten_nhan_vien' , khach_hang.ho_ten as 'ten_khach_hang' ,
 khach_hang.so_dien_thoai as 'sdt_khach_hang',
 dich_vu.ten_dich_vu, coalesce(sum(hop_dong_chi_tiet.so_luong),0) as 'so_luong_dich_vu_di_kem',
 hop_dong.tien_dat_coc
 from loai_dich_vu
inner join dich_vu on dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
inner join hop_dong on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
inner join nhan_vien on nhan_vien.ma_nhan_vien = hop_dong.ma_nhan_vien
inner join khach_hang on khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
left join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
where dich_vu.ma_dich_vu in (select hop_dong.ma_dich_vu
from hop_dong
where hop_dong.ngay_lam_hop_dong between '2020-10-01' and '2020-12-31') 
and dich_vu.ma_dich_vu not in (select hop_dong.ma_dich_vu
from hop_dong
where hop_dong.ngay_lam_hop_dong between '2021-01-01' and '2021-5-31')
group by hop_dong.ma_hop_dong;

/*
13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
(Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
*/
select dich_vu_di_kem.ma_dich_vu_di_kem, dich_vu_di_kem.ten_dich_vu_di_kem, sum(hop_dong_chi_tiet.so_luong)
from hop_dong
inner join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
inner join dich_vu_di_kem on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
where dich_vu_di_kem.ma_dich_vu_di_kem 
group by dich_vu_di_kem.ma_dich_vu_di_kem
having sum(hop_dong_chi_tiet.so_luong) >= all (select sum(hop_dong_chi_tiet.so_luong)
from  hop_dong_chi_tiet 
inner join dich_vu_di_kem on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
group by dich_vu_di_kem.ma_dich_vu_di_kem);

/*
14.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. 
Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung 
(được tính dựa trên việc count các ma_dich_vu_di_kem).
*/
-- select hop_dong.ma_hop_dong, dich_vu_di_kem.ten_dich_vu_di_kem, count(hop_dong_chi_tiet.ma_dich_vu_di_kem) as 'so_lan_su_dung'
-- from hop_dong
-- -- inner join dich_vu on dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
-- -- inner join loai_dich_vu on loai_dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
-- inner join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
-- inner join dich_vu_di_kem on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
-- where dich_vu_di_kem.ma_dich_vu_di_kem
-- group by dich_vu_di_kem.ma_dich_vu_di_kem
-- having count(hop_dong_chi_tiet.ma_dich_vu_di_kem) = 1
-- order by hop_dong.ma_hop_dong; --> lỗi mạch join

select hop_dong.ma_hop_dong, loai_dich_vu.ten_loai_dich_vu, dich_vu_di_kem.ten_dich_vu_di_kem,
 count(hop_dong_chi_tiet.ma_dich_vu_di_kem) as 'so_lan_su_dung'
 from loai_dich_vu
 inner join dich_vu on dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
 inner join hop_dong on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
 inner join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
 inner join dich_vu_di_kem on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
 where dich_vu_di_kem.ma_dich_vu_di_kem
group by dich_vu_di_kem.ma_dich_vu_di_kem
having count(hop_dong_chi_tiet.ma_dich_vu_di_kem) = 1
order by hop_dong.ma_hop_dong;

/*
15.	Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, 
ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.
*/
 select nhan_vien.ma_nhan_vien,nhan_vien.ho_ten, trinh_do.ten_trinh_do, bo_phan.ten_bo_phan,
 nhan_vien.so_dien_thoai, nhan_vien.dia_chi, count(hop_dong.ma_nhan_vien) as 'so_hop_dong_da_lap_trong_2_nam_gan_day'
 from hop_dong
 left join nhan_vien on nhan_vien.ma_nhan_vien = hop_dong.ma_nhan_vien
 inner join trinh_do on trinh_do.ma_trinh_do = nhan_vien.ma_trinh_do
 inner join bo_phan on bo_phan.ma_bo_phan = nhan_vien.ma_bo_phan
 where hop_dong.ma_nhan_vien in (select hop_dong.ma_nhan_vien
from hop_dong
where hop_dong.ngay_lam_hop_dong between '2020-01-01' and '2021-12-31') 
 group by nhan_vien.ma_nhan_vien
 having count(hop_dong.ma_nhan_vien) <= 3
 order by nhan_vien.ma_nhan_vien;
 
 /*
 16. Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.
 */
 -- > cách ko chạy
 delete from nhan_vien
 where nhan_vien.ma_nhan_vien in
 (select nhan_vien.ma_nhan_vien
 from hop_dong
 right join nhan_vien on nhan_vien.ma_nhan_vien = hop_dong.ma_nhan_vien
 inner join trinh_do on trinh_do.ma_trinh_do = nhan_vien.ma_trinh_do
 right join bo_phan on bo_phan.ma_bo_phan = nhan_vien.ma_bo_phan
where nhan_vien.ma_nhan_vien not in (select hop_dong.ma_nhan_vien
from hop_dong
where hop_dong.ngay_lam_hop_dong between '2020-01-01' and '2021-12-31') 
 group by nhan_vien.ma_nhan_vien
 having count(hop_dong.ma_nhan_vien) <1
 order by nhan_vien.ma_nhan_vien);

 -- > CHẠY ĐƯỢC
 set sql_safe_updates = 0;
 delete from nhan_vien
 where nhan_vien.ma_nhan_vien not in 
 (select hop_dong.ma_nhan_vien from hop_dong );
  set sql_safe_updates = 1;
 
  -- > những nhân viên sẽ bị xoá
(select nhan_vien.ma_nhan_vien,nhan_vien.ho_ten, trinh_do.ten_trinh_do, bo_phan.ten_bo_phan,
 nhan_vien.so_dien_thoai, nhan_vien.dia_chi, count(hop_dong.ma_nhan_vien) as 'so_hop_dong_da_lap'
 from hop_dong
 right join nhan_vien on nhan_vien.ma_nhan_vien = hop_dong.ma_nhan_vien
 inner join trinh_do on trinh_do.ma_trinh_do = nhan_vien.ma_trinh_do
 right join bo_phan on bo_phan.ma_bo_phan = nhan_vien.ma_bo_phan
where nhan_vien.ma_nhan_vien not in (select hop_dong.ma_nhan_vien
from hop_dong
where hop_dong.ngay_lam_hop_dong between '2020-01-01' and '2021-12-31') 
 group by nhan_vien.ma_nhan_vien
 having count(hop_dong.ma_nhan_vien) <1
 order by nhan_vien.ma_nhan_vien);
 
/*
17.	Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond, 
chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.
*/
create view thay_doi_loai_khach as  (select khach_hang.ma_khach_hang,khach_hang.ho_ten,loai_khach.ten_loai_khach,
sum(dich_vu.chi_phi_thue +coalesce((hop_dong_chi_tiet.so_luong*dich_vu_di_kem.gia),0)) as "tong_tien_thanh_toan"
from loai_khach 
left join khach_hang on khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
left join hop_dong on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
left join dich_vu on dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
left join loai_dich_vu on loai_dich_vu.ma_loai_dich_vu = dich_vu.ma_loai_dich_vu
left join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
left join dich_vu_di_kem on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
where (hop_dong.ngay_lam_hop_dong between '2021-01-01' and '2021-12-31') and (loai_khach.ten_loai_khach = "platinium")
group by khach_hang.ma_khach_hang
having sum(dich_vu.chi_phi_thue +coalesce((hop_dong_chi_tiet.so_luong*dich_vu_di_kem.gia),0)) > 10000000);
select * from thay_doi_loai_khach;

 set sql_safe_updates = 0;
update khach_hang
set ma_loai_khach = 1
where khach_hang.ma_khach_hang in (select khach_hang.ma_khach_hang from thay_doi_loai_khach );
 set sql_safe_updates = 1;

/*
18.	Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).
*/
create view khach_hang_co_hop_dong_truoc_2021 as (select khach_hang.ma_khach_hang, khach_hang.ho_ten, hop_dong.ngay_lam_hop_dong
from khach_hang
inner join hop_dong on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
where (hop_dong.ngay_lam_hop_dong not between '2021-01-01' and '2022-04-04'));
select * from khach_hang_co_hop_dong_truoc_2021;

 set sql_safe_updates = 0;
 set foreign_key_checks = off;
 delete from khach_hang
 where khach_hang.ma_khach_hang in (select khach_hang.ma_khach_hang from 
 (select khach_hang.ma_khach_hang from khach_hang_co_hop_dong_truoc_2021) as x );
 set sql_safe_updates = 1;
 set foreign_key_checks = on;
 -- cong thuc 
-- UPDATE tbl SET col = (
--   SELECT ... FROM (SELECT.... FROM) AS x);

/*
19.	Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.
*/
 create view dich_vu_di_kem_duoc_su_dung_tren_10_lan_trong_2020 as ( select dich_vu_di_kem.ma_dich_vu_di_kem, dich_vu_di_kem.ten_dich_vu_di_kem, sum(hop_dong_chi_tiet.so_luong) as 'so_lan_su_dung'
from hop_dong
inner join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
inner join dich_vu_di_kem on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
where dich_vu_di_kem.ma_dich_vu_di_kem and (hop_dong.ngay_lam_hop_dong  between '2020-01-01' and '2020-12-31')
group by dich_vu_di_kem.ma_dich_vu_di_kem
having sum(hop_dong_chi_tiet.so_luong) > 10);
select * from dich_vu_di_kem_duoc_su_dung_tren_10_lan_trong_2020;

 set sql_safe_updates = 0;
update dich_vu_di_kem
set gia = gia*2
where dich_vu_di_kem.ma_dich_vu_di_kem in (select dich_vu_di_kem_duoc_su_dung_tren_10_lan_trong_2020.ma_dich_vu_di_kem 
from dich_vu_di_kem_duoc_su_dung_tren_10_lan_trong_2020 );

 set sql_safe_updates = 0;
update khach_hang
set ma_loai_khach = 1
where khach_hang.ma_khach_hang in (select khach_hang.ma_khach_hang from thay_doi_loai_khach );
 set sql_safe_updates = 1;

select dich_vu_di_kem.ten_dich_vu_di_kem,dich_vu_di_kem.gia  from dich_vu_di_kem;

/*
20.	Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, thông tin hiển thị 
bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.
*/
select nhan_vien.ma_nhan_vien as `id` ,nhan_vien.ho_ten,nhan_vien.email,nhan_vien.so_dien_thoai,nhan_vien.ngay_sinh,
nhan_vien.dia_chi, "nhan_vien" as `role`  
from nhan_vien 
union
select khach_hang.ma_khach_hang as `id`,khach_hang.ho_ten,khach_hang.email,khach_hang.so_dien_thoai,khach_hang.ngay_sinh,
khach_hang.dia_chi, "khach_hang" as `role`
from khach_hang



