Use AutoSale
Declare @selectlimsum numeric (10, 0)
Set @selectlimsum = 30000
Select Clients.Name as '���', Clients.SurName as '�������',
Sum (Ordered.TotalPrice) as '��������� ��������� ������, $'
From Ordered join Orders
ON Ordered.IDOrder = Orders.IDOrder join Clients
ON Orders.IDClient = Clients.IDClient join Cars
ON Ordered.IDCar = Cars.IDCar
Group By Clients.Name, Clients.SurName
Having Sum(TotalPrice) > @selectlimsum
Order by Name, SurName
