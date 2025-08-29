create database Retail_Inventory_System;
GO
Use Retail_Inventory_system;
Go

create table Suppliers(SupplierID Int Identity(1,1) Primary Key,
SupplierName Nvarchar(100) Not Null,
ContactEmail Nvarchar(100) Unique,
City NVarchar(50),Country NVarchar(50)
);
Go
/*-- Create the Products table with a foreign key to Suppliers--ProductID,ProductName,Category,Price,supplierID,*/
create table Products(
ProductID INT Identity(1,1) Primary Key,
ProductName NVarchar(100) Not NUll,
Category Nvarchar(50),
Price Decimal(10,2) Not NUll,
SupplierID INT,Foreign key(SupplierID) references Suppliers(SupplierID)
);
GO

/*create table Stores table-storeid,storename,location,Managername*/
create table Stores(
StoreID INT Identity(1,1) Primary key,
StoreName Nvarchar(100),
Location Nvarchar(100),
Managername Nvarchar(100));
Go

-- Create the Inventory table, which links Products and Stores

create table Inventory (
InventoryID Int Identity(1,1) Primary key,
ProductID INT,
StoreID INT,
StockQuantity Int Not null,
Lastupdated datetime,
Foreign key(ProductID) references Products(ProductID),
Foreign Key(StoreID)references Stores(StoreID) 
);
Go


--create the table sales  to record  transactions--

create table Sales(
SaleID INt Identity(1,1) Primary key,
ProductID Int,
StoreID INt,
SaleDate Date,
Quantitysold INT,
Foreign key(ProductID) references Products(ProductID),
Foreign Key(StoreID)  references Stores(StoreID)
);
GO


--Data insertion and updation
use Retail_Inventory_System
select * from Suppliers
Insert into Suppliers(SupplierName,ContactEmail,City,Country) values('Tech Gadgets INc.','contact@techgadgets.com','New York','USA'),
('Fashion WholeSalers','info@fashionw.com','London','UK'),('Home EssentialsCo.','sales@homeessentials.net','Sydney','Australia'),
('Sports Gear Ltd','support@sportsgear.co','Manchester','UK');
Go

--Insert data into Products

select * from Products
insert into Products(ProductName,Category,Price,SupplierID) 
values ('Laptop','Electronics',1200.00,1),
		('Wireless Mouse','Electronics',25.50,1),
		('Denim Jeans','Apparel',65.00,2),
		('T-Shirt','Apparel',20.00,2),
		('Running Shoes','Apparel',90.00,4),
		('Coffee Maker','Home Appliances',89.99,3),
		('Blender','Home Aplliances',49.99,3);
Go

--Insert data into Stores
select * from Stores
insert into Stores(StoreName,Location,Managername)
values		('Downtown Outlet','123 Main St','Jane Doe'),
			('Midtown Mall','456 Commerce Ave','John Smith'),
			('Suburban Plaza','789 Oak St','Saraj Jones');
			GO

--Insert data into Inventory
select * from Inventory
Insert into Inventory(ProductID,StoreID,StockQuantity,Lastupdated)
values(1,1,50,Getdate()),
		(2,1,150,getdate()),
		(3,2,200,getdate()),
		(4,3,500,GETDATE()),
		(5,2,80,GETDATE()),
		(6,3,75,GETDATE()),
		(7,1,60,GETDATE()),
		(1,2,30,GETDATE());
GO



---Insert data into sales
select * from Sales
insert into sales(ProductID,StoreID,SaleDate,Quantitysold)
values(1,1,'2023-08-01',5),
		(2,1,'2023-08-01',10),
		(3,2,'2023-08-02',25),
		(4,3,'2023-08-03',50),
		(5,2,'2023-08-04',8),
		(6,3,'2023-08-04',12),
		(7,1,'2023-08-04',10),
		(1,2,'2023-08-05',3);
Go

select *from Products

--updating record
update Products set price =1250.00 where ProductName='Laptop'; 

--delete a record
select * from Sales
delete from sales where SaleID=2;
Go
commit  transaction;


select * from Sales
select * from Products
select * from Stores
select * from Suppliers
select * from Sales



--Query solving
--1.: List all products and their prices.
--2:: List all products from cheapest to most expensive

select ProductName,Price from Products

select ProductName,Price from Products order by Price asc;

--3	 Find products in the 'Electronics' category
--4.Find all products that are either 'Laptop' or 'T-Shirt'
--5.Find all suppliers whose name starts with 'T'.


select ProductName,Category from Products where Category='Electronics';

select Productname from Products where ProductName='Laptop'or ProductName='T-Shirt';
select ProductName from Products where ProductName IN('Laptop','T-Shirt');

select * from Suppliers;
select SupplierName from Suppliers WHERE SupplierName like 'T%';


--6.Count the total number of products available
--7. Find the minimum and maximum price of any product.
--8.Count the number of products in each Category


select count(*) from Products;

select count(ProductID),Category from Products Group by Category

select category, min(Price),max(price) from Products group by category;
begin transaction
update Products set Category='Home Appliances' where category='Home Aplliances';
commit transaction
begin transaction
rollback transaction;

select * from Products
--9.Show the date and time when the sales data was updated for each transaction.
--10.: List the product name and its corresponding supplier name

select saleID,SaleDate,GETDATE() as CurrentDateTime from Sales



