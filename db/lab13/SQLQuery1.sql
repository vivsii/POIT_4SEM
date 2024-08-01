use UNIVER
go

--1. ����������� �������� ��������� ��� ���������� � ������ PSUBJECT. ��������� ��������� ��������-������ ����� �� ������ ������� SUBJECT,
--�����-������ ������, ��������������� �� �������
--��������� ������ ���������� ���������� �����, ���������� � �������������� �����.

CREATE procedure PSUBJECT
as begin
	DECLARE @n int = (SELECT count(*) from SUBJECT);
	SELECT SUBJECT [���], SUBJECT_NAME [����������], PULPIT [�������] from SUBJECT;
	return @n;
end;

DECLARE @k int;
EXEC @k = PSUBJECT; -- ����� ��������� 
print '���������� ���������: ' + cast(@k as varchar(3));

DROP procedure PSUBJECT;

--2. ���., ����� ��������� ��������� @p (��. - ��� �������), @c (���. - ���-��)
--����� ��������� PSUBJECT � ������� ����������-�� �������� (Object Explorer) 
--� ����� ����������� ��-�� ������� �������� �� ��������� ��������� �����-����� ALTER.
--�������� ��������� PSUBJECT, ��������� � ��-����� 1, ����� �������, ����� ��� ��������� ��� ��-������� � ������� @p � @c. 
--�������� @p �������� �������, ����� ��� varchar(20) � �������� �� ����-����� NULL. �������� @� �������� ��������, ����� ��� INT.
--��������� PSUBJECT ������ ����������� ��-������������ �����, ����������� ������, ��������-������� �� ������� ����, 
--�� ��� ���� ��������� ������, ��������������� ���� �������, ��������� ���������� @p. 
--����� ����, ��������� ������ ���-�������� �������� ��������� ��������� @�, ������ ���������� ����� � �������������� ������,
--� ����� ���������� �������� � ����� ������, ������ ������ ���������� ��������� (���������� ����� � ������� SUBJECT). 


ALTER procedure PSUBJECT @p varchar(20), @c nvarchar(2) output
as begin
	SELECT * from SUBJECT where SUBJECT = @p;
	set @c = cast(@@rowcount as nvarchar(2));
end;

DECLARE @k1 int, @k2 nvarchar(2);
EXEC @k1 = PSUBJECT @p = '����', @c = @k2 output;
print '���������� ���������: ' + @k2;
go

--3. . ������� ��������� ��������� ������� � ������ #SUBJECT. ������������ � ��� �������� ������� 
--������ ��������������� �������� ��������������� ������ ��������� PSUBJECT, ������������� � ����-��� 2. 
--�������� ��������� PSUBJECT ����� �������, ����� ��� �� ��������� ��������� ���������.
--�������� ����������� INSERT� EXECUTE � ��-�������������� ���������� PSUBJECT, �������� ������ � ������� #SUBJECT. 


ALTER procedure PSUBJECT @p varchar(20)
as begin
	SELECT * from SUBJECT where SUBJECT = @p;
end;


CREATE table #SUBJECTs
(
	���_�������� varchar(20),
	��������_�������� varchar(100),
	������� varchar(20)
);
INSERT #SUBJECTs EXEC PSUBJECT @p = '���';
INSERT #SUBJECTs EXEC PSUBJECT @p = '����';
SELECT * from #SUBJECTs;
go

drop table #SUBJECTs

--4. ����������� ��������� � ������ PAUDITORI-UM_INSERT. ��������� ��������� ������ ������� ���������: @a, @n, @c � @t. 
--�������� @a ����� ��� CHAR(20), �������� @n ����� ��� VARCHAR(50), �������� @c ����� ��� INT � �������� �� ��������� 0, �������� @t ����� ��� CHAR(10).
--��������� ��������� ������ � ������� AUDITO-RIUM. �������� �������� AUDITORIUM, AUDI-TORIUM_NAME, 
--AUDITORIUM_CAPACITY � AUDITORIUM_TYPE ����������� ������ �������� �������������� ����������� @a, @n, @c � @t.
--��������� PAUDITORIUM_INSERT ������ ���-������ �������� TRY/CATCH ��� ��������� ������. � ������ ������������� ������, 
--��������� ������ ����������� ���������, ���������� ��� ������, ������� ����������� � ����� ��������� � ����������� �������� �����. 
--��������� ������ ���������� � ����� ������ ���-����� -1 � ��� ������, ���� ��������� ������ � 1, ��-�� ���������� �������. 
--���������� ������ ��������� � ���������� �����-����� �������� ������.

