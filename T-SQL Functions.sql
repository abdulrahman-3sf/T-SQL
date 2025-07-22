-----------------------------
--------- Functions ---------
-----------------------------


-----------------------------
------ Scaler Function ------
-----------------------------
create function dbo.GetAvgGrades(@Subject nvarchar(50))
returns int

as
begin
	declare @avgGrades int;

	select @avgGrades = AVG(grade)
	from Students
	where Subject = @Subject;

	return @avgGrades;
end;


-- Use the Function
select Name, dbo.GetAvgGrades(Subject) as AvgGrades
from Teachers;

------------------------------------------------------------------------------------

----------------------------
-- Table-Valued Functions --
----------------------------

-- Inline Table-Valued Functions (ITVFs)
create function dbo.GetStudentsBySubject(@Subject nvarchar(50))
returns table

as
return (
	select * from Students where Subject = @Subject
)

-- Use the Function
select * from dbo.GetStudentsBySubject('Math');

select AVG(Grade) as AvgGrades from dbo.GetStudentsBySubject('Science');

-- Use the Function with Join
select s.StudentID, s.Name as StudentName, t.Name as TeacherName, s.Grade
from dbo.GetStudentsBySubject('Math') as s
JOIN Teachers as t ON s.Subject = t.Subject;


-- Multi-Statement Table-Valued Functions (MTVFs)
create function dbo.GetTopPerformingStudents()
returns @Result table (
	StudentID int,
	Name nvarchar(50),
	Subject nvarchar(50),
	Grade int
)

as
begin
	insert into @Result (StudentID, Name, Subject, Grade)
	select top 3 StudentID, Name, Subject, Grade from Students
	order by grade desc;
	
	return;
end;

-- Use the Function
select * from dbo.GetTopPerformingStudents();