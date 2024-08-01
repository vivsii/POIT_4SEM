USE UNIVER;

--task1
--����������� ��������, ����������� ������ ��������� �� ������� ����. 
--� ����� ������ ���� �������� ������� �������� ��������� �� ������� SUBJECT � ���� ������ ����� ����-���. 
--������������ ���������� ������� RTRIM.
DECLARE @ds char(20), @t char(300) = '';
DECLARE Disc CURSOR for SELECT SUBJECT FROM SUBJECT WHERE PULPIT = '����';
OPEN Disc;
FETCH Disc into @ds;
print 'C����� ���������';
WHILE @@FETCH_STATUS = 0
	begin
	set @t = RTRIM(@ds) + ', ' + @t;
	FETCH Disc into @ds;
	end;
	print @t;
CLOSE Disc;
DEALLOCATE Disc;
--task2
--����������� ��������, ������������-��� ������� ����������� ������� �� ���������� �� ������� ���� ������ UNIVER.
DECLARE StudentsL CURSOR LOCAL for SELECT NAME, IDGROUP from STUDENT;
DECLARE @name nvarchar(50), @group int;      
	OPEN StudentsL;	  
	fetch StudentsL into @name, @group; 	
      print '1. '+ @name + ', ������: ' + cast(@group as varchar(6));   
      go
DECLARE @name nvarchar(50), @group int;     	
	fetch StudentsL into @name, @group; 	
      print '2. '+ @name+ ', ������: '  + cast(@group as varchar(6));  
go 
------------------------------
DECLARE StudentsG CURSOR GLOBAL for SELECT NAME, IDGROUP from STUDENT;
DECLARE @name nvarchar(50), @group int;      
	OPEN StudentsG;	  
	fetch StudentsG into @name, @group; 	
      print '1. '+ @name + ', ������: ' + cast(@group as varchar(6));   
      go
 DECLARE @name nvarchar(50), @group int;     	
	fetch StudentsG into @name, @group; 	
      print '2. '+ @name + ', ������: '+ cast(@group as varchar(6));  
CLOSE StudentsG;
DEALLOCATE StudentsG;
--task3
--����������� ��������, ������������-��� ������� ����������� �������� �� ������������ �� ������� ���� ������ UNIVER.
DECLARE @tid char(10), @tnm char(40), @tgn char(1);  
DECLARE Prog CURSOR LOCAL STATIC                              
	 for SELECT SUBJECT, PDATE, NOTE 
	       FROM PROGRESS where SUBJECT = '��';				   
open Prog;
print   '���������� ����� : '+cast(@@CURSOR_ROWS as varchar(5)); 
UPDATE PROGRESS set NOTE = 5 where IDSTUDENT = '1017';
DELETE PROGRESS where IDSTUDENT = '1079';
INSERT PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) 
                 values ('��', 1079, '2013-01-10', 7); 
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
	       FROM PROGRESS where SUBJECT = '��';				   
open Prog1;
print   '���������� ����� : ' + cast(@@CURSOR_ROWS as varchar(5)); 
UPDATE PROGRESS set NOTE = 5 where IDSTUDENT = '1017';
DELETE PROGRESS where IDSTUDENT = '1079';
INSERT PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) 
                 VALUES ('��', 1079, '2013-01-10', 4); 
FETCH Prog1 into @tid1, @tnm1, @tgn1;     
while @@fetch_status = 0                                    
     begin 
         print @tid1 + ' '+ @tnm1 + ' '+ @tgn1;      
         fetch Prog1 into @tid1, @tnm1, @tgn1; 
      end;          
CLOSE Prog1;

--task4
--����������� ��������, ������������-��� �������� ��������� � ��������-������ ������ ������� � ��������� SCROLL �� ������� ���� ������ UNIVER.
--������������ ��� ��������� �����-��� ����� � ��������� FETCH.

DECLARE  @tc int, @rn char(50);  
DECLARE Progr cursor local dynamic SCROLL                               
for SELECT row_number() over (order by SUBJECT) SName,
                           IDSTUDENT FROM PROGRESS
