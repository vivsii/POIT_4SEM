USE UNIVER 
--1 ����������� ��������� ������� � ������ COUNT_STUDENTS, ������� ��������� ���������� ���-������ �� ����������, 
--��� �������� �������� ���������� ���� varchar(20) � ������ @faculty. ������������ ����-������ ���������� 
--������ FACULTY, GROUPS, STUDENT. ���������� ������ �������.������ ��������� � ����� ������� � ������� ��������� ALTER � ���, 
--����� ������� ��������� ������ �������� @prof ���� varchar(20), ������������ ������������� ���-������. ��� ���������� 
--���������� �������� �� ��������� NULL. ���������� ������ ������� � ������� SELECT-��������.

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
SELECT FACULTY '���������',
DBO.COUNT_STUDENTS(FACULTY) '���-�� ���������'
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
SELECT FACULTY.FACULTY '���������',
	GROUPS.PROFESSION '�������������',
	DBO.COUNT_STUDENTS(FACULTY.FACULTY, GROUPS.PROFESSION) '���-�� ���������'
FROM FACULTY
	INNER JOIN GROUPS ON GROUPS.FACULTY = FACULTY.FACULTY
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION
GO
--2 ����������� ��������� ������� � ������ FSUBJECTS, ����������� �������� @p ���� varchar(20), �������� ��-������ ������ ��� ������� (������� SUBJECT.PULPIT). 
--������� ������ ���������� ������ ���� varchar(300) � �������� ��������� � ������. 
--������� � ��������� ��������, ������� ������� �����, ����������� ��������������� ����. 
--������������ ��������� ����������� ������ �� ������ SELECT-������� � ������� SUBJECT.

USE UNIVER 
GO
CREATE FUNCTION FSUBJECTS (@P NVARCHAR(20)) RETURNS NVARCHAR(300) AS
BEGIN
    DECLARE @LIST VARCHAR(300) = '����������: ', @SUB VARCHAR(20);
    DECLARE SUBJECT_CURSOR CURSOR LOCAL FOR
    SELECT SUBJECT.SUBJECT '����������'
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
PRINT DBO.FSUBJECTS('����');
SELECT PULPIT '�������', DBO.FSUBJECTS(PULPIT) '����������' FROM PULPIT;
GO

--3 ����������� ��������� ������� FFACPUL, ���������� ������ ������� ������������������ �� ������� ����. 
--������� ��������� ��� ���������, �������� ��� ��-�������� (������� FACULTY.FACULTY) � ��� 
--������� (������� PULPIT.PULPIT). ���������� SELECT-������ c ����� ������� ����������� ����� ��������� FACULTY � PULPIT. 
--���� ��� ��������� ������� ����� NULL, �� ��� ���-������� ������ ���� ������ �� ���� �����������. 
--���� ����� ������ �������� (������ ����� NULL), ����-��� ���������� ������ ���� ������ ��������� ����������. 
--���� ����� ������ �������� (������ ����� NULL), ����-��� ���������� �������������� �����, ���������� ����-��, ��������������� �������� �������.
--���� ������ ��� ���������, ������� ���������� ������-�������� �����, ���������� ������, ��������������� �������� ������� �� �������� ����������. 
--���� �� �������� ��������� ���������� ���������� ������������ ������, ������� ���������� ������ ������-�������� �����. 

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
SELECT * FROM DBO.FFACPUL('���',NULL);
SELECT * FROM DBO.FFACPUL(NULL,'����');
SELECT * FROM DBO.FFACPUL('����','�����');
SELECT * FROM DBO.FFACPUL('NO','NO');
GO
--4 �� ������� ���� ������� ��������, ��������������� ��-���� ��������� ������� FCTEACHER. 
--������� �������-�� ���� ��������, �������� ��� �������. ������� ���-������� ���������� 
--�������������� �� �������� �������-��� �������. ���� �������� ����� NULL, �� ������������ ����� ���������� ��������������.
USE UNIVER
GO
CREATE FUNCTION FCTEACHER(@PUL NVARCHAR(10)) RETURNS INT AS
    BEGIN
        DECLARE @COUNT INT=(SELECT COUNT(*) FROM TEACHER
        WHERE PULPIT=ISNULL(@PUL, PULPIT));
        RETURN @COUNT;
    END;
GO

SELECT PULPIT, DBO.FCTEACHER(PULPIT) [���������� ��������������] FROM PULPIT;

SELECT DBO.FCTEACHER(NULL) [����� ��������������];

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
	([���������] VARCHAR(50),
	[���������� ������] INT,
	[���������� �����] INT,
	[���������� ���������] INT,
	[���������� ��������������] INT)
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