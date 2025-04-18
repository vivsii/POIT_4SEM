USE UNIVER
--1 � ������� ��������, ��������������� �� ��-�����, ������� ������� TR_AUDIT.
--������� ������������� ��� ���������� � ��� ����� ����������. 
--� ������� STMT ������� ������ ��������� �������, �� ������� �� �����������, � � ����-��� TRNAME ����������� ���. 
--����������� AFTER-������� � ������ TR_TEACHER_INS ��� ������� TEACHER, ����������� �� ������� INSERT.
--������� ������ ���������� ������ �������� ������ � ������� TR_AUDIT. � ������� �� ������-���� �������� �������� �������� ������. 
CREATE TABLE TR_AUDIT
(
ID INT IDENTITY,
STMT VARCHAR(20)
CHECK (STMT IN ('INS', 'DEL', 'UPD')),
TRNAME VARCHAR(50),
CC VARCHAR(300)
)

CREATE TRIGGER TR_TEACHER_INS 
ON TEACHER AFTER INSERT
AS DECLARE @A1 CHAR(10), @A2 VARCHAR(100), @A3 CHAR(1), @A4 CHAR(20), @IN VARCHAR(300);
PRINT '�������� �������';
SET @A1=(SELECT [TEACHER] FROM INSERTED);
SET @A2=(SELECT [TEACHER_NAME] FROM INSERTED);
SET @A3=(SELECT [GENDER] FROM INSERTED);
SET @A4=(SELECT [PULPIT] FROM INSERTED);
SET @IN=@A1+' '+ @A2 +' '+ @A3+ ' ' +@A4;
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES('INS', 'TR_TEACHER_INS', @IN);
RETURN;
INSERT INTO TEACHER (TEACHER, TEACHER_NAME, GENDER, PULPIT)
VALUES ('���','�������� �������� ��������','�','����')

--DELETE FROM TEACHER 
--WHERE TEACHER = '���'

SELECT * FROM TR_AUDIT
--2 ������� AFTER-������� � ������ TR_TEACHER_DEL ��� ������� TEA-CHER, ����������� �� ������� DELETE. 
--������� ������ ���������� ������ ������ � ������� TR_AUDIT ��� ������ ��������� ������. 
--� ������� �� ���������� �������� ������� TEACHER ��������� ������. 
CREATE TRIGGER TR_TEACHER_DEL 
ON TEACHER AFTER DELETE
AS DECLARE @A1 CHAR(10), @A2 VARCHAR(100), @A3 CHAR(1), @A4 CHAR(20), @IN VARCHAR(300);
PRINT '�������� ��������';
SET @A1=(SELECT [TEACHER] FROM DELETED);
SET @A2=(SELECT [TEACHER_NAME] FROM DELETED);
SET @A3=(SELECT [GENDER] FROM DELETED);
SET @A4=(SELECT [PULPIT] FROM DELETED);
SET @IN=@A1+' '+ @A2 +' '+ @A3+ ' ' +@A4;
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES('DEL', 'TR_TEACHER_DEL', @IN);
RETURN;

DELETE TEACHER  WHERE TEACHER = '���'

SELECT * FROM TR_AUDIT
--3 ������� AFTER-������� � ������ TR_TEACHER_UPD ��� ������� TEA-CHER, ����������� �� ������� UPDATE. 
--������� ������ ���������� ������ ������ � ������� TR_AUDIT ��� ������ ���������� ������. 
--� ������� �� ���������� �������� �������� ���������� ������ �� � ����� ����-�����.
CREATE TRIGGER TR_TEACHER_UPD 
ON TEACHER AFTER UPDATE
AS DECLARE @A1 CHAR(10), @A2 VARCHAR(100), @A3 CHAR(1), @A4 CHAR(20), @IN VARCHAR(300);
PRINT '�������� ����������';
SET @A1=(SELECT [TEACHER] FROM INSERTED);
SET @A2=(SELECT [TEACHER_NAME] FROM INSERTED);
SET @A3=(SELECT [GENDER] FROM INSERTED);
SET @A4=(SELECT [PULPIT] FROM INSERTED);
SET @IN=@A1+' '+ @A2 +' '+ @A3+ ' ' +@A4;
INSERT INTO TR_AUDIT(STMT,TRNAME,CC)   VALUES('UPD', 'TR_TEACHER_UPD', @IN);
RETURN;
UPDATE TEACHER SET GENDER = '�' WHERE TEACHER='���'
	  SELECT * FROM TR_AUDIT
