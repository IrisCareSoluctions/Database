-- Comando sqls para doprar as tabelas para executar este código

DROP TABLE tb_ic_address CASCADE CONSTRAINTS;
DROP TABLE tb_ic_analysis CASCADE CONSTRAINTS;
DROP TABLE tb_ic_child CASCADE CONSTRAINTS;
DROP TABLE tb_ic_exam CASCADE CONSTRAINTS;
DROP TABLE tb_ic_phone CASCADE CONSTRAINTS;
DROP TABLE tb_ic_user CASCADE CONSTRAINTS;
DROP TABLE tb_ic_erros CASCADE CONSTRAINTS;


-- Gerado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   em:        2023-11-22 02:16:52 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE tb_ic_address (
    id_address   NUMBER NOT NULL,
    id_user      NUMBER NOT NULL,
    zip_code     VARCHAR2(15) NOT NULL,
    number_address     VARCHAR2(10) NOT NULL,
    street       VARCHAR2(200) NOT NULL,
    city         VARCHAR2(150) NOT NULL,
    state        VARCHAR2(150) NOT NULL,
    neighborhood VARCHAR2(200) NOT NULL
);

CREATE UNIQUE INDEX tb_ic_address__idx ON
    tb_ic_address (
        id_user
    ASC );

ALTER TABLE tb_ic_address ADD CONSTRAINT tb_ic_address_pk PRIMARY KEY ( id_address );

CREATE TABLE tb_ic_analysis (
    id_analysis   NUMBER NOT NULL,
    id_child      NUMBER NOT NULL,
    id_user       NUMBER NOT NULL,
    image         VARCHAR2(250) NOT NULL,
    dt_analysis        DATE NOT NULL,
    ds_leucocoria VARCHAR2(200) NOT NULL
);

ALTER TABLE tb_ic_analysis
    ADD CONSTRAINT tb_ic_analysis_pk PRIMARY KEY ( id_analysis,
                                                   id_child,
                                                   id_user );

CREATE TABLE tb_ic_child (
    id_child NUMBER NOT NULL,
    id_user  NUMBER NOT NULL,
    name_child     VARCHAR2(150) NOT NULL,
    cpf      VARCHAR2(15) NOT NULL,
    birthday DATE NOT NULL,
    active   VARCHAR2(10) NOT NULL
);

ALTER TABLE tb_ic_child ADD CONSTRAINT tb_ic_child_pk PRIMARY KEY ( id_child,
                                                                    id_user );

CREATE TABLE tb_ic_exam (
    id_exame    NUMBER NOT NULL,
    id_child    NUMBER NOT NULL,
    id_user     NUMBER NOT NULL,
    name_exam        VARCHAR2(150) NOT NULL,
    dt_exam      DATE NOT NULL,
    description VARCHAR2(300) NOT NULL,
    image       VARCHAR2(200)
);

ALTER TABLE tb_ic_exam
    ADD CONSTRAINT tb_ic_exam_pk PRIMARY KEY ( id_exame,
                                               id_child,
                                               id_user );

CREATE TABLE tb_ic_phone (
    id_phone NUMBER NOT NULL,
    id_user  NUMBER NOT NULL,
    ddd      VARCHAR2(5) NOT NULL,
    number_phone VARCHAR2(12) NOT NULL
);

ALTER TABLE tb_ic_phone ADD CONSTRAINT tb_ic_phone_pk PRIMARY KEY ( id_phone,
                                                                    id_user );

CREATE TABLE tb_ic_user (
    id_user  NUMBER NOT NULL,
    name_user     VARCHAR2(150) NOT NULL,
    email    VARCHAR2(150) NOT NULL,
    password VARCHAR2(100) NOT NULL,
    birthday DATE NOT NULL,
    cpf      VARCHAR2(15) NOT NULL,
    status   VARCHAR2(10) NOT NULL
);

ALTER TABLE tb_ic_user ADD CONSTRAINT tb_ic_user_pk PRIMARY KEY ( id_user );

ALTER TABLE tb_ic_address
    ADD CONSTRAINT tb_ic_address_tb_ic_user_fk FOREIGN KEY ( id_user )
        REFERENCES tb_ic_user ( id_user );

ALTER TABLE tb_ic_analysis
    ADD CONSTRAINT tb_ic_analysis_tb_ic_child_fk FOREIGN KEY ( id_child,
                                                               id_user )
        REFERENCES tb_ic_child ( id_child,
                                 id_user );

ALTER TABLE tb_ic_child
    ADD CONSTRAINT tb_ic_child_tb_ic_user_fk FOREIGN KEY ( id_user )
        REFERENCES tb_ic_user ( id_user );

ALTER TABLE tb_ic_exam
    ADD CONSTRAINT tb_ic_exam_tb_ic_child_fk FOREIGN KEY ( id_child,
                                                           id_user )
        REFERENCES tb_ic_child ( id_child,
                                 id_user );

ALTER TABLE tb_ic_phone
    ADD CONSTRAINT tb_ic_phone_tb_ic_user_fk FOREIGN KEY ( id_user )
        REFERENCES tb_ic_user ( id_user );

CREATE TABLE tb_ic_erros (
    id_erro     NUMBER NOT NULL,
    nm_user     VARCHAR2(150) NOT NULL,
    date_error        DATE NOT NULL,
    cd_error    VARCHAR2(100) NOT NULL,
    message     VARCHAR2(300) NOT NULL
);

ALTER TABLE tb_ic_erros ADD CONSTRAINT tb_ic_erros_pk PRIMARY KEY ( id_erro );

-- Relat�rio do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             1
-- ALTER TABLE                             11
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
