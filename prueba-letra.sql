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

SELECT * FROM t_aerolinea;