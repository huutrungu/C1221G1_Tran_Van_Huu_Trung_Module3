use quan_ly_sinh_vien;

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select `subject`.*
from `subject`
group by `subject`.sub_id
having `subject`.credit >= all (select `subject`.credit from `subject` group by `subject`.credit);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select `subject`.*, mark.mark 
from `subject`
inner join mark on mark.sub_id = `subject`.sub_id
group by `subject`.sub_id
having mark.mark >= all (select mark.mark from mark group by mark.mark);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select student.*, avg(mark.mark) as "điểm trung bình"
from student
inner join mark on mark.student_id = student.student_id
group by student_id
order by mark.mark desc;