select ProductName,SupplierName
from Products a join Suppliers b on a.SupplierID = b.SupplierID;


--11.Find all suppliers not located in the 'UK'.
--12.: Find categories that have more than one product
--13.: Find the names of products that have been sold

select SupplierName,Country 
from Suppliers where Country not like ('UK');
select *
select * from Products
select Category,count(ProductID) from Products group by Category having count(*)>1;
begin transaction
rollback transaction;

SELECT * FROM Sales
select DISTINCT P.ProductName,Quantitysold from Products P join Sales S on p.ProductID=s.ProductID
where Quantitysold>1;


SELECT ProductName FROM Products
WHERE ProductID IN (SELECT DISTINCT ProductID FROM Sales);

--14.Display the first letter of each store name in lowercase.
--15.Find the month of each sale
SELECT  StoreName,LOWER(substring(StoreName),1)) as firstletter
from Stores;


SELECT  StoreName,lower((substring(storename,1,1)))from Stores;


SELECT StoreName, LOWER(SUBSTRING(StoreName, 1, 1)) AS FirstLetter
FROM Stores;

select saledate, month(saledate) from sales;


--16.Calculate the total revenue per store.
--17. Calculate the number of days since each product's last inventory update.


select * from sales;
select * from Products
select StoreID,sum(distinct(Quantitysold*Price)) as Total_Revenue
from Products P join Sales s on p.ProductID=s.ProductID group by storeid;

SELECT
    s.StoreName,
    SUM(distinct(sa.QuantitySold * p.Price)) AS TotalRevenue
FROM Sales sa
JOIN Products p ON sa.ProductID = p.ProductID
JOIN Stores s ON sa.StoreID = s.StoreID
GROUP BY s.StoreName;
 
select * from Inventory
select P.ProductID,P.ProductName,Lastupdated,GETDATE(),datediff(day,lastupdated,getdate()) as last_inventory_update
from Inventory I join Products P on I.ProductiD=P.productId;

--18.Create a report showing product prices, categorized as 'High' (>100), 'Medium' (25-100), or 'Low' (<25).

select * from Products
select * from Sales

select 
ProductName,Price,
case 
when price>100 then 'High' 
when Price between 25 and 100 then 'Medium'
else 'low'
end as Pricecategory
from Products



--19.Show the total quantity of products sold by each supplier.JOIN and GROUP BY
select a.SupplierName,sum(c.Quantitysold) as Total_Quantity_sold
from Suppliers a join Products b on a.SupplierID=b.SupplierID join Sales c on  c.ProductID=b.ProductID 
group by a.SupplierName



--20.Find products that share the same Category but have different ProductNames.
select Category,ProductName from Products group by Category


SELECT p1.ProductName, p2.ProductName, p1.Category
FROM Products p1
JOIN Products p2
ON p1.Category = p2.Category AND p1.ProductID < p2.ProductID;

--21.	Subquery with Aggregate: Find the store with the highest total revenue
--22.Rank products by price within each category.
select * from sales
select * from Products
select * from Stores

select c.StoreName,sum(a.Quantitysold*b.Price) as Total_revenue_perstore,RANK() over(partition by store order by Total_revenue_perstore)
from sales a join Products b on a.ProductID=b.ProductID join Stores c on c.StoreID=a.StoreID group by c.StoreName

SELECT StoreName
FROM Stores
WHERE StoreID = (
    SELECT TOP 1 StoreID
    FROM Sales
    GROUP BY StoreID
    ORDER BY SUM(QuantitySold) DESC
);
-- 22.	Window Function (RANK): Rank products by price within each category
--23.	Window Function (SUM OVER): Calculate a running total of QuantitySold for each product.
select distinct category, productname,Price,dense_rank() over(partition by category order by price DESC) as rank  from Products

select * from sales

select distinct ProductID,sum(Quantitysold) over(order by ProductID) as running_total_QuantitySold
from Sales

--24.	CTE and JOIN: Find the product that is the single top-seller in a specific store.
--25.	Date/Time Function & Pattern Matching: Find sales that occurred in the first week of August, 2023.

select * from sales where SaleDate between '2023-08-01' and '2023-08-4';
--26.	Complex JOIN and WHERE: Find all products with a stock quantity less than 50 in any store located in 'New York'.

SELECT p.ProductName, i.StockQuantity,Location,city='New York'
FROM Products p
JOIN Inventory i ON p.ProductID = i.ProductID
JOIN Stores s ON i.StoreID = s.StoreID
WHERE i.StockQuantity>50 AND s.Location = '123 Main St';


--28.	UNION: Combine the product names from 'Apparel' category and the supplier names from the 'UK'.
--29.	Scalar Subquery: Find the product with a price equal to the average price of all products.

SELECT ProductName AS Name FROM Products WHERE Category = 'Apparel'
UNION ALL
SELECT SupplierName AS Name FROM Suppliers WHERE Country = 'UK';

select * from Suppliers


SELECT ProductName, Price FROM Products WHERE Price = (SELECT max(Price) FROM Products);

--30.	IS NULL: Find suppliers who do not have a contact email listed.
select supplierID,suppliername from  suppliers where ContactEmail is null;
--31.	NOT IN: Find products that have not been sold yet

select ProductName from Products where ProductID not in (select distinct ProductID from Sales);

