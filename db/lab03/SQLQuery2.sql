use EVS_MyBASE;
CREATE table ��������
(  ������� nvarchar(50) primary key,
  ���_������� nvarchar(50),
  ����������_����� int not null
);

CREATE table �������������
(  ���_������������� int not null primary key,
  �������_������������� nvarchar(50),
  ��� nvarchar(50),
  �������� nvarchar(50),
  ������� int not null,
  ���� int not null
);

CREATE table �����
(  �����_����� int not null primary key,
  ���_������������� int foreign key references �������������(���_�������������),
  ������� nvarchar(50) foreign key references ��������(�������),
  ������ int not null
);

CREATE table ������
(  �����_������ int not null primary key,
  ������������� nvarchar(50),
  ��������� nvarchar(50),
  ����������_��������� int not null,
  �����_����� int not null foreign key references �����(�����_�����)
);

ALTER Table ������������� ADD �����������_����� nvarchar(50); 

ALTER Table ������������� ADD ������ nchar(7) default '�������' check (������ in ('�������', '��_�������'));

ALTER Table ������������� DROP Column �����������_�����;

INSERT into �������������(���_�������������,�������_�������������,���,��������,�������,����)
Values(1,'�����','����������','���������',1111, 2);

INSERT into ��������(�������,���_�������,����������_�����)
Values('���','������',30);

INSERT into ������(�����_������,�������������,���������,����������_���������,�����_�����)
Values(1,'����','�',30, 1);

INSERT into �����(�����_�����,���_�������������,�������,������)
Values(1,1,'���',300);

SELECT ���_�������������, �������_�������������  From �������������

SELECT count(*) From ��������