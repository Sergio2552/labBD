create procedure insertChidoPeliculas (@nombre nvarchar(50) , @sinopsis nvarchar(max), @duracion time(7), @clasificacion nchar(4) , @genero nvarchar(17) )
as begin
insert into Pelicula select @nombre,@sinopsis,@duracion,@clasificacion,@genero end
exec insertChidoPeliculas 'Iron Man','Un tipo con un traje chido' ,'2:30','C','Accion'

create procedure BuscarPelicula (@nombre nvarchar(50))
as begin
select * from Pelicula where Nombre =@nombre
end
exec BuscarPelicula 'Iron Man'

create procedure BuscarSucursal(@sucursal nvarchar(30))
as begin
select * from Sucursales where Nombre = @sucursal
end
exec BuscarSucursal 'Mol Concordia'
 
create procedure upEmplEdad(@id int,@edad tinyint)
as begin
update Trabajadores set Edad=@edad
where IDTrabajador=@id
end
exec upEmplEdad 13,26

create procedure rmPelicula(@var1 int)
as begin
delete from Pelicula
where IDPelicula=@var1
end
exec rmPelicula 1002

create trigger NoEnableDelSucursal on Pelicula
instead of delete
as 
print 'No se pueden borrar sucursales ahi ganamos dinero :v'


create trigger algoTrigger on Pelicula
after insert
as
print 'Nueva pelicula , mas dinero \:v/'
