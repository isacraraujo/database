#  AT10 – BD - Exercício Prática de comandos SQL - DML - JOIN
## 1) Criar o modelo de banco de dados para Controle de Pedidos
## DROP DATABASE BD_PEDIDO;
## DROP TABLE TB_VENDEDOR;

CREATE DATABASE BD_Pedido;
USE BD_PEDIDO;

CREATE TABLE `tb_cliente`
(
 `id_cliente` int NOT NULL AUTO_INCREMENT ,
 `cd_cliente` varchar(50) NOT NULL ,
 `cliente`    varchar(50) NOT NULL ,

PRIMARY KEY (`id_cliente`)
);

CREATE TABLE `tb_veiculo`
(
 `id_veiculo`    int NOT NULL AUTO_INCREMENT ,
 `cd_veiculo`    varchar(50) NOT NULL ,
 `veiculo`       varchar(50) NOT NULL ,
 `valor_veiculo` decimal(9,2) NOT NULL ,

PRIMARY KEY (`id_veiculo`)
);

CREATE TABLE `tb_vendedor`
(
 `id_vendedor` int NOT NULL AUTO_INCREMENT ,
 `cd_vendedor` varchar(50) NOT NULL ,
 `id_chefe`    int NULL,
 `vendedor`    varchar(50) NOT NULL ,

PRIMARY KEY (`id_vendedor`),
KEY `FK_chefe` (`id_chefe`),
CONSTRAINT `fk_chefe_vendedor` FOREIGN KEY `FK_chefe` (`id_chefe`) REFERENCES `tb_vendedor` (`id_vendedor`)
);

CREATE TABLE `tb_pedido`
(
 `id_pedido`    int NOT NULL AUTO_INCREMENT ,
 `id_vendedor`  int NOT NULL ,
 `id_veiculo`   int NOT NULL ,
 `id_cliente`   int NOT NULL ,
 `nr_pedido`    int NULL ,
 `dt_pedido`    date NOT NULL ,
 `valor_pedido` decimal(9,2) NOT NULL ,
 `comissao`     decimal(9,2) NOT NULL ,

PRIMARY KEY (`id_pedido`),
KEY `FK_cliente` (`id_cliente`),
CONSTRAINT `fk_cliente` FOREIGN KEY `FK_cliente` (`id_cliente`) REFERENCES `tb_cliente` (`id_cliente`),
KEY `FK_veiculo` (`id_veiculo`),
CONSTRAINT `fk_veiculo` FOREIGN KEY `FK_veiculo` (`id_veiculo`) REFERENCES `tb_veiculo` (`id_veiculo`),
KEY `fk_vendedor` (`id_vendedor`),
CONSTRAINT `FK_vendedor` FOREIGN KEY `fk_vendedor` (`id_vendedor`) REFERENCES `tb_vendedor` (`id_vendedor`)
);

CREATE UNIQUE INDEX uk_id_cliente ON tb_cliente (id_cliente);
CREATE UNIQUE INDEX uk_id_veiculo ON tb_veiculo (id_veiculo);
CREATE UNIQUE INDEX uk_id_vendedor ON tb_vendedor (id_vendedor);
CREATE UNIQUE INDEX uk_id_chefe ON tb_vendedor (id_chefe);
CREATE UNIQUE INDEX uk_id_pedido ON tb_pedido (id_pedido);
###########################################################################################################
## 2) Criar e popular as tabelas do BD_Pedido_01

-- Carga Vendedor
Insert into tb_vendedor
(cd_vendedor, vendedor)
Values
(1, 'Anibal Mota'),
(2, 'Antonio de Moraes'), 
(3, 'Barbara Alcantara'), 
(4, 'Deise Castro'),
(5, 'Eider Nascimento'),
(6, 'Fernando Guimarães');

INSERT into tb_cliente
(cd_cliente, cliente) 
Values 
(1, 'Vallu Nascimento'),
(2, 'Rogeria Negreti'),
(3, 'Henrique Silva'),
(4, 'Wellington Alves'),
(5, 'Jose Pereira'),
(6, 'Paulo Costa'),
(7, 'Antônio Júnior');


Insert into tb_veiculo
(cd_veiculo, veiculo, valor_veiculo) 
Values
(1, 'Onix', 52000),
(2, 'Prisma', 49000),
(3, 'S10', 109000),
(4, 'Cruze', 101000),
(5, 'Spin', 69000),
(6, 'Cobalt', 63000) ;

-- Carga Pedido
insert into tb_pedido
(nr_pedido, dt_pedido, id_veiculo, id_cliente, id_vendedor, valor_pedido,comissao)
values
(1,'2021-01-10',1,2,3,52000,0),
(2,'2021-02-20',2,3,4,49000,0),
(3,'2021-03-30',3,4,5,109000,0),
(4,'2021-04-10',4,5,1,101000,0),
(5,'2021-05-20',5,5,1,69000,0),
(6,'2021-06-30',6,1,2,63000,0),
(7,'2021-07-10',1,4,5,52000,0),
(8,'2021-08-20',1,4,5,52000,0),
(9,'2021-09-30',1,4,5,52000,0),
(10,'2021-10-10',1,4,5,52000,0);

