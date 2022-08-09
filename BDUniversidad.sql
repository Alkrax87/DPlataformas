-- Base de datos Universidad
-- Miguel Vargas
-- 08/08/2022

use master
go

if DB_ID('BDUniversidad') is not null
	drop database BDUniversidad
go

create database BDUniversidad
go

use BDUniversidad
go

--crear tablas
if OBJECT_ID('TEscuela') is not null
	drop table TEscuela
go
create table TEscuela
(
	CodEscuela char(3) primary key,
	Escuela varchar(50),
	Facultad varchar(50)
)
go

if OBJECT_ID('TAlumno') is not null
	drop table TAlumno
go
create table TAlumno
(
	CodAlumno varchar(5) primary key,
	Apellidos varchar(50),
	Nombres varchar(50),
	LugarNac varchar(50),
	FechaNac datetime,
	CodEscuela char(3),
	foreign key (CodEscuela) references TEscuela
)
go

--Inserción de datos TEscuela
insert into TEscuela values('E01','Sistemas','Ingenieria')
insert into TEscuela values('E02','Civil','Ingenieria')
insert into TEscuela values('E03','Industrial','Ingenieria')
insert into TEscuela values('E04','Ambiental','Ingenieria')
insert into TEscuela values('E05','Arquitectura','Ingenieria')
go

select * from TEscuela

--Inserción de datos TAlumno
insert into TAlumno values('A0001','Lopez','Roberto','Cusco','2000-12-03','E01')
insert into TAlumno values('A0002','Ramirez','Mario','Arequipa','2003-11-21','E02')
insert into TAlumno values('A0003','Loyola','Luz','Piura','2001-05-26','E03')
insert into TAlumno values('A0004','Malca','Robert','Tacna','1999-01-13','E04')
insert into TAlumno values('A0005','Hidalgo','Adolfo','Abancay','1995-06-04','E05')
go

select * from TAlumno