OPEN Progr;

FETCH FIRST from Progr into  @tc, @rn;                 
print '������ ������           : ' + cast(@tc as varchar(3))+ rtrim(@rn);

FETCH NEXT from Progr into  @tc, @rn;                 
print '��������� ������        : ' + cast(@tc as varchar(3))+ rtrim(@rn);  

FETCH ABSOLUTE 3 from Progr into  @tc, @rn;                 
print '3-� ������ �� ������    : ' + cast(@tc as varchar(3))+ rtrim(@rn); 

FETCH RELATIVE 5 from Progr into  @tc, @rn;                 
print '5-� ������ ������ �� ������� : ' + cast(@tc as varchar(3))+ rtrim(@rn); 

FETCH PRIOR from Progr into  @tc, @rn;                 
print '���������� ������       : ' + cast(@tc as varchar(3))+ rtrim(@rn); 

FETCH LAST from Progr into @tc, @rn;       
print '��������� ������        : ' +  cast(@tc as varchar(3))+ rtrim(@rn);      
CLOSE Progr;

--task5
--������� ������, ��������������� ���������� ����������� CURRENT OF � ������ WHERE � �������������� ���������� UPDATE � DELETE.
declare Prog2 cursor local dynamic for 
	select IDSTUDENT, SUBJECT, NOTE from PROGRESS FOR UPDATE
declare @id varchar(10), @sub varchar(15), @nt int
open Prog2
fetch Prog2 into @id, @sub, @nt
print @id + ' ������� � ' + rtrim(cast(@sub as varchar)) + ' (������ ' + cast(@nt as varchar) + ')'
delete PROGRESS where CURRENT OF Prog2
fetch Prog2 into @id, @sub, @nt
update PROGRESS set NOTE = NOTE + 1 where CURRENT OF Prog2
print ''
print @id + ' ������� � ' + rtrim(cast(@sub as varchar)) + ' (������ ' + cast(@nt as varchar) + ')'
close Prog2
--task6
--����������� SELECT-������, � ����-��� �������� �� ������� PROGRESS ��������� ������, 
--���������� ��-�������� � ���������, ���������� ������ ���� 4 (������������ ������-����� ������ PROGRESS, STUDENT, GROUPS). 
INSERT INTO PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) values ('��',   1025,  '06.05.2013', 3);
declare ProgStud CURSOR LOCAL DYNAMIC FOR
	SELECT p.IDSTUDENT, s.NAME, p.NOTE FROM PROGRESS p
	JOIN STUDENT s ON s.IDSTUDENT = p.IDSTUDENT
	WHERE p.NOTE < 4
		FOR UPDATE
declare @id1 varchar(5), @nm varchar(50), @nt1 int


OPEN ProgStud
FETCH ProgStud INTO @id1, @nm, @nt1
print @id1 + ': ' + @nm + ' (������ ' + cast(@nt1 as varchar) + ')'
DELETE PROGRESS WHERE CURRENT OF ProgStud
CLOSE ProgStud
--����������� SELECT-������, � ��-����� �������� � ������� PRO-GRESS ��� �������� � ���������� ������� IDSTUDENT �������������� ������ (������������� �� �������).
declare Prog3 CURSOR LOCAL DYNAMIC FOR
	SELECT p.IDSTUDENT, s.NAME, p.NOTE FROM PROGRESS p
	JOIN STUDENT s ON s.IDSTUDENT = p.IDSTUDENT
	WHERE p.IDSTUDENT = 1017
		FOR UPDATE
declare @id2 varchar(5), @nm2 varchar(50), @nt2 int
OPEN Prog3
FETCH Prog3 INTO @id2, @nm2, @nt2
UPDATE PROGRESS SET NOTE = NOTE + 1 WHERE CURRENT OF Prog3
print @id2 + ': ' + @nm2 + ' (���� ������ ' + cast(@nt2 as varchar) + ')'
CLOSE Prog3