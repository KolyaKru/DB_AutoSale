Use AutoSale
Declare @limprice numeric (10,0)
Declare @limyear int
Set @limprice = 30000
Set @limyear = 2012
Select Mark as 'Марка', Model as 'Модель', Types.Category as 'Тип кузова', Year as 'Год', Generation as 'Поколение', MileAge as 'Пробег', Engine as 'Объём двигателя', TypeEngine as 'Тип двигателя', GearBox as 'Коробка передач', Transmission as 'Привод', Equipment as 'Комплектация', VIN, Price as 'Цена, $'  
From Cars join Types
ON Types.IDType = Cars.IDType
Where Price < @limprice and Year > @limyear
Order by Price, Year
