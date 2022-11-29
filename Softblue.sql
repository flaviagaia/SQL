--Comandos de Criação de Tabelas:

--
-- Cria a tabela TIPO
--
CREATE TABLE TIPO (
 CODIGO SERIAL NOT NULL, -- Código interno (PK)
 TIPO VARCHAR(32) NOT NULL, -- Descrição
 PRIMARY KEY(CODIGO) -- Define o campo CODIGO como PK
);

--
-- Cria a tabela INSTRUTOR
--
CREATE TABLE INSTRUTOR (
 CODIGO SERIAL NOT NULL, -- Código interno (PK) 
 INSTRUTOR VARCHAR(64) NOT NULL, -- Nome com até 64
 TELEFONE VARCHAR(9) NULL, -- Telefone, podendo ser nulo 
 PRIMARY KEY(CODIGO) -- Define o campo CODIGO como PK
);

--
-- Cria a tabela CURSO
--
CREATE TABLE CURSO (
 CODIGO SERIAL NOT NULL, -- Código interno (PK)
 CURSO VARCHAR(64) NOT NULL, -- Título com até 64 caracteres
 TIPO INTEGER NOT NULL, -- Código do tipo de curso
 INSTRUTOR INTEGER NOT NULL,
 VALOR REAL NOT NULL, -- Valor do curso
 PRIMARY KEY(CODIGO), -- Define o campo CODIGO como PK
 FOREIGN KEY(TIPO) REFERENCES TIPO(CODIGO), -- Cria o
 FOREIGN KEY(INSTRUTOR) REFERENCES INSTRUTOR(CODIGO) -- Cria o
);

--
-- Cria a tabela ALUNO 
--
CREATE TABLE ALUNO (
 CODIGO SERIAL NOT NULL, -- Código interno (PK)
 ALUNO VARCHAR(64) NOT NULL, -- Nome com até 64 caracteres
 ENDERECO VARCHAR(230) NOT NULL, -- Endereço com até 230
 EMAIL VARCHAR(128) NOT NULL, -- E-mail com até 128 caracteres
 PRIMARY KEY(CODIGO) -- Define o campo CODIGO como PK
);

--
-- Cria a tabela PEDIDO
--
CREATE TABLE PEDIDO (
 CODIGO SERIAL NOT NULL, -- Código interno (PK)
 ALUNO INTEGER NOT NULL, -- Código do aluno 
 DATAHORA TIMESTAMP NOT NULL, -- Armazena data e hora em
 PRIMARY KEY(CODIGO), -- Define o campo CODIGO como PK
 FOREIGN KEY(ALUNO) REFERENCES ALUNO(CODIGO) -- Cria o
);

--
-- Cria a tabela PEDIDO_DETALHE 
--
CREATE TABLE PEDIDO_DETALHE (
 PEDIDO SERIAL NOT NULL, -- Código do pedido 
 CURSO INTEGER NOT NULL, -- Código do curso 
 VALOR REAL NOT NULL, -- Valor do curso
 PRIMARY KEY(PEDIDO, CURSO), -- Define a chave primária
 FOREIGN KEY(PEDIDO) REFERENCES PEDIDO(CODIGO), -- Cria o
 FOREIGN KEY(CURSO) REFERENCES CURSO(CODIGO) -- Cria o
);

--Comandos de Alteração de Estrutura da Tabela: 

--
-- Inclua a coluna DATA_NASCIMENTO na tabela ALUNO do tipo string, de tamanho 10 caracteres
--
ALTER TABLE ALUNO ADD DATA_NASCIMENTO VARCHAR(10);
ALTER TABLE ALUNO ADD COLUMN DATA_NASCIMENTO_02
VARCHAR(10);

-- Para retirada
ALTER TABLE ALUNO DROP COLUMN DATA_NASCIMENTO_02;

-- 
-- Altere a coluna DATA_NASCIMENTO para NASCIMENTO e seu tipo de dado para DATE
--
ALTER TABLE ALUNO ALTER COLUMN DATA_NASCIMENTO TYPE DATE
USING DATA_NASCIMENTO::DATE;

-- se a mudança não envolver tipo de dado o USING é dispensável.
ALTER TABLE ALUNO DROP COLUMN DATA_NASCIMENTO;

ALTER TABLE ALUNO ADD COLUMN MSG VARCHAR(60);

--
-- Inclua o campo EMAIL na tabela INSTRUTOR, com tamanho de 100 caracteres
--
ALTER TABLE INSTRUTOR ADD EMAIL VARCHAR(100);

--
-- Remova o campo EMAIL da tabela INSTRUTOR
--
ALTER TABLE INSTRUTOR DROP EMAIL; 

--Códigos de população de tabelas:

