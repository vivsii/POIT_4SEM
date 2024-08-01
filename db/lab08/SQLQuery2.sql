use EVS_MyBASE;
--1
go
CREATE or ALTER VIEW [subject]
AS
SELECT Предмет [Название], 
Тип_занятий [тип],
Количество_часов [часы]
FROM ПРЕДМЕТЫ;
go
SELECT *FROM [subject]
DROP VIEW [subject]

--2

go
CREATE or ALTER VIEW [Количество курсов]
AS SELECT ГРУППЫ.Специальность [специальность], 
count(КУРСЫ.Номер_курса)	[количество курсов]
FROM ГРУППЫ inner join КУРСЫ
ON КУРСЫ.Номер_курса=ГРУППЫ.Номер_курса
GROUP BY  ГРУППЫ.Специальность
go
SELECT * FROM [Количество курсов]
DROP VIEW [Количество курсов]

--3
go
CREATE VIEW [группа]
AS SELECT ГРУППЫ.Номер_группы [номер],
		  ГРУППЫ.Отделение [отделение]
FROM ГРУППЫ
WHERE ГРУППЫ.Специальность like 'ПО%';
go
SELECT * FROM [группа];
go
ALTER VIEW [группа]
AS SELECT ГРУППЫ.Номер_группы [номер],
		  ГРУППЫ.Отделение [отделение],
		  ГРУППЫ.Количество_студентов [студенты]
FROM ГРУППЫ
WHERE ГРУППЫ.Специальность like 'ПО%';
go
SELECT * FROM [группа];
DROP VIEW [группа];

--4

go
CREATE VIEW [Группа]
AS SELECT ГРУППЫ.Номер_группы [номер],
		  ГРУППЫ.Отделение [отделение]
FROM ГРУППЫ
WHERE ГРУППЫ.Специальность like 'ПО%';
go
SELECT * FROM [Группа];

--5
select * from ПРЕДМЕТЫ
select * from КУРСЫ
select * from ПРЕПОДАВАТЕЛИ
select * from ГРУППЫ
go
CREATE or ALTER VIEW [все предметы]
AS SELECT TOP 150
Предмет [предметы],
Тип_занятий [тип]
FROM ПРЕДМЕТЫ
ORDER BY предметы
go
SELECT * FROM [все предметы]
DROP VIEW [все предметы];
--6
go
CREATE or ALTER VIEW [Количество курсов] WITH SCHEMABINDING
AS SELECT zk.Специальность [специальность], 
count(tv.Номер_курса)	[количество курсов]
FROM dbo.ГРУППЫ zk inner join dbo.КУРСЫ tv
ON tv.Номер_курса=zk.Номер_курса
GROUP BY  zk.Специальность
go
SELECT * FROM [Количество курсов]
DROP VIEW [Количество курсов]