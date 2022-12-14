
-- drop database db_alunos;

CREATE DATABASE DB_Alunos;
USE DB_Alunos;

-- GrauInstrucao
CREATE TABLE TB_GrauInstrucao
(idGrauInstrucao INT AUTO_INCREMENT NOT NULL
,nmGrauInstrucao VARCHAR(30) NOT NULL
,CONSTRAINT PK_GrauInstrucao PRIMARY KEY CLUSTERED (idGrauInstrucao ASC),
 CONSTRAINT UK_GrauInstrucao UNIQUE NONCLUSTERED (nmGrauInstrucao ASC)
);

-- CREATE UNIQUE INDEX UK_GrauInstrucao ON TB_GrauInstrucao (nmGrauInstrucao)

-- Sexo
CREATE TABLE TB_Sexo
(idSexo INT AUTO_INCREMENT NOT NULL
,nmSexo VARCHAR(10) NOT NULL
,CONSTRAINT PK_Sexo PRIMARY KEY CLUSTERED (idSexo ASC),
 CONSTRAINT UK_Sexo UNIQUE NONCLUSTERED (nmSexo ASC)
);

-- Hobby
CREATE TABLE TB_Hobby
(idHobby INT AUTO_INCREMENT NOT NULL
,nmHobby VARCHAR(30) NOT NULL
,CONSTRAINT PK_Hobby PRIMARY KEY CLUSTERED (idHobby ASC),
 CONSTRAINT UK_Hobby UNIQUE NONCLUSTERED (nmHobby ASC)
);

-- Curso
CREATE TABLE TB_Curso
(idCurso INT AUTO_INCREMENT NOT NULL
,nmCurso VARCHAR(50) NOT NULL
,CONSTRAINT PK_Curso PRIMARY KEY CLUSTERED (idCurso ASC),
 CONSTRAINT UK_Curso UNIQUE NONCLUSTERED (nmCurso ASC)
);

-- Aluno
CREATE TABLE TB_Aluno
(idAluno INT AUTO_INCREMENT NOT NULL
,nmAluno VARCHAR(50) NOT NULL
,deExperienciaProfissional VARCHAR(255)
,dtNascimento DATE
,idSexo INT NOT NULL
,idGrauInstrucao INT NOT NULL
,nuRA VARCHAR(8)
,CONSTRAINT PK_Aluno PRIMARY KEY CLUSTERED (idAluno ASC),
 CONSTRAINT UK_Aluno_RA UNIQUE NONCLUSTERED (nuRA ASC)
);

-- AlunoCurso
CREATE TABLE TB_AlunoCurso
(idAlunoCurso INT AUTO_INCREMENT NOT NULL
,idAluno INT NOT NULL
,idCurso INT NOT NULL
,dtConclusao DATE
,CONSTRAINT PK_AlunoCurso PRIMARY KEY CLUSTERED (idAlunoCurso ASC),
 CONSTRAINT UK_AlunoCurso UNIQUE NONCLUSTERED (idAluno ASC, idCurso ASC)
);

-- AlunoHobby
CREATE TABLE TB_AlunoHobby
(idAlunoHobby INT AUTO_INCREMENT NOT NULL
,idAluno INT NOT NULL
,idHobby INT NOT NULL
,CONSTRAINT PK_AlunoHobby PRIMARY KEY CLUSTERED (idAlunoHobby ASC),
 CONSTRAINT UK_AlunoHobby UNIQUE NONCLUSTERED (idAluno ASC, idHobby ASC)
);

-- ReferĂȘncias - FKs 
ALTER TABLE TB_Aluno
ADD CONSTRAINT FK_Aluno_Sexo FOREIGN KEY (idSexo) 
    REFERENCES TB_Sexo (idSexo);

ALTER TABLE TB_Aluno
ADD CONSTRAINT FK_Aluno_GrauInstrucao FOREIGN KEY (idGrauInstrucao) 
    REFERENCES TB_GrauInstrucao (idGrauInstrucao);

ALTER TABLE TB_AlunoCurso
ADD CONSTRAINT FK_AlunoCurso_Aluno FOREIGN KEY (idAluno) 
    REFERENCES TB_Aluno (idAluno);

ALTER TABLE TB_AlunoCurso
ADD CONSTRAINT FK_AlunoCurso_Curso FOREIGN KEY (idCurso) 
    REFERENCES TB_Curso (idCurso);

ALTER TABLE TB_AlunoHobby
ADD CONSTRAINT FK_AlunoHobby_Aluno FOREIGN KEY (idAluno) 
    REFERENCES TB_Aluno (idAluno);

ALTER TABLE TB_AlunoHobby
ADD CONSTRAINT FK_AlunoHobby_Hobby FOREIGN KEY (idHobby) 
    REFERENCES TB_Hobby (idHobby);
