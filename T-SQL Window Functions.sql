----------------------
-- Window Functions --
----------------------


select name, subject, grade, ROW_NUMBER() over (order by grade desc) as Rownum
from students
order by grade desc;


--
select name, subject, grade, RANK() over (order by grade desc) as Rownum
from students
order by grade desc;


--
select name, subject, grade, DENSE_RANK() over (order by grade desc) as Rownum
from students
order by grade desc;


--
select name, subject, grade, DENSE_RANK() over (partition by subject order by grade desc) as Rownum
from students;


--
select name, subject, grade,
	AVG(grade) over (partition by subject) as AvgGrades,
	SUM(grade) over (partition by subject) as TotalGrades
from students;


--
select studentID, name,
	LAG(grade, 1) over (order by grade desc) as prevGrade,
	grade,
	LEAD(grade, 1) over (order by grade desc) as nextGrade
from students;


--
declare @PageNumber int, @RowsPerPage int;

set @PageNumber = 1;
set @RowsPerPage = 3;

select * from students
order by studentID
offset (@PageNumber - 1) * @RowsPerPage rows
fetch next @RowsPerPage rows only;