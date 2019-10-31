/*UNIVERSIDAD CATOLICA DE EL SALVADOR
FACULTAD DE CIENCIAS EMPRESARIALES
LICENCIATURA EN SISTEMAS INFORMÁTICOS ADMINISTRATIVOS
GESTIÓN DE BASE DE DATOS II – CICLO II 2019
CATEDRÁTICO: LICDO. EDGAR AVILÉS

Guía de aplicación de: Funciones con Oracle 11g

Objetivo: Desarrollar la capacidad de análisis de los estudiantes para la creación de procedimientos almacenados,
como medidas de seguridad y rendimiento en un entorno de Base de Datos, con Oracle 11g.

Nota: Para habilitar la salida de DBMS, digite el siguiente comando set serveroutput on;*/

SET SERVEROUTPUT ON ;

/* 1. Se necesita calcular el importe total en $ del costo de transporte de un determinado vuelo de
carga; (Sumatoria de los costos de vuelo, de todas las cargas, de un determinado vuelo). Para
implementar está funcioalidad, digite el código correspondiente a la siguiente función; y pruebe la
función a través de un bloque de código anónimo. */

-- Función que devuelve el importe total en $, del transporte de carga de un determinado vuelo --
create or replace FUNCTION FU_importe_total_vuelocarga(codvuelo IN NUMBER)
    RETURN NUMBER
AS
    var_importetotal NUMBER(12,2);
BEGIN
    SELECT sum(costodetvucg) INTO var_importetotal FROM t_detvucg
    WHERE t_vuecg_codvuecg = codvuelo;
    RETURN var_importetotal;
END;

-- BLOQUE ANÓNIMO --
DECLARE
    var_costototal t_detvucg.costodetvucg%TYPE;
BEGIN
    var_costototal := fu_importe_total_vuelocarga(1);
    DBMS_OUTPUT.PUT_LINE('El costo total de transpote del vuelo es de: $'||var_costototal);
END;

/* 2. Se necesita calcular el valor monetario que poseen todas las cargas (Sumatoria de los precios de
costos de las cargas, de un determinado vuelo), que son transportas en un vuelo en especifico. */
create or replace FUNCTION FU_importe_total_cargas(codvuelo IN NUMBER)
    RETURN NUMBER
AS
    var_importetotal NUMBER(12,2);
BEGIN
    SELECT sum(pcdetvucg) INTO var_importetotal FROM t_detvucg
    WHERE t_vuecg_codvuecg = codvuelo;
    RETURN var_importetotal;
END;

-- BLOQUE ANÓNIMO --
DECLARE
    var_PrecioTotal t_detvucg.pcdetvucg%TYPE;
BEGIN
    var_PrecioTotal:= FU_importe_total_cargas(1);
    DBMS_OUTPUT.PUT_LINE('EL precio total de las cargas del vuelo es de: $'||var_PrecioTotal);
END;

/* 3. Se necesita calcular el importe total del costo, de todos los boletos de un determinado vuelo.*/
create or replace FUNCTION FU_importe_boletos_vuecom(codvuelo IN NUMBER)
    RETURN NUMBER
AS
    var_importetotal NUMBER(12,2);
BEGIN
    SELECT sum(costodetvucom) INTO var_importetotal FROM t_detvucom
    WHERE t_vuecom_codvuecom = codvuelo;
    RETURN var_importetotal;
END;

-- BLOQUE ANÓNIMO --
DECLARE
    var_costoboleto t_detvucom.costodetvucom%TYPE;
BEGIN
    var_costoboleto := FU_importe_boletos_vuecom(2);
    DBMS_OUTPUT.PUT_LINE('el costo total de todos los boletos es de : $'||var_costoboleto);
END;

/* 4. Contar el número total de aviones, correspondiente a una aerolínea*/
create or replace FUNCTION FU_count_avion_aerolinea(cod_aero IN CHAR)
RETURN NUMBER
AS
    var_totalAviones NUMBER(12,2);    
BEGIN
    SELECT count(t_avion_codavion) INTO var_totalAviones FROM t_avioaereo
    WHERE t_aerolinea_codaero = cod_aero;
    return var_totalaviones;
END;

-- BLOQUE ANÍNOMO --
DECLARE
    var_numavio NUMBER(12,2);
BEGIN
    var_numavio := fu_count_avion_aerolinea('A01');
    DBMS_OUTPUT.PUT_LINE('El número ttoal de aviones es de: '||var_numavio);
END;

SELECT t_aerolinea_codaero FROM T_AVIOAEREO WHERE t_aerolinea_codaero = 'A01';

/* 5. Crear una función que permita mostrar el nombre complete de un pasajero, proporcionado el
número de pasaporte. Digite el siguiente código*/
create or replace FUNCTION FU_nombreCompleto_Pasajero(pasaporte IN CHAR)
    RETURN VARCHAR2
AS
    var_nombre_completo VARCHAR2(100);
BEGIN
    SELECT nomjero||' '||apejero  INTO var_nombre_completo FROM t_pasajero
    WHERE pasapjero = pasaporte;
    return var_nombre_completo;
END;

SELECT FU_nombreCompleto_Pasajero('AB00010') FROM DUAL;