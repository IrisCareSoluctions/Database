
-- Procedure para ralizar o inserção de um usuário

create or replace procedure prc_ic_cadastra_usuario(
    name in varchar2,
    email in varchar2,
    password in varchar2,
    birthday in date,
    cpf in date
) as
    v_cpf_formatado VARCHAR2(11);
begin

    v_cpf_formatado := REPLACE(REPLACE(cpf, '.', ''), '-', '');
    
    IF LENGTH(v_cpf_formatado) <> 11 THEN
        RAISE_APPLICATION_ERROR(-20002, 'CPF deve ter 11 dígitos.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Criou');
  
exception
    when others then
      -- Tratamento ou registro da exceção
      DBMS_OUTPUT.PUT_LINE('Exceção capturada: ' || SQLERRM);
  
end prc_ic_cadastra_usuario;

-- Procedure para ralizar o inserção de um usuário

create or replace procedure prc_ic_cadastra_telefone() as
begin

  DBMS_OUTPUT.PUT_LINE('Criou');
  
end;