SELECT * FROM TR_AUDIT
--4 ������� AFTER-������� � ������ TR_TEACHER ��� ������� TEACHER, ���-�������� �� ������� INSERT, DELETE, UPDATE. 
--������� ������ ���������� ������ ������ � ������� TR_AUDIT ��� ������ ���������� ������. 
--� ���� �������� ���������� �������, ���������������� ������� � ��������� � ����-��� �� ��������������� ������� �������-���. 
--����������� ��������, ��������������� ����������������� ��������.
create trigger TR_TEACHER on TEACHER after INSERT, DELETE, UPDATE  
AS DECLARE @A1 CHAR(10), @A2 VARCHAR(100), @A3 CHAR(1), @A4 CHAR(20), @IN VARCHAR(300);
declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
     print '�������: INSERT';
    SET @A1=(SELECT [TEACHER] FROM INSERTED);
SET @A2=(SELECT [TEACHER_NAME] FROM INSERTED);
SET @A3=(SELECT [GENDER] FROM INSERTED);
SET @A4=(SELECT [PULPIT] FROM INSERTED);
SET @IN=@A1+' '+ @A2 +' '+ @A3+ ' ' +@A4;
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES('INS', 'TR_TEACHER_', @IN);
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
    print '�������: DELETE';
   SET @A1=(SELECT [TEACHER] FROM DELETED);
SET @A2=(SELECT [TEACHER_NAME] FROM DELETED);
SET @A3=(SELECT [GENDER] FROM DELETED);
SET @A4=(SELECT [PULPIT] FROM DELETED);
SET @IN=@A1+' '+ @A2 +' '+ @A3+ ' ' +@A4;
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES('DEL', 'TR_TEACHER', @IN);
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
    print '�������: UPDATE'; 
      SET @A1=(SELECT [TEACHER] FROM INSERTED);
SET @A2=(SELECT [TEACHER_NAME] FROM INSERTED);
SET @A3=(SELECT [GENDER] FROM INSERTED);
SET @A4=(SELECT [PULPIT] FROM INSERTED);
SET @IN=@A1+' '+ @A2 +' '+ @A3+ ' ' +@A4;
    SET @A1=(SELECT [TEACHER] FROM DELETED);
SET @A2=(SELECT [TEACHER_NAME] FROM DELETED);
SET @A3=(SELECT [GENDER] FROM DELETED);
SET @A4=(SELECT [PULPIT] FROM DELETED);
SET @IN=@A1+' '+ @A2 +' '+ @A3+ ' ' +@A4;
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES('UPD', 'TR_TEACHER', @IN); 
end;  
return;  
   
     DELETE TEACHER WHERE TEACHER='���'
	  INSERT INTO  TEACHER VALUES('���', '�������� �������� ��������', '�', '����');
	  	  UPDATE TEACHER SET GENDER = '�' WHERE TEACHER='���'

		    SELECT * FROM TR_AUDIT
--5 ����������� ��������, ������� ������������� �� ������� ���� ������ UNIVER, ��� ������-�� ����������� ����������� ����������� �� ������������ AFTER-��������.
INSERT INTO TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
VALUES(1,2,4,4)
UPDATE TEACHER SET GENDER = '�54' WHERE TEACHER='���'

 SELECT * FROM TR_AUDIT
 SELECT *FROM TEACHER
 --6 ������� ��� ������� TEACHER ��� AFTER-�������� � �������: TR_TEACHER_ DEL1, TR_TEACHER_DEL2 � TR_TEA-CHER_ DEL3. 
 --�������� ������ ����������� �� ����-��� DELETE � ����������� ��������������� ������ � ������� TR_AUDIT.  
--�������� ������ ��������� ������� TEACHER. 
--����������� ���������� ��������� ��� ���-���� TEACHER, ����������� �� ������� DELETE ��������� �������: 
--������ ������ ����������� ������� � ������ TR_TEA-CHER_DEL3, ��������� � ������� TR_TEACHER_DEL2. 
--������������ ��������� ������������� SYS.TRIGGERS � SYS.TRIGGERS_ EVENTS, � ����� ��������� ��������� SP_SETTRIGGERORDERS. 

 CREATE TRIGGER TEACH_AFTER_DEL1 ON TEACHER AFTER DELETE
AS PRINT '1';
 RETURN;
GO
CREATE TRIGGER TEACH_AFTER_DEL2 ON TEACHER AFTER DELETE
AS PRINT '2';
 RETURN;
