/*
UNIVERSIDAD CATOLICA DE EL SALVADOR
FACULTAD DE CIENCIAS EMPRESARIALES
LICENCIATURA EN SISTEMAS INFORMÁTICOS ADMINISTRATIVOS
GESTIÓN DE BASE DE DATOS II – CICLO II 2019
CATEDRÁTICO: LICDO. EDGAR AVILÉS

Guía de aplicación de: Triggers con Oracle 11g

Objetivo: Desarrollar la capacidad de análisis de los estudiantes para la creación de disparadores, como
medida de seguridad en un entorno de Base de Datos.

1. Crear la tabla AUDITORIA_AEROLINEA_U, y ejecutar la creación de la estructura de la tabla, tal cual
se le presenta en el segundo apartado de este ítem. Seguidamente al crear la tabla, desarrollar un
Trigger de “actualización después”; que permita copiar los datos antiguos de la tabla T_AEROLINEA,
a la tabla AUDITORIA_AEROLINEA_U; después de realizar la actualización de los datos en la tabla
T_AEROLINEA. Colocar el nombre del trigger de la siguiente manera: TRI_AU_AUDIT_AEROLINEA
*/

-- CREACIÓN DE TABLA AUDITORIA_AEROLINEA_U 

CREATE TABLE AUDITORIA_AEROLINEA_U (
codigo_aerolinea CHAR(3) NOT NULL,
nombre_aerolinea VARCHAR2(50) NOT NULL,
direccion_aerolinea VARCHAR2(100) NOT NULL,
telefono1_aerolinea CHAR(20) NOT NULL,
telefono2_aerolinea CHAR(20) NOT NULL,
email_aerolinea VARCHAR2(50) NOT NULL,
website_aerolinea VARCHAR2(100) NOT NULL,
codigo_pais CHAR(3) NOT NULL,
usuario	VARCHAR2(20) NOT NULL,
ip	VARCHAR2(20) NOT NULL,
fecha_actualizacion_registro TIMESTAMP(6) NOT NULL);
    
-- TRITGER 1 = TRI_AU_AUDIT_AEROLINEA

create or replace TRIGGER TRI_AU_AUDIT_AEROLINEA
AFTER UPDATE ON t_aerolinea
    FOR EACH ROW
DECLARE
    var_usuario varchar2(20);
BEGIN
    SELECT USER INTO var_usuario FROM DUAL;
    INSERT INTO auditoria_aerolinea_u
    (codigo_aerolinea, nombre_aerolinea, direccion_aerolinea, telefono1_aerolinea, telefono2_aerolinea,
    email_aerolinea, website_aerolinea, codigo_pais, usuario, ip, fecha_actualizacion_registro)
    VALUES (:old.codaero, :old.nombaereo, :old.diraereo, :old.tel1aereo, :old.tel2aereo, 
    :old.emailaereo, :old.websiteaereo, :old.t_pais_codpa, var_usuario, SYS_CONTEXT('USERENV','IP_ADDRESS',15),SYSDATE);
END;

/*
2.Crear la tabla AUDITORIA_VUELOCOMERCIAL_D, y ejecutar la creación de la estructura de la tabla,
tal cual se le presenta en el segundo apartado de este ítem. Seguidamente al crear la tabla, desarrollar
un Trigger de “eliminación después”; que permita copiar los datos antiguos de la tabla T_VUECOM, a
la tabla AUDITORIA_VUELOCOMERCIAL_D; después de realizar la eliminación de los datos en la
tabla T_VUECOM. Colocar el nombre del trigger de la siguiente manera: TRI_AD_AUDIT_VUECO
*/

-- CREACIÓN DE TABLA AUDITORIA_VUELOCOMERCIAL_D

CREATE TABLE AUDITORIA_VUELOCOMERCIAL_D (
    codvucomercial NUMBER(5) NOT NULL,
    f_desp TIMESTAMP(6) NOT NULL,
    f_ater TIMESTAMP(6) NOT NULL,
    aeropuerto_d VARCHAR2(50) NOT NULL,
    ciudad_d VARCHAR2(50) NOT NULL,
    distancia_km NUMBER(6) NOT NULL,
    codigo_avion CHAR(4) NOT NULL,
    codigo_aerolinea CHAR(3) NOT NULL,
    usuario VARCHAR2(20) NOT NULL,
    ip VARCHAR2(20) NOT NULL,
    fecha_eliminacion_registro TIMESTAMP(6) NOT NULL);

-- TRIGGER 2 = TRI_AD_AUDIT_VUECO

create or replace TRIGGER TRI_AD_AUDIT_VUECO
    AFTER DELETE ON t_vuecom
    FOR EACH ROW
