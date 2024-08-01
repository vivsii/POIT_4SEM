use EVS_MyBASE
--task1
--Разработать сценарий, формирующий список дисциплин на кафедре ИСиТ. 
--В отчет должны быть выведены краткие названия дисциплин из таблицы SUBJECT в одну строку через запя-тую. 
--Использовать встроенную функцию RTRIM.
DECLARE @ds char(20), @t char(300) = '';
DECLARE Grp CURSOR for SELECT Номер_группы FROM ГРУППЫ WHERE Специальность = 'ПОИТ';
OPEN Grp;
FETCH Grp into @ds;
print 'Cписок групп';
WHILE @@FETCH_STATUS = 0
	begin
	set @t = RTRIM(@ds) + ', ' + @t;
	FETCH Grp into @ds;
	end;
	print @t;
CLOSE Grp;
DEALLOCATE Grp;

--task2
--Разработать сценарий, демонстрирую-щий отличие глобального курсора от локального на примере базы данных.
DECLARE SubjL CURSOR LOCAL for SELECT Предмет, Тип_занятий from ПРЕДМЕТЫ;
DECLARE @name nvarchar(50), @sub nvarchar(50);      
	OPEN SubjL;	  
	fetch SubjL into @name, @sub; 	
      print '1. '+ @name + ', тип занятия: ' + @sub;   
      go
DECLARE @name nvarchar(50), @sub nvarchar(50);     	
	fetch SubjL into @name, @sub; 	
      print '2. '+ @name+ ', тип занятия: '  + @sub;  
go 
------------------------------
DECLARE SubjG CURSOR GLOBAL for SELECT Предмет, Тип_занятий from ПРЕДМЕТЫ;
DECLARE @name nvarchar(50), @sub nvarchar(50);      
	OPEN SubjG;	  
	fetch SubjG into @name, @sub; 	
      print '1. '+ @name + ', тип занятия: ' + @sub;   
      go
 DECLARE @name nvarchar(50), @sub nvarchar(50);     	
	fetch SubjG into @name, @sub; 	
      print '2. '+ @name + ', тип занятия: '+ @sub;  
CLOSE SubjG;
DEALLOCATE SubjG;

--task3
--Разработать сценарий, демонстрирую-щий отличие статических курсоров от динамических на примере базы данных UNIVER.
DECLARE @tid char(10), @tnm char(40), @tgn char(1);  
DECLARE Prog CURSOR LOCAL STATIC                              
	 for SELECT Номер_группы, Специальность, Количество_студентов 
	       FROM ГРУППЫ where Специальность = 'ПОИТ';				   
open Prog;
print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 
UPDATE ГРУППЫ set Количество_студентов = 32 where Номер_группы = 8;
DELETE ГРУППЫ where Номер_группы = '21';
INSERT ГРУППЫ (Номер_группы, Специальность, Отделение, Количество_студентов, Номер_курса) 
                 values (35, 'ПОИТ', 'А', 30, 2); 
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
	 for SELECT Номер_группы, Специальность, Количество_студентов 
	       FROM ГРУППЫ where Специальность = 'ПОИТ';				   
open Prog1;
print   'Количество строк : ' + cast(@@CURSOR_ROWS as varchar(5)); 
UPDATE ГРУППЫ set Количество_студентов = 32 where Номер_группы = 8;
DELETE ГРУППЫ where Номер_группы = '21';
INSERT ГРУППЫ (Номер_группы, Специальность, Отделение, Количество_студентов, Номер_курса) 
                 values (33, 'ПОИТ', 'А', 30, 2); 
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
for SELECT row_number() over (order by Предмет) Тип_занятий,
                           Количество_часов FROM ПРЕДМЕТЫ
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
	select Номер_курса, Предмет, Оплата from КУРСЫ FOR UPDATE
declare @id varchar(10), @sub2 varchar(15), @nt int
open Prog2
fetch Prog2 into @id, @sub2, @nt
print @id + ' Предмет – ' + rtrim(cast(@sub2 as varchar)) + ' (цена ' + cast(@nt as varchar) + ')'
delete КУРСЫ where CURRENT OF Prog2
fetch Prog2 into @id, @sub2, @nt
update КУРСЫ set Оплата = Оплата + 100 where CURRENT OF Prog2
print ''
print @id + ' Предмет – ' + rtrim(cast(@sub2 as varchar)) + ' (цена ' + cast(@nt as varchar) + ')'
close Prog2
--task6
--Разработать SELECT-запрос, с помо-щью которого из таблицы PROGRESS удаляются строки, 
--содержащие ин-формацию о студентах, получивших оценки ниже 4 (использовать объеди-нение таблиц PROGRESS, STUDENT, GROUPS). 
INSERT INTO ПРЕДМЕТЫ(Предмет, Тип_занятий, Количество_часов) values ('О','Лабы', 3);
INSERT INTO Курсы(Номер_курса, Код_преподавателя, Предмет, Оплата) values (11,1,'ОКГ', 123);

declare ProgStud CURSOR LOCAL DYNAMIC FOR
	SELECT p.Предмет, s.Номер_курса, p.Количество_часов FROM ПРЕДМЕТЫ p
	JOIN КУРСЫ s ON s.Предмет = p.Предмет
	WHERE p.Количество_часов < 10
		FOR UPDATE
declare @id1 varchar(5), @nm varchar(50), @nt1 int
OPEN ProgStud
FETCH ProgStud INTO @id1, @nm, @nt1
print @id1 + ': ' + @nm + ' (Количество часов ' + cast(@nt1 as varchar) + ')'
DELETE КУРСЫ WHERE CURRENT OF ProgStud
CLOSE ProgStud
--Разработать SELECT-запрос, с по-мощью которого в таблице PRO-GRESS для студента с конкретным номером IDSTUDENT корректируется оценка (увеличивается на единицу).

declare Prog3 CURSOR LOCAL DYNAMIC FOR
	SELECT p.Предмет, s.Номер_курса, p.Количество_часов FROM ПРЕДМЕТЫ p
	JOIN КУРСЫ s ON s.Предмет = p.Предмет
	WHERE p.Предмет = 'ТПВИ'
		FOR UPDATE
declare @id2 varchar(5), @nm2 varchar(50), @nt2 int
OPEN Prog3
FETCH Prog3 INTO @id2, @nm2, @nt2
UPDATE ПРЕДМЕТЫ SET Количество_часов = Количество_часов + 1 WHERE CURRENT OF Prog3
print @id2 + ': ' + @nm2 + ' (было колво часов ' + cast(@nt2 as varchar) + ')'
CLOSE Prog3