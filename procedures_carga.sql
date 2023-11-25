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


-- Realização das inserções, 5 inserções por tabela

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