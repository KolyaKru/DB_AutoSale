Use AutoSale 
Declare @selectname varchar (20)
Set @selectname = 'Николай'
Select Employees.Name as 'Имя', Employees.SurName as 'Фамилия', Employees.Specialty as 'Специальность', Employees.Address as 'Адрес', Employees.HomeTelephone as 'Телефон'
From Employees
Where Employees.Name = @selectname
Order By Name