--task 1
--���������� ��� �������, ������� ������� � ��. 
exec sp_helpindex'������'
exec sp_helpindex'�����'
exec sp_helpindex'��������'
exec sp_helpindex'�������������'

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