-- 1) Criar o modelo de banco de dados para Controle de Pedidos

CREATE DATABASE BD_Pedido;

USE BD_Pedido;

CREATE TABLE tb_pedido (
	id_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nr_pedido INT NOT NULL,
    dt_pedido DATE NOT NULL,
    id_veiculo INT NOT NULL,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    valor_pedido DECIMAL(9,2),
    comissao DECIMAL(9,2));
    
CREATE TABLE tb_vendedor (
	id_vendedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cd_vendedor INT NOT NULL,
    vendedor VARCHAR(50) NOT NULL,
    id_chefe INT NULL);
    
CREATE TABLE tb_veiculo (
	id_veiculo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cd_veiculo INT NOT NULL,
    veiculo VARCHAR(50) NOT NULL,
    valor_veiculo DECIMAL(9,2));
    
CREATE TABLE tb_cliente (
	id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cd_cliente INT NOT NULL,
    cliente VARCHAR(50) NOT NULL);
    
ALTER TABLE tb_pedido
	ADD CONSTRAINT fk_pedido_veiculo FOREIGN KEY (id_veiculo)
		REFERENCES tb_veiculo (id_veiculo);
        
ALTER TABLE tb_pedido
	ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente)
		REFERENCES tb_cliente (id_cliente);
        
ALTER TABLE tb_pedido
	ADD CONSTRAINT fk_pedido_vendedor FOREIGN KEY (id_vendedor)
		REFERENCES tb_vendedor (id_vendedor);
        
ALTER TABLE tb_vendedor
	ADD CONSTRAINT fk_vendedor_chefe FOREIGN KEY (id_chefe)
		REFERENCES tb_vendedor (id_vendedor);

CREATE UNIQUE INDEX uk_pedido_nr ON tb_pedido (nr_pedido);
CREATE UNIQUE INDEX uk_vendedor_cd ON tb_vendedor (cd_vendedor);
CREATE UNIQUE INDEX uk_veiculo_cd ON tb_veiculo (cd_veiculo);
CREATE UNIQUE INDEX uk_cliente_cd ON tb_cliente (cd_cliente);

-- 2) Criar e popular as tabelas do BD_Pedido_01

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

-- Carga Cliente Sem Chefe
Insert into tb_cliente
(cd_cliente, cliente) 
Values 
(1, 'Vallu Nascimento'),
(2, 'Rogeria Negreti'),
(3, 'Henrique Silva'),
(4, 'Wellington Alves'),
(5, 'Jose Pereira'),
(6, 'Paulo Costa'),
(7, 'Antônio Júnior');

-- Carga Veículo
Insert into tb_veiculo
(cd_veiculo, veiculo, valor_veiculo) 
Values
(1, 'Onix', 52000),
(2, 'Prisma', 49000),
(3, 'S10', 109000),
(4, 'Cruze', 101000),
(5, 'Spin', 69000),
(6, 'Cobalt', 63000);

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
update tb_vendedor set id_chefe = 3
where cd_vendedor in (1,2);

-- Deise é chefe do Eider
update tb_vendedor set id_chefe = 4
where cd_vendedor in (5);

-- Fernando Guimarães é chefe da Deise e Barbara 
update tb_vendedor set id_chefe = 6
where cd_vendedor in (3,4);

-- FIM

-- 3) Criar os comandos abaixo:
-- 01- Incluir cliente “Pedro Nóbrega”

SELECT MAX(cd_cliente) + 1 AS CD_CLIENTE_NOMVO FROM TB_CLIENTE;

Insert into tb_cliente (cd_cliente, cliente) 
Values ((SELECT MAX(cd_cliente) + 1 FROM (SELECT * FROM TB_CLIENTE) AS C), 'Pedro Nóbrega');

SELECT * FROM TB_CLIENTE;

-- 02 - Incluir vendedor “Hugo Silva”

Insert into tb_vendedor (cd_vendedor, vendedor) 
Values ((SELECT MAX(cd_vendedor) + 1 FROM (SELECT * FROM tb_vendedor) AS V), 'Hugo Silva');

SELECT * FROM TB_VENDEDOR;

-- 03 - Incluir pedido - Data= 26-04-2021, cliente = “Pedro Nóbrega”, Vendedor = “Hugo Silva”, veículo “S10”, valor R$109.000,00

/* 
DECLARE @nuPedido INT
DECLARE @idVeiculo INT
DECLARE @idCliente INT
DECLARE @idVendedor INT
DECLARE @vlPedido NUMERIC(9,2)
DECLARE @dtPedido DATE
SET @nuPedido = (SELECT MAX(nr_pedido) + 1 FROM TB_PEDIDO)
SET @idVeiculo = (SELECT id_Veiculo FROM TB_VEICULO WHERE veiculo = 'S10')
SET @idCliente = (SELECT id_Cliente FROM TB_CLIENTE WHERE cliente = 'Pedro Nóbrega')
SET @idVendedor = (SELECT id_Vendedor FROM TB_VENDEDOR WHERE vendedor = 'Hugo Silva')
SET @vlPedido = 109000
SET @dtPedido = '2021-04-26'

insert into tb_pedido
(nr_pedido, dt_pedido, id_veiculo, id_cliente, id_vendedor, valor_pedido)
values
(@nuPedido, @dtPedido, @idVeiculo, @idCliente, @idVendedor, @vlPedido);
*/

