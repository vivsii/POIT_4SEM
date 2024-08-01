use UNIVER;
--task 1
--Разработать представление с именем Препода-ватель. Представление должно быть построено на основе SELECT-запроса к таблице TEACHER и
--содержать следующие столбцы: код, имя преподавателя, пол, код кафедры. 
go
CREATE or ALTER VIEW [Преподаватель]
AS
SELECT TEACHER [код], 
TEACHER_NAME [имя преподавателя],
GENDER [пол],
PULPIT [код кафедры]
FROM TEACHER;
go
SELECT *FROM [Преподаватель]
DROP VIEW [Преподаватель]

--task 2
--Разработать и создать представление с именем Количество кафедр. 
--Представление должно быть построено на основе SELECT-запроса к таблицам FACULTY и PULPIT.
--Представление должно содержать следую-щие столбцы: факультет, количество кафедр (вычисляется на основе строк таблицы PULPIT).
go
CREATE or ALTER VIEW [Количество кафедр]
AS SELECT FACULTY.FACULTY_NAME [факультет], 
count(PULPIT.FACULTY)	[количество кафедр]
FROM FACULTY inner join PULPIT
ON PULPIT.FACULTY=FACULTY.FACULTY
GROUP BY FACULTY.FACULTY_NAME 
go
SELECT * FROM [Количество кафедр]
DROP VIEW [Количество кафедр]

--task 3
--Разработать и создать представление с именем Аудитории. Представление должно быть 
--по-строено на основе таблицы AUDITORIUM и содержать столбцы: код, наименование ауди-тории. 
--Представление должно отображать только лекционные аудитории (в столбце AUDITO-RIUM_ TYPE строка, начинающаяся с симво-ла ЛК) 
--и допускать выполнение оператора IN-SERT, UPDATE и DELETE.
go
CREATE VIEW [Аудитории]
AS SELECT AUDITORIUM.AUDITORIUM [Код],
		  AUDITORIUM.AUDITORIUM_NAME [Наименование аудитории]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%' ;
go
SELECT * FROM [Аудитории];
go
ALTER VIEW [Аудитории]
AS SELECT AUDITORIUM.AUDITORIUM [Код],
		  AUDITORIUM.AUDITORIUM_NAME [Наименование аудитории],
          AUDITORIUM.AUDITORIUM_TYPE [Тип аудитории]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%';
go
SELECT * FROM [Аудитории];
DROP VIEW [Аудитории];
select * from AUDITORIUM
 --task 4
--Разработать и создать представление с именем Лекционные_аудитории. 
--Представление должно быть построено на основе SELECT-запроса к таблице AUDITO-RIUM и содержать следующие столбцы: код, наименование аудитории. 
--Представление должно отображать только лекционные аудитории (в столбце AUDITO-RIUM_TYPE строка, начинающаяся с симво-лов ЛК). 
go
CREATE or ALTER VIEW [Лекционные аудитории]
AS SELECT AUDITORIUM.AUDITORIUM [Код],
          AUDITORIUM.AUDITORIUM_NAME [Наименование аудитории]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%';
go
SELECT * FROM [Лекционные аудитории]
DROP VIEW [Лекционные аудитории];
					

--task 5
--Разработать представление с именем Дисци-плины. Представление должно быть построено на основе SELECT-запроса к таблице SUB-JECT, 
--отображать все дисциплины в алфавит-ном порядке и содержать следующие столбцы: код, наименование дисциплины и код ка-федры. 
--Использовать TOP и ORDER BY.
go
CREATE or ALTER VIEW [Дисциплины]
AS SELECT TOP 150 SUBJECT [код],
SUBJECT_NAME [наименование],
PULPIT [код кафедры]
FROM SUBJECT
ORDER BY наименование
go
SELECT * FROM [Дисциплины]
DROP VIEW [Дисциплины];

--task 6
--Изменить представление Количество_кафедр, созданное в задании 2 так, чтобы оно было привязано к базовым таблицам.
--Продемонстрировать свойство привязанно-сти представления к базовым таблицам. 
--Использовать опцию SCHEMABINDING
go
CREATE or ALTER VIEW [Количество кафедр] WITH SCHEMABINDING
AS SELECT zk.FACULTY_NAME [факультет], 
count(tv.FACULTY)	[количество кафедр]
FROM dbo.FACULTY zk inner join dbo.PULPIT tv
ON tv.FACULTY=zk.FACULTY
GROUP BY zk.FACULTY_NAME 
go
SELECT * FROM [Количество кафедр];
