use quan_ly_sinh_vien;


--
select address as "địa chỉ",count(student.student_id) as "số lượng học viên"
from student
group by address;

select student.student_name, avg(mark) as "điểm trung bình" 
from student
inner join mark on mark.mark_id = student.student_id
group by student.student_name;

select student.student_name, avg(mark) as "điểm trung bình" 
from student
inner join mark on mark.mark_id = student.student_id
group by student.student_name
having avg(mark) > 8;

select student.student_name, avg(mark) as "điểm trung bình" 
from student
inner join mark on mark.mark_id = student.student_id
group by student.student_name
having avg(mark) >= all (select avg(mark) from mark group by mark.student_id);