go
CREATE procedure PAUDITORIUM_INSERT
		@a char(20),
		@n varchar(50),
		@c int = 0,
		@t char(10)
as begin 
begin try
	INSERT into AUDITORIUM(AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
		--values(@a, @n, @c, @t),
		values(433-1, '��', 433-1, 100);
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
EXEC @rc = PAUDITORIUM_INSERT @a = '420-3', @n = '��', @c = 100, @t = '420-3'; 
print '��� ������: ' + cast(@rc as varchar(3));
go

delete AUDITORIUM where AUDITORIUM='420-3';
DROP procedure PAUDITORIUM_INSERT;

--5. ����������� ��������� � ������ SUBJECT_REPORT, ����������� � ����������� �������� ����� ����� �� 
--������� ��������� �� ���-������� �������. � ����� ������ ���� �������� ������� �������� (���� SUBJECT) 
--�� ������� SUBJECT � ���� ������ ����� ������� (������������ ���������� ������� RTRIM). 
--��������� ����� ������� �������� � ������ @p ���� CHAR(10), ����-��� ������������ ��� �������� ���� �������.
--� ��� ������, ���� �� ��������� �������� @p ��-�������� ���������� ��� �������, ��������� ������ ������������ ������ � ���������� ������ � ����-������. 
--��������� SUBJECT_REPORT ������ ������-���� � ����� ������ ���������� ���������, ������-������ � ������. 

CREATE PROCEDURE SUBJECT_REPORT  @p char(10) AS
DECLARE @rc1 int = 0;
BEGIN TRY   
      DECLARE @tv char(20), @t char(300) = ' ';  
      DECLARE Spisok CURSOR for 
		 SELECT s.SUBJECT FROM SUBJECT s WHERE s.PULPIT = @p;
			if not exists (SELECT s.SUBJECT FROM SUBJECT s WHERE s.PULPIT = @p)
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
exec @rc2 = SUBJECT_REPORT @p = '����';
print '���������� ��������� �� ������� = ' + convert(varchar(3), @rc2);

DROP procedure SUBJECT_REPORT;

--6.����������� ��������� � ������ PAUDITORI-UM_INSERTX. ��������� ��������� ���� ������� ����������: @a, @n, @c, @t � @tn. 
--��������� @a, @n, @c, @t ���������� �������-��� ��������� PAUDITORIUM_INSERT. �������� @tn �������� �������, ����� ��� VARCHAR(50), 
--������������ ��� ����� �������� � ������� AUDITO-RIUM_TYPE.AUDITORIUM_TYPENAME.
--��������� ��������� ��� ������. ������ ������ ��-��������� � ������� AUDITORIUM_TYPE. 
--�������� �������� AUDITORIUM_TYPE � AUDITORIUM_ TYPENAME �������� �������������� ����������� @t � @tn. ������ ������ ����������� ����� ������ ��������� PAUDITORIUM_INSERT.
--���������� ������ � ������� AUDITORIUM_ TYPE � ����� ��������� PAUDITORIUM_INSERT ������ ����������� � ������ ����� ���������� � ������� ��������������� SERIALIZABLE. 
--� ��������� ������ ���� ������������� ��������� ������ � ������� ��������� TRY/CATCH. ��� ������ ������ ���� ���������� � ������� �������-��������� ��������� � ����������� �������� ��-���. 
--��������� PAUDITORIUM_INSERTX ������ ���������� � ����� ������ �������� -1 � ��� ������, ���� ��������� ������ � 1, ���� ���������� �����-���� ����������� �������. 

 
CREATE procedure PAUDITORIUM_INSERTX
		@a char(20),
		@n varchar(50),
		@c int = 0,
		@t char(10),
		@tn varchar(50)	--���., ��� ����� � AUD_TYPEAUD_TYPENAME
as begin
DECLARE @rc int = 1;
begin try
	set transaction isolation level serializable;          
	begin tran
	INSERT into AUDITORIUM_TYPE(AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
				values(@n, @tn);
	EXEC @rc = PAUDITORIUM_INSERT @a, @n, @c, @t;
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
EXEC @k3 = PAUDITORIUM_INSERTX '622-3', @n = '��', @c = 85, @t = '622-3', @tn = '����. �����'; 
print '��� ������: ' + cast(@k3 as varchar(3));

delete AUDITORIUM where AUDITORIUM='622-3';  
delete AUDITORIUM_TYPE where AUDITORIUM_TYPE='��';
go

drop procedure PAUDITORIUM_INSERTX;