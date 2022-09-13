USE [AutoSale]
GO
/****** Object:  StoredProcedure [dbo].[DateOrders]    Script Date: 19.05.2021 22:24:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[DateOrders]  
@datebegin date,
@dateend date
As
Set NOCOUNT ON
Select  IDOrder 'Номер заказа', IDClient as 'Номер клиента' ,DateAccomodation as 'Дата заказа' From dbo.Orders 
Where DateAccomodation BETWEEN @datebegin and @dateend
 