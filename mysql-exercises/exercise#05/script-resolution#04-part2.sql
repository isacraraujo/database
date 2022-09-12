CREATE DATABASE bd_aluno;
USE bd_aluno;

CREATE TABLE `tb_curso`
(`id_curso` int NOT NULL AUTO_INCREMENT ,
 `nome_curso`        varchar(50) NULL,
PRIMARY KEY (`id_curso`)
);

CREATE TABLE `tb_grauInstrucao`
(`id_grauInstrucao` int NOT NULL AUTO_INCREMENT ,
 `nome_grauInstrucao`        varchar(50) NULL,
PRIMARY KEY (`id_grauInstrucao`)
);

CREATE TABLE `tb_hobby`
(`id_hobby` int NOT NULL AUTO_INCREMENT ,
 `nome_hobby`        varchar(50) NULL,
PRIMARY KEY (`id_hobby`)
);

CREATE TABLE `tb_sexo`
(`id_sexo` int NOT NULL AUTO_INCREMENT ,
 `nome_sexo`        varchar(50) NULL,
PRIMARY KEY (`id_sexo`)
);

#______________Popular Tabelas do BD_Aluno____________________________

INSERT INTO tb_curso (nome_curso) VALUES ('Medicina'),('Engenharia Civil'),('Direito'),
('Ciência da Computação'),('Análise de Sistemas');

INSERT INTO tb_grauInstrucao (nome_grauInstrucao) VALUES ('Ensino Fundamental'),
('Ensino Médio'),('Graduação'),
('Especialização'),('Mestrado'),('Doutorado');

INSERT INTO tb_hobby (nome_hobby) VALUES ('Leitura'),('Filmes'),('Futebol'),
('Games'),('Música');

INSERT INTO tb_sexo (nome_sexo) VALUES ('Masculino'),('Feminino');

#______________Visualizar Dados Inseridos nas Tabelas______________
SELECT * FROM tb_curso;
SELECT * FROM tb_grauInstrucao;
SELECT * FROM tb_hobby;
SELECT * FROM tb_sexo;

#______________Atualizar Dados Inseridos nas Tabelas______________
UPDATE tb_curso SET nome_curso='Medicina Veterinária' WHERE id_curso=1;
UPDATE tb_grauInstrucao SET nome_grauInstrucao='PhD' WHERE id_grauInstrucao=6;
UPDATE tb_hobby SET nome_hobby='Jogos' WHERE id_hobby=4;
UPDATE tb_sexo SET nome_sexo='Homem' WHERE id_sexo=1;

#______________Deletar Dados Inseridos nas Tabelas______________
DELETE FROM tb_curso WHERE id_curso=1;