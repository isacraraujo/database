USE DB_AGENDA;
-- 1) Na tabela 'assistido'
ALTER TABLE tb_assistido 
ADD COLUMN logradouro VARCHAR(100) NOT NULL;
ALTER TABLE tb_assistido 
ADD COLUMN numeo VARCHAR(10) NOT NULL;
ALTER TABLE tb_assistido 
ADD COLUMN cep CHAR(8) NOT NULL;
ALTER TABLE tb_assistido
ADD COLUMN bairro VARCHAR(100);
ALTER TABLE tb_assistido
ADD COLUMN complemento VARCHAR(100) NOT NULL;
ALTER TABLE tb_assistido 
DROP COLUMN deEndereco;

ALTER TABLE tb_assistido
MODIFY COLUMN nuIdentidade VARCHAR(30) NULL;

-- 2) na tabela Agendamento 
ALTER TABLE TB_Agendamento
MODIFY COLUMN dtAgendamento DATETIME NOT NULL DEFAULT NOW();

-- 3) Crie uma tabela de Endereço e relacioná-la ao Assistido 
CREATE TABLE TB_Endereco
(idEndereco INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
logradouro VARCHAR(100) NOT NULL,
numero VARCHAR(10) NOT NULL,
cep CHAR(8) NOT NULL,
bairro VARCHAR(100),
complemento VARCHAR(100) NOT NULL,
idAssistido INT NOT NULL,
CONSTRAINT UQ_Endereco_idAssistido_cep UNIQUE (idAssistido, cep),
CONSTRAINT FK_Endereco_Assistido FOREIGN KEY (idAssistido) 
REFERENCES TB_Assistido (idAssistido));

ALTER TABLE tb_assistido 
DROP COLUMN logradouro;
ALTER TABLE tb_assistido 
DROP COLUMN numeo;
ALTER TABLE tb_assistido 
DROP COLUMN cep;
ALTER TABLE tb_assistido
DROP COLUMN bairro;
ALTER TABLE tb_assistido
DROP COLUMN complemento;

-- 4) Incluir os colaboradores responsáveis pelo cadastramento dos horários

CREATE TABLE TB_Pessoa
(idPessoa INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nmPessoa VARCHAR(100) NOT NULL,
nuCPF VARCHAR(11) NOT NULL,
coSenha VARCHAR(16) NOT NULL,
CONSTRAINT UQ_Pessoa_nuCPF UNIQUE (nuCPF));

CREATE TABLE TB_Colaborador
(idColaborador INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
idPessoa INT NOT NULL,
CONSTRAINT UQ_Colaborador_idPessoa UNIQUE (idPessoa),
CONSTRAINT FK_Colaborador_Pessoa FOREIGN KEY (idPessoa) 
REFERENCES TB_Pessoa (idPessoa));

select * from tb_assistido;

ALTER TABLE TB_Assistido
DROP COLUMN nuCPF;
ALTER TABLE TB_Assistido
DROP COLUMN nmAssistido;
ALTER TABLE TB_Assistido
DROP COLUMN coSenha;

ALTER TABLE TB_Assistido
ADD COLUMN idPessoa INT NOT NULL;

ALTER TABLE TB_Assistido
ADD CONSTRAINT FK_Assistido_Pessoa FOREIGN KEY (idPessoa) 
REFERENCES TB_Pessoa (idPessoa);

ALTER TABLE TB_Assistido
ADD CONSTRAINT UQ_Assistido_idPessoa UNIQUE (idPessoa);


