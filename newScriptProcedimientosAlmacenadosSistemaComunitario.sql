/*PROCEDIMIENTOS ALMACENADOS NUEVOS EN EL NUEVO PROYECTO*/

/*procedimiento almacenado consulta comunero se usa para listar los comuneros de la comuna a la que pertenece, y los que si estan activos*/
create procedure consulta_comunero(id_comuna int)
select pk_comunero,cedula,primer_nombre,segundo_nombre,
primer_apellido,segundo_apellido,telefono,edad 
from comunero
join comuna
on fk_comuna=pk_comuna
where fk_comuna=id_comuna and fk_estadoComunero=1
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

/*procedimiento almacenado para guardar, acualizar, u eliminar usuario*/
Delimiter $$
create procedure GuardarActualizarEliminar(
accion varchar(10),
pk_comuner varchar(7),
cedul varchar(15),
primer_nombr varchar(25) ,
segundo_nombr varchar(25),
primer_apellid varchar(25),
segundo_apellid varchar(25),
telefon varchar(15),
fecha_nacimient date,
eda int,
fk_comun int,
direccion_viviend varchar(500),
referencia_geografic varchar(500),
usuari varchar(50),
contrase varchar(25),
fk_tipousuari int
)
begin
if accion="Guardar" then
insert into comunero(cedula,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,telefono,fecha_nacimiento,edad,fk_comuna,direccion_vivienda,referencia_geografica,fk_estadoComunero)
				values(cedul,primer_nombr,segundo_nombr,primer_apellid,segundo_apellid,telefon,fecha_nacimient,eda,fk_comun,direccion_viviend,referencia_geografic,1);
                insert into login(usuario,contraseña,fk_tipousuario,fk_comunero)
							values(usuari,contrase,fk_tipousuari,(select pk_comunero from comunero where cedula=cedul));
elseif accion="Actualizar" then
update comunero set 
cedula =cedul,
primer_nombre = primer_nombr,
segundo_nombre = segundo_nombr,
primer_apellido = primer_apellid,
segundo_apellido = segundo_apellid,
telefono = telefon,
fecha_nacimiento = fecha_nacimient,
edad = eda,
fk_comuna = fk_comun,
direccion_vivienda = direccion_viviend,
referencia_geografica = referencia_geografic 
where pk_comunero=pk_comuner;
update login set usuario=usuari,contraseña=contrase,fk_tipousuario=fk_tipousuari where fk_comunero=pk_comuner;
elseif accion="Eliminar" then
update comunero set fk_estadoComunero=2 where pk_comunero=pk_comuner;
end if;
end$$
DELIMITER $$;



/*procedimiento almacenado para consultar los datos del comunero por su cedula u nombres, este procedimiento 
nos sirve para poder hacer el guardado del consumo en la bd*//*****************************************
establecer que solo se pueda consultar de la misma comuna********************************************/
create procedure consultaDatosComunero(dato varchar(300),fk_comun int)
select pk_comunero,cedula,primer_nombre, segundo_nombre,primer_apellido,segundo_apellido from comunero 
where (cedula=dato or CONCAT(primer_nombre," ",segundo_nombre," ",primer_apellido," ",segundo_apellido) = dato) and fk_comuna=fk_comun;

/*este procedimiento almacenado nos sirve para listar los medidores que tiene una persona, esto se ejecuta al mismo tiempo de haber ejecutado el
procedimiento almacenado para listar los datos basicos del comunero por su cedula*/
create procedure consultaMedidoresComunero(dato varchar(300))
select pk_medidor,numero_medidor from medidor where fk_comunero=(select pk_comunero from comunero where cedula=dato or CONCAT(primer_nombre," ",segundo_nombre," ",primer_apellido," ",segundo_apellido) = dato);

/*procedimiento almacenado para seleccionar el maximo consumo de un medidor*/
create procedure consultarmaximoConsumo(pk_medid int)
select max(lectura_actual) as lectura_actual from consumo where fk_medidor=pk_medid;

 /*procedimiento almacenado para consultar cuantos tipos de consumo tiene cada comuna*/
 create procedure consultaTipoConsumo(fk_comun int)
 select pk_tipoconsumo,tipo_consumo,limitem_cubico,valor,tarifa_basica,tarifa_ambiente,alcantarillado
 from tipoconsumo
 where fk_comuna=fk_comun
 order by limitem_cubico asc;
 
 /*procedimiento almacenado para consultar el numero de dias a aumentar a la fecha actual
 este sirve para definir una fecha limite de pago*/
create procedure consultaLimiteDias(fk_comun int)
select LimiteDias from LimiteDias
where fk_comuna=fk_comun;

