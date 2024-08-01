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
begin try
	begin tran
		delete �������� where ��������.������� = '�';
		insert ��������(�������, ���_�������, ����������_�����) VALUES ('�', '��-�', 15);
		insert ��������(�������, ���_�������, ����������_�����) VALUES ('���', '��-�', 15);
	commit tran;
end try
begin catch
		print '������' + case
		when error_number() = 2627 and patindex('%AUDITORIUM_PK%', error_message()) > 0
		then ' ������������ �����'
		else ' ����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0 
		rollback tran;
end catch

-----------------------3-----------------------
DECLARE @point varchar(3)
BEGIN TRY
	BEGIN TRAN
		DELETE FROM �������� WHERE ������� = '�'
		SET @point = 'p1'; SAVE TRAN @point
		INSERT INTO �������� VALUES('����', '����', 40)
		SET @point = 'p2'; SAVE TRAN @point
		INSERT INTO �������� VALUES('�����', '��', 50)
		SET @point = 'p3'; SAVE TRAN @point
	COMMIT TRAN
END TRY
BEGIN CATCH
	print '������: ' + error_message()
	IF @@TRANCOUNT > 0
	BEGIN
		print '����������� �����: ' + cast(@point as varchar)
		ROLLBACK TRAN @point
		COMMIT TRAN
	END
END CATCH

-----------------------4-----------------------
set transaction isolation level READ UNCOMMITTED
begin transaction
-----t1---------
select @@SPID, 'insert �����' '���������', *
from ����� WHERE �����_����� = '2';
select @@SPID, 'update ������' '���������', *
from ������ WHERE �����_����� = '2';
commit;
-----B�-------
--����� ���������� � ������� ��������������� READ COMMITED (�� �����) 
-----t2---------
begin transaction
select @@SPID
insert ����� values(7,3, '���',4000);
update ������ set �����_����� = '2' WHERE ������������� = '����'
-----t1----------
-----t2----------
ROLLBACK;

-----------------------5-----------------------
-----A--------
set transaction isolation level READ COMMITTED
begin transaction
select count(*) from ������ where �����_����� = '2';
-----t1-------
-----t2-------
select 'update PULPIT' '���������', count(*) 
from ������ where �����_����� = '2'; --�������� ��������������� ������
commit;
-----B----
begin transaction
------t1-----
update ������ set �����_����� = '2' where ������������� = '����';
commit;
------t2------

-----------------------6-----------------------
set transaction isolation level REPEATABLE READ
begin transaction
select �����_������ FROM ������ WHERE �����_����� = '3';
--------t1---------
--------t2---------
select case
when �����_������ = '3' then 'insert'  
else ' ' 
end,
�����_������ from ������ where �����_����� = '3'
commit
--- B ---	
begin transaction 	  
--------t1---------
insert ������ values (44, '����','�',32,1);
commit

-----------------------7-----------------------
set transaction isolation level SERIALIZABLE 
begin transaction 
delete �������� where ����������_����� = 15
insert �������� values ('���', '����', 15)
update �������� set ���_������� = '������' where ����������_����� = 15
select ������� from �������� where ����������_����� = 15
--------t1---------
select ������� from �������� where ����������_����� = 15
--------t2---------
commit 	
--- B ---	
begin transaction 	  
delete �������� where ����������_����� = 15 
insert �������� values ('���', '����', 15)
update �������� set ���_������� = '������' where ����������_����� = 15
select ������� from ��������  where ����������_����� = 15
--------t1---------
commit
select ������� from ��������  where ����������_����� = 15
--------t2---------
select * from ��������

-----------------------8-----------------------
begin tran --������� ���������� 
insert ��������  values ('���', '����',32)
begin tran --���������� ���������� 
update ����� set ������ = 444 where ������� = '���'
commit --��������� ���������� 
if @@TRANCOUNT > 0 --������� ���������� 
rollback

select (select count(*) from ����� where ������� = '���') �����,
(select count(*) from �������� where ������� = '���') �������

select * from �����
select * from ��������
delete  �������� where  ������� = '���'; 
