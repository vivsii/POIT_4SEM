USE UNIVER;

--task1
--Разработать сценарий, формирующий список дисциплин на кафедре ИСиТ. 
--В отчет должны быть выведены краткие названия дисциплин из таблицы SUBJECT в одну строку через запя-тую. 
--Использовать встроенную функцию RTRIM.
DECLARE @ds char(20), @t char(300) = '';
DECLARE Disc CURSOR for SELECT SUBJECT FROM SUBJECT WHERE PULPIT = 'ИСиТ';
OPEN Disc;
FETCH Disc into @ds;
print 'Cписок дисциплин';
WHILE @@FETCH_STATUS = 0
	begin
	set @t = RTRIM(@ds) + ', ' + @t;
	FETCH Disc into @ds;
	end;
	print @t;
CLOSE Disc;
DEALLOCATE Disc;
--task2
--Разработать сценарий, демонстрирую-щий отличие глобального курсора от локального на примере базы данных UNIVER.
DECLARE StudentsL CURSOR LOCAL for SELECT NAME, IDGROUP from STUDENT;
DECLARE @name nvarchar(50), @group int;      
	OPEN StudentsL;	  
	fetch StudentsL into @name, @group; 	
      print '1. '+ @name + ', группа: ' + cast(@group as varchar(6));   
      go
DECLARE @name nvarchar(50), @group int;     	
	fetch StudentsL into @name, @group; 	
      print '2. '+ @name+ ', группа: '  + cast(@group as varchar(6));  
go 
------------------------------
DECLARE StudentsG CURSOR GLOBAL for SELECT NAME, IDGROUP from STUDENT;
DECLARE @name nvarchar(50), @group int;      
	OPEN StudentsG;	  
	fetch StudentsG into @name, @group; 	
      print '1. '+ @name + ', группа: ' + cast(@group as varchar(6));   
      go
 DECLARE @name nvarchar(50), @group int;     	
	fetch StudentsG into @name, @group; 	
      print '2. '+ @name + ', группа: '+ cast(@group as varchar(6));  
CLOSE StudentsG;
DEALLOCATE StudentsG;
--task3
--Разработать сценарий, демонстрирую-щий отличие статических курсоров от динамических на примере базы данных UNIVER.
DECLARE @tid char(10), @tnm char(40), @tgn char(1);  
DECLARE Prog CURSOR LOCAL STATIC                              
	 for SELECT SUBJECT, PDATE, NOTE 
	       FROM PROGRESS where SUBJECT = 'БД';				   
open Prog;
print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 
UPDATE PROGRESS set NOTE = 5 where IDSTUDENT = '1017';
DELETE PROGRESS where IDSTUDENT = '1079';
INSERT PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) 
                 values ('БД', 1079, '2013-01-10', 7); 
FETCH Prog into @tid, @tnm, @tgn;     
while @@fetch_status = 0                                    
     begin 
         print @tid + ' '+ @tnm + ' '+ @tgn;      
         fetch Prog into @tid, @tnm, @tgn; 
      end;          
CLOSE Prog;
------------------
DECLARE @tid1 char(10), @tnm1 char(40), @tgn1 char(1);  
DECLARE Prog1 CURSOR LOCAL DYNAMIC                             
	 for SELECT SUBJECT, PDATE, NOTE 
	       FROM PROGRESS where SUBJECT = 'БД';				   
open Prog1;
print   'Количество строк : ' + cast(@@CURSOR_ROWS as varchar(5)); 
UPDATE PROGRESS set NOTE = 5 where IDSTUDENT = '1017';
DELETE PROGRESS where IDSTUDENT = '1079';
INSERT PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) 
                 VALUES ('БД', 1079, '2013-01-10', 4); 
FETCH Prog1 into @tid1, @tnm1, @tgn1;     
while @@fetch_status = 0                                    
     begin 
         print @tid1 + ' '+ @tnm1 + ' '+ @tgn1;      
         fetch Prog1 into @tid1, @tnm1, @tgn1; 
      end;          
CLOSE Prog1;

--task4
--Разработать сценарий, демонстрирую-щий свойства навигации в результи-рующем наборе курсора с атрибутом SCROLL на примере базы данных UNIVER.
--Использовать все известные ключе-вые слова в операторе FETCH.

