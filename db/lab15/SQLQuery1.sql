USE UNIVER
--1 С помощью сценария, представленного на ри-сунке, создать таблицу TR_AUDIT.
--Таблица предназначена для добавления в нее строк триггерами. 
--В столбец STMT триггер должен поместить событие, на которое он среагировал, а в стол-бец TRNAME собственное имя. 
--Разработать AFTER-триггер с именем TR_TEACHER_INS для таблицы TEACHER, реагирующий на событие INSERT.
--Триггер должен записывать строки вводимых данных в таблицу TR_AUDIT. В столбец СС помеща-ются значения столбцов вводимой строки. 
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
PRINT 'ОПЕРАЦИЯ ВСТАВКИ';
SET @A1=(SELECT [TEACHER] FROM INSERTED);
SET @A2=(SELECT [TEACHER_NAME] FROM INSERTED);
SET @A3=(SELECT [GENDER] FROM INSERTED);
SET @A4=(SELECT [PULPIT] FROM INSERTED);
SET @IN=@A1+' '+ @A2 +' '+ @A3+ ' ' +@A4;
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES('INS', 'TR_TEACHER_INS', @IN);
RETURN;
INSERT INTO TEACHER (TEACHER, TEACHER_NAME, GENDER, PULPIT)
VALUES ('ЕВП','ЕВСЕЕНКО ВИКТОРИЯ ПАВЛОВНА','Ж','ИСИТ')

--DELETE FROM TEACHER 
--WHERE TEACHER = 'ГДР'

SELECT * FROM TR_AUDIT
--2 Создать AFTER-триггер с именем TR_TEACHER_DEL для таблицы TEA-CHER, реагирующий на событие DELETE. 
--Триггер должен записывать строку данных в таблицу TR_AUDIT для каждой удаляемой строки. 
--В столбец СС помещаются значения столбца TEACHER удаляемой строки. 
CREATE TRIGGER TR_TEACHER_DEL 
ON TEACHER AFTER DELETE
AS DECLARE @A1 CHAR(10), @A2 VARCHAR(100), @A3 CHAR(1), @A4 CHAR(20), @IN VARCHAR(300);
PRINT 'ОПЕРАЦИЯ УДАЛЕНИЯ';
SET @A1=(SELECT [TEACHER] FROM DELETED);
SET @A2=(SELECT [TEACHER_NAME] FROM DELETED);
SET @A3=(SELECT [GENDER] FROM DELETED);
SET @A4=(SELECT [PULPIT] FROM DELETED);
SET @IN=@A1+' '+ @A2 +' '+ @A3+ ' ' +@A4;
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES('DEL', 'TR_TEACHER_DEL', @IN);
RETURN;

DELETE TEACHER  WHERE TEACHER = 'ЕВП'

SELECT * FROM TR_AUDIT
--3 Создать AFTER-триггер с именем TR_TEACHER_UPD для таблицы TEA-CHER, реагирующий на событие UPDATE. 
--Триггер должен записывать строку данных в таблицу TR_AUDIT для каждой изменяемой строки. 
--В столбец СС помещаются значения столбцов изменяемой строки до и после изме-нения.
CREATE TRIGGER TR_TEACHER_UPD 
ON TEACHER AFTER UPDATE
AS DECLARE @A1 CHAR(10), @A2 VARCHAR(100), @A3 CHAR(1), @A4 CHAR(20), @IN VARCHAR(300);
PRINT 'ОПЕРАЦИЯ ОБНОВЛЕНИЯ';
SET @A1=(SELECT [TEACHER] FROM INSERTED);
SET @A2=(SELECT [TEACHER_NAME] FROM INSERTED);
SET @A3=(SELECT [GENDER] FROM INSERTED);
SET @A4=(SELECT [PULPIT] FROM INSERTED);
SET @IN=@A1+' '+ @A2 +' '+ @A3+ ' ' +@A4;
INSERT INTO TR_AUDIT(STMT,TRNAME,CC)   VALUES('UPD', 'TR_TEACHER_UPD', @IN);
RETURN;
UPDATE TEACHER SET GENDER = 'М' WHERE TEACHER='ЕВП'
	  SELECT * FROM TR_AUDIT
SELECT * FROM TR_AUDIT
--4 Создать AFTER-триггер с именем TR_TEACHER для таблицы TEACHER, реа-гирующий на события INSERT, DELETE, UPDATE. 
--Триггер должен записывать строку данных в таблицу TR_AUDIT для каждой изменяемой строки. 
--В коде триггера определить событие, активизировавшее триггер и поместить в стол-бец СС соответствующую событию информа-цию. 
--Разработать сценарий, демонстрирующий работоспособность триггера.
create trigger TR_TEACHER on TEACHER after INSERT, DELETE, UPDATE  
AS DECLARE @A1 CHAR(10), @A2 VARCHAR(100), @A3 CHAR(1), @A4 CHAR(20), @IN VARCHAR(300);
declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
     print 'Событие: INSERT';
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
    print 'Событие: DELETE';
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
    print 'Событие: UPDATE'; 
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
   
     DELETE TEACHER WHERE TEACHER='ЕВП'
	  INSERT INTO  TEACHER VALUES('ЕВП', 'ЕВСЕЕНКО ВИКТОРИЯ ПАВЛОВНА', 'Ж', 'ИСИТ');
	  	  UPDATE TEACHER SET GENDER = 'М' WHERE TEACHER='ЕВП'

		    SELECT * FROM TR_AUDIT
