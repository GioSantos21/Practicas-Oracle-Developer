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