DECLARE
    var_usuario VARCHAR2(20);
BEGIN
    SELECT USER INTO var_usuario FROM DUAL;
    INSERT INTO auditoria_vuelocomercial_d
    (codvucomercial, f_desp, f_ater, aeropuerto_d, ciudad_d,
    distancia_km, codigo_avion, codigo_aerolinea, usuario, ip, fecha_eliminacion_registro)
    VALUES (:old.codvuecom, :old.fechrdespvuecom, :old.fechrdesatvuecom, :old.aeroputvuecom, :old.ciuddesvuecom, 
    :old.distkmvucom, :old.t_avion_codavion, :old.t_aerolinea_codaero, var_usuario, SYS_CONTEXT('USERENV','IP_ADDRESS',15), SYSDATE);
END;

/*
3. Crear la tabla AUDITORIA_PASAJERO, y ejecutar la creación de la estructura de la tabla, tal cual se le
presenta en el segundo apartado de este ítem. Seguidamente al crear la tabla, construir una vista que
posea toda la estructura de campos de la tabla T_PASAJERO. Definir el nombre de la vista con el
nombre “V_PASAJERO”, y desarrollar un Trigger de “actualización y eliminación después”; que
permita agregar los datos actualizados y eliminados de los pasajeros de la vista V_PASAJERO, a la
tabla AUDITORIA_PASAJERO; después de realizar la eliminación o actualización de los datos en la 
vista V_PASAJERO. Colocar el nombre del trigger de la siguiente manera:
TRI_DU_AUDITORIA_PASAJERO
*/

-- CREACIÓN DE TABLA AUDITORIA_PASAJERO

CREATE TABLE AUDITORIA_PASAJERO (
pasaporte_pasajero CHAR(20) NOT NULL,
nombre_pasajero VARCHAR2(30) NOT NULL,
apellido_pasajero VARCHAR2(30) NOT NULL,
fechanac_pasajero DATE NOT NULL,
direccion_pasajero VARCHAR2(50) NOT NULL,
telfij_pasajero CHAR(20) NOT NULL,
telmov_pasajero CHAR(20) NOT NULL,
evento VARCHAR2(20) NOT NULL,
usuario VARCHAR2(20) NOT NULL,
ip VARCHAR2(20) NOT NULL,
fecha_evento TIMESTAMP(6) NOT NULL);

-- VISTA = V_PASAJERO

CREATE VIEW V_PASAJERO
AS SELECT pasapjero, nomjero, apejero, fecjero, dirjero, telfijero, telmovjero 
FROM t_pasajero;

-- TRIGER 3 = TRI_DU_AUDITORIA_PASAJERO

create or replace TRIGGER TRI_DU_AUDITORIA_PASAJERO
    INSTEAD OF DELETE OR UPDATE
    ON V_PASAJERO
    FOR EACH ROW
DECLARE
    var_usuario VARCHAR2(20);
BEGIN
    SELECT USER INTO var_usuario FROM DUAL;
    -- CONDICIONES 
    -- ELIMINACIÓN
    IF DELETING THEN
    INSERT INTO auditoria_pasajero 
    (pasaporte_pasajero, nombre_pasajero, apellido_pasajero, fechanac_pasajero, direccion_pasajero, telfij_pasajero,
    telmov_pasajero, evento, usuario, ip, fecha_evento)
    VALUES (:old.pasapjero, :old.nomjero, :old.apejero, :old.fecjero, :old.dirjero, :old.telfijero, 
    :old.telmovjero, 'Eliminación', var_usuario, SYS_CONTEXT('USERENV', 'IP_ADDRESS',15),SYSDATE);
    END IF;
    -- ACTUALIZACIÓN
    IF UPDATING THEN
    INSERT INTO auditoria_pasajero
    (pasaporte_pasajero, nombre_pasajero, apellido_pasajero, fechanac_pasajero, direccion_pasajero, telfij_pasajero, 
    telmov_pasajero, evento, usuario, ip, fecha_evento)
    VALUES (:old.pasapjero, :old.nomjero, :old.apejero, :old.fecjero, :old.dirjero, :old.telfijero, 
    :old.telmovjero, 'Actualización', var_usuario, SYS_CONTEXT('USERENV','IP_ADDRESS',15), SYSDATE);
    END IF;
END;

/*
4. Ejecutar la creación de un trigger de “inserción antes”, asociado a la tabla T_CARGA; el trigger
permitirá evaluar la inserción de registros solo en los días de Lunes a Viernes; y en un horario de oficina
(5:00 AM – 17:59 PM). Defina el nombre del trigger de la siguiente manera: TRI_BI_CARGA
*/

