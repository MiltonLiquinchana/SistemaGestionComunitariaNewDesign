create database ProyectoSistemaAgua;
use ProyectoSistemaAgua;
create table tipousuario(
pk_tipousuario int primary key auto_increment not null,
tipo_usuario varchar(25) not null
);
/*nos sirve para verificar a que provincia pertenece el canton */
create table provincia(
cod_provincia char(10)  primary key  unique not null,
nombre_provincia varchar(100) not null
);
/*tabla nos sirve para saber a que canton pertenece la comuna*/
create table canton(
cod_canton char(10) primary key unique not null,
nombre_canton varchar(100) not null,
fk_provincia char(10) not null,
foreign key(fk_provincia) references provincia(cod_provincia)
);
/*Esta tabla nos sirve para saver a que parroquia pertenece la comuna*/
create table parroquia(
cod_parroquia char(10) primary key unique not null,
nombre_parroquia varchar(100) not null,
fk_canton char(10) not null,
foreign key(fk_canton) references canton(cod_canton)
);
/*Esta tabla nos sirve para registrar a que comuna pertenece el comunero*/
create table comuna(
pk_comuna int primary key auto_increment not null,
nombre_comuna varchar(200) not null,
direccion_comuna varchar(500) DEFAULT NULL,
fk_parroquia char(10) NOT NULL,
foreign key(fk_parroquia) references parroquia(cod_parroquia)
);

/*Tabla para saber si se encuentra activo o inactivo, es para filtrar en caso de que elimine a este comunero
si esta en inactivo sera como si estara eliminado pero no se perderan sus datos*/
create table estadoComunero(
pk_estadoComunero int primary key auto_increment,
estado varchar(10) not null
);

/*Esta tabla sirve para registrar al comunero*/
create table comunero(
pk_comunero int primary key auto_increment not null,
cedula varchar(15) not null unique,
primer_nombre varchar(25) not null,
segundo_nombre varchar(25) not null,
primer_apellido varchar(25) not null,
segundo_apellido varchar(25) not null,
telefono varchar(15) not null,
fecha_nacimiento date not null,
edad int not null,
fk_comuna int not null,
foreign key(fk_comuna) references comuna(pk_comuna),
direccion_vivienda varchar(500),
referencia_geografica varchar(500),
fk_estadoComunero int not null,
foreign key(fk_estadoComunero) references estadoComunero(estadoComunero)
);

create table login(
pk_login int primary key auto_increment not null,
usuario varchar(50) not null unique,
contraseña varchar(25) not null,
fk_tipousuario int not null,
fk_comunero int not null,
foreign key(fk_tipousuario) references tipousuario(pk_tipousuario),
foreign key(fk_comunero) references comunero(pk_comunero)
);

/*para registrar esto se puede hacer condicional si el campo medidor esta vacio aqui no se guarda nada solo se guarda comunero caso contrario
si se guarda aqui, lo mismo se aplica para el login el mismo tipo de condicional*/
create table medidor(
pk_medidor int primary key auto_increment not null,
numero_medidor varchar(30) unique not null,
fecha_conexion date not null,
fk_comunero int not null,
foreign key(fk_comunero) references comunero(pk_comunero)
);

/*Se puede hacer una ventana para guardar un nuevo tipo de consumo esta ventana es opcional(solo para admin general)*/
create table tipoconsumo(
pk_tipoconsumo int primary key auto_increment not null,
tipo_consumo varchar(20) not null,
limitem_cubico int NOT NULL,
valor decimal(8,2) NOT NULL,/**Revisar decimal**/
tarifa_basica decimal(8,2) not null,
tarifa_ambiente decimal(8,2) not null,
alcantarillado decimal(8,2) not null,
fk_comuna int NOT NULL,
 FOREIGN KEY (fk_comuna) REFERENCES comuna (pk_comuna)
);
create table consumo(
pk_consumo int primary key auto_increment not null,
lectura_anterior int not null,
lectura_actual int not null,
fecha_lectura date not null,
fecha_limite_pago date not null,/*Hasta que fecha tiene que pagar sin cargo extra*/
consumo_mcubico int not null,
total_pagar decimal(8,2) not null,
fk_medidor int not null,
fk_tipoconsumo int not null,
foreign key(fk_medidor) references medidor(pk_medidor),
foreign key(fk_tipoconsumo) references tipoconsumo(pk_tipoconsumo)
);

