-- 
-- Comandos DDL para criar os objetos necessários do projeto no Banco de Dados
-- 


-- Comando sqls para doprar as tabelas caso necessário

-- DROP TABLE tb_ic_address CASCADE CONSTRAINTS;
-- DROP TABLE tb_ic_analysis CASCADE CONSTRAINTS;
-- DROP TABLE tb_ic_child CASCADE CONSTRAINTS;
-- DROP TABLE tb_ic_exam CASCADE CONSTRAINTS;
-- DROP TABLE tb_ic_phone CASCADE CONSTRAINTS;
-- DROP TABLE tb_ic_user CASCADE CONSTRAINTS;
-- DROP TABLE tb_ic_erros CASCADE CONSTRAINTS;


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


-- 
-- Sequences
-- 

CREATE SEQUENCE seq_tb_ic_address START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_ic_analysis START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_ic_child START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_ic_exam START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_ic_phone START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_ic_user START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_ic_erros START WITH 1 INCREMENT BY 1;

-- 
-- Procedures de carga de dados
-- 

-- Procedure para ralizar o inserção de um usuário

create or replace procedure prc_ic_cadastra_usuario(
    id_usuario in number,
    name_user in varchar2,
    email in varchar2,
    password in varchar2,
    birthday in date,
    cpf in varchar2
) as
    v_cpf_formatado VARCHAR2(11);
    v_codigo_erro NUMBER;
    v_mensagem_erro VARCHAR2(250);
begin

    v_cpf_formatado := REPLACE(REPLACE(cpf, '.', ''), '-', '');
    
    IF LENGTH(v_cpf_formatado) <> 11 THEN
        RAISE_APPLICATION_ERROR(-20002, 'CPF deve ter 11 dígitos.');
    END IF;
    
    IF INSTR(email, '@') = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Não foi encontrado o caracter @ no email');
    END IF;

    INSERT INTO TB_IC_USER (ID_USER, name_user, EMAIL, PASSWORD, BIRTHDAY, CPF, STATUS)
    VALUES(id_usuario, name_user, email, password, birthday, v_cpf_formatado, 'ATIVO');
  
exception
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em coluna unica.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
        
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Violou a restricao de tamanho.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
  
end prc_ic_cadastra_usuario;


-- Procedure para ralizar o inserção de um telefone de um usuário

create or replace procedure prc_ic_cadastra_telefone(
    id_phone in number,
    id_user in number,
    ddd in varchar2,
    number_phone in varchar2
) as
    qtd_usuario number;
    v_codigo_erro NUMBER;
    v_mensagem_erro VARCHAR2(250);
begin


    IF LENGTH(ddd) <> 2 THEN
        RAISE_APPLICATION_ERROR(-20005, 'O valor do ddd deve ter 2 dígitos.');
    END IF;
    
    INSERT INTO TB_IC_PHONE (ID_PHONE, ID_USER, DDD, NUMBER_PHONE)
    VALUES (id_phone, id_user, ddd, number_phone);
    
exception
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em coluna unica.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
        
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Violou a restricao de tamanho.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
  
end prc_ic_cadastra_telefone;

-- Procedure para ralizar o inserção de um endereco de um usuário

create or replace procedure prc_ic_cadastra_endereco(
    id_address in number,
    id_user in number,
    zip_code in varchar2,
    number_address in varchar2,
    street in varchar2,
    city in varchar2,
    state in varchar2,
    neighborhood in varchar2
) as
    v_zip_code_formatado varchar2(20);
    v_codigo_erro NUMBER;
    v_mensagem_erro VARCHAR2(250);
begin

    v_zip_code_formatado := REPLACE(REPLACE(zip_code, '.', ''), '-', '');
    
    INSERT INTO TB_IC_ADDRESS (ID_ADDRESS, ID_USER, ZIP_CODE, NUMBER_ADDRESS, STREET, CITY, STATE, NEIGHBORHOOD)
    VALUES(id_address, id_user, v_zip_code_formatado, number_address, street, city, state, neighborhood);
  
