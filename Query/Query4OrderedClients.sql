Use AutoSale 
Select Clients.Name as '���', Clients.SurName as '�������', Clients.Telephone as '�������', Cars. Mark as '�����', Cars. Model as '������'
From Clients join Orders
ON Clients.IDClient = Orders.IDClient join Ordered 
On Orders.IDOrder = Ordered.IDOrder join Cars
On Ordered.IDCar = Cars.IDCar
Order by Name, SurName
