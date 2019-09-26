-- 1. El controlador de vuelo necesita ver, toda la información concerniente a las aerolíneas.
SELECT * FROM t_aerolinea;

/* 2. Se necesita consultar solo los siguientes datos de la aerolínea: Código, Nombre,
Dirección, y email de la aerolínea.*/
SELECT codaero, nombaereo, diraereo, emailaereo FROM t_aerolinea;

/* 3. Se deben de consultar los datos del punto anterior; pero se deben formatear las
columnas brindadas por la consulta, asignándoles un nombre de encabezado a cada
una.*/
SELECT codaero AS "Código de la Aereolinea", nombaereo AS "Nombre de la Aereolinea", diraereo AS "Dirección de la Aereolinea", emailaereo AS 
"Correo de la Aereolinea" FROM t_aerolinea;

/* 4. Es necesario formatear los datos de la consulta anterior, pero se deben de mostrar el
código y nombre de la aerolínea en una sola columna. Los encabezados a mostrar
serian: Datos principales de aerolínea, Dirección, y Email.*/
SELECT codaero || ' ' || nombaereo AS "Datos principales Aereolinea", diraereo, emailaereo FROM t_aerolinea;

/* 5. Se deben de consultar todos los aviones, cuya carga útil sea igual o mayor que
309,000 Kgs.*/
SELECT * FROM t_avion WHERE CUAVION >= 309000;

/* 6. Se deben de consultar todos los aviones, cuya carga útil sea igual o menor que
175,000 Kgs*/
SELECT * FROM t_avion WHERE CUAVION <= 309000;

/* 7. Se deben de consultar todos los aviones, cuya carga útil sea distinta de 309,000 Kgs*/
SELECT * FROM t_avion WHERE CUAVION <>309000; 

/* 8. Se deben de consultar todos los aviones, cuya carga útil no sea igual a 309,000 Kgs*/
SELECT * FROM t_avion WHERE NOT (CUAVION=309000);

/* 9. Se deben de consultar todos los aviones, cuya carga útil sea 7500 y 6670.*/
SELECT * FROM t_avion WHERE DISKAVION IN (7500, 6670);

/* 10. Se demanda ver los siguientes datos de los aviones: Su código y matricula en una
sola columna; y la distancia máxima que recorre en Kilómetros. Formatear los
encabezados de columnas.*/
SELECT codavion || ' ' || matriavion AS "Código y Matricula de Avion", DISKAVION FROM t_avion;

/* 11. . Se hace necesario consultar, todos los datos de los aviones; pero que su distancia
máxima a recorrer en kilómetros este entre 7500, y 15843*/
SELECT * FROM t_avion WHERE DISKAVION BETWEEN 7500 AND 15843;

/* 12. .Se deben de buscar todos los países que comiencen con la letra “E”*/
SELECT * FROM t_pais WHERE nompa LIKE 'E%';

/* 13. Se deben de buscar todos los países que finalicen con la letra “E”*/
SELECT * FROM t_pais WHERE nompa LIKE '%E';

/* 14. Se deben de buscar todos los países que posean la letras “E”, en la parte media de su
nombre*/
SELECT * FROM t_pais WHERE nompa LIKE '%E%';

/* 15. Se deben de buscar todos los países que posean las letras E; y S en la parte media
de su nombre, ordenándolos en forma ascendente primero; y luego en forma
descendente.*/
-- a
SELECT * FROM t_pais WHERE nompa LIKE '%E%S%' ORDER BY nompa;
-- b
SELECT * FROM t_pais WHERE nompa LIKE '%E%S%' ORDER BY nompa DESC;

/* 16. 
Ejecute la corrida de los siguientes comandos:
Sintaxis para la creación de secuencias
CREATE SEQUENCE nombre_secuencia INCREMENT BY número_incremento
START WITH inicia_en MINVALUE numero_inicio ORDER;
En donde:
Número incremento es un valor entero
Inicia en es un valor entero
Numero Inicio es un valor entero*/

--a
CREATE SEQUENCE SEC_DETVUECOM INCREMENT BY 1 START WITH 1 MINVALUE 1 ORDER;

--b
CREATE SEQUENCE SEC_DETVUECG INCREMENT BY 1 START WITH 1 MINVALUE 1 ORDER;

/* 17. .Asociar las secuencias recién creadas a las tablas T_ DETVUCOM; y T_ DETVUECG.
LOS TRIGGER EN MODO GRAFICO*/

/* 18. Se desea saber cuántos aviones AIRBUS modelo A300-600R se poseen*/
SELECT COUNT(modavion) AS "Total Modelo A300-600R" FROM t_avion WHERE modavion='A300-600R';

/* 19. Se desea saber cuánto es el consumo en litros del avión AIRBUS A300-600R; en su
distancia máxima. Considerando que cada 100 kms consume 1200 litros. No mostrar
registros repetidos*/
SELECT DISTINCT diskavion, ((diskavion/100)*1200) AS "Consumo en Litros MR" FROM t_avion WHERE modavion='A300-600R';

/* 20. Se desea saber cuántos aviones AIRBUS modelo A300-600F se poseen.*/
SELECT COUNT(modavion) AS "Total Modelo A300-600F" FROM t_avion WHERE modavion='A300-600F';

/* 21. Se desea saber cuánto es el consumo en litros del avión AIRBUS A300-600F; en su
distancia máxima. Considerando que cada 95 kms consume 1200 litros. No mostrar
registros repetidos.*/
SELECT DISTINCT diskavion, FLOOR(((diskavion/95)*1200)) AS "Consumo en litros MF" FROM t_avion WHERE modavion='A300-600F';