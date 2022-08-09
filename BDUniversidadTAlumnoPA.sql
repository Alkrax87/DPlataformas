-- Procedimientos Almacenados
-- Miguel Vargas
-- 08/08/2022

--PA para TAlumno
use BDUniversidad
go

if OBJECT_ID('spListarAlumno') is not null
	drop proc spListarAlumno
go
create proc spListarAlumno
as
begin
	select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela from TAlumno
end
go

exec spListarAlumno
go

--==============\
-- PA Agregar  ========================================================
--==============/
if OBJECT_ID('spAgregarAlumno') is not null
	drop proc spAgregarAlumno
go
create proc spAgregarAlumno
@CodAlumno char(5),@Apellidos varchar(50),@Nombres varchar(50),@LugarNac varchar(50),@FechaNac datetime,@CodEscuela char(3)
as
begin
	--CodAlumno no puede ser duplicado
	if not exists(select CodAlumno from TAlumno where CodAlumno = @CodAlumno)
		begin
			insert into TAlumno values(@CodAlumno,@Apellidos,@Nombres,@LugarNac,@FechaNac,@CodEscuela)
			select CodError = 0, Mensaje = 'Se inserto correctamente alumno'
		end
	else select CodError = 1, Mensaje = 'Error: CodAlumno duplicado'
end
go
--=============
-- Ejecucion  =
--=============
exec spListarAlumno
go
exec spAgregarAlumno @CodAlumno = 'A0006', @Apellidos = 'Orozco', @Nombres = 'Carlos', @LugarNac ='Lima', @FechaNac = '1992-07-29', @CodEscuela = 'E05'
go

--================\
-- PA Actualizar ========================================================
--================/
if OBJECT_ID('spActualizarAlumno') is not null
	drop proc spActualizarAlumno
go
create proc spActualizarAlumno
@CodAlumno char(5),@Apellidos varchar(50),@Nombres varchar(50),@LugarNac varchar(50),@FechaNac datetime,@CodEscuela char(3)
as
begin
	--CodAlumno existe
	if exists(select CodAlumno from TAlumno where CodAlumno = @CodAlumno)
		begin
			UPDATE TAlumno
			SET CodAlumno=@CodAlumno,Apellidos=@Apellidos,Nombres=@Nombres,LugarNac=@LugarNac,FechaNac=@FechaNac,CodEscuela=@CodEscuela
			WHERE CodAlumno = @CodAlumno
			select CodError = 0, Mensaje = 'Se Actualizo correctamente'
		end
	else select CodError = 1, Mensaje = 'Error: CodAlumno no existe'
end
go
--=============
-- Ejecucion  =
--=============
exec spListarAlumno
go
exec spActualizarAlumno @CodAlumno = 'A0006', @Apellidos = 'Fernandez', @Nombres = 'Julian', @LugarNac ='Puno', @FechaNac = '1990-01-01', @CodEscuela = 'E04'
go

--==============\
-- PA Buscar   ========================================================
--==============/
if OBJECT_ID('spBuscarAlumno') is not null
	drop proc spBuscarAlumno
go
create proc spBuscarAlumno
@Apellido varchar(50)
as
begin
	--Si escuela Existe
	if exists(select Apellidos from TAlumno where Apellidos like '%'+@Apellido+'%')
		begin
			select CodError = 0, Mensaje = 'Se realizo la busqueda exitosamente'
			select * from TAlumno WHERE Apellidos like '%'+@Apellido+'%'
		end
	else select CodError = 1, Mensaje = 'Error: El apellido no existe'
end
go
--=============
-- Ejecucion  =
--=============
exec spListarAlumno
go
exec spBuscarAlumno @Apellido = 'Fernandez'
go

--==============\
-- PA Eliminar ========================================================
--==============/
if OBJECT_ID('spEliminarAlumno') is not null
	drop proc spEliminarAlumno
go
create proc spEliminarAlumno
@CodAlumno char(5)
as
begin
	--Si escuela Existe
	if exists(select CodAlumno from TAlumno where CodAlumno = @CodAlumno)
		begin
			delete from TAlumno WHERE CodAlumno = @CodAlumno
			select CodError = 0, Mensaje = 'Se elimino alumno correctamente'
		end
	else select CodError = 1, Mensaje = 'Error: El CodAlumno no Existe'
end
go
--=============
-- Ejecucion  =
--=============
exec spEliminarAlumno @CodAlumno = 'A0006'
go
exec spListarAlumno
go