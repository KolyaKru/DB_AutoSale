Use AutoSale
Select Cars.Mark as 'Марка', Cars.Model as 'Модель', Cars.Year as 'Год', Cars.MileAge as 'Пробег', Ordered.DiscountPercent as 'Скидка, %'
From Cars join Ordered
ON Cars.IDCar = Ordered.IDCar
Where Ordered.DiscountPercent = (Select MAX (DiscountPercent) From Ordered)