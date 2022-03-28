create database student_management;
use student_management;
create table student(
`id` int not null,
`name` varchar(50) null,
`age` int null,
`country` varchar(45) null,
primary key(`id`));