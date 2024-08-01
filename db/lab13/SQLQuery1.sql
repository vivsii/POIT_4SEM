use UNIVER
go

--1. Разработать хранимую процедуру без параметров с именем PSUBJECT. Процедура формирует результи-рующий набор на основе таблицы SUBJECT,
--анало-гичный набору, представленному на рисунке
--Процедура должна возвращать количество строк, выведенных в результирующий набор.

CREATE procedure PSUBJECT
as begin
	DECLARE @n int = (SELECT count(*) from SUBJECT);
	SELECT SUBJECT [КОД], SUBJECT_NAME [ДИСЦИПЛИНА], PULPIT [КАФЕДРА] from SUBJECT;
	return @n;
end;

DECLARE @k int;
EXEC @k = PSUBJECT; -- вызов процедуры 
print 'Количество предметов: ' + cast(@k as varchar(3));

DROP procedure PSUBJECT;

--2. Изм., чтобы принимала параметры @p (вх. - код кафедры), @c (вых. - кол-во)
--Найти процедуру PSUBJECT с помощью обозревате-ля объектов (Object Explorer) 
--и через контекстное ме-ню создать сценарий на изменение процедуры опера-тором ALTER.
--Изменить процедуру PSUBJECT, созданную в за-дании 1, таким образом, чтобы она принимала два па-раметра с именами @p и @c. 
--Параметр @p является входным, имеет тип varchar(20) и значение по умол-чанию NULL. Параметр @с является выходным, имеет тип INT.
--Процедура PSUBJECT должна формировать ре-зультирующий набор, аналогичный набору, представ-ленному на рисунке выше, 
--но при этом содержать строки, соответствующие коду кафедры, заданному параметром @p. 
--Кроме того, процедура должна фор-мировать значение выходного параметра @с, равное количеству строк в результирующем наборе,
--а также возвращать значение к точке вызова, равное общему количеству дисциплин (количеству строк в таблице SUBJECT). 


ALTER procedure PSUBJECT @p varchar(20), @c nvarchar(2) output
as begin
	SELECT * from SUBJECT where SUBJECT = @p;
	set @c = cast(@@rowcount as nvarchar(2));
end;

DECLARE @k1 int, @k2 nvarchar(2);
EXEC @k1 = PSUBJECT @p = 'СУБД', @c = @k2 output;
print 'Количество предметов: ' + @k2;
go

--3. . Создать временную локальную таблицу с именем #SUBJECT. Наименование и тип столбцов таблицы 
--должны соответствовать столбцам результирующего набора процедуры PSUBJECT, разработанной в зада-нии 2. 
--Изменить процедуру PSUBJECT таким образом, чтобы она не содержала выходного параметра.
--Применив конструкцию INSERT… EXECUTE с мо-дифицированной процедурой PSUBJECT, добавить строки в таблицу #SUBJECT. 


ALTER procedure PSUBJECT @p varchar(20)
as begin
	SELECT * from SUBJECT where SUBJECT = @p;
end;


CREATE table #SUBJECTs
(
	Код_предмета varchar(20),
	Название_предмета varchar(100),
	Кафедра varchar(20)
);
INSERT #SUBJECTs EXEC PSUBJECT @p = 'ПСП';
INSERT #SUBJECTs EXEC PSUBJECT @p = 'СУБД';
SELECT * from #SUBJECTs;
go

drop table #SUBJECTs

--4. Разработать процедуру с именем PAUDITORI-UM_INSERT. Процедура принимает четыре входных параметра: @a, @n, @c и @t. 
--Параметр @a имеет тип CHAR(20), параметр @n имеет тип VARCHAR(50), параметр @c имеет тип INT и значение по умолчанию 0, параметр @t имеет тип CHAR(10).
--Процедура добавляет строку в таблицу AUDITO-RIUM. Значения столбцов AUDITORIUM, AUDI-TORIUM_NAME, 
--AUDITORIUM_CAPACITY и AUDITORIUM_TYPE добавляемой строки задаются соответственно параметрами @a, @n, @c и @t.
--Процедура PAUDITORIUM_INSERT должна при-менять механизм TRY/CATCH для обработки ошибок. В случае возникновения ошибки, 
--процедура должна формировать сообщение, содержащее код ошибки, уровень серьезности и текст сообщения в стандартный выходной поток. 
--Процедура должна возвращать к точке вызова зна-чение -1 в том случае, если произошла ошибка и 1, ес-ли выполнение успешно. 
--Опробовать работу процедуры с различными значе-ниями исходных данных.

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
		values(433-1, 'ЛК', 433-1, 100);
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
EXEC @rc = PAUDITORIUM_INSERT @a = '420-3', @n = 'ЛК', @c = 100, @t = '420-3'; 
print 'Код ошибки: ' + cast(@rc as varchar(3));
go

