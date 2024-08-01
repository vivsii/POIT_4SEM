use EVS_MyBASE;
CREATE table ПРЕДМЕТЫ
(  Предмет nvarchar(50) primary key,
  Тип_занятий nvarchar(50),
  Количество_часов int not null
);

CREATE table ПРЕПОДАВАТЕЛИ
(  Код_преподавателя int not null primary key,
  Фамилия_преподавателя nvarchar(50),
  Имя nvarchar(50),
  Отчество nvarchar(50),
  Телефон int not null,
  Стаж int not null
);

CREATE table КУРСЫ
(  Номер_курса int not null primary key,
  Код_преподавателя int foreign key references ПРЕПОДАВАТЕЛИ(Код_преподавателя),
  Предмет nvarchar(50) foreign key references ПРЕДМЕТЫ(Предмет),
  Оплата int not null
);

CREATE table ГРУППЫ
(  Номер_группы int not null primary key,
  Специальность nvarchar(50),
  Отделение nvarchar(50),
  Количество_студентов int not null,
  Номер_курса int not null foreign key references КУРСЫ(Номер_курса)
);

ALTER Table ПРЕПОДАВАТЕЛИ ADD Электронная_почта nvarchar(50); 

ALTER Table ПРЕПОДАВАТЕЛИ ADD Статус nchar(7) default 'активен' check (Статус in ('активен', 'не_активен'));

ALTER Table ПРЕПОДАВАТЕЛИ DROP Column Электронная_почта;

INSERT into ПРЕПОДАВАТЕЛИ(Код_преподавателя,Фамилия_преподавателя,Имя,Отчество,Телефон,Стаж)
Values(1,'Север','Александра','Сергеевна',1111, 2);

INSERT into ПРЕДМЕТЫ(Предмет,Тип_занятий,Количество_часов)
Values('ООП','Лекции',30);

INSERT into ГРУППЫ(Номер_группы,Специальность,Отделение,Количество_студентов,Номер_курса)
Values(1,'ПОИТ','А',30, 1);

INSERT into КУРСЫ(Номер_курса,Код_преподавателя,Предмет,Оплата)
Values(1,1,'ООП',300);

SELECT Код_преподавателя, Фамилия_преподавателя  From ПРЕПОДАВАТЕЛИ

SELECT count(*) From ПРЕДМЕТЫ