USE [AutoSale]
GO
/****** Object:  StoredProcedure [dbo].[SelectCar]    Script Date: 19.05.2021 20:50:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[SelectCar]
@mark varchar (20)
As
Set NOCOUNT ON
Select Mark as 'Марка', Model as 'Модель', Types.Category as 'Тип кузова',
Year as 'Год', Generation as 'Поколение', MileAge as 'Пробег', Engine as 'Объём двигателя',
TypeEngine as 'Тип двигателя', GearBox as 'Коробка передач', Transmission as 'Привод', 
Equipment as 'Комплектация', VIN, Price as 'Цена, $'  
From Cars join Types
On Types.IDType = Cars.IDType
Where Cars.Mark = @mark 
 