exception
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em coluna unica.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
        
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Violou a restricao de tamanho.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
end prc_ic_cadastra_endereco;

-- Procedure para ralizar o inserção de uma criança de um usuário

create or replace procedure prc_ic_cadastra_crianca(
    id_child in NUMBER,
    id_user in  NUMBER,
    name_child in     VARCHAR2,
    cpf in      VARCHAR2,
    birthday in DATE
)as 
    v_codigo_erro NUMBER;
    v_mensagem_erro VARCHAR2(250);
begin

    INSERT INTO tb_ic_child (id_child, id_user, name_child, cpf, birthday, active)
    VALUES(id_child, id_user, name_child, cpf, birthday, 'ATIVO');
    
exception
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em coluna unica.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
        
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Violou a restricao de tamanho.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);

end prc_ic_cadastra_crianca;

-- Procedure para ralizar o inserção de uma analise de uma crianca

create or replace procedure prc_ic_cadastra_analise(
    id_analysis   NUMBER,
    id_child      NUMBER,
    id_user       NUMBER,
    image         VARCHAR2,
    dt_analysis   DATE,
    ds_leucocoria VARCHAR2
) as
    v_codigo_erro NUMBER;
    v_mensagem_erro VARCHAR2(250);
begin

    INSERT INTO tb_ic_analysis (id_analysis, id_child, id_user, image, dt_analysis, ds_leucocoria)
    VALUES (id_analysis, id_child, id_user, image, dt_analysis, ds_leucocoria);

exception
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em coluna unica.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
        
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Violou a restricao de tamanho.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);

end prc_ic_cadastra_analise;

-- Procedure para ralizar o inserção de um exame de uma crianca

create or replace procedure prc_ic_cadastra_exame(
    id_exame    NUMBER,
    id_child    NUMBER,
    id_user     NUMBER,
    name_exam   VARCHAR2,
    dt_exam     DATE,
    description VARCHAR2,
    image       VARCHAR2
) as
    v_codigo_erro NUMBER;
    v_mensagem_erro VARCHAR2(250);
begin

    INSERT INTO tb_ic_exam (id_exame, id_child, id_user, name_exam, dt_exam, description, image)
    VALUES (id_exame, id_child, id_user, name_exam, dt_exam, description, image);

exception
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em coluna unica.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
        
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Violou a restricao de tamanho.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
  
end prc_ic_cadastra_exame;


-- 
-- Carga de Dados - Realização das inserções, 5 inserções por tabela
-- 


exec prc_ic_cadastra_usuario(seq_tb_ic_user.NEXTVAL, 'Vinicius de Oliveira', 'vini@gmail.com', 'vinicius123', to_date('15/05/2003', 'dd/mm/yyyy'), '52676451847');
exec prc_ic_cadastra_telefone(seq_tb_ic_phone.NEXTVAL, seq_tb_ic_user.CURRVAL, '11', '994968031');
exec prc_ic_cadastra_endereco(seq_tb_ic_address.NEXTVAL, seq_tb_ic_user.CURRVAL, '05763450', '190', 'Rua lira cearense', 'São Paulo', 'SP', 'Morumbi Sul');
exec prc_ic_cadastra_crianca(seq_tb_ic_child.NEXTVAL, seq_tb_ic_user.CURRVAL, 'Enzo de Oliveira', '53694563547', to_date('01/02/2023', 'dd/mm/yyyy'));
exec prc_ic_cadastra_analise(seq_tb_ic_analysis.NEXTVAL, seq_tb_ic_child.CURRVAL, seq_tb_ic_user.CURRVAL, 'foto_iris1.png', trunc(sysdate), 'A leucocoria aprenseta um pouco de vermelihdão, mas nada fora do normal');
exec prc_ic_cadastra_exame(seq_tb_ic_exam.NEXTVAL, seq_tb_ic_child.CURRVAL, seq_tb_ic_user.CURRVAL, 'Exame de sangue', to_date('15/09/2023', 'dd/mm/yyyy'), 'Exame realizada no Hospoital São Luiz para analisar o sangue', 'resultado_exame.png');

