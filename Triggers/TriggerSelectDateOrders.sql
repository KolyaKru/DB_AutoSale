USE [AutoSale]
GO
/****** Object:  Trigger [dbo].[SelectDateOrders]    Script Date: 19.05.2021 23:07:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Trigger [dbo].[SelectDateOrders]
ON [dbo].[Orders]
AFTER INSERT, UPDATE
AS
BEGIN 
Set NOCOUNT ON
Update Orders 
Set DateAccomodation = SYSDATETIME()
Where IDOrder = (Select IDOrder from inserted)
end
