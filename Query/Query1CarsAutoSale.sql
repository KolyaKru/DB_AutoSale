Use AutoSale
Select Mark as '�����', Model as '������', Types.Category as '��� ������', Year as '���', Generation as '���������', MileAge as '������', Engine as '����� ���������', TypeEngine as '��� ���������', GearBox as '������� �������', Transmission as '������', Equipment as '������������', VIN, Price as '����, $'  
From Cars join Types
On Types.IDType = Cars.IDType
Order by Mark, Model