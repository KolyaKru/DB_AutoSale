USE [AutoSale]
GO
/****** Object:  Trigger [dbo].[TriggerDiscount]    Script Date: 19.05.2021 22:52:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[TriggerDiscount]
ON [dbo].[Ordered] 
AFTER INSERT, UPDATE
AS
BEGIN 
Set NOCOUNT ON
Declare @mileage int
Declare @discountperc numeric (3, 1)
Select @mileage = MileAge From Cars join Ordered
On Cars.IDCar = Ordered.IDCar
Where Cars.IDCar = (Select IDCar from inserted)
IF (@mileage <= 10000) begin Set @discountperc = 0 end
Else If (@mileage >10000 and @mileage <=50000) begin set @discountperc = 5 end
else if (@mileage >50000 and @mileage <= 100000) begin set @discountperc = 7.5 end
else if (@mileage > 100000 and @mileage <=200000) begin set @discountperc = 10 end
else if (@mileage > 200000) begin set @discountperc = 12.5 end
Update Ordered
Set DiscountPercent = @discountperc,
Discount = @discountperc / 100 * Cars.Price
From Ordered join Cars
ON Cars.IDCar = Ordered.IDCar
Where IDOrder = (Select IDOrder from inserted)
And Cars.IDCar = (Select IDCar from inserted);
Update Ordered 
Set TotalPrice = Cars.Price - Discount 
From Cars join Ordered
ON Cars.IDCar = Ordered.IDCar
Where IDOrder = (Select IDOrder from inserted)
And Cars.IDCar = (Select IDCar from inserted)
end
