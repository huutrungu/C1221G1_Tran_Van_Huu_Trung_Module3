create database furama_manager;
use furama_manager;

create table vi_tri(
ma_vi_tri int primary key,
ten_vi_tri varchar(45)
);

create table trinh_do(
ma_trinh_do int primary key,
ten_trinh_do varchar(45)
);

create table bo_phan(
ma_bo_phan int primary key,
ten_bo_phan varchar(45)
);

create table nhan_vien(
ma_nhan_vien int primary key,
ho_ten varchar(45) not null,
ngay_sinh date not null,
so_cmnd varchar(45) not null,
luong double not null,
so_dien_thoai varchar(45) not null, 
email varchar(45),
dia_chi varchar(45),
ma_vi_tri int,
ma_trinh_do int,
ma_bo_phan int,
foreign key (ma_vi_tri) references vi_tri(ma_vi_tri),
foreign key (ma_trinh_do) references trinh_do(ma_trinh_do),
foreign key (ma_bo_phan) references bo_phan(ma_bo_phan)
);

create table loai_khach(
ma_loai_khach int primary key,
ten_loai_khach varchar(45)
);

create table khach_hang(
ma_khach_hang int primary key,
ma_loai_khach int,
ho_ten varchar(45) not null,
ngay_sinh date not null, 
gioi_tinh bit(1) not null,
so_cmnd varchar(45) not null,
so_dien_thoai varchar(45) not null,
email varchar(45),
dia_chi varchar(45),
foreign key (ma_loai_khach) references loai_khach(ma_loai_khach)
);

create table loai_dich_vu(
ma_loai_dich_vu int primary key,
ten_loai_dich_vu varchar(45)
);

create table kieu_thue(
ma_kieu_thue int primary key,
ten_kieu_thue varchar(45)
);

create table dich_vu(
ma_dich_vu int primary key,
ten_dich_vu varchar(45) not null,
dien_tich int,
chi_phi_thue double not null,
so_nguoi_toi_da int,
ma_kieu_thue int,
ma_loai_dich_vu int,
tieu_chuan_phong varchar(45),
mo_ta_tien_nghi_khac varchar(45),
dien_tich_ho_boi double,
so_tang int,
foreign key (ma_kieu_thue) references kieu_thue(ma_kieu_thue),
foreign key (ma_loai_dich_vu) references loai_dich_vu(ma_loai_dich_vu)
);

create table hop_dong(
ma_hop_dong int primary key,
ngay_lam_hop_dong datetime not null,
ngay_ket_thuc datetime not null,
tien_dat_coc double not null,
ma_nhan_vien int,
ma_khach_hang int,
ma_dich_vu int,
foreign key (ma_nhan_vien) references nhan_vien(ma_nhan_vien),
foreign key (ma_khach_hang) references khach_hang(ma_khach_hang),
foreign key (ma_dich_vu) references dich_vu(ma_dich_vu)
);

create table dich_vu_di_kem(
ma_dich_vu_di_kem int primary key,
ten_dich_vu_di_kem varchar(45) not null, 
gia double not null,
don_vi varchar(10) not null,
trang_thai varchar(45)
);

 create table hop_dong_chi_tiet(
ma_hop_dong_chi_tiet int primary key,
ma_hop_dong int,
ma_dich_vu_di_kem int,
so_luong int not null,
foreign key (ma_hop_dong) references hop_dong(ma_hop_dong),
foreign key (ma_dich_vu_di_kem) references dich_vu_di_kem(ma_dich_vu_di_kem)
);

-- update not null for all forein key
ALTER TABLE `furama_manager`.`nhan_vien` 
DROP FOREIGN KEY `nhan_vien_ibfk_1`,
DROP FOREIGN KEY `nhan_vien_ibfk_2`,
DROP FOREIGN KEY `nhan_vien_ibfk_3`;
ALTER TABLE `furama_manager`.`nhan_vien` 
CHANGE COLUMN `ma_vi_tri` `ma_vi_tri` INT NOT NULL ,
CHANGE COLUMN `ma_trinh_do` `ma_trinh_do` INT NOT NULL ,
CHANGE COLUMN `ma_bo_phan` `ma_bo_phan` INT NOT NULL ;
ALTER TABLE `furama_manager`.`nhan_vien` 
ADD CONSTRAINT `nhan_vien_ibfk_1`
  FOREIGN KEY (`ma_vi_tri`)
  REFERENCES `furama_manager`.`vi_tri` (`ma_vi_tri`),
