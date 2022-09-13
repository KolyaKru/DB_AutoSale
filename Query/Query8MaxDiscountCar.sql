Use AutoSale
Select Cars.Mark as '�����', Cars.Model as '������', Cars.Year as '���', Cars.MileAge as '������', Ordered.DiscountPercent as '������, %'
From Cars join Ordered
ON Cars.IDCar = Ordered.IDCar
Where Ordered.DiscountPercent = (Select MAX (DiscountPercent) From Ordered)