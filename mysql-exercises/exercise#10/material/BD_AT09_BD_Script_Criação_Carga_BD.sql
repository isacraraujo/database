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

INSERT INTO tb_setor (sigla, setor) VALUES ('DENF','Enfermaria');
INSERT INTO tb_setor (sigla, setor) VALUES ('DADM','Administração');
INSERT INTO tb_setor (sigla, setor) VALUES ('DINF','Informática');
INSERT INTO tb_setor (sigla, setor) VALUES ('DENG','Engenharia');
INSERT INTO tb_setor (sigla, setor) VALUES ('DJUR','Jurídico');
INSERT INTO tb_setor (sigla, setor) VALUES ('DLOG','Logística');
INSERT INTO tb_setor (sigla, setor) VALUES ('DPRE','Presidência');

SELECT * FROM tb_setor;

INSERT INTO tb_cargo (sigla, cargo) VALUES ('ENF','Enfermeiro(a)');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('ADM','Administrador(a)');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('ANA','Analista');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('ENG','Engenheiro(a)');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('ADV','Advogado(a)');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('GER','Gerente');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('EXE','Executivo(a)');

SELECT * FROM tb_cargo;

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (1, 'Ana Clara', '11111111111', '1977-07-05', 5, 1, 3000, null);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (2, 'Patrícia Azevedo','22222222222', '1944-07-04', 1, 1, 4000, null);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (3, 'José Maria',      '33333333333','1971-05-10', 3, 1, 6000, null);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (4, 'Sônia Abrantes',  '44444444444','1979-05-29', 4, 1, 7000, null);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (5, 'Valdir Reinaldo', '55555555555','1960-09-22', 2, 2, 16000, null);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (7, 'José Alberto',    '77777777777','1955-01-13', 2, 2, 15000, NULL);

SELECT * FROM tb_funcionario;

UPDATE tb_funcionario SET id_funcionario_chefe = 5 
WHERE MATRICULA NOT IN (5,8);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (8, 'Jorge Duboc',    '88888888888','1967-01-10', 2, 2, 20000, NULL);

UPDATE tb_funcionario SET id_funcionario_chefe = (select F.id_funcionario from (SELECT * FROM tb_funcionario) AS F where F.matricula = 8)
WHERE matricula = 5;

SELECT F.id_funcionario, F.matricula, F.nome, F.SALARIO, C.cargo, S.setor, FC.nome AS CHEFE FROM tb_funcionario F
	INNER JOIN tb_cargo C
		ON C.id_cargo = f.id_cargo
	INNER JOIN tb_setor S
		ON S.id_setor = F.id_setor
	LEFT JOIN tb_funcionario FC
		ON FC.id_funcionario = F.id_funcionario_chefe;