exec prc_ic_cadastra_usuario(seq_tb_ic_user.NEXTVAL, 'Felipe Roveroni', 'felipe@gmail.com', 'felipe2023', to_date('20/10/2001', 'dd/mm/yyyy'), '40558243355');
exec prc_ic_cadastra_telefone(seq_tb_ic_phone.NEXTVAL, seq_tb_ic_user.CURRVAL, '68', '22056748');
exec prc_ic_cadastra_endereco(seq_tb_ic_address.NEXTVAL, seq_tb_ic_user.CURRVAL, '29177358', '820', 'Rua Cinco', 'Serra', 'ES', 'Jardim Bela Vista');
exec prc_ic_cadastra_crianca(seq_tb_ic_child.NEXTVAL, seq_tb_ic_user.CURRVAL, 'Regina Priscila Patrícia Santos', '98261668207', to_date('15/12/2022', 'dd/mm/yyyy'));
exec prc_ic_cadastra_analise(seq_tb_ic_analysis.NEXTVAL, seq_tb_ic_child.CURRVAL, seq_tb_ic_user.CURRVAL, 'foto_iris2.png', trunc(sysdate), 'A leucocoria está normal.');
exec prc_ic_cadastra_exame(seq_tb_ic_exam.NEXTVAL, seq_tb_ic_child.CURRVAL, seq_tb_ic_user.CURRVAL, 'Hemograma Completo', to_date('10/10/2023', 'dd/mm/yyyy'), 'Exame de rotina para verificar a contagem de células sanguíneas e outras informações importantes', 'resultado_hemograma.png');

exec prc_ic_cadastra_usuario(seq_tb_ic_user.NEXTVAL, 'Bento Henrique Barbosa', 'bentohenriquebarbosa@transicao.com', 'lpEjMa9RCq', to_date('09/05/1990', 'dd/mm/yyyy'), '92533833053');
exec prc_ic_cadastra_telefone(seq_tb_ic_phone.NEXTVAL, seq_tb_ic_user.CURRVAL, '94', '38035414');
exec prc_ic_cadastra_endereco(seq_tb_ic_address.NEXTVAL, seq_tb_ic_user.CURRVAL, '68552240', '496', 'Rua Conceição do Araguaia', 'Redenção', 'PA', 'Setor Oeste');
exec prc_ic_cadastra_crianca(seq_tb_ic_child.NEXTVAL, seq_tb_ic_user.CURRVAL, 'Isaac Cauê Vinicius Gomes', '77427503252', to_date('02/06/2023', 'dd/mm/yyyy'));
exec prc_ic_cadastra_analise(seq_tb_ic_analysis.NEXTVAL, seq_tb_ic_child.CURRVAL, seq_tb_ic_user.CURRVAL, 'foto_iris3.png', trunc(sysdate), 'A leucocoria apresenta uma cor diferente, favor procurar um médico.');
exec prc_ic_cadastra_exame(seq_tb_ic_exam.NEXTVAL, seq_tb_ic_child.CURRVAL, seq_tb_ic_user.CURRVAL, 'Ressonância Magnética Cerebral', to_date('20/10/2023', 'dd/mm/yyyy'), 'Exame realizado para obter imagens detalhadas do cérebro e diagnosticar possíveis condições neurológicas', 'resultado_ressonancia.png');

