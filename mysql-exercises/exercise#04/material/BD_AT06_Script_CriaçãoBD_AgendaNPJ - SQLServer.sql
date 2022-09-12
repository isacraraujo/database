CREATE DATABASE DB_Agenda
USE DB_Agenda

CREATE TABLE TB_Assistido
(idAssistido INT NOT NULL PRIMARY KEY IDENTITY,
nuCPF VARCHAR(11) NOT NULL,
nuIdentidade VARCHAR(30) NOT NULL,
nmAssistido VARCHAR(100) NOT NULL,
deEndereco VARCHAR(100) NOT NULL,
coSenha VARCHAR(50) NOT NULL,
edIPAceiteTermo VARCHAR (30),
dtAceiteTermo DATETIME)

CREATE UNIQUE INDEX UK_Assistido ON TB_Assistido(nuCPF)

CREATE TABLE TB_LocalAtendimento
(idLocalAtendimento INT NOT NULL PRIMARY KEY IDENTITY,
nmLocalAtendimento VARCHAR(50) NOT NULL,
deEndereco VARCHAR(100) NOT NULL)

CREATE UNIQUE INDEX UK_LocalAtendimento ON TB_LocalAtendimento(nmLocalAtendimento)

CREATE TABLE TB_AreaJuridica
(idAreaJuridica INT NOT NULL PRIMARY KEY IDENTITY,
sgAreaJuridica VARCHAR(20) NOT NULL,
nmAreaJuridica VARCHAR(30) NOT NULL)

CREATE UNIQUE INDEX UK_AreaJuridica ON TB_AreaJuridica(nmAreaJuridica)

CREATE TABLE TB_LocalAtendimentoAreaJuridica
(idLocalAtendimentoAreaJuridica INT NOT NULL PRIMARY KEY IDENTITY,
idAreaJuridica INT NOT NULL,
idLocalAtendimento INT NOT NULL
CONSTRAINT [UK_LocalAtendimentoAreaJuridica]
UNIQUE NONCLUSTERED([idAreaJuridica] ASC, [idLocalAtendimento] ASC))

CREATE TABLE TB_HorarioAtendimento
(idHorarioAtendimento INT NOT NULL PRIMARY KEY IDENTITY,
dtAtendimento DATE NOT NULL,
hrInicioAtendimento TIME NOT NULL,
hrFimAtendimento TIME NOT NULL,
qtVagas SMALLINT NOT NULL,
icAtivo BIT NOT NULL,
idLocalAtendimentoAreaJuridica INT NOT NULL
CONSTRAINT [UK_HorarioAtendimento]
UNIQUE NONCLUSTERED(dtAtendimento ASC, hrInicioAtendimento ASC, idLocalAtendimentoAreaJuridica ASC))

CREATE TABLE TB_Agendamento
(idAgendamento INT NOT NULL PRIMARY KEY IDENTITY,
idHorarioAtendimento INT NOT NULL,
idAssistido INT NOT NULL,
dtAgendamento DATETIME NOT NULL
CONSTRAINT [UK_Agendamento] 
UNIQUE NONCLUSTERED(idHOrarioAtendimento ASC, idAssistido ASC))

-- REFERENCIAS FKS --

ALTER TABLE TB_LocalAtendimentoAreaJuridica
ADD CONSTRAINT FK_AreaJuridica_LocalAtendimento FOREIGN KEY (idAreaJuridica) 
REFERENCES TB_AreaJuridica(idAreaJuridica)

ALTER TABLE TB_LocalAtendimentoAreaJuridica
ADD CONSTRAINT FK_LocalAtendimentoAreaJuridica FOREIGN KEY (idLocalAtendimento) 
REFERENCES TB_LocalAtendimento(idLocalAtendimento)

ALTER TABLE TB_HorarioAtendimento
ADD CONSTRAINT FK_LocalAtendimento_HorarioAtendimento FOREIGN KEY (idLocalAtendimentoAreaJuridica) 
REFERENCES TB_LocalAtendimentoAreaJuridica(idLocalAtendimentoAreaJuridica)

ALTER TABLE TB_Agendamento
ADD CONSTRAINT FK_Agendamento_HorarioAtendimento FOREIGN KEY (idHorarioAtendimento)
REFERENCES TB_HorarioAtendimento(idHorarioAtendimento)

ALTER TABLE TB_Agendamento
ADD CONSTRAINT TB_Agendamento_HorarioAtendimento FOREIGN KEY (idAssistido)
REFERENCES TB_Assistido(idAssistido)