-- TRIGER 4 = TRI_BI_CARGA

create or replace TRIGGER TRI_BI_CARGA
    BEFORE INSERT ON t_carga
    FOR EACH ROW
DECLARE
BEGIN
    -- CONDICIÓN
    IF (to_char (SYSDATE, 'DY') IN ('SAB','DOM')) OR (to_char (SYSDATE, 'HH24:MI')
    BETWEEN '18:00' AND '4:59') THEN
        RAISE_APPLICATION_ERROR (-20500, 'Solo insertar datos en horas de trabajo y en días establecidos');
    END IF;
END;

-- PRUEBA TRIGGER 4

INSERT INTO t_carga (codcarga, nomcarga) VALUES ('705','Almohadas');

-- EJERCICIO CON EXITO

/*
5. Desarrolle un trigger de “actualización después” que permita insertar los datos antiguos de la tabla
T_FABRICAN, en una tabla de auditoria. Respete el uso de nomenclatura en la definición del nombre
de la tabla de auditoria y el trigger.
*/

-- CREACIÓN DE TABLA AUDITORIA_FABRICAN

CREATE TABLE AUDITORIA_FABRICAN(
codigo_fabrican CHAR(3) NOT NULL,
nombre_fabrican VARCHAR2(30) NOT NULL,
direccion_fabrican VARCHAR2(50) NOT NULL,
telefono1_fabrican CHAR(20) NOT NULL,
telefono2_fabrican CHAR(20) NOT NULL,
email_fabrican VARCHAR2(50) NOT NULL,
website_fabrican VARCHAR2(100) NOT NULL,
codigo_pais CHAR(3) NOT NULL,
usuario VARCHAR2(20) NOT NULL,
ip VARCHAR2(20) NOT NULL,
fecha_actualizacion_registro TIMESTAMP(6) NOT NULL);

-- TRIGGER 5 = TRI_AU_AUDIT_FABRICAN

create or replace TRIGGER TRI_AU_AUDIT_FABRICAN
    AFTER UPDATE ON t_fabrican
    FOR EACH ROW
DECLARE
    var_usuario VARCHAR2(20);
BEGIN
    SELECT USER INTO var_usuario FROM DUAL;
    INSERT INTO auditoria_fabrican
    (codigo_fabrican, nombre_fabrican, direccion_fabrican, telefono1_fabrican, telefono2_fabrican, 
    email_fabrican, website_fabrican, codigo_pais, usuario, ip, fecha_actualizacion_registro)
    VALUES (:old.cofabri, :old.nomfabri, :old.dirfabri, :old.tel1fabri, :old.tel2fabri, :old.emailfabri, 
    :old.websitefabri, :old.t_pais_codpa, var_usuario, SYS_CONTEXT('USERENV','IP_ADDRESS',15),SYSDATE);
END;

/*
6. Desarrolle un trigger de “inserción antes”, asociado a la tabla T_FABRICAN; el trigger permitirá
evaluar la inserción de registros solo en los días de Lunes a Viernes; y en un horario de oficina (5:00
AM – 17:59 PM). Respete el uso de nomenclatura en la definición del nombre del trigger.
*/

-- TRIGGER 6 = TRI_BI_FABRICAN

create or replace TRIGGER TRI_BI_FABRICAN
    BEFORE INSERT ON t_fabrican
    FOR EACH ROW
DECLARE
BEGIN
    -- CONDICIÓN
    IF (to_char(SYSDATE, 'DY') IN ('SAB','DOM')) OR (to_char(SYSDATE, 'HH24:MI')
    BETWEEN '18:00' AND '4:59') THEN
        RAISE_APPLICATION_ERROR(-20500, 'Ingrese datos en horas establecidas y días de trabajo');
    END IF;
END;

-- PRUEBA

INSERT INTO t_fabrican (cofabri, nomfabri, dirfabri, tel1fabri, tel2fabri, emailfabri, websitefabri, t_pais_codpa)
VALUES ('120','Geovanny_Santos','Concepción de Ataco', '7050-8090','70805040','geovanisantos@gmail.com','https://www.geoservices.com','A15');

-- PRUEBA CON EXITO

/*
7. Construya un trigger de “eliminación después”; que permita copiar los datos antiguos de la tabla T_
T_DETVUCG, a una tabla de auditoria después de realizar la eliminación de los datos en la tabla
primaria. Respete el uso de nomenclatura en la definición del nombre de la tabla de auditoria y el
trigger.
*/

-- CREACIÓN DE TABLA  AUDITORIA_DETVUELOCARGA

