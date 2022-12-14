USE [AutoSale]
GO
/****** Object:  Trigger [dbo].[TriggerMarkCars]    Script Date: 19.05.2021 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[TriggerMarkCars]
ON [dbo].[Cars]
AFTER INSERT, UPDATE
AS
BEGIN
SET NOCOUNT ON
UPDATE Cars
SET Mark = SuppliersMarks.Mark
FROM Cars JOIN SuppliersMarks
ON Cars.IDSupplierMark = SuppliersMarks.IDSupplierMark
end