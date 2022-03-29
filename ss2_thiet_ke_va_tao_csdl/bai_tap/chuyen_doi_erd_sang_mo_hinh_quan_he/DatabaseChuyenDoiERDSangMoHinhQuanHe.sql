create database quan_ly_vat_tu;
use quan_ly_vat_tu;
create table vat_tu(
ma_vtu int primary key,
ten_vtu varchar(20));

create table phieu_xuat(
so_px int primary key,
ngay_xuat datetime);

create table chi_tiet_phieu_xuat(
dg_xuat float, 
sl_xuat int,
ma_vtu int,
so_px int,
primary key (ma_vtu,so_px),
foreign key (ma_vtu) references vat_tu(ma_vtu),
foreign key (so_px) references phieu_xuat(so_px)
);

create table phieu_nhap(
so_pn int primary key,
ngay_nhap datetime);


create table chi_tiet_phieu_nhap(
dg_nhap float,
sl_nhap int,
ma_vtu int,
so_pn int,
primary key (ma_vtu,so_pn),
foreign key (ma_vtu) references vat_tu(ma_vtu),
foreign key (so_pn) references phieu_nhap(so_pn)
);

create table nha_cung_cap(
ma_ncc int primary key,
ten_ncc varchar(55),
dia_chi varchar(100)
);

create table don_dat_hang(
so_dh int primary key,
ngay_dh date,
ma_ncc int,
foreign key (ma_ncc) references nha_cung_cap(ma_ncc)
);

create table chi_tiet_don_dat_hang(
ma_vtu int,
so_dh int,
primary key(ma_vtu,so_dh),
foreign key (ma_vtu) references vat_tu(ma_vtu),
foreign key (so_dh) references don_dat_hang(so_dh)
);

create table so_dien_thoai(
ma_sdt int auto_increment primary key,
value_sdt varchar(10),
ma_ncc int,
foreign key (ma_ncc) references nha_cung_cap(ma_ncc)
);