--5 Разработать сценарий, который демонстрирует на примере базы данных UNIVER, что провер-ка ограничения целостности выполняется до срабатывания AFTER-триггера.
INSERT INTO TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
VALUES(1,2,4,4)
UPDATE TEACHER SET GENDER = 'Ж54' WHERE TEACHER='ЕВП'

 SELECT * FROM TR_AUDIT
 SELECT *FROM TEACHER
 --6 Создать для таблицы TEACHER три AFTER-триггера с именами: TR_TEACHER_ DEL1, TR_TEACHER_DEL2 и TR_TEA-CHER_ DEL3. 
 --Триггеры должны реагировать на собы-тие DELETE и формировать соответствующие строки в таблицу TR_AUDIT.  
--Получить список триггеров таблицы TEACHER. 
--Упорядочить выполнение триггеров для таб-лицы TEACHER, реагирующих на событие DELETE следующим образом: 
--первым должен выполняться триггер с именем TR_TEA-CHER_DEL3, последним – триггер TR_TEACHER_DEL2. 
--Использовать системные представления SYS.TRIGGERS и SYS.TRIGGERS_ EVENTS, а также системную процедуру SP_SETTRIGGERORDERS. 

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

--DELETE TEACHER WHERE TEACHER='ГДР'


SELECT T.NAME, E.TYPE_DESC
  FROM SYS.TRIGGERS  T JOIN  SYS.TRIGGER_EVENTS E  ON T.OBJECT_ID = E.OBJECT_ID
  WHERE OBJECT_NAME(T.PARENT_ID)='TEACHER' AND E.TYPE_DESC = 'DELETE' ;
--ИЗМ-Е ПОРЯДКА ВЫПОЛН-Я ТРИГГЕРОВ
EXEC  SP_SETTRIGGERORDER @TRIGGERNAME = 'TEACH_AFTER_DEL3',
	                        @ORDER='FIRST', @STMTTYPE = 'DELETE';
EXEC  SP_SETTRIGGERORDER @TRIGGERNAME = 'TEACH_AFTER_DEL2',
 @ORDER='LAST', @STMTTYPE = 'DELETE';
 --7 Разработать сценарий, демонстрирующий на примере базы данных UNIVER утверждение: 
 --AFTER-триггер является частью транзакции, в рамках которого выполняется оператор, акти-визировавший триггер.
 CREATE TRIGGER SEVENTRAN111 ON 
 PULPIT AFTER INSERT, DELETE, UPDATE
	AS DECLARE @C INT = (SELECT COUNT (*) FROM PULPIT);
	 IF (@C >20)
	 BEGIN
       RAISERROR('ОБЩАЯ КОЛИЧЕСТВО КАФЕДР НЕ МОЖЕТ БЫТЬ >20', 10, 1);
	 ROLLBACK;
	 END;
	 RETURN;

INSERT INTO PULPIT(PULPIT) VALUES ('ПУПУПУ');
--8 Для таблицы FACULTY создать INSTEAD OF-триггер, запрещающий удаление строк в таблице. 
--Разработать сценарий, который демонстри-рует на примере базы данных UNIVER, что проверка ограничения целостности выполнена, если есть INSTEAD OF-триггер.
--С помощью оператора DROP удалить все DML-триггеры, созданные в этой лабораторной работе.

CREATE TRIGGER FAC_INSREAD_OF
ON FACULTY INSTEAD OF DELETE

AS RAISERROR (N'УДАЛЕНИЕ ЗАПРЕЩЕНО', 10,1);
RETURN;
 DELETE FACULTY WHERE FACULTY = 'NEW';

DROP TRIGGER TR_TEACHER_INS, TR_TEACHER_DEL, TR_TEACHER_UPD, TR_TEACHER, TEACH_AFTER_DEL1, TEACH_AFTER_DEL2, TEACH_AFTER_DEL3, SEVENTRAN111, FAC_INSREAD_OF
--9 Создать DDL-триггер, реагирующий на все DDL-события в БД UNIVER. 
--Триггер должен запрещать создавать новые таблицы и удалять существующие. 
--Свое вы-полнение триггер должен сопровождать сооб-щением, которое содержит: 
--тип события, имя и тип объекта, а также пояснительный текст, в случае запрещения выполнения оператора. 
--Разработать сценарий, демонстрирующий работу триггера. 

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
       PRINT 'ТИП СОБЫТИЯ: ' + @EVENT_TYPE;
       PRINT 'ИМЯ ОБЪЕКТА: ' + @OBJ_NAME;
       PRINT 'ТИП ОБЪЕКТА: ' + @OBJ_TYPE;
       RAISERROR( N'ОПЕРАЦИИ С ТАБЛИЦЕЙ TEACHER ЗАПРЕЩЕНЫ', 16, 1);  
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
