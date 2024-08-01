	use UNIVER
--task 1
--����������� ������, � �������: 
--�������� ���������� ���� char, varchar, datetime, time, int, smallint, tinint, numeric(12, 5); 
--������ ��� ���������� ���������-���������� � ��������� ����������;
--��������� ������������ �������� ���������� � ������� ���������� SET � SELECT; 
--�������� ����� ���������� ����-��� � ������� ��������� SELECT, ���-����� ������ ���������� ����������� � ������� ��������� PRINT. 
--���������������� ����������.
DECLARE @c char ='a', 
		@v varchar(4)='VADIM', 
		@d datetime,
		@t time,
		@i int = 4,		
		@s smallint = 1,
		@ti tinyint = 1,
		@n numeric(12,5) = 18.1;
SET @d=GETDATE();
print 's= ' + cast(@s as varchar(10));
print 'ti= ' + cast(@ti as varchar(10));
print 'n= ' + cast(@n as varchar(10));
SELECT @t='12:59:34.21';
SELECT @c c, @v v, @d d, @t t, @i i;
SELECT @s=345, @ti=1, @n=1234567.12345;
--task 2
--����������� ������, � ������� ������-������ ����� ����������� ���������.
--���� ����� ����������� ��������� 200, �� ������� ���������� ���������, 
--������� ����������� ���������, ����-������ ���������, ����������� ������� ������ �������, � ������� ����� ����-�����. 
--���� ����� ����������� ��������� ������ 200, �� ������� ��������� � ������� ����� �����������.

DECLARE @v1 int, @v2 int, @v3 int, @v4 int 
SELECT @v1 = SUM(AUDITORIUM_CAPACITY) FROM AUDITORIUM 
if @v1 > 200 
begin 
select	@v2 = (select COUNT(*) as [����������_���������] from AUDITORIUM), 
		@v3 = (select AVG(AUDITORIUM_CAPACITY) as [�����������_���������] from AUDITORIUM) 
set	@v4 = (select COUNT(*) as [����-������_���������] from AUDITORIUM where AUDITORIUM_CAPACITY < @v3) 
select @v2 '��������� ���������', @v3 '���� ����������� � ���������', @v4 '����������� ������� ������ �������',	
       100*(cast(@v4 as float)/cast(@v2 as float)) '% ������� ����� ���������'			
end 
else print 's'+cast(@v1 as varchar(10))

--task 3 
--����������� T-SQL-������, ��-����� ������� �� ������ ���������� ����������: 
--@@ROWCOUNT (����� ������-������ �����); 
--@@VERSION (������ SQL Server);
--@@SPID (���������� ��������� ������������� ��������, ��������-��� �������� �������� ��������-���); 
--@@ERROR (��� ��������� ������); 
--@@SERVERNAME (��� �������); 
--@@TRANCOUNT (���������� ������� ����������� ����������); 
--@@FETCH_STATUS (�������� ��-�������� ���������� ����� ��������-������� ������); 
--@@NESTLEVEL (������� ������-����� ������� ���������).
--���������������� ���������.

select	@@ROWCOUNT '����� ������������ �����',
		@@VERSION '������ SQL Server',
		@@SPID '���������� ��������� ������������� ��������, ��������-��� �������� �������� ��������-���',
		@@ERROR '��� ��������� ������',
		@@SERVERNAME '��� �������',
		@@TRANCOUNT '���������� ������� ����������� ����������',
		@@FETCH_STATUS '�������� ���������� ���������� ����� ��������-������� ������',
		@@NESTLEVEL '������� ����������� ������� ���������'
--task 4 

declare @tt int=3, @x float=4, @z float;
if (@tt>@x) set @z=power(SIN(@tt),2);
if (@tt<@x) set @z=4*(@tt+@x);
if (@tt=@x) set @z=1-exp(@x-2);
print 'z='+cast(@z as varchar(10));

--�������������� ������� ��� �������� � ����������� (��������, �������� ��-����� ���������� � �������� �. �.);

declare @fio varchar(100)=(select top 1 NAME from STUDENT)
select substring(@fio, 1, charindex(' ', @fio))
		+substring(@fio, charindex(' ', @fio)+1,1)+'.'
		+substring(@fio, charindex(' ', @fio, charindex(' ', @fio)+1)+1,1)+'.'

--����� ���������, � ������� ���� ���-����� � ��������� ������, � ��������-��� �� ��������;

select NAME,BDAY, 2024-YEAR(BDAY) [k]	
from STUDENT 
where MONTH(BDAY)=MONTH(getdate())+1

--����� ��� ������, � ������� �������� ��������� ������ ������� ������� �� ��.

declare @gr integer = 6, @wd date
set @wd = (select top(1) PROGRESS.PDATE from PROGRESS 
join STUDENT on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where STUDENT.IDGROUP = @gr and PROGRESS.SUBJECT = '����')
print @wd

--task 5
--������������������ ����������� IF� ELSE �� ������� ������� ������ ���-��� ���� ������ �_UNIVER.

declare @idgr integer = 4, @avg numeric(5,2)
declare @count integer = (select count(*) from STUDENT where IDGROUP = @idgr)
if (@count > 5)
begin
set @avg = (select avg (cast (PROGRESS.NOTE as real))
from STUDENT join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT)
print '������ 5: '+cast(@avg as varchar)
end
else print '������ 5: '+cast(@count as varchar)

--task 6
--����������� ��������, � ������� � ��-����� CASE ������������� ������,
--���������� ���������� ���������� ��-�������� ��� ����� ���������.

select student.NAME [�������], student.IDGROUP [IDGROUP],
case when progress.NOTE between 0 and 3 then '�����'
when progress.NOTE between 4 and 6 then '������'
when progress.NOTE between 7 and 8 then '�������'
else 'no'
end �������, COUNT(*)[����������]
from student, PROGRESS where student.IDGROUP=6
group by student.NAME, student.IDGROUP,
case when progress.NOTE between 0 and 3 then '�����'
when progress.NOTE between 4 and 6 then '������'
when progress.NOTE between 7 and 8 then '�������'
else 'no'
end

--task 7
--������� ��������� ��������� ������� �� ���� �������� � 10 �����, 
--��������� �� � ������� ����������. ������������ �������� WHILE.

CREATE table #PET(
age int,
name varchar(50),
relatives int)
declare @ii int=0;
while @ii<10
begin
insert into #PET(age, name, relatives) 
values (floor(24*RAND()), replicate('���-��',2), floor(26*RAND()));
set @ii=@ii+1;
end
select * from #PET
--drop table #PET

--task 8
--����������� ������, ��������������� ������������� ��������� RETURN.
declare @xx int = 1
while @xx < 10
begin
print @xx
set @xx=@xx+1
if (@xx > 5) return
end

--task 9
--����������� �������� � ��������, � ��-����� ������������ ��� ��������� ������ ����� TRY � CATCH. 
--��������� ������� ER-ROR_NUMBER (��� ��������� ����-��), ERROR_MESSAGE (��������� �� ������),
--ERROR_LINE (����� ������ � �������), ERROR_PROCEDURE (��� ��������� ��� NULL), ER-ROR_SEVERITY (������� ����������� ������),
--ERROR_STATE (����� ����-��). ���������������� ���������.

begin try
  declare @Err int;
  select @Err = 1 / 0;
end try
begin catch
  print ERROR_NUMBER()
  print ERROR_MESSAGE()
  print ERROR_LINE()
  print ERROR_PROCEDURE()
  print ERROR_SEVERITY()
  print ERROR_STATE()
end catch