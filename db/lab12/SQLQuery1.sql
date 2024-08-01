-----------------------1-----------------------
SET NOCOUNT ON
	IF EXISTS (SELECT * FROM  SYS.OBJECTS        -- ������� X ����?
	            WHERE OBJECT_ID= OBJECT_ID(N'DBO.M') )	    
	DROP TABLE M;
	DECLARE @C INT, @FLAG CHAR ='C' -- COMMIT ��� ROLLBACK?
	SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������
	CREATE TABLE M(K INT );          
	-- ������ ���������� 
		INSERT M VALUES (1),(2),(3);
		SET @C = (SELECT COUNT(*) FROM M);
		PRINT '���������� ����� � ������� M: ' + CAST( @C AS VARCHAR(2));
		IF @FLAG = 'C'  COMMIT;                   -- ���������� ����������: �������� 
	          ELSE   ROLLBACK;                                 -- ���������� ����������: �����  
      SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������
	
	IF  EXISTS (SELECT * FROM  SYS.OBJECTS       -- ������� X ����?
	            WHERE OBJECT_ID= OBJECT_ID(N'DBO.M') )
	PRINT '������� M ����';  
      ELSE PRINT '������� M ���'
-----------------------2-----------------------
BEGIN TRY
	BEGIN TRAN                 -- ������  ����� ����������
		INSERT FACULTY VALUES ('��', '��������� ������ ����');
	    INSERT FACULTY VALUES ('���', '��������� PRINT-����������');
		--DELETE FACULTY WHERE FACULTY = '��';
--DELETE FACULTY WHERE FACULTY = '���';
	COMMIT TRAN;               -- �������� ����������
END TRY

BEGIN CATCH
	PRINT '������: '+ CASE
		WHEN ERROR_NUMBER() = 2627 AND PATINDEX('%FACULTY_PK%', ERROR_MESSAGE()) > 0 THEN '������������ '	
		ELSE '����������� ������: '+ CAST(ERROR_NUMBER() AS  VARCHAR(5))+ ERROR_MESSAGE()
	END;
	IF @@TRANCOUNT > 0 ROLLBACK TRAN; -- ��.����������� ��.>0,  ����� �� ���������
END CATCH;

SELECT * FROM FACULTY;
-----------------------3-----------------------
DECLARE @POINT VARCHAR(32);

BEGIN TRY
	BEGIN TRAN
		SET @POINT = 'P1';
		SAVE TRAN @POINT;  -- ����������� ����� P1
		INSERT STUDENT(IDSTUDENT, NAME, BDAY, INFO, FOTO) VALUES
		                      (20,'���', '1997-08-02', NULL, NULL),
							  (20,'���', '1997-08-06', NULL, NULL),
							  (20,'���', '1997-08-01', NULL, NULL),
							  (20,'���', '1997-08-03', NULL, NULL);
		SET @POINT = 'P2';
		SAVE TRAN @POINT; -- ����������� ����� P2
		INSERT STUDENT(IDSTUDENT, NAME, BDAY, INFO, FOTO) VALUES
							  (21, '��������� �������', '1997-08-02', NULL, NULL);
	COMMIT TRAN;
END TRY

BEGIN CATCH
	PRINT '������: '+ CASE
		WHEN ERROR_NUMBER() = 2627 AND PATINDEX('%STUDENT_PK%', ERROR_MESSAGE()) > 0 THEN '������������ ��������'
		ELSE '����������� ������: '+ CAST(ERROR_NUMBER() AS  VARCHAR(5)) + ERROR_MESSAGE()
	END;
    IF @@TRANCOUNT > 0 -- ���� ���������� �� ���������
	BEGIN
	   PRINT '����������� �����: '+ @POINT;
	   ROLLBACK TRAN @POINT; -- ����� � ��������� �����.�����
	   COMMIT TRAN; -- �������� ���������, ������ �� �����.�����
	END;
END CATCH;

SELECT * FROM STUDENT WHERE IDGROUP=20;
DELETE STUDENT WHERE IDGROUP=20 AND IDGROUP = 21
-----------------------4-----------------------
-- ������ ���������� � ������� �������� READ UNCOMMITTED
--��� ����� ������ ������� ��������.
--���������� ����� ������ � ���������������� ����������, ��������� ������� ������������.
-----A------

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT @@SPID
BEGIN TRANSACTION
------------------ T1 ------------------
SELECT * FROM SUBJECT WHERE SUBJECT = 'TEST';
ROLLBACK TRAN;

COMMIT TRAN;
-------t2---------
-----------------------5----------------------
-- A ---
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
SELECT * FROM SUBJECT WHERE SUBJECT = '��';
-------------------------- T1 ------------------
-------------------------- T2 -----------------
SELECT * FROM SUBJECT WHERE SUBJECT = '��';
COMMIT TRAN;


ROLLBACK
-----------------------6-----------------------
--�������� ���������������� ������, �� ������ ����������
-- ��������� ���������� � ������� �������� REPEATABLE READ
--���������� ����� ������ ���������, �������������� �� ������ �� ������.
--�������� ����� ���������� ��-�� "��������� �����", 
--����� ����� ������ ����������� ������� ������������, � ���������� ���� ������� ���������� �������������� ������.
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
SELECT COUNT(*) FROM SUBJECT WHERE SUBJECT = '����';
-------------------------- T1 ------------------
-------------------------- T2 -----------------
SELECT COUNT(*) FROM SUBJECT WHERE SUBJECT = '����';
COMMIT TRAN;
rollback
-----------------------7-----------------------
--�������������, ��� �� ���� ������ ���������� �� ������ ������� ��������� � ������, � ������� ���������� ������� ����������.
-- ��������� ���������� � ������� �������� SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
SELECT * FROM SUBJECT;
-------------------------- T1 -----------------
-------------------------- T2 ------------------
SELECT * FROM SUBJECT;
COMMIT TRAN;

rollback

rollback
-----------------------8-----------------------
BEGIN TRAN
  INSERT AUDITORIUM_TYPE VALUES ('TEST', 'TEST TEST');
  BEGIN TRAN
    UPDATE AUDITORIUM SET AUDITORIUM = '206-1' WHERE AUDITORIUM_TYPE = 'TEST'
    COMMIT
    IF @@TRANCOUNT > 0 ROLLBACK
  SELECT
    (SELECT COUNT(*) FROM AUDITORIUM WHERE AUDITORIUM_TYPE='TEST') 'AUDIT',
    (SELECT COUNT(*) FROM AUDITORIUM_TYPE  WHERE AUDITORIUM_TYPE='TEST') 'TYPE'
DELETE  AUDITORIUM_TYPE WHERE  AUDITORIUM_TYPE = 'TEST';

