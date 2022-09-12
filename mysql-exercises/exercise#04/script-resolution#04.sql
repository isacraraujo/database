CREATE DATABASE db_agenda;
USE db_agenda;

CREATE TABLE tb_assistido
(idAssistido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nuCPF VARCHAR(11) NOT NULL,
nuIdentidade VARCHAR(30) NOT NULL,
nmAssistido VARCHAR(100) NOT NULL,
deEndereco VARCHAR(100) NOT NULL,
coSenha VARCHAR(50) NOT NULL,
edIPAceiteTermo VARCHAR (30),
dtAceiteTermo DATETIME(3));

CREATE UNIQUE INDEX uk_Assistido ON tb_Assistido(nuCPF)

CREATE TABLE tb_LocalAtendimento
(idLocalAtendimento INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nmLocalAtendimento VARCHAR(50) NOT NULL,
deEndereco VARCHAR(100) NOT NULL);

CREATE UNIQUE INDEX UK_LocalAtendimento ON tb_LocalAtendimento(nmLocalAtendimento)

CREATE TABLE tb_AreaJuridica
(idAreaJuridica INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
sgAreaJuridica VARCHAR(20) NOT NULL,
nmAreaJuridica VARCHAR(30) NOT NULL);

CREATE UNIQUE INDEX uk_AreaJuridica ON tb_AreaJuridica(nmAreaJuridica)

CREATE TABLE tb_LocalAtendimentoAreaJuridica
(idLocalAtendimentoAreaJuridica INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
idAreaJuridica INT NOT NULL,
idLocalAtendimento INT NOT NULL
CONSTRAINT [UK_LocalAtendimentoAreaJuridica]
UNIQUE (`idAreaJuridica` ASC, `idLocalAtendimento` ASC));

CREATE TABLE tb_HorarioAtendimento
(idHorarioAtendimento INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
dtAtendimento DATE NOT NULL,
hrInicioAtendimento TIME(6) NOT NULL,
hrFimAtendimento TIME(6) NOT NULL,
qtVagas SMALLINT NOT NULL,
icAtivo TINYINT NOT NULL,
idLocalAtendimentoAreaJuridica INT NOT NULL
CONSTRAINT [UK_HorarioAtendimento]
UNIQUE (dtAtendimento ASC, hrInicioAtendimento ASC, idLocalAtendimentoAreaJuridica ASC));

CREATE TABLE tb_Agendamento
(idAgendamento INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
idHorarioAtendimento INT NOT NULL,
idAssistido INT NOT NULL,
dtAgendamento DATETIME(3) NOT NULL
CONSTRAINT [UK_Agendamento] 
UNIQUE (idHOrarioAtendimento ASC, idAssistido ASC));

ALTER TABLE tb_LocalAtendimentoAreaJuridica
ADD CONSTRAINT FK_AreaJuridica_LocalAtendimento FOREIGN KEY (idAreaJuridica) 
REFERENCES TB_AreaJuridica(idAreaJuridica);

ALTER TABLE tb_LocalAtendimentoAreaJuridica
ADD CONSTRAINT FK_LocalAtendimentoAreaJuridica FOREIGN KEY (idLocalAtendimento) 
REFERENCES TB_LocalAtendimento(idLocalAtendimento);

ALTER TABLE tb_HorarioAtendimento
ADD CONSTRAINT FK_LocalAtendimento_HorarioAtendimento FOREIGN KEY (idLocalAtendimentoAreaJuridica) 
REFERENCES TB_LocalAtendimentoAreaJuridica(idLocalAtendimentoAreaJuridica);

ALTER TABLE tb_Agendamento
ADD CONSTRAINT FK_Agendamento_HorarioAtendimento FOREIGN KEY (idHorarioAtendimento)
REFERENCES TB_HorarioAtendimento(idHorarioAtendimento);

ALTER TABLE tb_Agendamento
ADD CONSTRAINT TB_Agendamento_HorarioAtendimento FOREIGN KEY (idAssistido)
REFERENCES TB_Assistido(idAssistido);