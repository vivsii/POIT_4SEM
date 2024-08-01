use EVS_MyBASE
--task1
--����������� ��������, ����������� ������ ��������� �� ������� ����. 
--� ����� ������ ���� �������� ������� �������� ��������� �� ������� SUBJECT � ���� ������ ����� ����-���. 
--������������ ���������� ������� RTRIM.
DECLARE @ds char(20), @t char(300) = '';
DECLARE Grp CURSOR for SELECT �����_������ FROM ������ WHERE ������������� = '����';
OPEN Grp;
FETCH Grp into @ds;
print 'C����� �����';
WHILE @@FETCH_STATUS = 0
	begin
	set @t = RTRIM(@ds) + ', ' + @t;
	FETCH Grp into @ds;
	end;
	print @t;
CLOSE Grp;
DEALLOCATE Grp;

--task2
--����������� ��������, ������������-��� ������� ����������� ������� �� ���������� �� ������� ���� ������.
DECLARE SubjL CURSOR LOCAL for SELECT �������, ���_������� from ��������;
DECLARE @name nvarchar(50), @sub nvarchar(50);      
	OPEN SubjL;	  
	fetch SubjL into @name, @sub; 	
      print '1. '+ @name + ', ��� �������: ' + @sub;   
      go
DECLARE @name nvarchar(50), @sub nvarchar(50);     	
	fetch SubjL into @name, @sub; 	
      print '2. '+ @name+ ', ��� �������: '  + @sub;  
go 
------------------------------
DECLARE SubjG CURSOR GLOBAL for SELECT �������, ���_������� from ��������;
DECLARE @name nvarchar(50), @sub nvarchar(50);      
	OPEN SubjG;	  
	fetch SubjG into @name, @sub; 	
      print '1. '+ @name + ', ��� �������: ' + @sub;   
      go
 DECLARE @name nvarchar(50), @sub nvarchar(50);     	
	fetch SubjG into @name, @sub; 	
      print '2. '+ @name + ', ��� �������: '+ @sub;  
CLOSE SubjG;
DEALLOCATE SubjG;

--task3
--����������� ��������, ������������-��� ������� ����������� �������� �� ������������ �� ������� ���� ������ UNIVER.
DECLARE @tid char(10), @tnm char(40), @tgn char(1);  
DECLARE Prog CURSOR LOCAL STATIC                              
	 for SELECT �����_������, �������������, ����������_��������� 
	       FROM ������ where ������������� = '����';				   
open Prog;
print   '���������� ����� : '+cast(@@CURSOR_ROWS as varchar(5)); 
UPDATE ������ set ����������_��������� = 32 where �����_������ = 8;
DELETE ������ where �����_������ = '21';
INSERT ������ (�����_������, �������������, ���������, ����������_���������, �����_�����) 
                 values (35, '����', '�', 30, 2); 
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
	 for SELECT �����_������, �������������, ����������_��������� 
	       FROM ������ where ������������� = '����';				   
open Prog1;
print   '���������� ����� : ' + cast(@@CURSOR_ROWS as varchar(5)); 
UPDATE ������ set ����������_��������� = 32 where �����_������ = 8;
DELETE ������ where �����_������ = '21';
INSERT ������ (�����_������, �������������, ���������, ����������_���������, �����_�����) 
                 values (33, '����', '�', 30, 2); 
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
for SELECT row_number() over (order by �������) ���_�������,
                           ����������_����� FROM ��������
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
	select �����_�����, �������, ������ from ����� FOR UPDATE
declare @id varchar(10), @sub2 varchar(15), @nt int
open Prog2
fetch Prog2 into @id, @sub2, @nt
print @id + ' ������� � ' + rtrim(cast(@sub2 as varchar)) + ' (���� ' + cast(@nt as varchar) + ')'
delete ����� where CURRENT OF Prog2
fetch Prog2 into @id, @sub2, @nt
update ����� set ������ = ������ + 100 where CURRENT OF Prog2
print ''
print @id + ' ������� � ' + rtrim(cast(@sub2 as varchar)) + ' (���� ' + cast(@nt as varchar) + ')'
close Prog2
--task6
--����������� SELECT-������, � ����-��� �������� �� ������� PROGRESS ��������� ������, 
--���������� ��-�������� � ���������, ���������� ������ ���� 4 (������������ ������-����� ������ PROGRESS, STUDENT, GROUPS). 
INSERT INTO ��������(�������, ���_�������, ����������_�����) values ('�','����', 3);
INSERT INTO �����(�����_�����, ���_�������������, �������, ������) values (11,1,'���', 123);

declare ProgStud CURSOR LOCAL DYNAMIC FOR
	SELECT p.�������, s.�����_�����, p.����������_����� FROM �������� p
	JOIN ����� s ON s.������� = p.�������
	WHERE p.����������_����� < 10
		FOR UPDATE
declare @id1 varchar(5), @nm varchar(50), @nt1 int
OPEN ProgStud
FETCH ProgStud INTO @id1, @nm, @nt1
print @id1 + ': ' + @nm + ' (���������� ����� ' + cast(@nt1 as varchar) + ')'
DELETE ����� WHERE CURRENT OF ProgStud
CLOSE ProgStud
--����������� SELECT-������, � ��-����� �������� � ������� PRO-GRESS ��� �������� � ���������� ������� IDSTUDENT �������������� ������ (������������� �� �������).

declare Prog3 CURSOR LOCAL DYNAMIC FOR
	SELECT p.�������, s.�����_�����, p.����������_����� FROM �������� p
	JOIN ����� s ON s.������� = p.�������
	WHERE p.������� = '����'
		FOR UPDATE
declare @id2 varchar(5), @nm2 varchar(50), @nt2 int
OPEN Prog3
FETCH Prog3 INTO @id2, @nm2, @nt2
UPDATE �������� SET ����������_����� = ����������_����� + 1 WHERE CURRENT OF Prog3
print @id2 + ': ' + @nm2 + ' (���� ����� ����� ' + cast(@nt2 as varchar) + ')'
CLOSE Prog3