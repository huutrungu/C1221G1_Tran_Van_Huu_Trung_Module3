use quan_ly_sinh_vien;


-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select * from student 
where Left(student_name,1) = "H";


-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select * from class
where month(start_date) = 12;
-- tương tự
select * from class 
where monthname(start_date) = "december";


-- hiển thị thông tin môn học có credit từ 3-5
select * from `subject`
where credit >= 3 and credit <= 5;
-- tương tự
select * from `subject`
where credit between 3 and 5;


-- tắt safe update tạm thời và đổi class_id theo tên.
set sql_safe_updates = 0;
update student set class_id = 2 where student_name = "khoa";
set sql_safe_updates = 1;

/* Hiển thị các thông tin: StudentName, SubName, Mark. 
Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. 
Nếu trùng sắp theo tên tăng dần. */
select student.student_name,`subject`.sub_name,mark.mark
from ((student
inner join mark on student.student_id = mark.student_id)
inner join `subject` on `subject`.sub_id = mark.sub_id )
order by mark.mark desc,student.student_name asc;





