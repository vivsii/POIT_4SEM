use UNIVER

--task 1
--���������� ��� �������, ������� ������� � �� UNIVER.  
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'SUBJECT'	
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'TEACHER'
exec sp_helpindex 'AUDITORIUM'
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PROGRESS'
exec sp_helpindex 'STUDENT'

--������� ��������� ��������� �������. ��������� �� ������� (�� ����� 1000 �����).  
create table #temp_table(	
some_ind int, 
some_field varchar(20))
set nocount on
DECLARE @i int = 0
while @i < 1000
begin
insert #temp_table(some_ind, some_field)
values(FLOOR(RAND()*10000), REPLICATE('����',3))
SET @i = @i + 1; 
end

SELECT count(*)[���������� �����] from #temp_table
SELECT * from #temp_table

--����������� SELECT-������. ��-������ ���� ������� � ���������� ��� ���������. 
select * from #temp_table where some_ind between 1500 and 5000 
checkpoint			--�������� ��
DBCC DROPCLEANBUFFERS	--�������� �������� ���

--������� ���������������� ��-����, ����������� ��������� SE-LECT-�������.
CREATE clustered index #temp_table_cl on #temp_table(some_ind asc)
drop table #temp_table

--task 2
--������� ��������� ��������� ���-����. ��������� �� ������� (10000 ����� ��� ������).  
create table #temp_table_1(
some_ind int, 
some_field varchar(20),
cc int identity(1,1))
SET nocount on
DECLARE @j int = 0
while @j < 10000
begin
insert #temp_table_1(some_ind, some_field)
values(FLOOR(RAND()*10000), REPLICATE('������',3))
SET @j = @j + 1
end

SELECT count(*)[���������� �����] from #temp_table_1
SELECT * from #temp_table_1

--����������� SELECT-������. ��-������ ���� ������� � ���������� ��� ���������. 
select * from #temp_table_1 where cc >500 and some_ind between 1500 and 5000 

--������� ������������������ ��-���������� ��������� ������.  
CREATE index #temp_table_1_nonclu on #temp_table_1(some_ind, CC)
select CC from #temp_table_1 where some_ind > 500 and CC <1000
select CC from #temp_table_1 order by some_ind, CC
select CC from #temp_table_1 where some_ind =500 and CC > 3

--drop table #temp_table_1

--task 3
--������� ��������� ��������� ���-����. ��������� �� ������� (�� ��-��� 10000 �����).  
create table #temp_table_2(
some_ind int, 
some_field varchar(20),
cc int identity(1,1))
SET nocount on
DECLARE @k int = 0
while @k < 10000
begin
insert #temp_table_2(some_ind, some_field)
values(FLOOR(RAND()*30000), REPLICATE('Fadva',3) );
SET @k = @k + 1; 
end

--����������� SELECT-������. ��-������ ���� ������� � ���������� ��� ���������.  
select * from #temp_table_2 where cc >500 and some_ind between 1500 and 5000 

--������� ������������������ ��-���� ��������, ����������� ���-������ SELECT-�������.  
CREATE index #temp_table_2_nonclu_2 on #temp_table_2(some_ind) INCLUDE(cc)
select CC from #temp_table_2 where some_ind > 500

drop table #temp_table_2

--task 4
--������� � ��������� ��������� ��-������� �������. 
--����������� SELECT-������, ��-������ ���� ������� � ���������� ��� ���������.  
--������� ������������������ ����������� ������, ��������-��� ��������� SELECT-�������.

SELECT some_ind from  #temp_table_2 where some_ind between 5000 and 19999; 
SELECT some_ind from  #temp_table_2 where some_ind>15000 and  some_ind < 20000  
SELECT some_ind from  #temp_table_2 where some_ind=17000

 CREATE  index #temp_table_WHERE on #temp_table_2(some_ind) 
 where (some_ind>15000 and  some_ind  < 20000)
--drop index #temp_table_WHERE on #temp_table_2

-- task 5
--��������� ��������� ��������� �������. 
use tempdb
CREATE index #temp_table_2_ind  on #temp_table_2(some_ind)

INSERT top(10000) #temp_table_2(some_ind, some_field) 
select some_ind, some_field from #temp_table_2

--������� ������������������ ��-����. ������� ������� ���������-��� �������. 
SELECT	name [������], avg_fragmentation_in_percent [������������(%)] 
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
OBJECT_ID(N'#temp_table_2'), NULL, NULL, NULL) ss
JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
where name is not null
INSERT top(10000) #temp_table_2(some_ind, some_field) select some_ind, some_field from #temp_table_2;

--��������� ��������� ��������-����� �������, ������� ������� ������������. 
--��������� ��������� ���������-�� ������� � ������� ������� ����-�������� �������.

ALTER index #temp_table_2_ind on #temp_table_2 reorganize
ALTER index #temp_table_2_ind  on #temp_table_2 rebuild with (online = off)
--drop index #temp_table_2_ind on #temp_table_2

--task 6
--���������� ������, ������������-��� ���������� ��������� FILL-FACTOR ��� �������� ����������-��������� �������.
CREATE index #temp_table_2_ind1  on #temp_table_2(some_ind)with (fillfactor = 90)

INSERT top(50)percent into #temp_table_2(some_ind, some_field)
select some_ind, some_field  from #temp_table_2

SELECT	name [������], avg_fragmentation_in_percent [������������(%)],fragment_count,avg_fragment_size_in_pages 
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
OBJECT_ID(N'#temp_table_2'), NULL, NULL, NULL) ss
JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
where name is not null
drop index #temp_table_2_ind2 on #temp_table_2