/*procedimiento almacenado para guardar el consumo para ejecutar este procedimiento debe aber datos en las tablas relacionadas*/
Delimiter $$
create procedure guardarConsumo(
lectura_ante int,
lectura_actual int,
fecha_lectu varchar(15),
fecha_limit varchar(15),
consumo_mcubic int,
total_pag double,
fk_medido int,
fk_tipoconsum int,
fk_comun int)
BEGIN
insert into consumo (lectura_anterior,lectura_actual,fecha_lectura,fecha_limite_pago,consumo_mcubico,total_pagar,fk_medidor,fk_tipoconsumo)
values(lectura_ante,lectura_actual,fecha_lectu,fecha_limit,consumo_mcubic,total_pag,fk_medido,fk_tipoconsum);
insert into cobro_agua(
fk_consumo,
fecha_cacelacion,
dias_retraso,
fk_multas,
valor_multa,
tarifa_basicaC,
tarifa_ambienteC,
alcantarilladoC,
totalpagar,
deposito,
cambio,
fk_estado_pagos) 
values((select max(pk_consumo) as pk_consumo from consumo where fk_medidor=fk_medido),fecha_limit,0,1,0,
(select tarifa_basica from tipoconsumo where pk_tipoconsumo=fk_tipoconsum),
(select tarifa_ambiente from tipoconsumo where pk_tipoconsumo=fk_tipoconsum),
(select alcantarillado from tipoconsumo where pk_tipoconsumo=fk_tipoconsum),
total_pag,
0,0,2);
end $$
DELIMITER $$;

/*procedimiento almacenado para buscar l que aun no estan cancelados*/
DELIMITER $$
create procedure buscarConsumoImpaga(pk_medid int)
begin
select pk_consumo,fecha_lectura
from consumo join cobro_agua
on consumo.pk_consumo=cobro_agua.fk_consumo
where fk_medidor=pk_medid and fk_estado_pagos=2;
end$$
DELIMITER $$;

/*procedimiento almacenado para consultar los datos del consumo seleccionado*/
DELIMITER $$
create procedure buscarDatosConsumoImpaga(fk_consum int,fk_comun int)
begin
select consumo_mcubico,tipo_consumo,fecha_lectura, fecha_limite_pago,total_pagar as subtotal,
(if(curdate()>fecha_limite_pago,"Retraso","Sin Recargo"))as tipo_multa,
(
if(curdate()>fecha_limite_pago,(select valor from multas 
 where tipo_multa="Retraso"
and fk_comuna=fk_comun),"0")
)as valor_multa,tarifa_ambiente,alcantarillado from consumo
join tipoconsumo
on pk_tipoconsumo=fk_tipoconsumo
where pk_consumo=fk_consum;
end$$
DELIMITER $$;

/*procedimiento almacenado para guardar el pago del consumo*/
create procedure guardarPagoConsumo(
dias_retras int, 
valor_totalmulta double,
total_pagado double,
fk_consum int,
fk_comun int,
deposit double,
cambi double)
update cobro_agua set fecha_cacelacion=curdate(),dias_retraso=dias_retras,
fk_multas=(select if(curdate()>(select fecha_limite_pago from consumo where pk_consumo=fk_consum),
(select pk_multas from multas where tipo_multa="Retraso" and fk_comuna=fk_comun),1)),
valor_multa=valor_totalmulta,
totalpagar=total_pagado,
deposito=deposit,
cambio=cambi,
fk_estado_pagos=1
where fk_consumo=fk_consum;

/*procedimiento almacenado para consultar datos para la factura,
modificar es****************************************************************************************************
este procedimiento almacenado debe consultar el ttarifa ambiente, alcantarillado de la misma tabla
esto en caso de reimprecion de factura, por eso se debe remodificar la tabla cobro de agua
y agregar esas columnas*/
create procedure consultaDatosFactura(pk_consum int)
select primer_apellido, segundo_apellido, primer_nombre, segundo_nombre, cedula, telefono,direccion_vivienda,
numero_medidor, fecha_lectura,fecha_limite_pago,lectura_anterior, lectura_actual,tipo_consumo,consumo_mcubico,tarifa_basicaC,
consumo.total_pagar as subtotal,tarifa_ambienteC, alcantarilladoC,tipo_multa,dias_retraso,valor_multa as total_multa, 
cobro_agua.totalpagar,deposito,cambio from comunero
join medidor
on pk_comunero=fk_comunero
join consumo
on pk_medidor=fk_medidor
join tipoconsumo
on pk_tipoconsumo=fk_tipoconsumo
join cobro_agua
on pk_consumo=fk_consumo
join multas
on pk_multas=fk_multas
where pk_consumo=pk_consum;



/*procedimiento almacenado para mostrar el conteo de cuantos pagos hay, este valor se usara para generar el numero de factura*/
create procedure numFac(
fk_comun int
)
select count(pk_cobro_agua) as conteo from cobro_agua
join consumo
on pk_consumo=fk_consumo
join medidor
on pk_medidor=fk_medidor
join comunero
on pk_comunero=fk_comunero
where fk_comuna=fk_comun and fk_estado_pagos=1;

/*corregir problema de update cuando no tiene usuario ni contraseña, no se guarda*/
/*agregar mensaje que avise si se configuro un limite de dias*/
select * from cobro_agua;
/*hola como estas*/
