-- 01 - Incluir 11 alunos na tabela Aluno com dados diferentes.
use db_alunos;

INSERT INTO TB_Sexo (nmSexo)
VALUES 
	('Feminino')
	,('Masculino');

-- Carga de Curso


INSERT INTO TB_Curso (nmCurso) 
VALUES ('Medicina'),('Direito'),('Psicologia'),('Engenharia Civil'),('Ciência da Computação'),('Análise de Sistemas');

select * from tb_curso;

-- Grau de Instrução 
INSERT INTO TB_GrauInstrucao (nmGrauInstrucao)
VALUES 
	('Ensino Fundamental')
	,('Ensino Médio')
	,('Superior Completo')
	,('Pós-graduação')
	,('Mestrado')
	,('Doutorado');

select * from TB_GrauInstrucao order by idGrauInstrucao;

-- Hobby

INSERT INTO TB_Hobby (nmHobby)
VALUES 
	('Futebol')
	,('Filmes')
	,('Esporte')
	,('Leitura')
	,('Música')
	,('Viagem')
	,('Games');



select * from tb_aluno;

select * from tb_sexo;

-- 01 - 

INSERT INTO tb_Aluno 
	(nmAluno
	,deExperienciaProfissional
	,dtNascimento
	,idSexo
	,idGrauInstrucao
	,nuRA) 
VALUES
("Alexandre Ferreira", "Estagiário", "2000-10-10", 1, 2, "22000001"),
("Ana Clara",        "Estagiária", "2001-01-01", 2, 2, "22000002"),
("Angelo Jordão", "Estudante universitário", "1999-06-30", 1, 2, "22000003"),
("Antônio Luiz", "Não tenho", "1999-12-12", 1, 3, "22000004"),
("Bruno Rios",     "Programador Júnior", "1999-05-10", 1, 2, "22000005"),
("Carlos Henrique", "Analista Pleno", "1999-02-08", 1, 2, "22000006"),
("Daniel Cunha", "Estudante", "2001-05-25", 1, 3, "22000007"),
("Danilo Rebouca", "Estagiário", "2002-05-20", 1, 2, "22000008"),
("Davi Pereira", "Não possuo", "1998-04-14", 1, 1, "22000009"),
("Gabriela Souza", "Engenheira", "1990-10-10", 2, 4, "22000010"),
("Gabriela Souza", "Estagiária", "2000-10-10", 2, 5, "22000011");

-- 02 - Incluir os cursos abaixo para os seguintes alunos
-- Engenharia Civil	Gabriela Souza	22000010
-- Análise de Sistemas	Gabriela Souza	22000011
-- Direito	Gabriela Souza	22000011
-- Direito	Daniel Cunha	22000007
-- Análise de Sistemas 	Davi Pereira	22000009
-- Análise de Sistemas	Antônio Luiz	22000004

SELECT * FROM TB_ALUNOCURSO;

SELECT * FROM TB_ALUNO WHERE nuRA = 22000010;
SELECT idCurso FROM TB_Curso where nmCurso = 'Engenharia Civil';

INSERT INTO TB_ALUNOCURSO (idAluno, idCurso) 
VALUES ((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000010)
       ,(SELECT idCurso FROM TB_Curso where nmCurso = 'Engenharia Civil')),
       ((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000011)
       ,(SELECT idCurso FROM TB_Curso where nmCurso = 'Análise de Sistemas')),
       ((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000011)
       ,(SELECT idCurso FROM TB_Curso where nmCurso = 'Direito')),
       ((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000007)
       ,(SELECT idCurso FROM TB_Curso where nmCurso = 'Direito')),
       ((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000009)
       ,(SELECT idCurso FROM TB_Curso where nmCurso = 'Análise de Sistemas')),       
       ((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000004)
       ,(SELECT idCurso FROM TB_Curso where nmCurso = 'Análise de Sistemas'));  

SELECT * FROM TB_ALUNOCURSO AC
	INNER JOIN TB_ALUNO A 
		ON A.idAluno = AC.idAluno
	INNER JOIN TB_Curso C 
		ON C.idCurso = AC.idCurso;
        
