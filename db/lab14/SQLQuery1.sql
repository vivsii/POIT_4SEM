USE UNIVER 
--1 Разработать скалярную функцию с именем COUNT_STUDENTS, которая вычисляет количество сту-дентов на факультете, 
--код которого задается параметром типа varchar(20) с именем @faculty. Использовать внут-реннее соединение 
--таблиц FACULTY, GROUPS, STUDENT. Опробовать работу функции.Внести изменения в текст функции с помощью оператора ALTER с тем, 
--чтобы функция принимала второй параметр @prof типа varchar(20), обозначающий специальность сту-дентов. Для параметров 
--определить значения по умолчанию NULL. Опробовать работу функции с помощью SELECT-запросов.

GO
CREATE FUNCTION COUNT_STUDENTS(@FACULTY VARCHAR(20)) RETURNS INT
AS BEGIN 
  DECLARE @COUNT INT=0;
    SET @COUNT=(SELECT COUNT(STUDENT.IDSTUDENT)
    FROM FACULTY
	JOIN GROUPS ON GROUPS.FACULTY = FACULTY.FACULTY
	JOIN STUDENT ON STUDENT.IDGROUP = GROUPS.IDGROUP
	WHERE FACULTY.FACULTY = @FACULTY)
    RETURN @COUNT;
END;
GO
SELECT FACULTY 'ФАКУЛЬТЕТ',
DBO.COUNT_STUDENTS(FACULTY) 'КОЛ-ВО СТУДЕНТОВ'
FROM FACULTY
GO

ALTER FUNCTION COUNT_STUDENTS (@FACULTY NVARCHAR(20), @PROF NVARCHAR(20)) RETURNS INT AS
BEGIN
    DECLARE @COUNT INT=0;
    SET @COUNT=(SELECT COUNT(STUDENT.IDSTUDENT)
    FROM FACULTY
    INNER JOIN GROUPS ON GROUPS.FACULTY = FACULTY.FACULTY
    INNER JOIN STUDENT ON STUDENT.IDGROUP = GROUPS.IDGROUP
    WHERE FACULTY.FACULTY = @FACULTY AND GROUPS.PROFESSION = @PROF)
    RETURN @COUNT;
END;
GO
SELECT FACULTY.FACULTY 'ФАКУЛЬТЕТ',
	GROUPS.PROFESSION 'СПЕЦИАЛЬНОСТЬ',
	DBO.COUNT_STUDENTS(FACULTY.FACULTY, GROUPS.PROFESSION) 'КОЛ-ВО СТУДЕНТОВ'
FROM FACULTY
	INNER JOIN GROUPS ON GROUPS.FACULTY = FACULTY.FACULTY
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION
GO
--2 Разработать скалярную функцию с именем FSUBJECTS, принимающую параметр @p типа varchar(20), значение ко-торого задает код кафедры (столбец SUBJECT.PULPIT). 
--Функция должна возвращать строку типа varchar(300) с перечнем дисциплин в отчете. 
--Создать и выполнить сценарий, который создает отчет, аналогичный представленному ниже. 
--Использовать локальный статический курсор на основе SELECT-запроса к таблице SUBJECT.

USE UNIVER 
GO
CREATE FUNCTION FSUBJECTS (@P NVARCHAR(20)) RETURNS NVARCHAR(300) AS
BEGIN
    DECLARE @LIST VARCHAR(300) = 'ДИСЦИПЛИНЫ: ', @SUB VARCHAR(20);
    DECLARE SUBJECT_CURSOR CURSOR LOCAL FOR
    SELECT SUBJECT.SUBJECT 'ДИСЦИПЛИНА'
    FROM SUBJECT
    WHERE SUBJECT.PULPIT = @P
    OPEN SUBJECT_CURSOR
    FETCH NEXT FROM SUBJECT_CURSOR INTO @SUB
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @LIST=@LIST+RTRIM(@SUB)+', ';
            FETCH SUBJECT_CURSOR INTO @SUB
        END;
    RETURN @LIST;
END;
PRINT DBO.FSUBJECTS('ИСИТ');
SELECT PULPIT 'КАФЕДРА', DBO.FSUBJECTS(PULPIT) 'ДИСЦИПЛИНЫ' FROM PULPIT;
GO

--3 Разработать табличную функцию FFACPUL, результаты работы которой продемонстрированы на рисунке ниже. 
--Функция принимает два параметра, задающих код фа-культета (столбец FACULTY.FACULTY) и код 
--кафедры (столбец PULPIT.PULPIT). Использует SELECT-запрос c левым внешним соединением между таблицами FACULTY и PULPIT. 
--Если оба параметра функции равны NULL, то она воз-вращает список всех кафедр на всех факультетах. 
--Если задан первый параметр (второй равен NULL), функ-ция возвращает список всех кафедр заданного факультета. 
--Если задан второй параметр (первый равен NULL), функ-ция возвращает результирующий набор, содержащий стро-ку, соответствующую заданной кафедре.
--Если заданы два параметра, функция возвращает резуль-тирующий набор, содержащий строку, соответствующую заданной кафедре на заданном факультете. 
--Если по заданным значениям параметров невозможно сформировать строки, функция возвращает пустой резуль-тирующий набор. 

