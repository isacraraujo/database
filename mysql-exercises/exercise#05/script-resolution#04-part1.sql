USE agendanpj;

INSERT INTO area
(nmArea,sgArea)
VALUES
('Cível / Criminal / Júri','NJ1'),('Cível1','NJ2'),
('Cível2','NJ3'),('Criminal','NJ4'),
('Trabalhista1','NJ5'),('Trabalhista2','NJ6'),
('Trabalhista3','NJ7'),('Cível / Criminal','NJ8'),
('Previdenciário / Cível','NJ9'),('Previdenciário / Cível / Criminal','NJ10'),
('Criminal / Júri','NJ11'),('Cível / Criminal / Júri','NJ12'),
('Recursos Criminal / Cívell1','NJ13'),('Recursos Criminal / Cível2','NJ14'),
('Recursos Criminal / Cível3','NJ15'),('Recursos Criminal','NJ16'),
('Cível / Criminal / Júri2','NJ17'),('Conciliação e Mediação','NJ18'),
('Execuções Penais','NJ19'),('Encaminhamento1','NJ20'),
('Encaminhamento2','NJ21'),('Encaminhamento3','NJ22');

INSERT INTO assistido
(nmAssistido,nuCPF,nuIdentidade,deEndereco,coSenha,edIPAceite,dtAceite)
VALUES
('João','1234567890','123456','CENTRO UNIVERSITARIO DE BRASILIA',
'123456','TAMOJUNTO!','2022-05-04');

INSERT INTO local
(nmLocal, edLocal, sgLocal)
VALUES
('NAJ Ceilândia','SEPN 510, Edifício Cabo Frio, Térreo','LOCAL1'),
('NAJ Central Cível','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub','LOCAL2'),
('NAJ Central Cível2','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub','LOCAL3'),
('NAJ Central Penal','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub','LOCAL4'),
('NAJ Central Trabalhista1','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub','LOCAL5'),
('NAJ Central Trabalhista2','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub','LOCAL6'),
('NAJ Central Trabalhista3','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub, Térreo','LOCAL7'),
('NAJ Guará','Fórum do Guará, QE 25, conjunto 02, Lotes 2/3, Guara II, ao lado da feira do Guará','LOCAL8'),
('NAJ Juizado Especial da Justiça Federal1','SEPN 510, Edifício Cabo Frio, Térreo','LOCAL9'),
('NAJ Juizado Especial da Justiça Federal2','SEPN 510, Edifício Cabo Frio, Térreo','LOCAL10'),
('NAJ Júri / Entorpecentes','TJDFT, Praça do Buriti, Palácio da Justiça, Bl. B, ala B, 2º Andar','LOCAL11'),
('NAJ Paranoá','Área Especial 02, Fórum do Paranoá','LOCAL12'),
('NAJ Recursal1','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub','LOCAL13'),
('NAJ Recursal2','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub','LOCAL14'),
('NAJ Recursal3','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub','LOCAL15'),
('NAJ STJ','SAFS - Setor de Administração Federal Sul, Quadra 06, Lote 01, Trecho 3, CAC','LOCAL16'),
('NAJ Taguatinga','QNC A/E n° 23, Via Sandu Norte, Fórum de Taguatinga','LOCAL17'),
('NAJ TJ Conciliação e CAMED','SEPN 510, Edifício Cabo Frio, Térreo','LOCAL18'),
('NAJ VEP','Setor de Rádio e TV Sul, Quadra 701, Bloco N, Subsolo','LOCAL19'),
('Recepção NAJs Centrais1','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub','LOCAL20'),
('Recepção NAJs Centrais2','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub','LOCAL21'),
('Recepção NAJs Centrais3','SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub','LOCAL22');

DELETE FROM area WHERE idArea=1;
DELETE FROM agenda;
SELECT * FROM localarea;


INSERT INTO localarea
(Area_idArea,Local_idLocal)
VALUES
(46,53);