exec prc_ic_cadastra_usuario(seq_tb_ic_user.NEXTVAL, 'Julio Bernardo Nicolas Ferreira', 'julio_bernardo_ferreira@corpoclinica.com.br', '53IrPzj0AC', to_date('15/11/2002', 'dd/mm/yyyy'), '81879726530');
exec prc_ic_cadastra_telefone(seq_tb_ic_phone.NEXTVAL, seq_tb_ic_user.CURRVAL, '31', '981426967');
exec prc_ic_cadastra_endereco(seq_tb_ic_address.NEXTVAL, seq_tb_ic_user.CURRVAL, '33900340', '547', 'Rua Pimenta da Veiga', 'Ribeirão das Neves', 'MG', 'São José (Justinópolis )');
exec prc_ic_cadastra_crianca(seq_tb_ic_child.NEXTVAL, seq_tb_ic_user.CURRVAL, 'Mário Benício Gonçalves', '01439509409', to_date('29/04/2023', 'dd/mm/yyyy'));
exec prc_ic_cadastra_analise(seq_tb_ic_analysis.NEXTVAL, seq_tb_ic_child.CURRVAL, seq_tb_ic_user.CURRVAL, 'foto_iris4.png', trunc(sysdate), 'A leucocoria está normal.');
exec prc_ic_cadastra_exame(seq_tb_ic_exam.NEXTVAL, seq_tb_ic_child.CURRVAL, seq_tb_ic_user.CURRVAL, 'Eletrocardiograma', to_date('10/11/2023', 'dd/mm/yyyy'), 'Exame para avaliar a atividade elétrica do coração e identificar irregularidades no ritmo cardíaco', 'resultado_eletrocardiograma.png');

exec prc_ic_cadastra_usuario(seq_tb_ic_user.NEXTVAL, 'Mário Benício Gonçalves', 'mario_benicio_goncalves@grupompe.com.br', 'NGsYtoOgkn', to_date('03/11/1951', 'dd/mm/yyyy'), '01439509409');
exec prc_ic_cadastra_telefone(seq_tb_ic_phone.NEXTVAL, seq_tb_ic_user.CURRVAL, '86', '98185-8982');
exec prc_ic_cadastra_endereco(seq_tb_ic_address.NEXTVAL, seq_tb_ic_user.CURRVAL, '64017600', '768', 'Rua Equador', 'Teresina', 'PI', 'Cidade Nova');
exec prc_ic_cadastra_crianca(seq_tb_ic_child.NEXTVAL, seq_tb_ic_user.CURRVAL, 'Felipe Murilo Moraes', '11516500482', to_date('06/03/2023', 'dd/mm/yyyy'));
exec prc_ic_cadastra_analise(seq_tb_ic_analysis.NEXTVAL, seq_tb_ic_child.CURRVAL, seq_tb_ic_user.CURRVAL, 'foto_iris5.png', trunc(sysdate), 'A leucocoria aprenseta um pouco de vermelihdão, mas nada fora do normal');
exec prc_ic_cadastra_exame(seq_tb_ic_exam.NEXTVAL, seq_tb_ic_child.CURRVAL, seq_tb_ic_user.CURRVAL, 'Teste de Glicose', to_date('05/12/2023', 'dd/mm/yyyy'), 'Exame para medir os níveis de glicose no sangue, auxiliando no diagnóstico de diabetes e monitoramento de condições relacionadas', 'resultado_glicose.png');

-- 
-- Procedures de Relatório
-- 

-- Procudere pra retornar as crianças cadastradas pelo usario, passando como parâmetro o id dele e sendo exibida apenas as crianças com status ativo

CREATE OR REPLACE PROCEDURE prc_consulta_crianca
    (p_id_user IN tb_ic_user.id_user%TYPE) IS
    CURSOR c_criancas IS
        SELECT c.id_child, c.name_child, c.cpf, c.birthday, c.active
        FROM tb_ic_child c
        INNER JOIN tb_ic_user u ON c.id_user = u.id_user
        WHERE c.id_user = p_id_user;

    v_id_child tb_ic_child.id_child%TYPE;
    v_name_child tb_ic_child.name_child%TYPE;
    v_cpf tb_ic_child.cpf%TYPE;
    v_birthday tb_ic_child.birthday%TYPE;
    v_active tb_ic_child.active%TYPE;

