Use AutoSale 
Select Clients.Name as 'Имя', Clients.SurName as 'Фамилия', Clients.Telephone as 'Телефон', Cars. Mark as 'Марка', Cars. Model as 'Модель'
From Clients join Orders
ON Clients.IDClient = Orders.IDClient join Ordered 
On Orders.IDOrder = Ordered.IDOrder join Cars
On Ordered.IDCar = Cars.IDCar
Order by Name, SurName
