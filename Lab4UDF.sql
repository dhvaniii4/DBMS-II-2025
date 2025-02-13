--Lab-4 UDF
--Part – A 
--1. Write a function to print "hello world".
Create or Alter Function hello_world()
returns varchar(100)
as begin 
	Return 'Hello World'
end
Select dbo.hello_world();
--2. Write a function which returns addition of two numbers. 
Create or Alter Function add_two_num(
 @n1 int,
 @n2 int
) 
returns int
as begin 
	return @n1+@n2
end
Select dbo.add_two_num(2,3);
--3. Write a function to check whether the given number is ODD or EVEN. 
Create or Alter Function check_odd_even(
 @n1 int
) 
returns varchar(10)
as begin 
	Declare @res varchar(10);
	if(@n1%2=0)
	begin 
		set @res = 'EVEN';
	end
	else
		set @res = 'ODD';
	return @res
end
select dbo.check_odd_even(12)
--4. Write a function which returns a table with details of a person whose first name starts with B. 
Create or Alter Function fun_detailsPerson()
returns table
as begin
	return (Select * from Employee where firstname like 'B%');
end
Select * from fun_detailsPerson();
--5. Write a function which returns a table with unique first names from the person table. 
Create or Alter Function fun_unique_fname()
returns table
as begin 
	return (Select distinct firstname from person);
end
select dbo.fun_unique_fname();
--6. Write a function to print number from 1 to N. (Using while loop) 

--7. Write a function to find the factorial of a given integer.