insert into tb_pedido
(nr_pedido, dt_pedido, id_veiculo, id_cliente, id_vendedor, valor_pedido)
values
((SELECT MAX(nr_pedido) + 1 FROM (SELECT * FROM TB_PEDIDO) AS P)
,'2021-04-26'
,(SELECT id_Veiculo FROM TB_VEICULO WHERE veiculo = 'S10')
,(SELECT id_Cliente FROM TB_CLIENTE WHERE cliente = 'Pedro Nóbrega')
,(SELECT id_Vendedor FROM TB_VENDEDOR WHERE vendedor = 'Hugo Silva')
,109000);

SELECT * FROM TB_PEDIDO;

-- 04 - Alterar cliente “Vallu Nascimento” para “Carlos Nascimento” na tabela cliente
SET SQL_SAFE_UPDATES=0;

UPDATE TB_CLIENTE SET cliente = 'Carlos Nascimento'
WHERE cliente = 'Vallu Nascimento';

SELECT * FROM TB_CLIENTE;

-- 05 - Alterar vendedor Anibal para Anibal Santoro

UPDATE TB_VENDEDOR SET VENDEDOR = 'Anibal Santoro'
WHERE VENDEDOR = 'Anibal MOTA';

SELECT * FROM TB_VENDEDOR;

-- 06 - Alterar o valor do Pedido 1 parar cd_veículo 4 e valor R$101.000,00

UPDATE TB_PEDIDO SET 
	ID_VEICULO = (SELECT ID_VEICULO FROM TB_VEICULO WHERE CD_VEICULO = 4)
    ,VALOR_PEDIDO = 101000.00
WHERE NR_PEDIDO = 1;

SELECT * FROM TB_PEDIDO;
SELECT * FROM TB_VEICULO;

-- 07 - Excluir Cliente quando o cd_cliente = 1 (vê se é possível ? Explique ?)

DELETE FROM TB_CLIENTE WHERE CD_CLIENTE =1;

-- 08 - Atualizar o valor da comissão em 10% do valor da venda

UPDATE TB_PEDIDO SET COMISSAO = (valor_pedido * 0.1);

SELECT * FROM TB_PEDIDO;

-- 09 - Listar os nr_pedidos, dt_pedido, Cliente, veículo, valor, comissao

SELECT 
	P.NR_PEDIDO
    ,P.DT_PEDIDO
    ,C.CLIENTE
    ,V.VEICULO
    ,P.VALOR_PEDIDO
    ,P.COMISSAO
 FROM TB_PEDIDO P
	INNER JOIN TB_CLIENTE C 
		ON C.id_Cliente = P.id_Cliente
	INNER JOIN TB_VEICULO V
		ON V.id_Veiculo = P.id_Veiculo
order by 2, 3, 4;

-- 10 - Listar os pedidos dos clientes que começa o nome com well

SELECT P.*, C.cliente FROM TB_PEDIDO P
	INNER JOIN TB_CLIENTE C 
		ON C.id_Cliente = P.id_Cliente
WHERE
	C.Cliente LIKE 'Well%';

-- 11 - Alterar o valor do pedido, aumentando em 20%

UPDATE TB_PEDIDO SET VALOR_PEDIDO = VALOR_PEDIDO * 1.2;

SELECT * FROM TB_PEDIDO;

-- 12 - Alterar a comissão do pedido em 5% do valor da venda

UPDATE TB_PEDIDO SET COMISSAO = VALOR_PEDIDO * 0.05;

SELECT * FROM TB_PEDIDO;

-- 13 - Listar o cd_cliente = 4 e cd_veículo = 1 trazendo nome do cliente e veículo

-- 14 - Listar o cd_cliente = 4 ou cd_veículo = 1 trazendo nome do cliente e veículo

-- 15 - Listar os veículos que foram vendidos (veículos, dt_pedido, valor_pedido)

-- 16 - Listar os veículos que NÃO FORAM VENDIDOS (veículos, valor_veículo)

-- 17 - Listar os clientes que compraram carros (veículos, cliente)

-- 18 - Listar os clientes que NÃO COMPRARAM CARROS (cliente)

-- 19 - Listar os vendedores e os carros vendidos (vendedor, veículo, dt_pedido)

-- 20 - Listar os vendedores que NÃO VENDERAM CARROS (Vendedores)

-- 21 - Listar a estrutura de vendas (chefes e vendedores)

