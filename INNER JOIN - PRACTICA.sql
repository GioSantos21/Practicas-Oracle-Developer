/*1. Mostrar el nombre de la aerolínea y el país de origen de la misma; ordene los registros por
el país en forma ascendente.*/
SELECT nombaereo AS "Nombre Aereolinea", nompa AS "Pais Origen" FROM t_aerolinea
INNER JOIN t_pais ON t_aerolinea.t_pais_codpa= t_pais.codpa
ORDER BY t_pais.nompa; 

/*2. Mostrar el listado de todos los aviones en base a: Matricula, Modelo de Avión, Carga Útil, y
Distancia Máxima en Kms que recorre. Además el tipo de Avión que es (Comercial o
Carga). Ordene el resultado en base al tipo de Avión.*/
SELECT matriavion AS "Matricula Avion", modavion AS "Modelo Avion", cuavion AS "Carga Util", diskavion AS "Distancia Maxima",
nombtipoav AS "Tipo Avion" FROM t_avion
INNER JOIN t_tipoavion ON t_avion.t_tipoavion_codtipoavion = t_tipoavion.codtipoavion
ORDER BY t_tipoavion.nombtipoav;

/*3. Mostrar el listado de todos los países, y el nombre de las aerolíneas por cada país. Brinde
precedencia relevancia a los datos de los países.*/
SELECT nompa AS "Nombre Pais", nombaereo AS "Nombre Aereolinea" FROM t_pais
LEFT JOIN t_aerolinea ON t_pais.codpa = t_aerolinea.t_pais_codpa;

/*4. Seleccione el nombre del fabricante, la matricula del avión y el modelo del avión; muestre
todos los aviones, dando relevancia a los mismos.*/
SELECT nomfabri AS "Nombre Fabricante", matriavion AS "Matricula Avion", modavion AS "Modelo Avion" FROM t_fabrican
RIGHT JOIN t_avion ON cofabri = t_avion.t_fabrican_cofabri;

/*5. Mostrar los siguientes datos: Nombre y apellido del pasajero; peso en equipaje, clase,
costo del boleto, aeropuerto de destino; y ciudad; independientemente de la cantidad de
vuelos que tomaron. Además mostrar datos de los vuelos y su detalle, y ordenarlas por el
nombre del pasajero en orden ascendente*/
SELECT nomjero AS "Nombre Pasajero", apejero AS "Apellido Pasajero", pmdetvucom AS "Peso Equipaje",
clasedetvucom AS "Clase", costodetvucom AS "Costo Boleto", aeroputvuecom AS "Aereopuerto Destino", 
ciuddesvuecom AS "Ciudad Destino" FROM t_pasajero
INNER JOIN t_detvucom ON t_pasajero.pasapjero = t_detvucom.t_pasajero_pasapjero
INNER JOIN t_vuecom ON t_detvucom.t_vuecom_codvuecom = t_vuecom.codvuecom
ORDER BY nomjero asc;

/*6. Mostrar los siguientes datos: Nombre y apellido del pasajero; peso en equipaje, clase,
costo del boleto, aeropuerto de destino; y ciudad. Donde el aeropuerto de destino sea:
Benito Juárez de la ciudad de México*/
SELECT nomjero AS "Nombre Pasajero", apejero AS "Apellido Pasajero", pmdetvucom AS "Peso Equipaje",
clasedetvucom AS "Clase", costodetvucom AS "Costo Boleto", aeroputvuecom AS "Aereopuerto Destino", 
ciuddesvuecom AS "Ciudad Destino" FROM t_pasajero
INNER JOIN t_detvucom ON t_pasajero.pasapjero = t_detvucom.t_pasajero_pasapjero
INNER JOIN t_vuecom ON t_detvucom.t_vuecom_codvuecom = t_vuecom.codvuecom
WHERE t_vuecom.aeroputvuecom = 'Benito Ju¿rez'
ORDER BY nomjero;

/*7. Ordenar los datos de la consulta anterior, en base al nombre del pasajero en orden
ascendente*/
SELECT nomjero AS "Nombre Pasajero", apejero AS "Apellido Pasajero", pmdetvucom AS "Peso Equipaje",
clasedetvucom AS "Clase", costodetvucom AS "Costo Boleto", aeroputvuecom AS "Aereopuerto Destino", 
ciuddesvuecom AS "Ciudad Destino" FROM t_pasajero
INNER JOIN t_detvucom ON t_pasajero.pasapjero = t_detvucom.t_pasajero_pasapjero
INNER JOIN t_vuecom ON t_detvucom.t_vuecom_codvuecom = t_vuecom.codvuecom
WHERE t_vuecom.aeroputvuecom = 'Benito Ju¿rez'
ORDER BY nomjero DESC;

/*8. Mostrar el código y nombre de aerolínea; más los correspondientes aviones que poseen
(Matrícula y Modelo de Avión)*/
SELECT codaero As "Código Aereolinea", nombaereo AS "Nombre Aereolinea", matriavion AS "Matricula Avion", modavion AS "Modelo Avion" FROM t_aerolinea
INNER JOIN t_avioaereo ON t_aerolinea.codaero = t_avioaereo.t_aerolinea_codaero
INNER JOIN t_avion ON t_avioaereo.t_avion_codavion = t_avion.codavion;

/*9. Ordenar la consulta anterior, por nombre de aerolínea.*/
SELECT codaero As "Código Aereolinea", nombaereo AS "Nombre Aereolinea", matriavion AS "Matricula Avion", modavion AS "Modelo Avion" FROM t_aerolinea
INNER JOIN t_avioaereo ON t_aerolinea.codaero = t_avioaereo.t_aerolinea_codaero
INNER JOIN t_avion ON t_avioaereo.t_avion_codavion = t_avion.codavion
ORDER BY t_aerolinea.nombaereo;

/*10. Reformule la consulta del punto 9; para buscar todos los aviones de la Aerolínea Azul
Airlines*/
SELECT codaero As "Código Aereolinea", nombaereo AS "Nombre Aereolinea", matriavion AS "Matricula Avion", modavion AS "Modelo Avion" FROM t_aerolinea
INNER JOIN t_avioaereo ON t_aerolinea.codaero = t_avioaereo.t_aerolinea_codaero
INNER JOIN t_avion ON t_avioaereo.t_avion_codavion = t_avion.codavion
WHERE t_aerolinea.nombaereo = 'Azul Airlines'
ORDER BY t_aerolinea.nombaereo;