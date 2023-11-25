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