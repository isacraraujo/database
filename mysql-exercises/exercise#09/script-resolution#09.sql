-- 01) Listar a quantidade total de clientes
SELECT COUNT(ID_CLIENTE) AS TOTAL_CLIENTE
FROM TB_CLIENTE;
SELECT * FROM TB_CLIENTE;

-- 02) Listar a média dos preços dos veículos
SELECT ROUND(AVG(VALOR_VEICULO)) AS MEDIA_PRECO_VEICULO
FROM TB_VEICULO;

-- 03) Listar o veículo mais caro
SELECT VEICULO, MAX(VALOR_VEICULO)
FROM TB_VEICULO;

-- 04) Listar o veículo mais barato do vendedor “Anibal Mota”
SELECT MIN(VALOR_PEDIDO) AS MENOR_VALOR
FROM TB_PEDIDO
WHERE ID_VENDEDOR = 1;

-- 05) Listar o total de pedidos por vendedor
SELECT V.VENDEDOR,COUNT(P.ID_PEDIDO) AS QTD_PEDIDOS
FROM TB_PEDIDO P
	INNER JOIN TB_VENDEDOR V
		ON V.ID_VENDEDOR = P.ID_VENDEDOR
GROUP BY P.ID_VENDEDOR;

-- 06) Listar o veículo, vendedor, cliente por ordem de ano do pedido, veículo e cliente
SELECT YEAR(P.DT_PEDIDO) AS ANO_PEDIDO,V.VEICULO, F.VENDEDOR, C.CLIENTE, P.DT_PEDIDO
FROM TB_PEDIDO P
	INNER JOIN TB_CLIENTE C
		ON C.ID_CLIENTE = P.ID_CLIENTE
	INNER JOIN TB_VEICULO V
		ON V.ID_VEICULO = P.ID_VEICULO
	INNER JOIN TB_VENDEDOR F
		ON F.ID_VENDEDOR = P.ID_VENDEDOR
GROUP BY YEAR(P.DT_PEDIDO),V.VEICULO, C.CLIENTE;

-- 07) Listar o veículo, cliente e quantos meses tem o pedido
SELECT V.VEICULO, C.CLIENTE, P.DT_PEDIDO
FROM TB_PEDIDO P 
	INNER JOIN TB_VEICULO V
		ON V.ID_VEICULO = P.ID_VEICULO
	INNER JOIN TB_CLIENTE C
		ON C.ID_CLIENTE = P.ID_CLIENTE;
-- ##NÃO CONSEGUI VER QUANTOS MESES TEM O PEDIDO

-- 08) Listar o veículo, cliente, vendedor, valor do pedido, valor do pedido
-- + 100 como "valor+taxa", valor do pedido acrescido de 20% como "preço do reajuste"
SELECT V.VEICULO, C.CLIENTE, F.VENDEDOR, P.VALOR_PEDIDO
	,  P.VALOR_PEDIDO+100 AS VALOR_TAXA
    ,  P.VALOR_PEDIDO*0.20+P.VALOR_PEDIDO AS REAJUSTE_PEDIDO
FROM TB_PEDIDO P 
	INNER JOIN TB_VEICULO V
		ON V.ID_VEICULO = P.ID_VEICULO
	INNER JOIN TB_CLIENTE C
		ON C.ID_CLIENTE = P.ID_CLIENTE
	INNER JOIN TB_VENDEDOR F 
		ON F.ID_VENDEDOR = P.ID_VENDEDOR;

-- 09) Listar a média das vendas antes do mês 07 do ano 2021
SELECT * FROM TB_PEDIDO;
SELECT AVG(VALOR_PEDIDO) AS MEDIA_VENDAS_JULHO
FROM TB_PEDIDO
WHERE DT_PEDIDO < '2021-07-01';

-- 10) Listar o valor total das vendas depois do mês 06 do ano 2021
SELECT * FROM TB_PEDIDO;
SELECT SUM(VALOR_PEDIDO) FROM TB_PEDIDO
WHERE DT_PEDIDO >= '2021-06-01';

-- 11) Listar o veículo vendido, quantidade de meses tem a compra

-- 12) Listar os vendedores e a somatória das comissões por vendedor

-- 13) Listar os clientes e quantidade de compras realizadas

-- 14) Listar nr_pedido, comissão e classificação (< 4000 = normal) (>=4000 e <5000 = Boa) (> 5000 = Ótima)