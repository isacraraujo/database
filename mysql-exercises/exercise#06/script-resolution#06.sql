############# Realizar as operações abaixo no banco de dados BD_Alunos
	USE bd_aluno;

#####01 - Incluir 11 alunos na tabela Aluno com dados diferentes.
	INSERT INTO tb_grauinstrucao
	(nome_grauInstrucao)
	VALUES
	('Ensino Fundamental','Ensino Médio','Ensino Superior','Pós-Graduação','Mestrado');

	INSERT INTO tb_aluno
	(nome_aluno,expProf,dateNasc,id_sexo,id_grauInstrucao,ra)
	VALUES
	('Alexandre Ferreira','Estagiário','10-10-2000',1,2,'22000001'),
	('Ana Clara','Estagiária','01-01-2001',2,2,'22000002'),
	('Angelo Jordão','Estudante universitário','30-06-1999',1,2,'22000003'),
	('Antônio Luiz','Não tenho','12-12-1999',1,3,'22000004'),
	('Bruno Rios','Programador Júnior','10-05-1999',1,2,'22000005'),
	('Carlos Henrique','Analista Pleno','08-02-1999',1,2,'22000006'),
	('Daniel Cunha','Estudante','25-05-2001',1,2,'22000007'),
	('Danilo Rebouças','Estagiário','20-05-2002',1,2,'22000008'),
	('Davi Pereira','Não possuo','14-04-1998',1,1,'22000009'),
	('Gabriela Souza','Engenheira','10-10-1990',2,4,'22000010'),
	('Gabriela Souza','Estagiária','10-10-2000',2,5,'22000011');

##### 02 - Incluir os cursos abaixo para os seguintes alunos:
#RA 22000010
	UPDATE tb_aluno SET id_curso = 1 WHERE id_aluno = 10;
#RA 22000011
	UPDATE tb_aluno SET id_curso = 2 WHERE id_aluno = 11;
#RA 22000011
	UPDATE tb_aluno SET id_curso = 3 WHERE id_aluno = 11;
#RA 22000007
	UPDATE tb_aluno SET id_curso = 1 WHERE id_aluno = 7;
#RA 22000009
	UPDATE tb_aluno SET id_curso = 2 WHERE id_aluno = 9;
#RA 22000010
	UPDATE tb_aluno SET id_curso = 3 WHERE id_aluno = 10;

##### 03 - Incluir o Hobby para os alunos abaixo:
	INSERT INTO tb_hobby
	(nome_hobby)
	VALUES
	('Futebol','Filme','Esporte','Música','Games');

#RA 22000001
	UPDATE tb_aluno SET id_curso = 1 WHERE id_aluno = 1;
#RA 22000002
	UPDATE tb_aluno SET id_curso = 2 WHERE id_aluno = 2;
#RA 22000003
	UPDATE tb_aluno SET id_curso = 3 WHERE id_aluno = 3;
#RA 22000004
	UPDATE tb_aluno SET id_curso = 4 WHERE id_aluno = 4;
#RA 22000005
	UPDATE tb_aluno SET id_curso = 5 WHERE id_aluno = 1;
#RA 22000006
	UPDATE tb_aluno SET id_curso = 6 WHERE id_aluno = 2;
#RA 22000007
	UPDATE tb_aluno SET id_curso = 7 WHERE id_aluno = 4;
#RA 22000007
	UPDATE tb_aluno SET id_curso = 7 WHERE id_aluno = 3;
#RA 22000007
	UPDATE tb_aluno SET id_curso = 7 WHERE id_aluno = 2;

##### 04 - Incluir o aluno abaixo.
	INSERT INTO tb_aluno
	(nome_aluno,expProf,dateNasc,sexo,id_grauInstrucao,ra)
	VALUES
	('Sérgio Souza','Programador','30-06-1967',1,5,'22000007')

##### 05  - Alterar a data de nascimento da aluna Ana Clara - RA 22000002 para 27/12/2001
	UPDATE tb_aluno SET dateNasc = '27-12-2001' WHERE id_aluno = 2;
    
##### 06 - Alterar a experiência profissional da aluna ‘Gabriela Souza’ de ‘Estagiária’
#####      para ‘Analista de Sistemas’
	UPDATE tb_aluno SET expProf = 'Estagiária' WHERE id_aluno = 11;

##### 07 - Atualizar o campo Grau de Instrução do aluno ‘Davi Pereira RA 22000009’ para ‘Ensino Médio’.
	UPDATE tb_aluno SET id_grauInstrucao = 2 WHERE id_aluno = 9;
    
##### 08 - Incluir o campo renda familiar (decimal(8,2) ou money) na tabela aluno.
	ALTER TABLE tb_aluno ADD COLUMN renda_familiar DECIMAL(8,2) AFTER ra;

##### 09 - Atualizar o campo renda familiar de todos os alunos para R$1.000,00
	UPDATE tb_aluno SET renda_familiar = 1000.00 WHERE id_aluno IS NOT NULL;

##### 10 - Aumentar em 200% o valor da renda familiar de todos os alunos do sexo ‘Masculino’
#####      e 300% a do sexo ‘Feminino’



##### 11 - Excluir o registro do aluno ‘Danilo Rebouças RA 22000008’
	DELETE FROM tb_aluno WHERE id_aluno=8 OR ra=22000008;

##### 12 - Excluir o aluno ‘Alexandre Ferreira RA 22000001’ **
	DELETE FROM tb_aluno WHERE id_aluno=8 OR ra=22000001;

##### 13 - Excluir todos os cursos e hobbies relacionados ao aluno ‘Antônio Luiz RA 22000004’



##### 14 - Excluir o registro do aluno ‘Antônio Luiz - RA 22000004’
	DELETE FROM tb_aluno WHERE id_aluno=4 OR ra=22000004;

##### 15 - Listar todos os alunos do sexo Feminino
	SELECT id_sexo = 2 FROM tb_aluno;

##### 16 - Listar todos os alunos do sexo Masculino em ordem alfabética ascendente
	SELECT id_sexo = 1 FROM tb_aluno ORDER BY nome_aluno ASC;
