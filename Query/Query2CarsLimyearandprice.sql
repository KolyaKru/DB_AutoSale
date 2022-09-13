Use AutoSale
Declare @limprice numeric (10,0)
Declare @limyear int
Set @limprice = 30000
Set @limyear = 2012
Select Mark as '�����', Model as '������', Types.Category as '��� ������', Year as '���', Generation as '���������', MileAge as '������', Engine as '����� ���������', TypeEngine as '��� ���������', GearBox as '������� �������', Transmission as '������', Equipment as '������������', VIN, Price as '����, $'  
From Cars join Types
ON Types.IDType = Cars.IDType
Where Price < @limprice and Year > @limyear
Order by Price, Year