ADD CONSTRAINT `nhan_vien_ibfk_2`
  FOREIGN KEY (`ma_trinh_do`)
  REFERENCES `furama_manager`.`trinh_do` (`ma_trinh_do`),
ADD CONSTRAINT `nhan_vien_ibfk_3`
  FOREIGN KEY (`ma_bo_phan`)
  REFERENCES `furama_manager`.`bo_phan` (`ma_bo_phan`);
  
ALTER TABLE `furama_manager`.`khach_hang` 
CHANGE COLUMN `ma_loai_khach` `ma_loai_khach` INT NOT NULL ;

ALTER TABLE `furama_manager`.`hop_dong_chi_tiet` 
DROP FOREIGN KEY `hop_dong_chi_tiet_ibfk_1`,
DROP FOREIGN KEY `hop_dong_chi_tiet_ibfk_2`;
ALTER TABLE `furama_manager`.`hop_dong_chi_tiet` 
CHANGE COLUMN `ma_hop_dong` `ma_hop_dong` INT NOT NULL ,
CHANGE COLUMN `ma_dich_vu_di_kem` `ma_dich_vu_di_kem` INT NOT NULL ;
ALTER TABLE `furama_manager`.`hop_dong_chi_tiet` 
ADD CONSTRAINT `hop_dong_chi_tiet_ibfk_1`
  FOREIGN KEY (`ma_hop_dong`)
  REFERENCES `furama_manager`.`hop_dong` (`ma_hop_dong`),
ADD CONSTRAINT `hop_dong_chi_tiet_ibfk_2`
  FOREIGN KEY (`ma_dich_vu_di_kem`)
  REFERENCES `furama_manager`.`dich_vu_di_kem` (`ma_dich_vu_di_kem`);
  
  ALTER TABLE `furama_manager`.`hop_dong` 
DROP FOREIGN KEY `hop_dong_ibfk_1`,
DROP FOREIGN KEY `hop_dong_ibfk_2`,
DROP FOREIGN KEY `hop_dong_ibfk_3`;
ALTER TABLE `furama_manager`.`hop_dong` 
CHANGE COLUMN `ma_nhan_vien` `ma_nhan_vien` INT NOT NULL ,
CHANGE COLUMN `ma_khach_hang` `ma_khach_hang` INT NOT NULL ,
CHANGE COLUMN `ma_dich_vu` `ma_dich_vu` INT NOT NULL ;
ALTER TABLE `furama_manager`.`hop_dong` 
ADD CONSTRAINT `hop_dong_ibfk_1`
  FOREIGN KEY (`ma_nhan_vien`)
  REFERENCES `furama_manager`.`nhan_vien` (`ma_nhan_vien`),
ADD CONSTRAINT `hop_dong_ibfk_2`
  FOREIGN KEY (`ma_khach_hang`)
  REFERENCES `furama_manager`.`khach_hang` (`ma_khach_hang`),
ADD CONSTRAINT `hop_dong_ibfk_3`
  FOREIGN KEY (`ma_dich_vu`)
  REFERENCES `furama_manager`.`dich_vu` (`ma_dich_vu`);
  
  ALTER TABLE `furama_manager`.`dich_vu` 
DROP FOREIGN KEY `dich_vu_ibfk_1`,
DROP FOREIGN KEY `dich_vu_ibfk_2`;
ALTER TABLE `furama_manager`.`dich_vu` 
CHANGE COLUMN `ma_kieu_thue` `ma_kieu_thue` INT NOT NULL ,
CHANGE COLUMN `ma_loai_dich_vu` `ma_loai_dich_vu` INT NOT NULL ;
ALTER TABLE `furama_manager`.`dich_vu` 
ADD CONSTRAINT `dich_vu_ibfk_1`
  FOREIGN KEY (`ma_kieu_thue`)
  REFERENCES `furama_manager`.`kieu_thue` (`ma_kieu_thue`),
ADD CONSTRAINT `dich_vu_ibfk_2`
  FOREIGN KEY (`ma_loai_dich_vu`)
  REFERENCES `furama_manager`.`loai_dich_vu` (`ma_loai_dich_vu`);










