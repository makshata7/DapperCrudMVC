create database EmployeeDB3
go

use EmployeeDB3
go

create table Employees
(
	Id int primary key identity(1,1) not null,
	Name nvarchar(300) not null,
	Salary int not null,
	MobileNumber int not null,
	Address nvarchar(300) not null
)
go

create proc [dbo].[Employees_Create]
	@Id int,
	@Name nvarchar(300),
	@Salary int,
	@MobileNumber int,
	@Address varchar(300)
	
as begin
	insert into Employees
	(
		Name,
		Salary,
		MobileNumber,
		Address
	)
    values
	(
		@Name,
		@Salary,
		@MobileNumber,
		@Address
	)

	select SCOPE_IDENTITY() InsertedId
end
go

create proc [dbo].[Get_Employees]
	@Id int = null,
	@Search nvarchar(50) = null,
	@OrderBy varchar(100) = 'name',
	@IsDescending bit = 0
as begin
	select 
		Name,
		Salary,
		MobileNumber,
		Address
	from 
		Employees
	where
		Id = coalesce(@Id, Id)
		and
		(
			(@Search is null or @Search = '')
			or
			(
				@Search is not null
				and
				(
					Name like '%' + @Search + '%'
					or
					Salary like '%' + @Search + '%'
					or
					MobileNumber like '%' + @Search + '%'
					or
					Address like '%' + @Search + '%'
				)
			)
		)
	order by
		case when @OrderBy = 'name' and @IsDescending = 0 then Name end asc
		, case when @OrderBy = 'name' and @IsDescending = 1 then Name end desc
		, case when @OrderBy = 'salary' and @IsDescending = 0 then salary end asc
		, case when @OrderBy = 'salary' and @IsDescending = 1 then salary end desc
		, case when @OrderBy = 'mobilenumber' and @IsDescending = 0 then mobilenumber end asc
		, case when @OrderBy = 'mobilenumber' and @IsDescending = 1 then mobilenumber end desc
		, case when @OrderBy = 'address' and @IsDescending = 0 then address end asc
		, case when @OrderBy = 'address' and @IsDescending = 1 then address end desc
		
end
go

SET IDENTITY_INSERT [dbo].[Employees] ON 
GO
INSERT [dbo].[Employees] ([Id], [Name], [Salary], [MobileNumber], [Address] ) VALUES (1, N'Rima', 1000, N'12343455', N'Maharashtra')
GO
INSERT [dbo].[Employees] ([Id], [Name], [Salary], [MobileNumber], [Address]) VALUES (2, N'Rohit', 59000, N'23435465', N'Chennai')
GO
INSERT [dbo].[Employees] ([Id], [Name], [Salary], [MobileNumber], [Address] ) VALUES (3, N'Siya', 4000, N'24355678', N'Kashmir')
GO
INSERT [dbo].[Employees] ([Id], [Name], [Salary], [MobileNumber], [Address]) VALUES (4, N'Priya', 2000, N'1234565768', N'Kerala')
GO
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO

create proc [dbo].[Employees_Get]
	@Id int
as begin
	select 
		Id,
		Name,
		Salary,
		MobileNumber,
		Address
	from 
		Employees
	where 
		Id = @Id
end
go


create proc [dbo].[Employees_Update]
	@Id int,
	@Name nvarchar(300),
	@Salary int,
	@MobileNumber int,
	@Address varchar(300)
as begin
	update 
		Employees
	set
		Name = @Name,
		Salary = @Salary,
		MobileNumber = @MobileNumber,
		Address = @Address	
	where 
		Id=@Id
end
go


create proc [dbo].[Employees_Delete]
	@Id int
as begin
	delete 
	from 
		Employees
	where 
		Id = @Id
end
go