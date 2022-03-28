use student_management;
create table class(
`id` int auto_increment,
`name` varchar(50),
  primary key(`id`));

create table teacher(
`id` int auto_increment ,
`name` varchar(50),
`age` int null,
`country` varchar(50),
primary key(`id`));

INSERT INTO `student_management`.`student` (`id`, `name`, `age`, `country`) VALUES ('1', 'Trung', '18', 'VietNam');
insert into student_management.student (`name`,age,country) value ("Khoa",18,"Vn");
insert into student_management.class (`name`) value ("C1221G1");
insert into student_management.class (`name`) value ("C0222G1");
insert into student_management.teacher(`name`,age,country) value ("Chanh",35,"VN");
insert into student_management.teacher(`name`,age,country) value ("Hai",30,"VN");
delete from student where id = 2;

select * from student;
select * from class;
select * from teacher;

alter table student add `point` double;
update student set `point` = 9 where id in (1,3);

alter table teacher add exp int;
alter table teacher drop column exp;