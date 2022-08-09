echo Instalador de la BDUniversidad
echo Autor: Miguel Vargas
echo 08/08/2022
sqlcmd -SMIGUEL-PC\SQLEXPRESS -E -i BDUniversidad.sql
sqlcmd -SMIGUEL-PC\SQLEXPRESS -E -i BDUniversidadTEscuelaPA.sql
sqlcmd -SMIGUEL-PC\SQLEXPRESS -E -i BDUniversidadTAlumnoPA.sql
echo Se ejecuto correctamente la BD
pause