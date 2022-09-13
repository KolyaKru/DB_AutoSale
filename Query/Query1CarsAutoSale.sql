Use AutoSale
Select Mark as 'Марка', Model as 'Модель', Types.Category as 'Тип кузова', Year as 'Год', Generation as 'Поколение', MileAge as 'Пробег', Engine as 'Объём двигателя', TypeEngine as 'Тип двигателя', GearBox as 'Коробка передач', Transmission as 'Привод', Equipment as 'Комплектация', VIN, Price as 'Цена, $'  
From Cars join Types
On Types.IDType = Cars.IDType
Order by Mark, Model