DECLARE  @tc int, @rn char(50);  
DECLARE Progr cursor local dynamic SCROLL                               
for SELECT row_number() over (order by SUBJECT) SName,
                           IDSTUDENT FROM PROGRESS
OPEN Progr;

FETCH FIRST from Progr into  @tc, @rn;                 
print 'первая строка           : ' + cast(@tc as varchar(3))+ rtrim(@rn);

FETCH NEXT from Progr into  @tc, @rn;                 
print 'следующая строка        : ' + cast(@tc as varchar(3))+ rtrim(@rn);  

FETCH ABSOLUTE 3 from Progr into  @tc, @rn;                 
print '3-я строка от начала    : ' + cast(@tc as varchar(3))+ rtrim(@rn); 

FETCH RELATIVE 5 from Progr into  @tc, @rn;                 
print '5-я строка вперед от текущей : ' + cast(@tc as varchar(3))+ rtrim(@rn); 

FETCH PRIOR from Progr into  @tc, @rn;                 
print 'предыдущая строка       : ' + cast(@tc as varchar(3))+ rtrim(@rn); 

FETCH LAST from Progr into @tc, @rn;       
print 'последняя строка        : ' +  cast(@tc as varchar(3))+ rtrim(@rn);      
CLOSE Progr;

--task5
--Создать курсор, демонстрирующий применение конструкции CURRENT OF в секции WHERE с использованием операторов UPDATE и DELETE.
declare Prog2 cursor local dynamic for 
	select IDSTUDENT, SUBJECT, NOTE from PROGRESS FOR UPDATE
declare @id varchar(10), @sub varchar(15), @nt int
open Prog2
fetch Prog2 into @id, @sub, @nt
print @id + ' студент – ' + rtrim(cast(@sub as varchar)) + ' (оценка ' + cast(@nt as varchar) + ')'
delete PROGRESS where CURRENT OF Prog2
fetch Prog2 into @id, @sub, @nt
update PROGRESS set NOTE = NOTE + 1 where CURRENT OF Prog2
print ''
print @id + ' студент – ' + rtrim(cast(@sub as varchar)) + ' (оценка ' + cast(@nt as varchar) + ')'
close Prog2
--task6
--Разработать SELECT-запрос, с помо-щью которого из таблицы PROGRESS удаляются строки, 
--содержащие ин-формацию о студентах, получивших оценки ниже 4 (использовать объеди-нение таблиц PROGRESS, STUDENT, GROUPS). 
INSERT INTO PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) values ('КГ',   1025,  '06.05.2013', 3);
declare ProgStud CURSOR LOCAL DYNAMIC FOR
	SELECT p.IDSTUDENT, s.NAME, p.NOTE FROM PROGRESS p
	JOIN STUDENT s ON s.IDSTUDENT = p.IDSTUDENT
	WHERE p.NOTE < 4
		FOR UPDATE
declare @id1 varchar(5), @nm varchar(50), @nt1 int


OPEN ProgStud
FETCH ProgStud INTO @id1, @nm, @nt1
print @id1 + ': ' + @nm + ' (оценка ' + cast(@nt1 as varchar) + ')'
DELETE PROGRESS WHERE CURRENT OF ProgStud
CLOSE ProgStud
--Разработать SELECT-запрос, с по-мощью которого в таблице PRO-GRESS для студента с конкретным номером IDSTUDENT корректируется оценка (увеличивается на единицу).
declare Prog3 CURSOR LOCAL DYNAMIC FOR
	SELECT p.IDSTUDENT, s.NAME, p.NOTE FROM PROGRESS p
	JOIN STUDENT s ON s.IDSTUDENT = p.IDSTUDENT
	WHERE p.IDSTUDENT = 1017
		FOR UPDATE
declare @id2 varchar(5), @nm2 varchar(50), @nt2 int
OPEN Prog3
FETCH Prog3 INTO @id2, @nm2, @nt2
UPDATE PROGRESS SET NOTE = NOTE + 1 WHERE CURRENT OF Prog3
print @id2 + ': ' + @nm2 + ' (была оценка ' + cast(@nt2 as varchar) + ')'
CLOSE Prog3