delete AUDITORIUM where AUDITORIUM='420-3';
DROP procedure PAUDITORIUM_INSERT;

--5. Разработать процедуру с именем SUBJECT_REPORT, формирующую в стандартный выходной поток отчет со 
--списком дисциплин на кон-кретной кафедре. В отчет должны быть выведены краткие названия (поле SUBJECT) 
--из таблицы SUBJECT в одну строку через запятую (использовать встроенную функцию RTRIM). 
--Процедура имеет входной параметр с именем @p типа CHAR(10), кото-рый предназначен для указания кода кафедры.
--В том случае, если по заданному значению @p не-возможно определить код кафедры, процедура должна генерировать ошибку с сообщением ошибка в пара-метрах. 
--Процедура SUBJECT_REPORT должна возвра-щать к точке вызова количество дисциплин, отобра-женных в отчете. 

CREATE PROCEDURE SUBJECT_REPORT  @p char(10) AS
DECLARE @rc1 int = 0;
BEGIN TRY   
      DECLARE @tv char(20), @t char(300) = ' ';  
      DECLARE Spisok CURSOR for 
		 SELECT s.SUBJECT FROM SUBJECT s WHERE s.PULPIT = @p;
			if not exists (SELECT s.SUBJECT FROM SUBJECT s WHERE s.PULPIT = @p)
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
exec @rc2 = SUBJECT_REPORT @p = 'ИСиТ';
print 'Количество дисциплин на кафедре = ' + convert(varchar(3), @rc2);

DROP procedure SUBJECT_REPORT;

--6.Разработать процедуру с именем PAUDITORI-UM_INSERTX. Процедура принимает пять входных параметров: @a, @n, @c, @t и @tn. 
--Параметры @a, @n, @c, @t аналогичны парамет-рам процедуры PAUDITORIUM_INSERT. Параметр @tn является входным, имеет тип VARCHAR(50), 
--предназначен для ввода значения в столбец AUDITO-RIUM_TYPE.AUDITORIUM_TYPENAME.
--Процедура добавляет две строки. Первая строка до-бавляется в таблицу AUDITORIUM_TYPE. 
--Значения столбцов AUDITORIUM_TYPE и AUDITORIUM_ TYPENAME задаются соответственно параметрами @t и @tn. Вторая строка добавляется путем вызова процедуры PAUDITORIUM_INSERT.
--Добавление строки в таблицу AUDITORIUM_ TYPE и вызов процедуры PAUDITORIUM_INSERT должны выполняться в рамках одной транзакции с уровнем изолированности SERIALIZABLE. 
--В процедуре должна быть предусмотрена обработка ошибок с помощью механизма TRY/CATCH. Все ошибки должны быть обработаны с выдачей соответ-ствующего сообщения в стандартный выходной по-ток. 
--Процедура PAUDITORIUM_INSERTX должна возвращать к точке вызова значение -1 в том случае, если произошла ошибка и 1, если выполнения проце-дуры завершилось успешно. 

 
CREATE procedure PAUDITORIUM_INSERTX
		@a char(20),
		@n varchar(50),
		@c int = 0,
		@t char(10),
		@tn varchar(50)	--доп., для ввода в AUD_TYPEAUD_TYPENAME
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
EXEC @k3 = PAUDITORIUM_INSERTX '622-3', @n = 'КГ', @c = 85, @t = '622-3', @tn = 'Комп. гласс'; 
print 'Код ошибки: ' + cast(@k3 as varchar(3));

delete AUDITORIUM where AUDITORIUM='622-3';  
delete AUDITORIUM_TYPE where AUDITORIUM_TYPE='КГ';
go

drop procedure PAUDITORIUM_INSERTX;