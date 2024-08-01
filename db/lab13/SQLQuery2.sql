use UNIVER
go
--1. 
CREATE procedure PSUBJECT
as begin
	DECLARE @n int = (SELECT count(*) from ��������);
	SELECT ������� [�������], ���_������� [���], ����������_����� [����] from ��������;
	return @n;
end;

DECLARE @k int;
EXEC @k = PSUBJECT; -- ����� ��������� 
print '���������� ���������: ' + cast(@k as varchar(3));

DROP procedure PSUBJECT;

--2. 
ALTER procedure PSUBJECT @p varchar(20), @c nvarchar(2) output
as begin
	SELECT * from �������� where ������� = @p;
	set @c = cast(@@rowcount as nvarchar(2));
end;

DECLARE @k1 int, @k2 nvarchar(2);
EXEC @k1 = PSUBJECT @p = '��', @c = @k2 output;
print '���������� ���������: ' + @k2;
go

--3. 
ALTER procedure PSUBJECT @p varchar(20)
as begin
	SELECT * from �������� where ������� = @p;
end;


CREATE table #SUBJECTs
(
	�������� varchar(20),
	��� varchar(100),
	���� varchar(20)
);
INSERT #SUBJECTs EXEC PSUBJECT @p = '��';
INSERT #SUBJECTs EXEC PSUBJECT @p = '����';
SELECT * from #SUBJECTs;
go

drop table #SUBJECTs

--4.
go
CREATE procedure PSUBJECT_INSERT
		@a char(20),
		@n varchar(50),
		@c int = 0
as begin 
begin try
	INSERT into ��������(�������, ���_�������, ����������_�����)
		--values(@a, @n, @c),
		values('��������', '����', 100);
	return 1;
end try
begin catch
	print '����� ������: ' + cast(error_number() as varchar(6));
	print '���������: ' + error_message();
	print '�������: ' + cast(error_severity() as varchar(6));
	print '�����: ' + cast(error_state() as varchar(8));
	print '����� ������: ' + cast(error_line() as varchar(8));
	if error_procedure() is not null   
	print '��� ���������: ' + error_procedure();
	return -1;
end catch;
end;


DECLARE @rc int;  
EXEC @rc = PSUBJECT_INSERT @a = '������', @n = '������', @c = 100; 
print '��� ������: ' + cast(@rc as varchar(3));
go

delete �������� where ������� ='��������';
DROP procedure PSUBJECT_INSERT;

--5. 
CREATE PROCEDURE COURSE_REPORT @p char(10) AS
DECLARE @rc1 int = 0;
BEGIN TRY   
      DECLARE @tv char(20), @t char(300) = ' ';  
      DECLARE Spisok CURSOR for 
		 SELECT s.������������� FROM ������ s WHERE s.�����_����� = @p;
			if not exists (SELECT s.������������� FROM ������ s WHERE s.�����_����� = @p)
          raiserror('������', 11, 1);
      else 
      OPEN Spisok;	  
		FETCH Spisok INTO @tv;   
		print '������ ��������� �� �������: ';   
		while @@fetch_status = 0                                     
		BEGIN 
			SET @t = rtrim(@tv) + ', ' + @t;  
			SET @rc1 = @rc1 + 1;       
			FETCH Spisok INTO @tv; 
		END;   
		print @t;        
	  close Spisok;
    return @rc1;
END TRY  
BEGIN CATCH              
	print '������ � ����������' 
    if error_procedure() is not null   
    print '��� ��������� : ' + error_procedure();
    return @rc1;
END CATCH; 

DECLARE @rc2 int;
exec @rc2 = COURSE_REPORT @p = '2';
print '���������� ��������� �� ������� = ' + convert(varchar(3), @rc2);

DROP procedure SUBJECT_REPORT;

--6.
CREATE procedure PSUBJECT_INSERTX
		@a char(20),
		@n varchar(50),
		@c int = 0,
		@t char(10),
		@tn varchar(50)	--���., ��� ����� 
as begin
DECLARE @rc int = 1;
begin try
	set transaction isolation level serializable;          
	begin tran
	INSERT into �������(�������, ���_�������,����������_�����)
				values(@n, @tn);
	EXEC @rc = PSUBJECT_INSERT @a, @n, @c;
	commit tran;
	return @rc;
end try
begin catch
	print '����� ������: ' + cast(error_number() as varchar(6));
	print '���������: ' + error_message();
	print '�������: ' + cast(error_severity() as varchar(6));
	print '�����: ' + cast(error_state() as varchar(8));
	print '����� ������: ' + cast(error_line() as varchar(8));
	if error_procedure() is not  null   
	print '��� ���������: ' + error_procedure(); 
	if @@trancount > 0 rollback tran ; 
	return -1;
end catch;
end;


DECLARE @k3 int;  
EXEC @k3 = PSUBJECT_INSERTX '���������', @n = '��', @c = 85, @t = '���', @tn = '���'; 
print '��� ������: ' + cast(@k3 as varchar(3));

delete ������� where �������='���������';  
delete ������� where �������='��';
go

drop procedure PSUBJECT_INSERTX;