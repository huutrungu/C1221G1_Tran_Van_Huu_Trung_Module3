create database student_management;
use student_management;
create table student(
`id` int auto_increment,
`name` varchar(50) ,
`age` int ,
`country` varchar(45) ,
primary key(`id`));