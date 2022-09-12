# Criar banco de dados do MER em anexo "MER - BD_RH.png
create database db_rh;
use db_rh;

CREATE TABLE tb_funcionario (
	id_funcionario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	matricula INT NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(100) NOT NULL,
	dt_nascimento DATE NOT NULL,
	salario NUMERIC(9,2) NOT NULL,
	id_setor INT NOT NULL,
	id_cargo INT NOT NULL,
	id_funcionario_chefe INT NULL
	);

CREATE TABLE tb_setor (
	id_setor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	sigla VARCHAR(10) NOT NULL,
	setor VARCHAR(30) NOT NULL
	);

CREATE TABLE tb_cargo (
	id_cargo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	sigla VARCHAR(10) NOT NULL,
	cargo VARCHAR(30) NOT NULL
	);

ALTER TABLE tb_funcionario 
	ADD CONSTRAINT fk_setor FOREIGN KEY (id_setor) 
		REFERENCES tb_setor (id_setor);

ALTER TABLE tb_funcionario 
	ADD CONSTRAINT fk_cargo FOREIGN KEY (id_cargo) 
	    REFERENCES tb_cargo (id_cargo);

ALTER TABLE tb_funcionario 
	ADD CONSTRAINT fk_chefe FOREIGN KEY (id_funcionario_chefe) 
	    REFERENCES tb_funcionario (id_funcionario);

CREATE UNIQUE INDEX uk_funcionario_matricula ON tb_funcionario (matricula);
CREATE UNIQUE INDEX uk_funcionario_cpf ON tb_funcionario (cpf);
CREATE UNIQUE INDEX uk_setor ON tb_setor (sigla);
CREATE UNIQUE INDEX uk_cargo ON tb_cargo (sigla);
#__________________________________________________________________________________________________________________

# Criar os comandos SQL para resolver as questões do exercício "AT09 - BD - Exercício Comandos SQL - BD_RH.docx"
# 01 - Listar todos os campos tb_funcionario ordenados por nome decrescente;
SELECT * FROM TB_FUNCIONARIO ORDER BY NOME DESC;

# 02 - Listar os dois primeiros registros (todos campos) da  tb_funcionario
SELECT * FROM TB_FUNCIONARIO LIMIT 2;

# 03 - Listar todos os campos da tb_funcionario cujo nome contenha “an”
SELECT * FROM TB_FUNCIONARIO WHERE NOME LIKE '%an%';

# 04 - Listar as três primeiras matrículas com álias “Código”, nome do funcionário da tb_funcionario
SELECT ID_FUNCIONARIO, NOME FROM TB_FUNCIONARIO LIMIT 3;

# 05 - Listar os código de cargo “cd_cargo” existentes na tb_funcionario sem repetição
SELECT DISTINCT ID_CARGO FROM TB_funcionario;

# 06 - Listar ‘Matrícula = ‘ + matricula + ‘ nome = ‘ + nome da tb_funcionario
SELECT CONCAT('Matricula = ', matricula, 'nome = ', nome) as mat_nome from tb_funcionario;

# 07 - Listar os setores da tabela tb_setor em ordem decrescente
SELECT * FROM TB_SETOR ORDER BY SETOR DESC;

# 08 - Listar todos os setores cujo nome termina em “aria”
SELECT * FROM TB_SETOR WHERE SETOR LIKE '%aria';

# 09 - Listar todos os registros onde o setor comece com “E”
SELECT * FROM TB_SETOR WHERE SETOR LIKE 'E%';

# 10 - Listar qual é o setor que paga o maior salário
SELECT
   SETOR,
   SALARIO
FROM
   TB_SETOR S
INNER JOIN
   TB_FUNCIONARIO ON TB_FUNCIONARIO.ID_SETOR = S.ID_SETOR
WHERE
   TB_FUNCIONARIO.SALARIO ORDER BY SALARIO DESC LIMIT 1;

# 11 - Listar os funcionários que são do setor diferente de 1 ou salario > 5000 por ordem alfabética de nomes
SELECT *
FROM TB_FUNCIONARIO
WHERE ID_SETOR <> 1
OR SALARIO > 5000
ORDER BY NOME;

# 12 - Listar os funcionários que são do setor “Administração” e salario > ou = 16000 por ordem decrescente de nomes
SELECT * FROM TB_FUNCIONARIO WHERE ID_SETOR = 2 OR SALARIO > 16000;

#13 - Listar os nomes dos funcionários, salario e salário com aumento de 20% por ordem decrescente de salário aumentado

#14 - Listar o cargo que tem o menor salário

#15 - Listar todos os funcionários com matrícula, nome, salário, nome do cargo e nome do setor em ordem de setor, cargo e nome do funcionário

#16 - Listar todos os chefes e seus funcionários ex: matrícula do chefe, nome do chefe, nome do funcionário, salário do funcionário, cargo do funcionário e setor do funcionário







