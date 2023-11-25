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
    (p_id_child IN tb_ic_child.id_child%TYPE) IS
   v_name_child tb_ic_child.name_child%TYPE;
   v_birthday tb_ic_child.birthday%TYPE;
   v_idade_meses NUMBER;

BEGIN
   SELECT name_child, birthday INTO v_name_child, v_birthday
   FROM tb_ic_child
   WHERE id_child = p_id_child;

   v_idade_meses := TRUNC(MONTHS_BETWEEN(SYSDATE, v_birthday));

   IF v_idade_meses < 12 THEN
      DBMS_OUTPUT.PUT_LINE('A criança ' || v_name_child || ' deve fazer a análise uma vez por semana.');
   ELSIF v_idade_meses >= 12 AND v_idade_meses <= 60 THEN
      DBMS_OUTPUT.PUT_LINE('A criança ' || v_name_child || ' deve fazer a análise uma vez por mês.');
   ELSE
      DBMS_OUTPUT.PUT_LINE('A criança ' || v_name_child || ' deve fazer a análise a cada 3 meses.');
   END IF;

END prc_ic_verificar_analise_criancas;
/


exec prc_ic_verificar_analise_criancas(10);