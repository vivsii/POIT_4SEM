use UNIVER;
--�� ������ ������ FACULTY, PULPIT � PROFESSION ������������ ������ ������������ ������, ������� ��������� �� ����������,
--�������������� �����-����� �� �������������, � ������������ �������� ���������� ����� ���������� ��� ����������. 
--������������ � ������ WHERE �����-��� IN c ����������������� ����������� � ������� PROFESSION
--task 1
select FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME
from FACULTY, PULPIT, PROFESSION
where FACULTY.FACULTY = PULPIT.FACULTY and PULPIT.FACULTY = PROFESSION.FACULTY
and PROFESSION_NAME IN (select  PROFESSION.PROFESSION_NAME from PROFESSION 
where (PROFESSION_NAME like '%����������%' or PROFESSION_NAME like '%����������%' ))

--���������� ������ ������ 1 ����� ����-���, ����� ��� �� ��������� ��� ������� � ����������� INNER JOIN ������ FROM �������� �������. 
--��� ���� ��������� ��-�������� ������� ������ ���� ��������-��� ���������� ��������� �������. 
--task 2
select FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME
from (FACULTY INNER JOIN PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY) INNER JOIN PROFESSION ON PULPIT.FACULTY = PROFESSION.FACULTY 
WHERE PROFESSION_NAME in (select PROFESSION_NAME from  PROFESSION
where (PROFESSION_NAME like '%����������%' or PROFESSION_NAME like '%����������%'))

--���������� ������, ����������� 1 ����� ��� ������������� ����������. 
--�������-���: ������������ ���������� INNER JOIN ���� ������. 
--task 3
select FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME
from (FACULTY INNER JOIN PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY) INNER JOIN PROFESSION ON PULPIT.FACULTY = PROFESSION.FACULTY 
where (PROFESSION_NAME like '%����������%' or PROFESSION_NAME like '%����������%')

--�� ������ ������� AUDITORIUM ����-�������� ������ ��������� ����� ����-��� ������������ ��� ������� ���� ����-�����.
--��� ���� ��������� ������� �����-�������� � ������� �������� ��������-���.
--����������: ������������ �������-������ ��������� c �������� TOP � ORDER BY. 
--task 4
select AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM A
where AUDITORIUM_CAPACITY = (select top(1) AUDITORIUM_CAPACITY from AUDITORIUM R 
where  R.AUDITORIUM_TYPE= A.AUDITORIUM_TYPE 
order by AUDITORIUM_CAPACITY desc)

--�� ������ ������ FACULTY � PULPIT ������������ ������ ������������ ��-��������� �� ������� ��� �� ����� �����-�� (������� PULPIT). 
--������������ �������� EXISTS � ���-������������ ���������. 
--task 5
select FACULTY.FACULTY_NAME from FACULTY
where not exists (select *from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY_NAME)

--�� ������ ������� PROGRESS ������-������ ������, ���������� ������� ���-����� ������ (������� NOTE) �� �����-������, ������� ��������� 
--����: ����, �� � ����. 
--����������: ������-������ ��� ����������������� ���������� � ������ SELECT; 
--� ����������� �����-���� ���������� ������� AVG. 
--task 6
 select top 1
	(select avg(NOTE) from PROGRESS where SUBJECT like '����') [����],
	(select avg(NOTE) from PROGRESS where SUBJECT like '�� ') [��] ,
	(select avg(NOTE) from PROGRESS where SUBJECT like '����') [����]
	from PROGRESS

--����������� SELECT-������, ���������-������ ������ ���������� ALL �������-�� � �����������.
--task 7
select SUBJECT,  NOTE from PROGRESS
where NOTE >=all (select NOTE from PROGRESS where IDSTUDENT between 1000 and 1008)

--����������� SELECT-������, ���������-������ ������� ���������� ANY ���-������ � �����������.
--task 8
select SUBJECT,  NOTE from PROGRESS
where NOTE >=any (select NOTE from PROGRESS where IDSTUDENT between 1000 and 1008)

--����� � ������� STUDENT ���������, � ������� ���� �������� � ���� � ��� �� ����. ��������� �������.
--task 10*
select STUDENT.NAME,Day(BDAY)[dnyha], STUDENT.BDAY FROM STUDENT WHERE DAY(BDAY)
IN ( 
	SELECT DAY(BDAY) 
	FROM STUDENT  
	GROUP BY DAY(BDAY) 
	HAVING COUNT(DAY(BDAY)) > 1) 
group by Day(Bday),STUDENT.NAME,STUDENT.BDAY
order by 'dnyha' asc;