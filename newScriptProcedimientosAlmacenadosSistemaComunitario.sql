/*PROCEDIMIENTOS ALMACENADOS NUEVOS EN EL NUEVO PROYECTO*/

/*procedimiento almacenado consulta comunero se usa para listar los comuneros de la comuna a la que pertenece*/
create procedure consulta_comunero(id_comuna int)
select pk_comunero,cedula,primer_nombre,segundo_nombre,
primer_apellido,segundo_apellido,telefono,edad 
from comunero
join comuna
on fk_comuna=pk_comuna
where fk_comuna=id_comuna
;

/*procedimiento almacenado consulta comunero por id se usa para editar*/
create procedure consulta_comuneroID(id_comunero int)
select cedula,primer_nombre,segundo_nombre,
primer_apellido,segundo_apellido,telefono,direccion_vivienda,
referencia_geografica,nombre_comuna,fecha_nacimiento,edad,
(select usuario from login where fk_comunero=id_comunero) as usuario,
(select contraseña from login where fk_comunero=id_comunero) as contraseña,
(
select pk_tipousuario from tipousuario
where pk_tipousuario=(select fk_tipousuario from login where fk_comunero=id_comunero)
 ) as pk_tipousuario
 from comunero
 join comuna
 on comunero.fk_comuna=comuna.pk_comuna
 where pk_comunero=id_comunero
 ;
/*procedimiento para listar tipo de usuario este se usa tanto para un nuevo comunero como para su edicio*/
create procedure listar_tipousuario()
select * from tipousuario;