--
-- Tabela TIPO:
--
INSERT INTO TIPO (CODIGO, TIPO) VALUES (1, 'Banco de dados'), 
(2, 'Programação'),(3, 'Modelagem de dados');

--
-- Tabela INSTRUTOR:
--
INSERT INTO INSTRUTOR (INSTRUTOR, TELEFONE) VALUES ('André Milani',
'1111-1111'),
('Carlos Tosin', '1212-1212'),('Rodrigo Hagstrom', '1313-1313');

--
-- Tabela CURSO:
--
INSERT INTO CURSO (CODIGO, CURSO, TIPO, INSTRUTOR, VALOR) VALUES
(1, 'Java Fundamentos', 2, 2, 270);
INSERT INTO CURSO VALUES (2, 'Java Avançado', 2, 2, 330);
INSERT INTO CURSO VALUES (3, 'SQL Completo', 1, 1, 170);
INSERT INTO CURSO VALUES (4, 'Php Básico', 2, 1, 270);

--
-- Tabela ALUNO:
--
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (1,
'José', 'Rua XV de Novembro 72', 'jose@email.com.br');
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (2,
'Wagner', 'Av. Paulista', 'wagner@email.com.br');
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (3,
'Emílio', 'Rua Lajes 103, ap: 701', 'emilio@email.com.br'); 
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (4,
'Cris', 'Rua Tauney 22', 'cris@email.com.br');
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (5,
'Regina', 'Rua Salles 305', 'regina@email.com.br');
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (6,
'Fernando', 'Av. Central 30', 'fernando@email.com.br');

--
-- Tabela PEDIDO:
--
INSERT INTO PEDIDO (CODIGO, ALUNO, DATAHORA) VALUES (1, 2, '2020-04-15 11:23:32');
INSERT INTO PEDIDO VALUES (2, 2, '2020-04-15 14:36:21');
INSERT INTO PEDIDO VALUES (3, 3, '2020-04-16 11:17:45');
INSERT INTO PEDIDO VALUES (4, 4, '2020-04-17 14:27:22');
INSERT INTO PEDIDO VALUES (5, 5, '2020-04-18 11:18:19');
INSERT INTO PEDIDO VALUES (6, 6, '2020-04-19 13:47:35');
INSERT INTO PEDIDO VALUES (7, 6, '2020-04-20 18:13:44');

--
-- Tabela PEDIDO_DETALHE:
--
INSERT INTO PEDIDO_DETALHE (PEDIDO, CURSO, VALOR) VALUES (1, 1,
270)
,(1, 2, 330),(2, 1, 270),(2, 2, 330),(2, 3, 170),(3, 4, 270),(4, 2, 330)
,(4, 4, 270),(5, 3, 170),(6, 3, 170),(7, 4, 270); 

--Códigos de Queries (SELECTS em uma única tabela):

--O quarto aluno mais antigo
SELECT ALUNO FROM (SELECT DISTINCT ON (ALUNO) ALUNO.ALUNO,
DATAHORA FROM
PEDIDO INNER JOIN ALUNO ON PEDIDO.ALUNO = ALUNO.CODIGO 
ORDER BY ALUNO.ALUNO, DATAHORA) Q ORDER BY DATAHORA ASC LIMIT
1 OFFSET 3;

--O segundo e o terceiro alunos mais antigos
SELECT ALUNO FROM (SELECT DISTINCT ON (ALUNO) ALUNO.ALUNO,
DATAHORA FROM
PEDIDO INNER JOIN ALUNO ON PEDIDO.ALUNO = ALUNO.CODIGO 
ORDER BY ALUNO.ALUNO, DATAHORA) Q ORDER BY DATAHORA ASC LIMIT
2 OFFSET 1;

--O valor total de cada pedido realizado
SELECT PEDIDO, SUM(VALOR) FROM PEDIDO_DETALHE GROUP BY
PEDIDO;

--O valor do curso mais caro
SELECT MAX(VALOR) FROM CURSO; 

--Exiba o número do pedido, nome do aluno e quantos cursos foram comprados no pedido 
--para todos os pedidos realizados que compraram dois ou menos cursos

SELECT * FROM ALUNO;

--Crie uma Trigger que permita verificar o momento de inserção de dados na tabela aluno.


CREATE OR REPLACE FUNCTION ALUNO_gatilho() RETURNS TEXT AS $$
begin
	NEW.MSG :='ALUNO INSERIDO !';
	RETURN NEW;
end;
$$
language 'plpgsql';

CREATE TRIGGER ALUNO_gatilho BEFORE INSERT ON ALUNO
    FOR EACH ROW EXECUTE PROCEDURE ALUNO_gatilho();
--	
SELECT * FROM ALUNO;