create table multas(
pk_multas int primary key auto_increment not null,
tipo_multa varchar(50) not null,
valor decimal(8,2) not null,
 fk_comuna int NOT NULL,
 FOREIGN KEY (fk_comuna) REFERENCES comuna (pk_comuna)
);

/*nos sirve para el registro de anticipos y saldos pendientes que la persona debe pagar*/
create table saldos(
pk_saldos int primary key auto_increment not null,
tipo_saldo varchar(50) not null,/*pueden ser anticipos o saldos pendientes*/
descripcion varchar(500) not null,
valor decimal(8,2) not null,
fk_comunero int not null,
foreign key(fk_comunero) references comunero(pk_comunero)
);

CREATE TABLE tipo_descuento (
  pk_tipo_descuento int primary key NOT NULL AUTO_INCREMENT,
  tipo_descuento varchar(30) NOT NULL,
  descripcion varchar(300) not null,
  valor_descuento decimal(10,2) NOT NULL,
  fk_comuna int NOT NULL,
  FOREIGN KEY (fk_comuna) REFERENCES comuna(pk_comuna)
);
/*para saber si esta pago incompleto o inpaga*/
CREATE TABLE estado_pagos (
  pk_estado_pagos int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  estado varchar(10) NOT NULL
);

create table cobro_agua(
pk_cobro_agua int primary key auto_increment not null,
fk_consumo int not null,
fecha_cacelacion date not null,/*Fecha en la que se esta cancelando al aguatero*/
dias_retraso int not null,/*Se calcula al verificar la fecha cancelacion con fecha limite
(si fecha de cancelacion es superior a tantos dias comenar a calcular los dias de retraso)*/
fk_multas int not null,
valor_multa decimal(8,2) not null,
tarifa_basicaC decimal(8,2) not null,
tarifa_ambienteC decimal(8,2) not null,
alcantarilladoC decimal(8,2) not null,
totalpagar decimal(8,2) not null,/*Se calcula al multiplicar valor multa por dias retraso + el consumo metros cubicos(revisar doc excel)*/
deposito decimal(8,2) not null,
cambio decimal(8,2) not null,
fk_estado_pagos int not null,
foreign key(fk_consumo) references consumo(pk_consumo),
foreign key(fk_multas) references multas(pk_multas),
foreign key(fk_estado_pagos) references estado_pagos(pk_estado_pagos)
);

/*para registrar el tipo actividad*/
create table tipo_actividad(
pk_tipo_actividad int primary key auto_increment not null,
tipo_Actividad varchar(50) not null,
fk_comuna int NOT NULL,
FOREIGN KEY (fk_comuna) REFERENCES comuna (pk_comuna)
);

/*nos sirve para saber la actividad que se realizo*/
create table actividad(
pk_actividad int primary key auto_increment not null,
fecha_participacion date not null,
descripcion_Actividad varchar(200) not null,
fk_comuna int NOT NULL,
FOREIGN KEY (fk_comuna) REFERENCES comuna (pk_comuna)
);
/*Nos sirve para saber si asistio o no asistio*/
create table estado_asistencia(
pk_estado_asistencia int primary key auto_increment not null,
estado_asistencia varchar(10) not null
);
/*Esta tabla sirve para registrar tanto asistencias de reuniones como mingas*/
create table registros_participacion(
pk_registros_participacion int primary key auto_increment not null,
fk_comunero int not null,
fk_tipo_actividad int not null,
fk_actividad int not null,
fk_estado_asistencia int not null,
foreign key(fk_comunero) references comunero(pk_comunero),
foreign key(fk_tipo_actividad) references tipo_actividad(pk_tipo_actividad),
foreign key(fk_actividad) references actividad(pk_actividad),
foreign key(fk_estado_asistencia) references estado_asistencia(pk_estado_asistencia)
);

