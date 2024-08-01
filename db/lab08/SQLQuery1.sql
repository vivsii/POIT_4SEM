use UNIVER;
--task 1
--����������� ������������� � ������ �������-������. ������������� ������ ���� ��������� �� ������ SELECT-������� � ������� TEACHER �
--��������� ��������� �������: ���, ��� �������������, ���, ��� �������. 
go
CREATE or ALTER VIEW [�������������]
AS
SELECT TEACHER [���], 
TEACHER_NAME [��� �������������],
GENDER [���],
PULPIT [��� �������]
FROM TEACHER;
go
SELECT *FROM [�������������]
DROP VIEW [�������������]

--task 2
--����������� � ������� ������������� � ������ ���������� ������. 
--������������� ������ ���� ��������� �� ������ SELECT-������� � �������� FACULTY � PULPIT.
--������������� ������ ��������� ������-��� �������: ���������, ���������� ������ (����������� �� ������ ����� ������� PULPIT).
go
CREATE or ALTER VIEW [���������� ������]
AS SELECT FACULTY.FACULTY_NAME [���������], 
count(PULPIT.FACULTY)	[���������� ������]
FROM FACULTY inner join PULPIT
ON PULPIT.FACULTY=FACULTY.FACULTY
GROUP BY FACULTY.FACULTY_NAME 
go
SELECT * FROM [���������� ������]
DROP VIEW [���������� ������]

--task 3
--����������� � ������� ������������� � ������ ���������. ������������� ������ ���� 
--��-������� �� ������ ������� AUDITORIUM � ��������� �������: ���, ������������ ����-�����. 
--������������� ������ ���������� ������ ���������� ��������� (� ������� AUDITO-RIUM_ TYPE ������, ������������ � �����-�� ��) 
--� ��������� ���������� ��������� IN-SERT, UPDATE � DELETE.
go
CREATE VIEW [���������]
AS SELECT AUDITORIUM.AUDITORIUM [���],
		  AUDITORIUM.AUDITORIUM_NAME [������������ ���������]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like '��%' ;
go
SELECT * FROM [���������];
go
ALTER VIEW [���������]
AS SELECT AUDITORIUM.AUDITORIUM [���],
		  AUDITORIUM.AUDITORIUM_NAME [������������ ���������],
          AUDITORIUM.AUDITORIUM_TYPE [��� ���������]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like '��%';
go
SELECT * FROM [���������];
DROP VIEW [���������];
select * from AUDITORIUM
 --task 4
--����������� � ������� ������������� � ������ ����������_���������. 
--������������� ������ ���� ��������� �� ������ SELECT-������� � ������� AUDITO-RIUM � ��������� ��������� �������: ���, ������������ ���������. 
--������������� ������ ���������� ������ ���������� ��������� (� ������� AUDITO-RIUM_TYPE ������, ������������ � �����-��� ��). 
go
CREATE or ALTER VIEW [���������� ���������]
AS SELECT AUDITORIUM.AUDITORIUM [���],
          AUDITORIUM.AUDITORIUM_NAME [������������ ���������]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like '��%';
go
SELECT * FROM [���������� ���������]
DROP VIEW [���������� ���������];
					

--task 5
--����������� ������������� � ������ �����-�����. ������������� ������ ���� ��������� �� ������ SELECT-������� � ������� SUB-JECT, 
--���������� ��� ���������� � �������-��� ������� � ��������� ��������� �������: ���, ������������ ���������� � ��� ��-�����. 
--������������ TOP � ORDER BY.
go
CREATE or ALTER VIEW [����������]
AS SELECT TOP 150 SUBJECT [���],
SUBJECT_NAME [������������],
PULPIT [��� �������]
FROM SUBJECT
ORDER BY ������������
go
SELECT * FROM [����������]
DROP VIEW [����������];

--task 6
--�������� ������������� ����������_������, ��������� � ������� 2 ���, ����� ��� ���� ��������� � ������� ��������.
--������������������ �������� ����������-��� ������������� � ������� ��������. 
--������������ ����� SCHEMABINDING
go
CREATE or ALTER VIEW [���������� ������] WITH SCHEMABINDING
AS SELECT zk.FACULTY_NAME [���������], 
count(tv.FACULTY)	[���������� ������]
FROM dbo.FACULTY zk inner join dbo.PULPIT tv
ON tv.FACULTY=zk.FACULTY
GROUP BY zk.FACULTY_NAME 
go
SELECT * FROM [���������� ������];