BEGIN
    OPEN c_criancas;

    LOOP
        FETCH c_criancas INTO v_id_child, v_name_child, v_cpf, v_birthday, v_active;

        EXIT WHEN c_criancas%NOTFOUND;

        IF v_active = 'ATIVO' THEN

            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_child || ', Nome: ' || v_name_child || ', CPF: ' || v_cpf || ', Data de Nascimento: ' || TO_CHAR(v_birthday, 'DD/MM/YYYY') || ', Status: ' || v_active);
    
        END IF;
    END LOOP;

    CLOSE c_criancas;

END prc_consulta_crianca;
/

exec prc_consulta_crianca(6);


-- A procedure printa a frequencia que a criança deve fazer a analise de acordo com a idade dela

CREATE OR REPLACE PROCEDURE prc_ic_verificar_analise_criancas
    (p_id_child IN tb_ic_child.id_child%TYPE DEFAULT NULL) IS
   -- Variáveis para armazenar os resultados do cursor
   v_id_child tb_ic_child.id_child%TYPE;
   v_name_child tb_ic_child.name_child%TYPE;
   v_birthday tb_ic_child.birthday%TYPE;
   v_idade_meses NUMBER;

   -- Declaração do cursor
   CURSOR c_criancas IS
      SELECT id_child, name_child, birthday
      FROM tb_ic_child
      WHERE p_id_child IS NULL OR id_child = p_id_child;

BEGIN
   -- Loop para percorrer os resultados do cursor
   FOR crianca IN c_criancas LOOP
      -- Atribui os valores do cursor às variáveis
      v_id_child := crianca.id_child;
      v_name_child := crianca.name_child;
      v_birthday := crianca.birthday;

      -- Calcula a idade da criança em meses
      v_idade_meses := TRUNC(MONTHS_BETWEEN(SYSDATE, v_birthday));

      -- Tomada de decisão com base na idade da criança
      IF v_idade_meses < 12 THEN
         DBMS_OUTPUT.PUT_LINE('A criança ' || v_name_child || ' deve fazer a análise uma vez por semana.');
      ELSIF v_idade_meses >= 12 AND v_idade_meses <= 60 THEN
         DBMS_OUTPUT.PUT_LINE('A criança ' || v_name_child || ' deve fazer a análise uma vez por mês.');
      ELSE
         DBMS_OUTPUT.PUT_LINE('A criança ' || v_name_child || ' deve fazer a análise a cada 3 meses.');
      END IF;
   END LOOP;

END prc_ic_verificar_analise_criancas;
/

exec prc_ic_verificar_analise_criancas(17);

-- 
-- Function com cálculo
-- 

-- Função para retornar media de idade das crianças cadastradas

create or replace function fnc_ic_media_idade_criancas return number is 

    total_meses NUMBER := 0;
   qtd_criancas NUMBER := 0;

    CURSOR c_criancas IS
        SELECT birthday FROM tb_ic_child;

    data_nascimento DATE;
    idade_meses NUMBER;
    
    v_codigo_erro NUMBER;
    v_mensagem_erro VARCHAR2(250);

begin

   OPEN c_criancas;

   LOOP
      FETCH c_criancas INTO data_nascimento;

      EXIT WHEN c_criancas%NOTFOUND;

      idade_meses := TRUNC(MONTHS_BETWEEN(SYSDATE, data_nascimento));

      total_meses := total_meses + idade_meses;
      qtd_criancas := qtd_criancas + 1;
   END LOOP;

   CLOSE c_criancas;

   DECLARE
      media_meses NUMBER;
   BEGIN
      IF qtd_criancas > 0 THEN
         media_meses := total_meses / qtd_criancas;
         RETURN media_meses;
      ELSE
         RETURN NULL;
      END IF;
   END;

exception
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
end fnc_ic_media_idade_criancas;


-- Teste da function

DECLARE
   media_resultado NUMBER;
BEGIN
   media_resultado := fnc_ic_media_idade_criancas;

   IF media_resultado IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE('A média de idades das crianças é: ' || TO_CHAR(media_resultado, '999.99') || ' meses.');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Não há crianças cadastradas para calcular a média de idades.');
   END IF;
END;
/