USE UNIVER
GO
CREATE FUNCTION FFACPUL(@FAC VARCHAR(10), @PUL VARCHAR(10)) RETURNS TABLE
    AS RETURN
    SELECT FACULTY.FACULTY, PULPIT.PULPIT
    FROM FACULTY LEFT OUTER JOIN PULPIT
    ON FACULTY.FACULTY = PULPIT.FACULTY
WHERE FACULTY.FACULTY=ISNULL(@FAC, FACULTY.FACULTY) AND PULPIT.PULPIT=ISNULL(@PUL, PULPIT.PULPIT);

GO
--DROP FUNCTION DBO.FFACPUL;
SELECT * FROM DBO.FFACPUL(NULL,NULL);
SELECT * FROM DBO.FFACPUL('ИЭФ',NULL);
SELECT * FROM DBO.FFACPUL(NULL,'ИСИТ');
SELECT * FROM DBO.FFACPUL('ТТЛП','ЛМИЛЗ');
SELECT * FROM DBO.FFACPUL('NO','NO');
GO
--4 На рисунке ниже показан сценарий, демонстрирующий ра-боту скалярной функции FCTEACHER. 
--Функция принима-ет один параметр, задающий код кафедры. Функция воз-вращает количество 
--преподавателей на заданной парамет-ром кафедре. Если параметр равен NULL, то возвращается общее количество преподавателей.
USE UNIVER
GO
CREATE FUNCTION FCTEACHER(@PUL NVARCHAR(10)) RETURNS INT AS
    BEGIN
        DECLARE @COUNT INT=(SELECT COUNT(*) FROM TEACHER
        WHERE PULPIT=ISNULL(@PUL, PULPIT));
        RETURN @COUNT;
    END;
GO

SELECT PULPIT, DBO.FCTEACHER(PULPIT) [КОЛИЧЕСТВО ПРЕПОДАВАТЕЛЕЙ] FROM PULPIT;

SELECT DBO.FCTEACHER(NULL) [ВСЕГО ПРЕПОДАВАТЕЛЕЙ];

--6
USE UNIVER
GO
CREATE FUNCTION COUNT_PULPIT(@FACULTY NVARCHAR(10)) RETURNS INT
AS BEGIN
    DECLARE @RC INT=0;
    SET @RC=(SELECT COUNT(*) FROM PULPIT
        WHERE PULPIT.FACULTY=@FACULTY)
    RETURN @RC;
END;
----DROP FUNCTION COUNT_PULPIT;
GO

CREATE FUNCTION COUNT_GROUPS(@FACULTY NVARCHAR(10)) RETURNS INT
AS BEGIN
    DECLARE @RC INT=0;
    SET @RC=(SELECT COUNT(*) FROM GROUPS
        WHERE GROUPS.FACULTY=@FACULTY)
    RETURN @RC;
END;
--DROP FUNCTION COUNT_GROUPS;
GO

CREATE FUNCTION COUNT_PROFESSION(@FACULTY VARCHAR(20)) RETURNS INT
	AS BEGIN
		DECLARE @RC INT = 0;
		SET @RC = (SELECT COUNT(*) FROM PROFESSION
			WHERE PROFESSION.FACULTY = @FACULTY)
		RETURN @RC;
	END;
--DROP FUNCTION COUNT_PROFESSION;
GO
DROP FUNCTION COUNT_STUDENTS

CREATE FUNCTION COUNT_STUDENTS (@FACULTY VARCHAR(20)) RETURNS INT
AS 
 BEGIN 
 DECLARE @RC INT = 0;
		SET @RC = (SELECT COUNT(*) FROM STUDENT
	     JOIN GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
			WHERE GROUPS.FACULTY = @FACULTY)
		RETURN @RC;
 END



CREATE FUNCTION FACULTY_REPORT(@C INT) RETURNS @FR TABLE
	([ФАКУЛЬТЕТ] VARCHAR(50),
	[КОЛИЧЕСТВО КАФЕДР] INT,
	[КОЛИЧЕСТВО ГРУПП] INT,
	[КОЛИЧЕСТВО СТУДЕНТОВ] INT,
	[КОЛИЧЕСТВО СПЕЦИАЛЬНОСТЕЙ] INT)
	AS BEGIN
		DECLARE CC CURSOR LOCAL STATIC FOR
			SELECT FACULTY FROM FACULTY WHERE DBO.COUNT_STUDENTS(FACULTY.FACULTY) > @C;
		DECLARE @F VARCHAR(30);
		OPEN CC;
			FETCH CC INTO @F;
		WHILE @@FETCH_STATUS = 0
			BEGIN
				INSERT @FR VALUES(
				@F,
				DBO.COUNT_PULPIT(@F),
	            DBO.COUNT_GROUPS(@F),
				DBO.COUNT_STUDENTS(@F),
				DBO.COUNT_PROFESSION(@F));
	            FETCH CC INTO @F;
			END;
		CLOSE CC;
		DEALLOCATE CC;
		RETURN;
	END;
GO

SELECT * FROM DBO.FACULTY_REPORT(1);
GO