/*Esta tabla nos sirve para registrar el cobro de multas por mingas y reuniones*/
create table cobro_participacion(
pk_cobro_participacion int primary key auto_increment not null,
fk_registros_participacion int not null,
fecha_pago date not null,
subtotal decimal(8,2) not null,
fk_multa int not null,
fk_saldos int not null,
total decimal(8,2) not null,
fk_estado_pagos int not null,
foreign key(fk_registros_participacion) references registros_participacion(pk_registros_participacion),
foreign key(fk_multa) references multas(pk_multas),
FOREIGN KEY (fk_saldos) REFERENCES saldos (pk_saldos),
foreign key(fk_estado_pagos) references estado_pagos(pk_estado_pagos)
);

/*tabla para registrar las cuotas que se combran durante el año*/
create table cuotas(
pk_cuotas int primary key auto_increment not null,
fecha_registro date not null,
fecha_limite_pago date not null,
descripcion varchar(250) not null,
valor decimal(8,2) not null,
fk_comuna int NOT NULL,
FOREIGN KEY (fk_comuna) REFERENCES comuna(pk_comuna)
);

/*Esta tabla no sirve para registrar el cobro de las cuotas*/
create table cobro_cuotas(
pk_cobro_cuotas int primary key auto_increment not null,
fk_comunero int not null,
fk_cuotas int not null,
fecha_cancelacion date not null,/*fecha en la que el comunero paga*/
dias_retraso char(10) not null,/*si la fecha en la que paga supera a la fecha limite*/
subtotal decimal(8,2) not null,
fk_saldos int not null,
fk_multas int not null,
total decimal(8,2) not null,
fk_estado_pagos int not null,
foreign key(fk_comunero) references comunero(pk_comunero),
foreign key(fk_cuotas) references cuotas(pk_cuotas),
FOREIGN KEY (fk_saldos) REFERENCES saldos (pk_saldos),
foreign key(fk_multas) references multas(pk_multas),
foreign key(fk_estado_pagos) references estado_pagos(pk_estado_pagos)
);

/*Esta tabla nos sirve para sacar el reporte de agua*/
create table reporte_agua(
pk_reporte_agua int primary key auto_increment not null,
fk_comunero int not null,/*nos sirve para sacar los datos asociados al comunero*/
fk_medidor int not null,
fk_cobro_agua int not null,/*para sacar los datos del agua consumos, total pagado, total saldo pendiente, etc*/
fk_consumo int not null,/*para sacar cuanto consumio*/
foreign key(fk_comunero) references comunero(pk_comunero),
foreign key(fk_medidor) references medidor(pk_medidor),
foreign key(fk_cobro_agua) references cobro_agua(pk_cobro_agua),
foreign key(fk_consumo) references consumo(pk_consumo)
);

/*esta tabla nos sirve para los reportes de participacion*/
create table reporte_participacion(
pk_reporte_participacion int primary key auto_increment not null,
fk_comunero int not null,
fk_registros_participacion int not null,
fk_cobro_participacion int not null,
foreign key(fk_comunero) references comunero(pk_comunero),
foreign key(fk_registros_participacion) references registros_participacion(pk_registros_participacion),
foreign key(fk_cobro_participacion) references cobro_participacion(pk_cobro_participacion)
);

/*esta tabla nos sirve para los reportes de cuotas*/
create table reporte_cuotas(
pk_reporte_cuotas int primary key auto_increment not null,
fk_comunero int not null,
fk_cuotas int not null,
fk_cobro_cuotas int not null,
foreign key(fk_comunero) references comunero(pk_comunero),
foreign key(fk_cuotas) references cuotas(pk_cuotas),
foreign key(fk_cobro_cuotas) references cobro_cuotas(pk_cobro_cuotas)
);

/*tabla para guardar configuraciones varias*/
create table LimiteDias(
pk_LimiteDias int primary key auto_increment not null,
LimiteDias int not null,
fk_comuna int not null,
foreign key(fk_comuna) references comuna(pk_comuna)
)