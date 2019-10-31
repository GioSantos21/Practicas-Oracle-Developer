/*UNIVERSIDAD CATOLICA DE EL SALVADOR
FACULTAD DE CIENCIAS EMPRESARIALES
LICENCIATURA EN SISTEMAS INFORM�TICOS ADMINISTRATIVOS
GESTI�N DE BASE DE DATOS II � CICLO II 2019
CATEDR�TICO: LICDO. EDGAR AVIL�S

Gu�a de aplicaci�n de: Funciones con Oracle 11g

Objetivo: Desarrollar la capacidad de an�lisis de los estudiantes para la creaci�n de procedimientos almacenados,
como medidas de seguridad y rendimiento en un entorno de Base de Datos, con Oracle 11g.

Nota: Para habilitar la salida de DBMS, digite el siguiente comando set serveroutput on;*/

SET SERVEROUTPUT ON ;

/* 1. Se necesita calcular el importe total en $ del costo de transporte de un determinado vuelo de
carga; (Sumatoria de los costos de vuelo, de todas las cargas, de un determinado vuelo). Para
implementar est� funcioalidad, digite el c�digo correspondiente a la siguiente funci�n; y pruebe la
funci�n a trav�s de un bloque de c�digo an�nimo. */

-- Funci�n que devuelve el importe total en $, del transporte de carga de un determinado vuelo --
create or replace FUNCTION FU_importe_total_vuelocarga(codvuelo IN NUMBER)
    RETURN NUMBER
AS
    var_importetotal NUMBER(12,2);
BEGIN
    SELECT sum(costodetvucg) INTO var_importetotal FROM t_detvucg
    WHERE t_vuecg_codvuecg = codvuelo;
    RETURN var_importetotal;
END;

-- BLOQUE AN�NIMO --
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

-- BLOQUE AN�NIMO --
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

-- BLOQUE AN�NIMO --
DECLARE
    var_costoboleto t_detvucom.costodetvucom%TYPE;
BEGIN
    var_costoboleto := FU_importe_boletos_vuecom(2);
    DBMS_OUTPUT.PUT_LINE('el costo total de todos los boletos es de : $'||var_costoboleto);
END;

/* 4. Contar el n�mero total de aviones, correspondiente a una aerol�nea*/
create or replace FUNCTION FU_count_avion_aerolinea(cod_aero IN CHAR)
RETURN NUMBER
AS
    var_totalAviones NUMBER(12,2);    
BEGIN
    SELECT count(t_avion_codavion) INTO var_totalAviones FROM t_avioaereo
    WHERE t_aerolinea_codaero = cod_aero;
    return var_totalaviones;
END;

-- BLOQUE AN�NOMO --
DECLARE
    var_numavio NUMBER(12,2);
BEGIN
    var_numavio := fu_count_avion_aerolinea('A01');
    DBMS_OUTPUT.PUT_LINE('El n�mero ttoal de aviones es de: '||var_numavio);
END;

SELECT t_aerolinea_codaero FROM T_AVIOAEREO WHERE t_aerolinea_codaero = 'A01';

/* 5. Crear una funci�n que permita mostrar el nombre complete de un pasajero, proporcionado el
n�mero de pasaporte. Digite el siguiente c�digo*/
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