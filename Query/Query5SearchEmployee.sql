Use AutoSale 
Declare @selectname varchar (20)
Set @selectname = '�������'
Select Employees.Name as '���', Employees.SurName as '�������', Employees.Specialty as '�������������', Employees.Address as '�����', Employees.HomeTelephone as '�������'
From Employees
Where Employees.Name = @selectname
Order By Name