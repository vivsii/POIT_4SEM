use EVS_MyBASE;
--1
go
CREATE or ALTER VIEW [subject]
AS
SELECT ������� [��������], 
���_������� [���],
����������_����� [����]
FROM ��������;
go
SELECT *FROM [subject]
DROP VIEW [subject]

--2

go
CREATE or ALTER VIEW [���������� ������]
AS SELECT ������.������������� [�������������], 
count(�����.�����_�����)	[���������� ������]
FROM ������ inner join �����
ON �����.�����_�����=������.�����_�����
GROUP BY  ������.�������������
go
SELECT * FROM [���������� ������]
DROP VIEW [���������� ������]

--3
go
CREATE VIEW [������]
AS SELECT ������.�����_������ [�����],
		  ������.��������� [���������]
FROM ������
WHERE ������.������������� like '��%';
go
SELECT * FROM [������];
go
ALTER VIEW [������]
AS SELECT ������.�����_������ [�����],
		  ������.��������� [���������],
		  ������.����������_��������� [��������]
FROM ������
WHERE ������.������������� like '��%';
go
SELECT * FROM [������];
DROP VIEW [������];

--4

go
CREATE VIEW [������]
AS SELECT ������.�����_������ [�����],
		  ������.��������� [���������]
FROM ������
WHERE ������.������������� like '��%';
go
SELECT * FROM [������];

--5
select * from ��������
select * from �����
select * from �������������
select * from ������
go
CREATE or ALTER VIEW [��� ��������]
AS SELECT TOP 150
������� [��������],
���_������� [���]
FROM ��������
ORDER BY ��������
go
SELECT * FROM [��� ��������]
DROP VIEW [��� ��������];
--6
go
CREATE or ALTER VIEW [���������� ������] WITH SCHEMABINDING
AS SELECT zk.������������� [�������������], 
count(tv.�����_�����)	[���������� ������]
FROM dbo.������ zk inner join dbo.����� tv
ON tv.�����_�����=zk.�����_�����
GROUP BY  zk.�������������
go
SELECT * FROM [���������� ������]
DROP VIEW [���������� ������]