CREATE TABLE AUDITORIA_DETVUELOCARGA (
codigo_detvuelocarga NUMBER(6,0) NOT NULL,
precio_detvuelocarga NUMBER(5,0) NOT NULL,
descripcion_detvuelocarga VARCHAR2(200) NOT NULL,
costo_detvuelocarga NUMBER(10,2) NOT NULL,
codigo_vuelocarga NUMBER(5,0) NOT NULL,
codigo_carga CHAR(4) NOT NULL,
usuario VARCHAR2(20) NOT NULL,
ip VARCHAR2(20) NOT NULL,
fecha_eliminacion_registro TIMESTAMP(6) NOT NULL);

-- TRIGER 7 = TRI_AD_AUDIT_DETVUCG

create or replace TRIGGER TRI_AD_AUDIT_DETVUCG
    AFTER DELETE ON t_detvucg
    FOR EACH ROW
DECLARE
    var_usuario VARCHAR2(20);
BEGIN
    SELECT USER INTO var_usuario FROM DUAL;
    INSERT INTO auditoria_detvuelocarga
    (codigo_detvuelocarga, precio_detvuelocarga, descripcion_detvuelocarga, costo_detvuelocarga,
    codigo_vuelocarga, codigo_carga, usuario, ip, fecha_eliminacion_registro)
    VALUES (:old.coddetvucg, :old.pcdetvucg, :old.descripdetvucg, :old.costodetvucg, 
    :old.t_vuecg_codvuecg, :old.t_carga_codcarga, var_usuario, SYS_CONTEXT('USERENV','IP_ADDRESS',15),SYSDATE);
END;

/*
8. Defina una nueva vista total de todos los campos de la tabla T_AVION, y construya un trigger que
permita copiar los datos eliminados y/o actualizados a una tabla de auditoria. Respete el uso de
nomenclatura en la definición del nombre de la tabla de auditoria, la vista y el trigger.
*/

-- CREACIÓN DE TABLA AUDITORIA_AVION

CREATE TABLE AUDITORIA_AVION (
codigo_avion CHAR(4) NOT NULL,
matricula_avion CHAR(15) NOT NULL,
modelo_avion VARCHAR2(30) NOT NULL,
cargaUtil_avion NUMBER(10,2) NOT NULL,
distancia_avion NUMBER(10,2) NOT NULL,
codigo_fabrican CHAR(3) NOT NULL,
codigo_tipoavion CHAR(2) NOT NULL,
evento VARCHAR2(20) NOT NULL,
usuario VARCHAR2(20) NOT NULL,
ip VARCHAR2(20) NOT NULL,
fecha_evento TIMESTAMP(6) NOT NULL);

-- VISTA = V_AVION

CREATE VIEW V_AVION
AS SELECT codavion, matriavion, modavion, cuavion, diskavion, t_fabrican_cofabri, t_tipoavion_codtipoavion
FROM t_avion;

-- TRIGGER 8 = TRI_DU_AUDITORIA_AVION

create or replace TRIGGER TRI_DU_AUDITORIA_AVION
    INSTEAD OF DELETE OR UPDATE
    ON V_AVION
    FOR EACH ROW
DECLARE
    var_usuario VARCHAR2(20);
BEGIN
    SELECT USER INTO var_usuario FROM DUAL;
    -- CONDICIÓN
    -- ELIMINACIÓN
    IF DELETING THEN
    INSERT INTO auditoria_avion 
    (codigo_avion, matricula_avion, modelo_avion, cargaUtil_avion, distancia_avion, codigo_fabrican, 
    codigo_tipoavion, evento, usuario, ip, fecha_evento) 
    VALUES (:old.codavion, :old.matriavion, :old.modavion, :old.cuavion, :old.diskavion, :old.t_fabrican_cofabri, 
    :old.t_tipoavion_codtipoavion,'Eliminación', 'var_usuario', SYS_CONTEXT('USERENV','IP_ADDRESS',15),SYSDATE);
    END IF;
    IF UPDATING THEN
    INSERT INTO auditoria_avion 
    (codigo_avion, matricula_avion, modelo_avion, cargaUtil_avion, distancia_avion, codigo_fabrican, 
    codigo_tipoavion, evento, usuario, ip, fecha_evento) 
    VALUES (:old.codavion, :old.matriavion, :old.modavion, :old.cuavion, :old.diskavion, :old.t_fabrican_cofabri, 
    :old.t_tipoavion_codtipoavion,'Actualización', 'var_usuario', SYS_CONTEXT('USERENV','IP_ADDRESS',15),SYSDATE);
    END IF;
END;