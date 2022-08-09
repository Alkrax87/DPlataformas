-- Procedimientos Almacenados
-- Miguel Vargas
-- 08/08/2022

--PA para TEscuela
use BDUniversidad
go

if OBJECT_ID('spListarEscuela') is not null
	drop proc spListarEscuela
go
create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

exec spListarEscuela
go

--==============\
-- PA Agregar  ========================================================
--==============/
if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go
create proc spAgregarEscuela
@CodEscuela char(3),@Escuela varchar(50), @Facultad varchar(50)
as
begin
	--CodEscuela no puede ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		--Escuela no puede ser duplicado
		if not exists(select Escuela from TEscuela where Escuela = @Escuela)
			begin
				insert into TEscuela values(@CodEscuela,@Escuela,@Facultad)
				select CodError = 0, Mensaje = 'Se inserto correctamente escuela'
			end
		else select CodError = 1, Mensaje = 'Error: Escuela duplicado'
	else select CodError = 1, Mensaje = 'Error: CodEscuela duplicado'
end
go
--=============
-- Ejecucion  =
--=============
exec spListarEscuela
go
exec spAgregarEscuela @CodEscuela = 'E06', @Escuela = 'Derecho', @Facultad = 'Derecho'
go

--Actividad: Implementar eliminar, Actualizar y Buscar
--Presentado el dia miercoles 10/08/2022 a travez de aula virtual

--================\
-- PA Actualizar ========================================================
--================/
if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go
create proc spActualizarEscuela
@CodEscuela char(3),@Escuela varchar(50), @Facultad varchar(50)
as
begin
	--CodEscuela no puede ser duplicado
	if exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		begin
			UPDATE TEscuela
			SET Escuela = @Escuela, Facultad = @Facultad
			WHERE CodEscuela = @CodEscuela
			select CodError = 0, Mensaje = 'Se Actualizo correctamente'
		end
	else select CodError = 1, Mensaje = 'Error: CodEscuela no existe'
end
go
--=============
-- Ejecucion  =
--=============
exec spListarEscuela
go
exec spActualizarEscuela @CodEscuela = 'E06', @Escuela = 'Economia', @Facultad = 'CEAC'
go

--==============\
-- PA Buscar   ========================================================
--==============/
if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go
create proc spBuscarEscuela
@Escuela varchar(50)
as
begin
	--Si escuela Existe
	if exists(select Escuela from TEscuela where Escuela like '%'+@Escuela+'%')
		begin
			select CodError = 0, Mensaje = 'Se realizo la busqueda exitosamente'
			select * from TEscuela WHERE Escuela like '%'+@Escuela+'%'
		end
	else select CodError = 1, Mensaje = 'Error: La escuela no existe'
end
go
--=============
-- Ejecucion  =
--=============
exec spListarEscuela
go
exec spBuscarEscuela @Escuela = 'nomia'
go

--==============\
-- PA Eliminar ========================================================
--==============/
if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go
create proc spEliminarEscuela
@CodEscuela char(3)
as
begin
	--Si escuela Existe
	if exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		begin
			delete from TEscuela WHERE CodEscuela = @CodEscuela
			select CodError = 0, Mensaje = 'Se elimino escuela correctamente'
		end
	else select CodError = 1, Mensaje = 'Error: El CodEscuela Escuela no Existe'
end
go
--=============
-- Ejecucion  =
--=============
exec spEliminarEscuela @CodEscuela = 'E06'
go
exec spListarEscuela
go