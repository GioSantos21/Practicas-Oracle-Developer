/*
UNIVERSIDAD CATOLICA DE EL SALVADOR
FACULTAD DE CIENCIAS EMPRESARIALES
LICENCIATURA EN SISTEMAS INFORMÁTICOS ADMINISTRATIVOS
GESTIÓN DE BASE DE DATOS II – CICLO II 2019
CATEDRÁTICO: LICDO. EDGAR AVILÉS

Guía de aplicación de: Subconsultas, Joins y Vistas con Oracle 11g (SOLUCION)

Objetivo: Desarrollar la capacidad de análisis para la aplicación de: Subconsultas, joins y vistas complejas;
en Oracle 11g

Notas relevantes:

A. Luego de construir las consultas para cada punto, deberá crear una vista por cada consulta
construida. Todas las vistas deberán ser creadas con la opción de Read Only; y deberán ser
nombradas de la siguiente manera: ‘v_nombredescriptivo’.

B. Formatee el resultado de todos los encabezados de cada consulta generada; dentro de cada vista
creada.

1. Mostrar todos los aviones, cuya distancia máxima en kms sea superior al promedio máximo
recorrido en Kms. */
SELECT * FROM t_avion 
WHERE diskavion > (SELECT AVG(diskavion) AS "Promedio Máximo en KMS" FROM t_avion);

/* 2. Mostrar todos los aviones, cuya distancia máxima en kms sea inferior al promedio máximo recorrido
en Kms. */
SELECT * FROM t_avion
WHERE diskavion < (SELECT AVG(diskavion) AS "Promedio Mínimo en KMS" FROM t_avion);


/* 3. Mostrar todos los aviones, cuya distancia máxima en kms sea superior al promedio máximo
recorrido en Kms. */
SELECT * FROM t_avion 
WHERE diskavion > (SELECT AVG(diskavion) AS "Promedio Máximo en KMS" FROM t_avion);

/* 4. Mostrar todos los aviones, cuya distancia máxima en kms sea inferior al promedio máximo recorrido
en Kms. */
SELECT * FROM t_avion
WHERE diskavion < (SELECT AVG(diskavion) AS "Promedio Mínimo en KMS" FROM t_avion);


/* 5. Seleccione todos los aviones, que sean diferentes de la distancia máxima. */
SELECT * FROM t_avion
WHERE diskavin <> (SELECT MAX(diskavion) AS "Distancia Máxima" FROM t_avion);


/* 6. Seleccione todos los aviones, que sean diferentes de la distancia minima. */
SELECT * FROM t_avion
WHERE diskavion <> (SELECT MIN(diskavion) AS "Distancia Mínima" FROM t_avion);

/* 7. Seleccione la descripción de todos aquellos detalles de vuelos, que el precio de la carga este dentro
del promedio del costo de la carga. */
SELECT descripdetvucg FROM t_detvucg
WHERE pcdetvucg NOT IN (SELECT AVG(pcdetvucg) FROM t_detvucg);

/* 8. Muestre las descripciones y costo de los detalles del vuelo de carga, donde el costo del vuelo de
carga este entre $8000.00 y $11000.00. */
SELECT descripdetvucg, costodetvucg FROM t_detvucg
WHERE costodetvucg IN (SELECT costodetvucg FROM t_detvucg WHERE costodetvucg BETWEEN 8000 AND 11000);

/* 9. Muestre las descripciones y costo de los detalles del vuelo de carga, donde el costo del vuelo de
carga no este entre $8000.00 y $11000.00. */
SELECT descripdetvucg, costodetvucg FROM t_detvucg
WHERE costodetvucg NOT IN (SELECT costodetvucg FROM t_detvucg WHERE costodetvucg BETWEEN 8000 AND 11000);

/* 10. Seleccione la descripción, y precio de carga de todos aquellos detalles de vuelos, que el precio de
la carga este dentro del rango $10000.00 y $12000.00. */
SELECT descripdetvucg, pcdetvucg FROM t_detvucg
WHERE pcdetvucg IN (SELECT pcdetvucg FROM t_detvucg WHERE pcdetvucg BETWEEN 10000 AND 12000);

/* 11. Seleccione la descripción, y precio de carga de todos aquellos detalles de vuelos, que el precio de
la carga no esté dentro del rango $10000.00 y $12000.00. */
SELECT descripdetvucg, pcdetvucg FROM t_detvucg
WHERE pcdetvucg NOT IN (SELECT pcdetvucg FROM t_detvucg WHERE pcdetvucg BETWEEN 10000 AND 12000);

/* 12. Seleccione la descripción, y costo transporte; de todos aquellos detalles de vuelo que el costo de
vuelo sea menor que todo el rango comprendido entre $10000.00 y $12000.00. */
SELECT descripdetvucg, costodetvucg FROM t_detvucg
WHERE costodetvucg < ALL (SELECT costodetvucg FROM t_detvucg WHERE costodetvucg BETWEEN 10000 AND 12000);

