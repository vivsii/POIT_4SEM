use UNIVER
--task 1
--�� ������ ������ AUDITORIUM � AUDI-TORIUM_TYPE ����������� ������, ��-��������� ��� ������� ���� ��������� ������������, 
--�����������, ������� ����������� ���������, ��������� ���-�������� ���� ��������� � ����� ������-���� ��������� ������� ����. 
--�������������� ����� ������ �����-���� ������� � ������������� ���� ����-����� � ������� � ������������ ������-����. 
--������������ ���������� ���������� ������, ������ GROUP BY � ���������� �������. 

SELECT AUDITORIUM.AUDITORIUM_TYPE,
min(AUDITORIUM_CAPACITY) [����������� ����������� ���������],
max(AUDITORIUM_CAPACITY) [������������ ����������� ���������],
avg(AUDITORIUM_CAPACITY) [������� ����������� ���������],
count (*) [����������], --����� ������-���� ��������� ������� ����
sum(AUDITORIUM_CAPACITY) [��������� ����������� ���� ���������]
FROM AUDITORIUM Inner Join AUDITORIUM_TYPE
On AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
GROUP BY AUDITORIUM.AUDITORIUM_TYPE;

--task 2
--�� ������ ������ AUDITORIUM � AUDI-TORIUM_TYPE ����������� ������, ��-��������� ��� ������� ���� ��������� ������������, 
--�����������, ������� ����������� ���������, ��������� ���-�������� ���� ��������� � ����� ������-���� ��������� ������� ����. 
--�������������� ����� ������ �����-���� ������� � ������������� ���� ����-����� � ������� � ������������ ������-����. 
--������������ ���������� ���������� ������, ������ GROUP BY � ���������� �������. 

SELECT AUDITORIUM.AUDITORIUM_TYPE,
min(AUDITORIUM_CAPACITY) [����������� ����������� ���������],
max(AUDITORIUM_CAPACITY) [������������ ����������� ���������],
avg(AUDITORIUM_CAPACITY) [������� ����������� ���������],
count (*) [����������], --����� ������-���� ��������� ������� ����
sum(AUDITORIUM_CAPACITY) [��������� ����������� ���� ���������]
FROM AUDITORIUM Inner Join AUDITORIUM_TYPE
On AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
GROUP BY AUDITORIUM.AUDITORIUM_TYPE;

--task 3
--����������� ������ �� ������ ������� PROGRESS, ������� ����� ��������� �������� ��������������� ������ 
--� �� ��-�������� � �������� ���������. 
--���������� ����� ������ ������������-�� � �������, �������� �������� ������.
--������������ ��������� � ������ FROM, � ���������� ��������� GROUP BY � CASE. 

SELECT * FROM(SELECT CASE
WHEN NOTE = 10 then '10'
WHEN NOTE between 8 and 9 then '8-9'
WHEN NOTE between 6 and 7 then '6-7'
WHEN NOTE between 4 and 5 then '4-5'
END [������� ������], COUNT(*) as [����������]
FROM PROGRESS 
GROUP BY CASE
WHEN NOTE = 10 then '10'
WHEN NOTE between 8 and 9 then '8-9'
WHEN NOTE between 6 and 7 then '6-7'
WHEN NOTE between 4 and 5 then '4-5'
END) AS T
ORDER BY Case [������� ������]
WHEN '10' then 4
WHEN '8-9' then 3
WHEN '6-7' then 2
WHEN '4-5' then 1
ELSE 0
END;

--task 4
--����������� SELECT-������� �� ������ ������ FACULTY, GROUPS, STUDENT � PROGRESS, ������� �������� ������� ��������������� ������
--��� ������� ���-�� ������ ������������� � ����������. 
--������ ������������� � ������� �����-��� ������� ������.
--������� ������ ������ �������������� � ��������� �� ���� ������ ����� �������.
--������������ ���������� ���������� ������, ���������� ������� AVG � �����-����� ������� CAST � ROUND.
select a.FACULTY,
       G.PROFESSION,
	   G.IDGROUP,
       round(avg(cast(NOTE AS float(4))), 2) as [������� ������]
from FACULTY a
         join GROUPS G on a.FACULTY = G.FACULTY
         join STUDENT S on G.IDGROUP = S.IDGROUP
         join PROGRESS P on S.IDSTUDENT = P.IDSTUDENT
group by a.FACULTY, G.PROFESSION, G.YEAR_FIRST, G.IDGROUP
order by [������� ������] desc

--task 5
--���������� SELECT-������, ������������� � ������� 4, ��� ����� � ������� �������� �������� ������ �������������� 
--������ ������ �� ����������� � ������ �� � ����. ������������ WHERE.

select a.FACULTY,
	   b.PROFESSION,
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) [AVG NOTE]
from ((FACULTY a inner join GROUPS b on a.FACULTY = b.FACULTY)
inner join STUDENT on b.IDGROUP = STUDENT.IDGROUP) 
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where PROGRESS.SUBJECT = '��' or PROGRESS.SUBJECT = '����'
group by a.FACULTY,
		 b.PROFESSION

--task 6
--�� ������ ������ FACULTY, GROUPS, STUDENT � PROGRESS ����������� ��-����, � ������� ��������� �������������,
--���������� � ������� ������ ��� ����� ��-������� �� ���������� ���. 

SELECT GROUPS.FACULTY [FACULTY], GROUPS.PROFESSION [PROFESSION], PROGRESS.SUBJECT [PROGRESS],
round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [AVG]
FROM GROUPS, PROFESSION, PROGRESS
WHERE GROUPS.FACULTY = '���'
GROUP BY GROUPS.FACULTY, GROUPS.PROFESSION,PROGRESS.SUBJECT;

--task 7
--�� ������ ������� PROGRESS ���������� ��� ������ ���������� ���������� ���-������, ���������� ������ 8 � 9. 
--������������ �����������, ������ HAVING, ����������. 

select p1.SUBJECT as 'PREDMET', 
	p1.NOTE as 'MARK', 
	(select count(*) from PROGRESS p2
	where p2.SUBJECT = p1.SUBJECT and p2.NOTE = p1.NOTE) as 'COUNT'
from PROGRESS p1
group by p1.SUBJECT, p1.NOTE
having NOTE in (8, 9)