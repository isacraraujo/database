CREATE DATABASE biblioteca;

CREATE TABLE `aluno`
(
 `idAluno`       int NOT NULL AUTO_INCREMENT ,
 `nomeAluno`     varchar(100) NULL ,
 `idEmprest`     int NOT NULL ,
 `telefoneAluno` int NULL ,
 `enderecoAluno` varchar(100) NOT NULL ,

PRIMARY KEY (`idAluno`),
KEY `FK_71` (`idEmprest`),
CONSTRAINT `FK_69` FOREIGN KEY `FK_71` (`idEmprest`) REFERENCES `emprestBiblio` (`idEmprest`)
);

CREATE TABLE `autorLivro`
(
 `idAutorLivro` int NOT NULL AUTO_INCREMENT ,
 `nomeAutor`    varchar(100) NOT NULL ,
 `cpfAutor`     varchar(100) NOT NULL ,

PRIMARY KEY (`idAutorLivro`)
);

CREATE TABLE `editora`
(
 `idEditora`       int NOT NULL AUTO_INCREMENT ,
 `nomeEditora`     varchar(50) NULL ,
 `cpnjEditora`     int NULL ,
 `enderecoEditora` varchar(45) NOT NULL ,
 `telefoneEditora` int NOT NULL ,

PRIMARY KEY (`idEditora`)
);

CREATE TABLE `emprestBiblio`
(
 `idEmprest`   int NOT NULL AUTO_INCREMENT ,
 `dtEmprest`   date NOT NULL ,
 `dtDevolPrev` date NOT NULL ,
 `dtDevolReal` date NOT NULL ,

PRIMARY KEY (`idEmprest`)
);

CREATE TABLE `exemplarLivro`
(
 `idExemplar`   int NOT NULL AUTO_INCREMENT ,
 `nomeExemplar` varchar(150) NOT NULL ,
 `idEmprest`    int NOT NULL ,
 `idAluno`      int NOT NULL ,

PRIMARY KEY (`idExemplar`),
KEY `FK_59` (`idAluno`),
CONSTRAINT `FK_57` FOREIGN KEY `FK_59` (`idAluno`) REFERENCES `aluno` (`idAluno`),
KEY `FK_74` (`idEmprest`),
CONSTRAINT `FK_72` FOREIGN KEY `FK_74` (`idEmprest`) REFERENCES `emprestBiblio` (`idEmprest`)
);


CREATE TABLE `isbn`
(
 `idISBN`        int NOT NULL ,
 `editoraISBN`   varchar(100) NOT NULL ,
 `categoriaISBN` varchar(100) NOT NULL ,
 `anoISBN`       year NOT NULL ,

PRIMARY KEY (`idISBN`)
);

CREATE TABLE `tituloLivro`
(
 `idLivro`      int NOT NULL AUTO_INCREMENT ,
 `idExemplar`   int NOT NULL ,
 `idEditora`    int NOT NULL ,
 `idAutorLivro` int NOT NULL ,
 `nomeLivro`    varchar(150) NOT NULL ,
 `idISBN`       int NOT NULL ,

PRIMARY KEY (`idLivro`),
KEY `FK_38` (`idExemplar`),
CONSTRAINT `FK_36` FOREIGN KEY `FK_38` (`idExemplar`) REFERENCES `exemplarLivro` (`idExemplar`),
KEY `FK_44` (`idISBN`),
CONSTRAINT `FK_42` FOREIGN KEY `FK_44` (`idISBN`) REFERENCES `isbn` (`idISBN`),
KEY `FK_50` (`idAutorLivro`),
CONSTRAINT `FK_48` FOREIGN KEY `FK_50` (`idAutorLivro`) REFERENCES `autorLivro` (`idAutorLivro`),
KEY `FK_53` (`idEditora`),
CONSTRAINT `FK_51` FOREIGN KEY `FK_53` (`idEditora`) REFERENCES `editora` (`idEditora`)
);