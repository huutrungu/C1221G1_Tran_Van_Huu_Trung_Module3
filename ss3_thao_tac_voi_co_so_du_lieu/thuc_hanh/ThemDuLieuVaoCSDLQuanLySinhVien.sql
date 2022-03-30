use quan_ly_sinh_vien;

insert into class 
values (1,"A1","2008-12-20",1);
insert into class 
values (2,"A2","2008-12-22",1);
insert into class
values (3,"B3", current_date, 0);

insert into student(student_name,address,phone,`status`,class_id)
values("Trung","Da-Nang","0131231311",1,1);
insert into student(student_name,address,`status`,class_id)
values("Khoa","Da-Nang",1,1);
insert into student(student_name,address,phone,`status`,class_id)
values("Hong","Da-Nang","0131299311",0,2);

insert into `subject` 
values (1, "CF",5,1),
		(2, "C",6,1),
        (3,"HDJ",5,1),
        (4,"RDBMS",10,1);
        
INSERT INTO `mark` (`mark_id`, `sub_id`, `student_id`, `mark`) VALUES ('1', '1', '1', '8');
