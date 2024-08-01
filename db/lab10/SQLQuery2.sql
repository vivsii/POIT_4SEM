--task 1
--Определить все индексы, которые имеются в БД. 
exec sp_helpindex'ГРУППЫ'
exec sp_helpindex'КУРСЫ'
exec sp_helpindex'ПРЕДМЕТЫ'
exec sp_helpindex'ПРЕПОДАВАТЕЛИ'

--Создать временную локальную таблицу. Заполнить ее данными (не менее 1000 строк).  
create table #temp_table(	
some_ind int, 
some_field varchar(20))
set nocount on
DECLARE @i int = 0
while @i < 1000
begin
insert #temp_table(some_ind, some_field)
values(FLOOR(RAND()*10000), REPLICATE('прив',3))
SET @i = @i + 1; 
end

SELECT count(*)[количество строк] from #temp_table
SELECT * from #temp_table

--Разработать SELECT-запрос. По-лучить план запроса и определить его стоимость. 
select * from #temp_table where some_ind between 1500 and 5000 
checkpoint			--фиксация БД
DBCC DROPCLEANBUFFERS	--очистить буферный кэш

--Создать кластеризованный ин-декс, уменьшающий стоимость SE-LECT-запроса.
CREATE clustered index #temp_table_cl on #temp_table(some_ind asc)
drop table #temp_table