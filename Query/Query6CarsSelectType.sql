Use AutoSale
Declare @selecttype varchar(30)
Set @selecttype = N'Купе'
Select Cars.Mark as 'Марка', Cars.Model as 'Модель', Cars.Price as 'Цена, $'
From Cars join Types
ON Types.IDType = Cars.IDType 
Where Types.Category = @selecttype 
Order by Mark, Model