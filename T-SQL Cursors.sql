-----------------------------
---------- Cursors ----------
-----------------------------

-- USE IT WHEN IT IS THE LAST OPTION YOU HAVE --


-- Static Cursor
declare static_cursor cursor static for
select StudentID, Name, Grade from Students;

open static_cursor;

declare @StudentID int, @Name nvarchar(50), @Grade int;

fetch next from static_cursor into @StudentID, @Name, @Grade;

while @@FETCH_STATUS = 0
begin
	print 'StudentID: ' + cast(@StudentID as nvarchar(10)) + ', Name: ' + @Name + ', Grade: ' + cast(@Grade as nvarchar(10));

	fetch next from static_cursor into @StudentID, @Name, @Grade;
end;

close static_cursor;
deallocate static_cursor;


-- Dynamic Cursor
declare dynamic_cursor cursor dynamic for
select StudentID, Name, Grade from Students;

open dynamic_cursor;

declare @StudentID int, @Name nvarchar(50), @Grade int;

fetch next from dynamic_cursor into @StudentID, @Name, @Grade;

while @@FETCH_STATUS = 0
begin
	print 'StudentID: ' + cast(@StudentID as nvarchar(10)) + ', Name: ' + @Name + ', Grade: ' + cast(@Grade as nvarchar(10));

	fetch next from dynamic_cursor into @StudentID, @Name, @Grade;
end;

close dynamic_cursor;
deallocate dynamic_cursor;


-- Forward Cursor (we can also put it dynamic) [ONE WAY]
declare forward_only_cursor cursor static forward_only for
select StudentID, Name, Grade from Students;

open forward_only_cursor;

declare @StudentID int, @Name nvarchar(50), @Grade int;

fetch next from forward_only_cursor into @StudentID, @Name, @Grade;

while @@FETCH_STATUS = 0
begin
	print 'StudentID: ' + cast(@StudentID as nvarchar(10)) + ', Name: ' + @Name + ', Grade: ' + cast(@Grade as nvarchar(10));

	fetch next from forward_only_cursor into @StudentID, @Name, @Grade;
end;

close forward_only_cursor;
deallocate forward_only_cursor;


-- Scrollable Cursor [TWO WAY]
declare scroll_cursor cursor static scroll for
select StudentID, Name, Grade from Students;

open scroll_cursor;

declare @StudentID int, @Name nvarchar(50), @Grade int;

fetch next from scroll_cursor into @StudentID, @Name, @Grade;

while @@FETCH_STATUS = 0
begin
	print 'StudentID: ' + cast(@StudentID as nvarchar(10)) + ', Name: ' + @Name + ', Grade: ' + cast(@Grade as nvarchar(10));

	-- fetch prior from scroll_cursor into @StudentID, @Name, @Grade;
	fetch next from scroll_cursor into @StudentID, @Name, @Grade;
end;

close scroll_cursor;
deallocate scroll_cursor;