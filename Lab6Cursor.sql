Create Database CSE_4A_132
--Lab-6 Cursor
CREATE TABLE Products ( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL 
); 
Select * from Products
INSERT INTO Products (Product_id, Product_Name, Price) VALUES 
(1, 'Smartphone', 35000), 
(2, 'Laptop', 65000), 
(3, 'Headphones', 5500), 
(4, 'Television', 85000), 
(5, 'Gaming Console', 32000); 

--Part - A 
--1. Create a cursor Product_Cursor to fetch all the rows from a products table. 
Declare @prod_id int, @prod_nm varchar(100), @price int;

Declare Product_Cursor Cursor
for Select * from Products;

Open Product_Cursor;

Fetch Next From Product_Cursor into @prod_id, @prod_nm, @price;

while @@FETCH_STATUS=0
	Begin 
		Print(Cast(@prod_id as varchar(10)) + '-' + @prod_nm + '-' + Cast(@price as Varchar(20)));
		Fetch Next From Product_Cursor into @prod_id, @prod_nm, @price;
	end;

Close Product_Cursor;
Deallocate Product_Cursor;
--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName. 
--(Example: 1_Smartphone) 
Declare @pro_id int, @prod_name Varchar(100)
Declare Product_Cursor_Fetch cursor
for Select Product_id, Product_name from Products;

open Product_Cursor_Fetch;

Fetch next from Product_Cursor_Fetch into @pro_id, @prod_name;

while @@FETCH_STATUS=0
	Begin
		Print Cast(@pro_id as varchar(10))+'_'+@prod_name;
		Fetch next from Product_Cursor_Fetch into @pro_id, @prod_name;
	End;
Close Product_Cursor_Fetch;
Deallocate Product_Cursor_Fetch;
--3. Create a Cursor to Find and Display Products Above Price 30,000. 
Declare @pro_name Varchar(100), @pric Decimal(10,2);
Declare Cursor_Find_Display cursor
for Select Product_Name, Price from Products;

open Cursor_Find_Display;

Fetch next from Cursor_Find_Display into @pro_name,@pric;

while @@FETCH_STATUS=0
	Begin
		if @pric>30000
		Begin
			print @pro_name;
		end
		Fetch next from Cursor_Find_Display into @pro_name,@pric;
	End;
Close Cursor_Find_Display;
Deallocate Cursor_Find_Display;
--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table. 
Declare @product_id int;
Declare Product_CursorDelete Cursor 
for 
Select Product_id from Products;

Open Product_CursorDelete;

Fetch Next from Product_CursorDelete into @product_id;
While @@FETCH_STATUS=0
	Begin
		Delete from Products
		where Product_id = @product_id;

		Fetch Next from Product_CursorDelete into @product_id;
	End;
Close Product_CursorDelete;
Deallocate Product_CursorDelete;

--Part – B 
--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases 
--the price by 10%. 
Declare @pr_id int;
Declare Product_CursorUpdate Cursor
for 
select Product_id from Products;

Open Product_CursorUpdate;

Fetch next from Product_CursorUpdate into @pr_id;
While @@FETCH_STATUS=0
	Begin
		Update Products 
		set Price = Price+(Price*0.1)
		where Product_id=@pr_id;
		Select * from Products;
		Fetch next from Product_CursorUpdate into @pr_id;
	End;
	
Close Product_CursorUpdate;
Deallocate Product_CursorUpdate;
--6. Create a Cursor to Rounds the price of each product to the nearest whole number.
Declare @pr int;
Declare RoundPrice_Cursor Cursor
for 
Select Cast(Price as int) from Products;

open RoundPrice_Cursor;
Fetch next from RoundPrice_Cursor into @pr;
while @@FETCH_STATUS=0
	Begin 
		print Cast(Round(@pr,2	) as Varchar);
		Fetch next from RoundPrice_Cursor into @pr;
	End;
close RoundPrice_Cursor;
deallocate RoundPrice_Cursor;

--Part – C 
--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop” 
--(Note: Create NewProducts table first with same fields as Products table)
CREATE TABLE NewProducts ( 
newProduct_id INT PRIMARY KEY, 
newProduct_Name VARCHAR(250) NOT NULL, 
newPrice DECIMAL(10, 2) NOT NULL 
); 
Declare @newpr int, @newprname varchar(20), @newPrice decimal(10,2);
Declare NewProducts_cursor Cursor
for
Select Product_id, Product_Name, Price from Products where Product_Name='Laptop';

open NewProducts_cursor;
Fetch next from NewProducts_cursor into @newpr, @newprname, @newPrice;
while @@FETCH_STATUS=0
	Begin 
		Insert into NewProducts Values (@newpr, @newprname, @newPrice)
		Select PRODUCT_id, Product_name, Price 
		from Products;

		Fetch next from NewProducts_cursor into @newpr, @newprname, @newPrice;
	End;
CLose NewProducts_cursor;
Deallocate NewProducts_cursor;

--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products 
--with a price above 50000 to an archive table, removing them from the original Products table. 	
Create Table ArchivedProducts(
Product_id int,
Product_Name Varchar(100),
Price Decimal(10,2)
);
Declare @highprid int, @highprnme varchar(100), @highprice decimal(10,2);
Declare HighPrice_Cursor cursor 
for 
Select Product_id, Product_Name, Price from Products where Price>50000;

Open HighPrice_Cursor;
Fetch next from HighPrice_Cursor into @highprid, @highprnme, @highprice;
while @@FETCH_STATUS=0
	Begin
		Insert into ArchivedProducts values(@highprid, @highprnme, @highprice)
		
		Delete from Products
		where Product_id=@highprid;
	End;
Close HighPrice_Cursor;
Deallocate HighPrice_Cursor;