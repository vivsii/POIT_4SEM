use UNIVER
go
--1. 
CREATE procedure PSUBJECT
as begin
	DECLARE @n int = (SELECT count(*) from ПРЕДМЕТЫ);
	SELECT Предмет [предмет], Тип_занятий [тип], Количество_часов [часы] from ПРЕДМЕТЫ;
	return @n;
end;

DECLARE @k int;
EXEC @k = PSUBJECT; -- вызов процедуры 
print 'Количество предметов: ' + cast(@k as varchar(3));

DROP procedure PSUBJECT;

--2. 
ALTER procedure PSUBJECT @p varchar(20), @c nvarchar(2) output
as begin
	SELECT * from ПРЕДМЕТЫ where Предмет = @p;
	set @c = cast(@@rowcount as nvarchar(2));
end;

DECLARE @k1 int, @k2 nvarchar(2);
EXEC @k1 = PSUBJECT @p = 'БД', @c = @k2 output;
print 'Количество предметов: ' + @k2;
go

--3. 
ALTER procedure PSUBJECT @p varchar(20)
as begin
	SELECT * from ПРЕДМЕТЫ where Предмет = @p;
end;


CREATE table #SUBJECTs
(
	название varchar(20),
	тип varchar(100),
	часы varchar(20)
);
INSERT #SUBJECTs EXEC PSUBJECT @p = 'БД';
INSERT #SUBJECTs EXEC PSUBJECT @p = 'ТРПИ';
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
	INSERT into ПРЕДМЕТЫ(Предмет, Тип_занятий, Количество_часов)
		--values(@a, @n, @c),
		values('Матпрога', 'лаба', 100);
	return 1;
end try
begin catch
	print 'Номер ошибки: ' + cast(error_number() as varchar(6));
	print 'Сообщение: ' + error_message();
	print 'Уровень: ' + cast(error_severity() as varchar(6));
	print 'Метка: ' + cast(error_state() as varchar(8));
	print 'Номер строки: ' + cast(error_line() as varchar(8));
	if error_procedure() is not null   
	print 'Имя процедуры: ' + error_procedure();
	return -1;
end catch;
end;


DECLARE @rc int;  
EXEC @rc = PSUBJECT_INSERT @a = 'ОТПиСП', @n = 'Лекция', @c = 100; 
print 'Код ошибки: ' + cast(@rc as varchar(3));
go

delete ПРЕДМЕТЫ where Предмет ='Матпрога';
DROP procedure PSUBJECT_INSERT;

--5. 
CREATE PROCEDURE COURSE_REPORT @p char(10) AS
DECLARE @rc1 int = 0;
BEGIN TRY   
      DECLARE @tv char(20), @t char(300) = ' ';  
      DECLARE Spisok CURSOR for 
		 SELECT s.Специальность FROM ГРУППЫ s WHERE s.Номер_курса = @p;
			if not exists (SELECT s.Специальность FROM ГРУППЫ s WHERE s.Номер_курса = @p)
          raiserror('ошибка', 11, 1);
      else 
      OPEN Spisok;	  
		FETCH Spisok INTO @tv;   
		print 'Список дисциплин на кафедре: ';   
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
	print 'ошибка в параметрах' 
    if error_procedure() is not null   
    print 'имя процедуры : ' + error_procedure();
    return @rc1;
END CATCH; 

DECLARE @rc2 int;
exec @rc2 = COURSE_REPORT @p = '2';
print 'Количество дисциплин на кафедре = ' + convert(varchar(3), @rc2);

DROP procedure SUBJECT_REPORT;

--6.
CREATE procedure PSUBJECT_INSERTX
		@a char(20),
		@n varchar(50),
		@c int = 0,
		@t char(10),
		@tn varchar(50)	--доп., для ввода 
as begin
DECLARE @rc int = 1;
begin try
	set transaction isolation level serializable;          
	begin tran
	INSERT into ПРЕДМЕТ(Предмет, Тип_занятий,Количество_часов)
				values(@n, @tn);
	EXEC @rc = PSUBJECT_INSERT @a, @n, @c;
	commit tran;
	return @rc;
end try
begin catch
	print 'Номер ошибки: ' + cast(error_number() as varchar(6));
	print 'Сообщение: ' + error_message();
	print 'Уровень: ' + cast(error_severity() as varchar(6));
	print 'Метка: ' + cast(error_state() as varchar(8));
	print 'Номер строки: ' + cast(error_line() as varchar(8));
	if error_procedure() is not  null   
	print 'Имя процедуры: ' + error_procedure(); 
	if @@trancount > 0 rollback tran ; 
	return -1;
end catch;
end;


DECLARE @k3 int;  
EXEC @k3 = PSUBJECT_INSERTX 'философия', @n = 'Лк', @c = 85, @t = 'фил', @tn = 'мяу'; 
print 'Код ошибки: ' + cast(@k3 as varchar(3));

delete ПРЕДМЕТ where Предмет='философия';  
delete ПРЕДМЕТ where Предмет='Лк';
go

drop procedure PSUBJECT_INSERTX;