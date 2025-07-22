-------------------------------------
-- Common Table Expressions (CTEs) --
-------------------------------------

-- Normal Sub Query
select * from (
	select EmployeeID, Name, Sales
	from Employees6
	where Department = 'Sales'
) SalesStaff;

-- CTE
with SalesStaff as (
	select EmployeeID, Name, Sales
	from Employees6
	where Department = 'Sales'
)

select * from SalesStaff;


-- Recursive CTE
with Numbers as (
	select 1 as Number

	union all

	select Number + 1 from Numbers where Number < 10
)

select * from Numbers;


-- Employee Hierarchies
with EmployeeTreeHierarchy as (
	select EmployeeID, ManagerID, Name, cast(Name as varchar(max)) as 'Hierarchy', 0 as Level
	from Employees7
	where ManagerID IS NULL

	union all

	select e.EmployeeID, e.ManagerID, e.Name, cast(eth.Hierarchy + ' -> ' + e.Name as varchar(max)), eth.Level + 1 as Level
	from Employees7 e inner join EmployeeTreeHierarchy eth
	on e.ManagerID = eth.EmployeeID
)

select * from EmployeeTreeHierarchy
order by level;


-- Generating a Date Series
declare @StartDate date = '2025-01-01';
declare @EndDate date = '2025-01-31';

with DateSeries as (
	select @StartDate as DateValue

	union all

	select DATEADD(day, 1, DateValue)
	from DateSeries
	where DateValue < @EndDate
)

select * from DateSeries;


-- Identifying Duplicate Records
with DuplicateEmails as (
	select Email, COUNT(*) as DuplicateEmail
	from Contacts
	group by Email
	having COUNT(*) > 1
)

select c.ContactID, c.Name, c.Email
from Contacts c inner join DuplicateEmails de
on c.Email = de.Email;


-- Ranking Items
with SalesTotals as (
	select EmployeeID, SUM(SaleAmount) as TotalSales
	from SalesRecords
	group by EmployeeID
),

RankedSales as (
	select EmployeeID, TotalSales, DENSE_RANK() over (order by TotalSales desc) as SalesRank
	from SalesTotals
)

select * from RankedSales;


-- Calculating Average Sales of Top Performing Employees
with SalesTotals as (
	select EmployeeID, SUM(SaleAmount) as TotalSales
	from SalesRecords
	group by EmployeeID
),

TopSalesEmployees as (
	select top 3 *
	from SalesTotals
	order by TotalSales desc
)

select AVG(TotalSales) as Top3AvgTotalSales from TopSalesEmployees;