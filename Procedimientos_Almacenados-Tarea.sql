/*
UNIVERSIDAD CATOLICA DE EL SALVADOR
FACULTAD DE CIENCIAS EMPRESARIALES
LICENCIATURA EN SISTEMAS INFORM�TICOS ADMINISTRATIVOS
GESTI�N DE BASE DE DATOS II � CICLO II 2019
CATEDR�TICO: LICDO. EDGAR AVIL�S

Gu�a de aplicaci�n de: Procedimientos Almacenados y Funciones con Oracle 11g

Objetivo: Desarrollar la capacidad de an�lisis de los estudiantes para la creaci�n de procedimientos almacenados,
como medidas de seguridad y rendimiento en un entorno de Base de Datos, con Oracle 11g.
------------------------
1. Digite el siguiente c�digo PL/SQL; que permite ejecutar la actualizaci�n del costo del vuelo
comercial, en base al c�digo de vuelo y a la clase en la cual viaja el pasajero. */
create or replace PROCEDURE sp_update_cost_detvucom
(codvuelocomer IN NUMBER, clasevuelocomer IN CHAR, costdet_vucom IN NUMBER)
AS
BEGIN
 UPDATE t_detvucom SET COSTODETVUCOM = costdet_vucom
 WHERE T_VUECOM_CODVUECOM = codvuelocomer
 AND CLASEDETVUCOM = clasevuelocomer;
END;

/* 2. Desarrolle el siguiente bloque de c�digo PL/SQL; el cual permitir� actualizar el costo de transporte
de una determinada carga, en base al c�digo del vuelo; y al tipo de carga transportado en base al
c�digo del mismo. */
create or replace PROCEDURE sp_update_carga_detvucg (costocarg IN NUMBER,
codvuelo IN NUMBER, codigcarga IN CHAR)
AS
BEGIN
 UPDATE t_detvucg SET COSTODETVUCG = costocarg WHERE
T_VUECG_CODVUECG = codvuelo AND T_CARGA_CODCARGA = codigcarga;
END;

/*3. Construya el bloque siguiente de c�digo PL/SQL; el cual permitira la adici�n de nuevas cargas a la
tabla cargas. */
create or replace PROCEDURE SP_INSERT_T_CARGA (codigo_carga IN CHAR,
nombre_carga IN VARCHAR2)
IS
BEGIN
 INSERT INTO T_CARGA (codcarga, nomcarga) values (codigo_carga, nombre_carga);
END;

/* 4. Cree el siguiente procedimiento almacenado, el cual le permitir� eliminar el detalle de vuelo de un
determinado pasajero en base a su n�mero de pasaporte. */
create or replace PROCEDURE SP_DELETE_T_DETVUCOM(num_pasaporte IN CHAR)
IS
BEGIN
 DELETE FROM t_detvucom where T_PASAJERO_PASAPJERO = num_pasaporte;
END;

/* 5. Digite el c�digo PL/SQL adecuado, para poder adicionar un nuevo registro en la tabla aerol�neas. */
create or replace PROCEDURE SP_INSERT_T_AEROLINEA
(codigo_aerolinea IN CHAR, nombre_aerolinea IN VARCHAR2, direccion_aerolinea IN VARCHAR2, telefono1_aerolinea IN CHAR, telefono2_aerolinea IN CHAR,
email_aerolinea IN VARCHAR2, website_aerolinea IN VARCHAR2, codigo_pais IN CHAR)
AS
BEGIN
    INSERT INTO t_aerolinea (codaero, nombaereo, diraereo, tel1aereo, tel2aereo, emailaereo, websiteaereo, t_pais_codpa) 
    VALUES (codigo_aerolinea, nombre_aerolinea, direccion_aerolinea, telefono1_aerolinea, telefono2_aerolinea,
    email_aerolinea, website_aerolinea, codigo_pais);
END;
/* 6. Desarrolle un procedimiento almacendo; que permita adicionar una nueva aeronave; a la tabla
avi�n. */
create or replace PROCEDURE SP_INSERT_T_AVION
(codigo_avion IN CHAR, matricula_avion IN CHAR, modelo_avion IN VARCHAR2, cargaUtil_avion IN NUMBER, distancia_avion IN NUMBER,
codigo_fabrican IN CHAR, codigo_tipoavion IN CHAR)
AS
BEGIN
    INSERT INTO t_avion (codavion, matriavion, modavion, cuavion, diskavion, t_fabrican_cofabri, t_tipoavion_codtipoavion)
    VALUES (codigo_avion, matricula_avion, modelo_avion, cargaUtil_avion, distancia_avion,
    codigo_fabrican, codigo_tipoavion);
END;

/* 7. Construya el c�digo PL/SQL necesario para poder eliminar el detalle de transporte, de una
determinada carga en base a: El c�digo del vuelo de carga, y el c�digo de la carga en especif�co. */
create or replace PROCEDURE SP_DELETE_T_CARGA_T_DETVUCG
(codigo_detalleVueloCarga IN NUMBER, codigo_carga IN CHAR)
IS
BEGIN
    DELETE FROM t_detvucg WHERE coddetvucg = codigo_detalleVueloCarga AND t_carga_codcarga = codigo_carga;
END;

/* 8. Implemente dos procedimientos almacenados; que permitan realizar la actualizaci�n de la ciudad
de destino y aeropuerto; de los vuelos comerciales, y vuelos de carga respectivamente. */
create or replace PROCEDURE  SP_UPDATE_T_VUECG
(ciudadDestino_vuecg IN VARCHAR2, aeropuerto_vuecg IN VARCHAR2)
AS
BEGIN
    UPDATE t_vuecg SET ciuddesvuecg = ciudadDestino_vuecg
    WHERE aeroputvuecg = aeropuerto_vuecg; 
END;

create or replace PROCEDURE  SP_UPDATE_T_VUECOM
(ciudadDestino_vuecom IN VARCHAR2, aeropuerto_vuecom IN VARCHAR2)
AS
BEGIN
    UPDATE t_vuecom SET ciuddesvuecom = ciudadDestino_vuecom
    WHERE aeroputvuecom = aeropuerto_vuecom; 
END;