-----------------------4-----------------------

---B---
USE UNIVER;
GO
BEGIN TRANSACTION
SELECT @@SPID
INSERT SUBJECT VALUES ('TEST', 'TEST', '»—»“');

--------------------- T1 --------------------
--------------------- T2 --------------------
ROLLBACK TRAN;
COMMIT TRAN;

-----------------------5-----------------------

--- B ---
BEGIN TRANSACTION
-------------------------- T1 --------------------
UPDATE SUBJECT SET SUBJECT_NAME = '¡‡Á˚ ‰‡ÌÌ˚ı111'  WHERE SUBJECT = '¡ƒ';
SELECT * FROM SUBJECT WHERE SUBJECT = '¡ƒ';
COMMIT TRAN;
-------------------------- T2 --------------------
ROLLBACK
-----------------------6-----------------------
--- B ---
BEGIN TRANSACTION
-------------------------- T1 --------------------

INSERT SUBJECT VALUES ('»—»“', '»—»“1', '»—»“');

COMMIT TRAN;
rollback
select * FROM SUBJECT
delete FROM SUBJECT WHERE SUBJECT = '»—»“';

-----------------------7-----------------------
--- B ---
BEGIN TRANSACTION
-------------------------- T1 --------------------
--DELETE FROM SUBJECT WHERE SUBJECT_NAME = 'TEST'
INSERT SUBJECT VALUES ('TEST', 'TEST', '»—»“');
UPDATE SUBJECT SET SUBJECT = 'TEST' WHERE PULPIT = 'TEST'
COMMIT TRAN;
-------------------- T2 --------------------

rollback