use db_aluno;

INSERT INTO TB_Curso (nmCurso)
VALUES ('Medicina')
,('Engenharia Civil')
,('Direito')
,('Arquitetura')
,('Ciência da Computação')
,('Análise de Sistemas');

SELECT * FROM TB_Curso
ORDER BY idCurso;

INSERT INTO TB_GrauInstrucao (nmGrauInstrucao, nuGrauInstrucao) 
VALUES ('Ensino Fundamental',0),('Ensino Médio',1),('Graduação',2),('Especialização',3),('Mestrado',4),('Doutorado',5);

SELECT * FROM TB_GrauInstrucao
ORDER BY 1;

INSERT INTO TB_Hobby (nmHobby) VALUES ('Leitura'),('Filmes'),('Futebol'),('Games'),('Música');

SELECT * FROM TB_Hobby ORDER BY 2;

INSERT INTO TB_Sexo (nmSexo) VALUES ('Masculino'),('Feminino');

SELECT * FROM TB_Sexo;

INSERT INTO `db_aluno`.`tb_aluno`
(`nmAluno`,
`deExperienciaProfissional`,
`dtNascimento`,
`idSexo`,
`idGrauInstrucao`,
`idCurso`,
`nuRA`,
`nuCPF`)
VALUES
('CARLOS HENRIQUE',
NULL,
'2001-01-01',
1,
16,
NULL,
22100212,
'12345678901');

select * from tb_Aluno;
SELECT * FROM TB_GRAUINSTRUCAO;
delete from tb_aluno;

INSERT INTO TB_Aluno
(`nmAluno`,
`deExperienciaProfissional`,
`dtNascimento`,
`idSexo`,
`idGrauInstrucao`,
`idCurso`,
`nuRA`,
`nuCPF`)
SELECT 
	Nome,
    null as deExperienciaProfissional,
    '2005-01-01' as datanascimento,
    (SELECT idSexo FROM TB_SEXO WHERE nmSexo = Sexo) as sexo,
    16 as grauinstrucao,
    null as curso,
    RA as RA,
    (RA*1000) as CPF
FROM EXCEL_ALUNOS;

select * from tb_aluno;
select * from EXCEL_ALUNOS;
SELECT idSexo FROM TB_SEXO WHERE nmSexo = 'Masculino';