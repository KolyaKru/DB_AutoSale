Use AutoSale
Declare @selecttype varchar(30)
Set @selecttype = N'����'
Select Cars.Mark as '�����', Cars.Model as '������', Cars.Price as '����, $'
From Cars join Types
ON Types.IDType = Cars.IDType 
Where Types.Category = @selecttype 
Order by Mark, Model