-----------------------1-----------------------
SET NOCOUNT ON
	IF EXISTS (SELECT * FROM  SYS.OBJECTS        -- ТАБЛИЦА X ЕСТЬ?
	            WHERE OBJECT_ID= OBJECT_ID(N'DBO.M') )	    
	DROP TABLE M;
	DECLARE @C INT, @FLAG CHAR ='C' -- COMMIT ИЛИ ROLLBACK?
	SET IMPLICIT_TRANSACTIONS  ON   -- ВКЛЮЧ. РЕЖИМ НЕЯВНОЙ ТРАНЗАКЦИИ
	CREATE TABLE M(K INT );          
	-- НАЧАЛО ТРАНЗАКЦИИ 
		INSERT M VALUES (1),(2),(3);
		SET @C = (SELECT COUNT(*) FROM M);
		PRINT 'КОЛИЧЕСТВО СТРОК В ТАБЛИЦЕ M: ' + CAST( @C AS VARCHAR(2));
		IF @FLAG = 'C'  COMMIT;                   -- ЗАВЕРШЕНИЕ ТРАНЗАКЦИИ: ФИКСАЦИЯ 
	          ELSE   ROLLBACK;                                 -- ЗАВЕРШЕНИЕ ТРАНЗАКЦИИ: ОТКАТ  
      SET IMPLICIT_TRANSACTIONS  OFF   -- ВЫКЛЮЧ. РЕЖИМ НЕЯВНОЙ ТРАНЗАКЦИИ
	
	IF  EXISTS (SELECT * FROM  SYS.OBJECTS       -- ТАБЛИЦА X ЕСТЬ?
	            WHERE OBJECT_ID= OBJECT_ID(N'DBO.M') )
	PRINT 'ТАБЛИЦА M ЕСТЬ';  
      ELSE PRINT 'ТАБЛИЦЫ M НЕТ'
-----------------------2-----------------------
begin try
	begin tran
		delete ПРЕДМЕТЫ where ПРЕДМЕТЫ.Предмет = 'в';
		insert ПРЕДМЕТЫ(Предмет, Тип_занятий, Количество_часов) VALUES ('в', 'ЛБ-К', 15);
		insert ПРЕДМЕТЫ(Предмет, Тип_занятий, Количество_часов) VALUES ('КЯР', 'ЛБ-К', 15);
	commit tran;
end try
begin catch
		print 'ошибка' + case
		when error_number() = 2627 and patindex('%AUDITORIUM_PK%', error_message()) > 0
		then ' дублирование ключа'
		else ' неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0 
		rollback tran;
end catch

-----------------------3-----------------------
DECLARE @point varchar(3)
BEGIN TRY
	BEGIN TRAN
		DELETE FROM ПРЕДМЕТЫ WHERE Предмет = 'о'
		SET @point = 'p1'; SAVE TRAN @point
		INSERT INTO ПРЕДМЕТЫ VALUES('ксис', 'лаба', 40)
		SET @point = 'p2'; SAVE TRAN @point
		INSERT INTO ПРЕДМЕТЫ VALUES('матем', 'пз', 50)
		SET @point = 'p3'; SAVE TRAN @point
	COMMIT TRAN
END TRY
BEGIN CATCH
	print 'Ошибка: ' + error_message()
	IF @@TRANCOUNT > 0
	BEGIN
		print 'Контрольная точка: ' + cast(@point as varchar)
		ROLLBACK TRAN @point
		COMMIT TRAN
	END
END CATCH

-----------------------4-----------------------
set transaction isolation level READ UNCOMMITTED
begin transaction
-----t1---------
select @@SPID, 'insert КУРСЫ' 'результат', *
from КУРСЫ WHERE Номер_курса = '2';
select @@SPID, 'update ГРУППЫ' 'результат', *
from ГРУППЫ WHERE Номер_курса = '2';
commit;
-----B–-------
--явную транзакцию с уровнем изолированности READ COMMITED (по умолч) 
-----t2---------
begin transaction
select @@SPID
insert КУРСЫ values(7,3, 'ОКГ',4000);
update ГРУППЫ set Номер_курса = '2' WHERE Специальность = 'ИСиТ'
-----t1----------
-----t2----------
ROLLBACK;

-----------------------5-----------------------
-----A--------
set transaction isolation level READ COMMITTED
begin transaction
select count(*) from ГРУППЫ where Номер_курса = '2';
-----t1-------
-----t2-------
select 'update PULPIT' 'результат', count(*) 
from ГРУППЫ where Номер_курса = '2'; --работает неповторяющееся чтение
commit;
-----B----
begin transaction
------t1-----
update ГРУППЫ set Номер_курса = '2' where Специальность = 'ИСиТ';
commit;
------t2------

-----------------------6-----------------------
set transaction isolation level REPEATABLE READ
begin transaction
select Номер_группы FROM ГРУППЫ WHERE Номер_курса = '3';
--------t1---------
--------t2---------
select case
when Номер_группы = '3' then 'insert'  
else ' ' 
end,
Номер_группы from ГРУППЫ where Номер_курса = '3'
commit
--- B ---	
begin transaction 	  
--------t1---------
insert ГРУППЫ values (44, 'ПОИТ','А',32,1);
commit

-----------------------7-----------------------
set transaction isolation level SERIALIZABLE 
begin transaction 
delete ПРЕДМЕТЫ where Количество_часов = 15
insert ПРЕДМЕТЫ values ('выш', 'лабы', 15)
update ПРЕДМЕТЫ set Тип_занятий = 'Лекции' where Количество_часов = 15
select Предмет from ПРЕДМЕТЫ where Количество_часов = 15
--------t1---------
select Предмет from ПРЕДМЕТЫ where Количество_часов = 15
--------t2---------
commit 	
--- B ---	
begin transaction 	  
delete ПРЕДМЕТЫ where Количество_часов = 15 
insert ПРЕДМЕТЫ values ('выш', 'лабы', 15)
update ПРЕДМЕТЫ set Тип_занятий = 'Лекции' where Количество_часов = 15
select Предмет from ПРЕДМЕТЫ  where Количество_часов = 15
--------t1---------
commit
select Предмет from ПРЕДМЕТЫ  where Количество_часов = 15
--------t2---------
select * from ПРЕДМЕТЫ

-----------------------8-----------------------
begin tran --внешняя транзакция 
insert ПРЕДМЕТЫ  values ('ббб', 'лабы',32)
begin tran --внутренняя транзакция 
update КУРСЫ set Оплата = 444 where Предмет = 'ООП'
commit --внутрення транзакиця 
if @@TRANCOUNT > 0 --внешняя транзакция 
rollback

select (select count(*) from КУРСЫ where Предмет = 'ббб') курсы,
(select count(*) from ПРЕДМЕТЫ where Предмет = 'ббб') Предмет

select * from КУРСЫ
select * from ПРЕДМЕТЫ
delete  ПРЕДМЕТЫ where  Предмет = 'ббб'; 