-- Carga Chefia
select * from tb_vendedor;
-- 1	1	Anibal Mota	NULL
-- 2	2	Antonio de Moraes	NULL
-- 3	3	Barbara Alcantara	NULL
-- 4	4	Deise Castro	NULL
-- 5	5	Eider Nascimento	NULL
-- 6	6	Fernando Guimarães	NULL

-- Barbara é chefe do Anibal e Antonio
update tb_vendedor set id_chefe = 3 where cd_vendedor in (1,2);

-- Deise é chefe do Eider
update tb_vendedor set id_chefe = 4
where cd_vendedor in (5);

-- Fernando Guimarães é chefe da Deise e Barbara 
update tb_vendedor set id_chefe = 6
where cd_vendedor in (3,4);
#####################################################################
####  3) Criar os comandos abaixo:

# 01- Incluir cliente “Pedro Nóbrega”
INSERT INTO TB_CLIENTE (CD_CLIENTE,CLIENTE)
VALUES ((SELECT MAX(CD_CLIENTE)+1 FROM (SELECT * FROM TB_CLIENTE) AS A), 'Pedro Nobrega');

# 02 - Incluir vendedor “Hugo Silva”
INSERT INTO TB_VENDEDOR (CD_VENDEDOR,VENDEDOR)
VALUES ((SELECT MAX(CD_VENDEDOR)+1 FROM (SELECT * FROM TB_VENDEDOR) AS V), 'Hugo Silva');

# 03 - Incluir pedido - Data= 26-04-2021, cliente = “Pedro Nóbrega”, Vendedor = “Hugo Silva”, veículo “S10”, valor R$109.000,00
/*INSERT INTO TB_PEDIDO
(NR_PEDIDO, DT_PEDIDO, ID_VEICULO, ID_CLIENTE, ID_VENDEDOR, VALOR_PEDIDO)
VALUES
((SELECT*/

# 04 - Alterar cliente “Vallu Nascimento” para “Carlos Nascimento” na tabela cliente
UPDATE TB_CLIENTE SET CLIENTE = 'Carlos Nascimento'
WHERE CLIENTE = 'Vallu nascimento';

# 05 - Alterar vendedor Anibal para Anibal Santoro
UPDATE  TB_VENDEDOR SET VENDEDOR = 'Anibal Santoro' WHERE VENDEDOR = 'Anibal Mota';

# 06 - Alterar o valor do Pedido 1 parar cd_veículo 4 e valor R$101.000,00
UPDATE TB_PEDIDO SET ID_VEICULO = (SELECT ID_VEICULO FROM TB_VEICULO WHERE CD_VEICULO = 4), VALOR_PEDIDO = 101000.00
WHERE NR_PEDIDO = 1;

# 07 - Excluir Cliente quando o cd_cliente = 1 (vê se é possível ? Explique ?)
DELETE FROM TB_CLIENTE WHERE CD_CLIENTE = 1;
# PQ O CLIENTE ESTÁ VINCULADO A UM PEDIDO

# 08 - Atualizar o valor da comissão em 10% do valor da venda
UPDATE TB_PEDIDO SET COMISSAO = VALOR_PEDIDO * 0.1;

# 09 - Listar os nr_pedidos, dt_pedido, Cliente, veículo, valor, comissao
SELECT
	P.NR_PEDIDO,
	P.DT_PEDIDO,
	C.CLIENTE, V.VEICULO,
	P.VALOR_PEDIDO,
	P.COMISSAO
FROM TB_PEDIDO P
INNER JOIN TB_CLIENTE C
	ON C.ID_CLIENTE = P.ID_CLIENTE
    INNER JOIN TB_VEICULO V
		ON V.ID_VEICULO = V.ID_VEICULO
ORDER BY 2,3,4;

# 10 - Listar os pedidos dos clientes que começa o nome com well
SELECT P.*, C.CLIENTE FROM TB_PEDIDO P
	INNER JOIN TB_CLIENTE C
		ON C.ID_CLIENTE = P.ID_CLIENTE
WHERE C.CLIENTE LIKE 'well%';

# 11 - Alterar o valor do pedido, aumentando em 20%
UPDATE TB_PEDIDO SET VALOR_PEDIDO = VALOR_PEDIDO * 1.2;

# 12 - Alterar a comissão do pedido em 5% do valor da venda
UPDATE TB_PEDIDO SET COMISSAO = VALOR_PEDIDO * 0.05;

# 13 - Listar o cd_cliente = 4 e cd_veículo = 1 trazendo nome do cliente e veículo

# 14 - Listar o cd_cliente = 4 ou cd_veículo = 1 trazendo nome do cliente e veículo

# 15 - Listar os veículos que foram vendidos (veículos, dt_pedido, valor_pedido)

# 16 - Listar os veículos que NÃO FORAM VENDIDOS (veículos, valor_veículo)

# 17 - Listar os clientes que compraram carros (veículos, cliente)

# 18 - Listar os clientes que NÃO COMPRARAM CARROS (cliente)

# 19 - Listar os vendedores e os carros vendidos (vendedor, veículo, dt_pedido)

# 20 - Listar os vendedores que NÃO VENDERAM CARROS (Vendedores)

# 21 - Listar a estrutura de vendas (chefes e vendedores)


























