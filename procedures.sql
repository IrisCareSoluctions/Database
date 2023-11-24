
-- Procedure para ralizar o inserção de um usuário

create or replace procedure prc_ic_cadastra_usuario(
    name in varchar2,
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
        RAISE_APPLICATION_ERROR(-20002, 'Não foi encontrado o caracter @ no email');
    END IF;

    INSERT INTO TB_IC_USER (ID_USER, NAME, EMAIL, PASSWORD, BIRTHDAY, CPF, STATUS)
    VALUES(seq_tb_ic_user.NEXTVAL, name, email, password, birthday, cpf, 'ATIVO');
  
exception
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em coluna unica.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message_error)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
        
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Violou a restricao de tamanho.');

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
        VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_USUARIO');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_IC_ERROS (id_erro, nm_user, date_error, cd_error, message_error)
        VALUES (seq_tb_ic_erros.NEXTVAL, USER, SYSDATE, v_codigo_erro, v_mensagem_erro);
  
end prc_ic_cadastra_usuario;


-- Procedure para ralizar o inserção de um usuário

create or replace procedure prc_ic_cadastra_telefone() as
begin

  DBMS_OUTPUT.PUT_LINE('Criou');
  
end;

-- Realização das inserções

exec prc_ic_cadastra_usuario('Vinicius de Oliveira', 'vini@gmail.com', '123', to_date('01/05/2003', 'dd/mm/yyyy'), '52467645184');