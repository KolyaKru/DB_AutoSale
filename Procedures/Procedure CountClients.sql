USE [AutoSale]
GO
/****** Object:  StoredProcedure [dbo].[CountClients]    Script Date: 19.05.2021 21:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[CountClients]
AS
SET NOCOUNT ON
SELECT  COUNT (IDClient) AS 'Количество клиентов'  
FROM dbo.Clients

 