/* 13. Seleccione la descripción, y costo transporte; de todos aquellos detalles de vuelo que el costo de
vuelo sea mayor que todo el rango comprendido entre $8000.00 y $11000.00. */
SELECT descripdetvucg, costodetvucg FROM t_detvucg
WHERE costodetvucg > ALL (SELECT costodetvucg FROM t_detvucg WHERE costodetvucg BETWEEN 8000 AND 11000);

/* 14. Seleccione la descripción, y costo transporte; de todos aquellos detalles de vuelo que el costo de
vuelo sea distinto que todo el rango comprendido entre $7500.00 y $10000.00. */
SELECT descripdetvucg, costodetvucg FROM t_detvucg
WHERE costodetvucg <> ALL (SELECT costodetvucg FROM t_detvucg WHERE costodetvucg BETWEEN 7500 AND 10000);

/* 15. Se demanda crear un informe completo de vuelos y pasajeros. Los datos a solicitar son: Nombre de
la Aerolínea, código de vuelo; aeropuerto de destino, ciudad de destino, matrícula y modelo de
avión que ejecuto el vuelo; y el pasaporte, nombre y apellido del pasajero. */
SELECT nombaereo, codaero, aeroputvuecom, ciuddesvuecom, matriavion, modavion, t_pasajero_pasapjero, nomjero, apejero FROM T_AEROLINEA
INNER JOIN T_VUECOM ON T_AEROLINEA.CODAERO = T_VUECOM.T_AEROLINEA_CODAERO
INNER JOIN t_avion ON T_VUECOM.T_AVION_CODAVION = t_avion.CODAVION
INNER JOIN T_DETVUCOM ON T_VUECOM.CODVUECOM = T_DETVUCOM.T_VUECOM_CODVUECOM
INNER JOIN T_PASAJERO ON T_DETVUCOM.T_PASAJERO_PASAPJERO = T_PASAJERO.PASAPJERO;

/* 16. Se demanda crear un informe completo de vuelos y pasajeros. Los datos a solicitar son: Nombre de
la Aerolínea, código de vuelo; aeropuerto de Destino, Ciudad de Destino, matrícula y modelo de
avión que ejecuto el vuelo; y el pasaporte, nombre y apellido del pasajero. Donde la Ciudad de
destino sea 'México DF', se deben ordenar la información por el apellido del pasajero en orden
ascendente y descendente. */


/* 17. Se demanda crear un informe completo de vuelos y pasajeros. Los datos a solicitar son: Nombre de
la Aerolínea, código de vuelo; Aeropuerto de Destino, Ciudad de Destino, matrícula y modelo de
avión que ejecuto el vuelo; y el pasaporte, nombre y apellido del pasajero. Donde la Ciudad de
destino sea 'Ciudad de Guatemala', se deben ordenar la información por el apellido del pasajero en
orden ascendente y descendente. */


/* 18. Se demanda crear un informe completo de vuelos y pasajeros. Los datos a solicitar son: Nombre de
la Aerolínea, código de vuelo; Aeropuerto de Destino, Ciudad de Destino, matrícula y modelo de
avión que ejecuto el vuelo; y el pasaporte, nombre y apellido del pasajero. Donde la Ciudad de
destino sea ‘Panamá', se deben ordenar la información por el apellido del pasajero en orden
ascendente y descendente. */


/* 19. Se pide un reporte que contenga los siguientes datos: Nombre de la Aerolínea, código de vuelo;
aeropuerto de destino, ciudad de destino, matrícula y modelo de avión que ejecuto el vuelo; y los
datos de carga: código, nombre de la carga; y su respectivo costo de transporte. Donde el costo de
transporte la carga sea mayor que el promedio, se deben ordenar la información por el nombre de la
carga en forma ascendente y descendente. */


/* 20. Se pide un reporte que contenga los siguientes datos: Nombre de la Aerolínea, código de vuelo,
Aeropuerto de Destino, Ciudad de Destino, matrícula y modelo de avión que ejecuto el vuelo; y los
datos de carga: código, nombre de la carga; y su respectivo costo de transporte. Donde el costo de
transporte de la carga sea menor que el promedio, se deben ordenar la información por el nombre
de la carga en forma ascendente y descendente. */


/* 21. Se pide un reporte que contenga los siguientes datos: Nombre de la Aerolínea, código de vuelo;
Aeropuerto de Destino, Ciudad de Destino, matrícula y modelo de avión que ejecuto el vuelo; y los
datos de carga: código, nombre de la carga; y su respectivo costo de transporte. Donde el costo de
transporte de la carga sea menor que el costo máximo de transporte de carga; y donde el costo de
la carga sea mayor que el costo mínimo de transporte. Se deben ordenar la información por el
nombre de la carga en forma ascendente. */


/* 22. Se pide un reporte que contenga los siguientes datos: Nombre de la Aerolínea, código de vuelo;
Aeropuerto de Destino, Ciudad de Destino, matrícula y modelo de avión que ejecuto el vuelo; y los
datos de carga: código, nombre de la carga; y su respectivo costo de transporte. Donde el precio de
costo de la carga sea menor que el costo máximo de transporte de carga; y donde el precio de
costo de la carga sea mayor que el costo mínimo de transporte. Se deben ordenar la información
por el nombre de la carga en forma ascendente. */