-- 03 -- Incluir o Hobby para os alunos abaixo:
/* Alexandre Ferreira	Futebol	22000001
Ana Clara	Filme	22000002
Angelo Jordão	Esporte	22000003
Antônio Luiz	Música	22000004
Bruno Rios	Futebol	22000005
Carlos Henrique	Filme	22000006
Daniel Cunha	Games	22000007
Daniel Cunha	Música	22000007
Daniel Cunha	Filme	22000007
*/ 
select * from tb_hobby;
SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000001;
SELECT idHobby FROM TB_Hobby where nmHobby = 'Futebol';
       
INSERT INTO TB_ALUNOHOBBY (idAluno, idHobby)
VALUES ((SELECT idAluno FROM TB_ALUNO WHERE nuRA = '22000001')
       ,(SELECT idHobby FROM TB_Hobby where nmHobby = 'Futebol')),
		((SELECT idAluno FROM TB_ALUNO WHERE nuRA = '22000002')
       ,(SELECT idHobby FROM TB_Hobby where nmHobby = 'Filmes')),
		((SELECT idAluno FROM TB_ALUNO WHERE nuRA = '22000003')
       ,(SELECT idHobby FROM TB_Hobby where nmHobby = 'Esporte')),
		((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000004)
       ,(SELECT idHobby FROM TB_Hobby where nmHobby = 'Música')),
		((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000005)
       ,(SELECT idHobby FROM TB_Hobby where nmHobby = 'Futebol')),
		((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000006)
       ,(SELECT idHobby FROM TB_Hobby where nmHobby = 'Filmes')),
		((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000007)
       ,(SELECT idHobby FROM TB_Hobby where nmHobby = 'Games')),
		((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000007)
       ,(SELECT idHobby FROM TB_Hobby where nmHobby = 'Música')),
		((SELECT idAluno FROM TB_ALUNO WHERE nuRA = 22000007)
       ,(SELECT idHobby FROM TB_Hobby where nmHobby = 'Filmes'));
	
SELECT * FROM TB_ALUNOHOBBY AH
	INNER JOIN TB_ALUNO A 
		ON A.idAluno = AH.idAluno
	INNER JOIN TB_HOBBY H
		ON H.idHobby = AH.idHobby
ORDER BY nmAluno, nmHobby;

-- 04 - Incluir o aluno abaixo
INSERT INTO tb_Aluno 
	(nmAluno
	,deExperienciaProfissional
	,dtNascimento
	,idSexo
	,idGrauInstrucao
	,nuRA) 
VALUES
("Sérgio Souza", "Programador", "1967-06-30", 1, 6, "22000007");

-- 05  - Alterar a data de nascimento da aluna ‘Ana Clara - RA 22000002’ para ‘27/12/2001’ 
set sql_safe_updates = 0;

UPDATE TB_ALUNO SET dtNascimento = '2001-12-27'
WHERE nuRA = '22000002';

SELECT * FROM TB_ALUNO WHERE nuRA = '22000002';

-- 06 - Alterar a experiência profissional da aluna ‘Gabriela Souza’ de ‘Estagiária’ para ‘Analista de Sistemas’
select * from tb_aluno where nmAluno = 'Gabriela Souza';

UPDATE TB_ALUNO SET deExperienciaProfissional = 'Analista de Sistemas'
WHERE nmAluno = 'Gabriela Souza'
	AND deExperienciaProfissional = 'Estagiária';

-- 07 - Atualizar o campo Grau de Instrução do aluno ‘Davi Pereira RA 22000009’ para ‘Ensino Médio’
select * from tb_aluno where nuRA = '22000009';

UPDATE TB_Aluno 
	SET idGrauInstrucao = 
        (SELECT idGrauInstrucao 
           FROM TB_GRAUINSTRUCAO 
           WHERE nmGrauInstrucao = 'Ensino Médio')
WHERE nuRA = '22000009';

-- 08 - Incluir o campo renda familiar (decimal(8,2) ou money) na tabela aluno

ALTER TABLE TB_ALUNO 
ADD COLUMN vrRendaFamiliar DECIMAL(8,2) NULL AFTER nuRA;

select * from tb_aluno;

-- 09 - Atualizar o campo renda familiar de todos os alunos para R$1.000,00

UPDATE TB_ALUNO SET vrRendaFamiliar = 1000;

select * from tb_aluno;

-- 10 - 
    
    