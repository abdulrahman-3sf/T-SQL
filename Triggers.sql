----------------------------
--------- Triggers ---------
----------------------------

-------------------------------------------
-- Triggers After Insert, Update, Delete --
-------------------------------------------

-- After Insert
create trigger trg_AfterInsertStudent on Students
after insert

as
begin
	insert into StudentInsertLog(StudentID, Name, Subject, Grade)
	select Studentid, Name, Subject, Grade from inserted;
end;

-- Try it
insert into Students (StudentID, Name, Subject, Grade)
values (10, 'nowa', 'Math', 23);

select * from StudentInsertLog;


-- After Update
create trigger trg_AfterUpdateStudent on Students
after update

as
begin
	if update(grade)
		begin
			insert into StudentUpdateLog(StudentID, OldGrade, NewGrade)

			select i.StudentID, d.grade as OldGrade, i.grade as NewGrade
			from inserted as i inner join deleted as d
			on i.StudentID = d.StudentID;
		end
end;

-- Try it
update Students
set Grade = 99
where StudentID = 4;

select * from StudentUpdateLog;


-- After Delete
create trigger trg_AfterDeleteStudent on Students
after delete

as
begin
	insert into StudentDeleteLog(StudentID, Name, Subject, Grade)
	select StudentID, Name, Subject, Grade from deleted;
end;

-- Try it
delete from Students where StudentID = 10;

select * from StudentDeleteLog;



-----------------------------------------------
-- Triggers Instead Of Insert, Update, Delete --
-----------------------------------------------

-- Instead Of Delete
create trigger trg_InstedOfDeleteStudent on Students
instead of delete

as
begin
	update Students
	set IsActive = 0
	from Students as s inner join deleted as d
	on s.StudentID = d.StudentID;
end

-- Try it
delete Students where StudentID = 1;

select * from Students;


-- Instead Of Update
create trigger trg_UpdateStudentView on StudentView
instead of update

as
begin
	update PersonalInfo
	set Name = i.Name, Address = i.Address
	from PersonalInfo inner join inserted as i
	on PersonalInfo.StudentID = i.StudentID;

	update AcademicInfo
	set Course = i.Course, Grade = i.Grade
	from AcademicInfo inner join inserted as i
	on AcademicInfo.StudentID = i.StudentID;
end;

-- Try it
update StudentView
set Name = 'Khaled', Address = 'Jedda', Course = 'Science', Grade = 99
where StudentID = 1;


-- Instead Of Insert
create trigger trg_InsertStudentView on StudentView
instead of insert

as
begin
	insert into PersonalInfo (StudentID, Name, Address)
	select StudentID, Name, Address from inserted;

	insert into AcademicInfo (StudentID, Course, Grade)
	select StudentID, Course, Grade from inserted;
end;

-- Try it
insert into StudentView (StudentID, Name, Address, Course, Grade)
values (3, 'ali', 'Taif', 'Physics', 88);

select * from StudentView;

select * from PersonalInfo;
select * from AcademicInfo;