GO
CREATE TRIGGER TEACH_AFTER_DEL3 ON TEACHER AFTER DELETE
AS PRINT '3';
 RETURN;
GO

--DELETE TEACHER WHERE TEACHER='���'


SELECT T.NAME, E.TYPE_DESC
  FROM SYS.TRIGGERS  T JOIN  SYS.TRIGGER_EVENTS E  ON T.OBJECT_ID = E.OBJECT_ID
  WHERE OBJECT_NAME(T.PARENT_ID)='TEACHER' AND E.TYPE_DESC = 'DELETE' ;
--���-� ������� ������-� ���������
EXEC  SP_SETTRIGGERORDER @TRIGGERNAME = 'TEACH_AFTER_DEL3',
	                        @ORDER='FIRST', @STMTTYPE = 'DELETE';
EXEC  SP_SETTRIGGERORDER @TRIGGERNAME = 'TEACH_AFTER_DEL2',
 @ORDER='LAST', @STMTTYPE = 'DELETE';
 --7 ����������� ��������, ��������������� �� ������� ���� ������ UNIVER �����������: 
 --AFTER-������� �������� ������ ����������, � ������ �������� ����������� ��������, ����-������������ �������.
 CREATE TRIGGER SEVENTRAN111 ON 
 PULPIT AFTER INSERT, DELETE, UPDATE
	AS DECLARE @C INT = (SELECT COUNT (*) FROM PULPIT);
	 IF (@C >20)
	 BEGIN
       RAISERROR('����� ���������� ������ �� ����� ���� >20', 10, 1);
	 ROLLBACK;
	 END;
	 RETURN;

INSERT INTO PULPIT(PULPIT) VALUES ('������');
--8 ��� ������� FACULTY ������� INSTEAD OF-�������, ����������� �������� ����� � �������. 
--����������� ��������, ������� ���������-���� �� ������� ���� ������ UNIVER, ��� �������� ����������� ����������� ���������, ���� ���� INSTEAD OF-�������.
--� ������� ��������� DROP ������� ��� DML-��������, ��������� � ���� ������������ ������.

CREATE TRIGGER FAC_INSREAD_OF
ON FACULTY INSTEAD OF DELETE

AS RAISERROR (N'�������� ���������', 10,1);
RETURN;
 DELETE FACULTY WHERE FACULTY = 'NEW';

DROP TRIGGER TR_TEACHER_INS, TR_TEACHER_DEL, TR_TEACHER_UPD, TR_TEACHER, TEACH_AFTER_DEL1, TEACH_AFTER_DEL2, TEACH_AFTER_DEL3, SEVENTRAN111, FAC_INSREAD_OF
--9 ������� DDL-�������, ����������� �� ��� DDL-������� � �� UNIVER. 
--������� ������ ��������� ��������� ����� ������� � ������� ������������. 
--���� ��-�������� ������� ������ ������������ ����-������, ������� ��������: 
--��� �������, ��� � ��� �������, � ����� ������������� �����, � ������ ���������� ���������� ���������. 
--����������� ��������, ��������������� ������ ��������. 

CREATE TRIGGER TR_TEACHER_DDL5 ON DATABASE 
FOR CREATE_TABLE, DROP_TABLE, ALTER_TABLE
AS   
DECLARE @EVENT_TYPE VARCHAR(100),
  @OBJ_NAME VARCHAR(100),
  @OBJ_TYPE VARCHAR(100) 

SET @EVENT_TYPE = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)');
SET @OBJ_NAME = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(100)');
SET @OBJ_TYPE = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'VARCHAR(100)');

IF @EVENT_TYPE = 'ALTER_TABLE' OR @EVENT_TYPE = 'DROP_TABLE' OR @EVENT_TYPE = 'CREATE_TABLE'
BEGIN
       PRINT '��� �������: ' + @EVENT_TYPE;
       PRINT '��� �������: ' + @OBJ_NAME;
       PRINT '��� �������: ' + @OBJ_TYPE;
       RAISERROR( N'�������� � �������� TEACHER ���������', 16, 1);  
ROLLBACK  
END

CREATE TABLE PRANK (
    ID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE
);
DROP TABLE PRANK

ALTER TABLE TEACHER add Prank int
ALTER TABLE TEACHER drop column Prank

SELECT * FROM TEACHER

DROP TRIGGER TR_TEACHER_DDL5 ON DATABASE;
