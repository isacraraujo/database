use bd_pedido;

alter view vw_pedido as
SELECT
    P.id_pedido
    ,P.nr_pedido
    ,P.dt_pedido
    ,YEAR(P.dt_pedido) AS Ano_Pedido
    ,MONTH(P.dt_pedido) AS Mes_Pedido
    ,DAY(P.dt_pedido) AS Dia_Pedido
    ,P.valor_pedido
    ,P.comissao
    ,C.id_cliente
    ,C.cd_cliente
    ,C.cliente
    ,V.id_veiculo
	,V.cd_veiculo
    ,V.veiculo
    ,V.valor_veiculo
    ,VD.id_vendedor
	,VD.vendedor
FROM 
	TB_PEDIDO P
	INNER JOIN TB_CLIENTE C 
		ON C.id_Cliente = P.id_Cliente
	INNER JOIN TB_VEICULO V
		ON V.id_Veiculo = P.id_Veiculo
	INNER JOIN TB_Vendedor VD
		ON VD.id_Vendedor = P.id_Vendedor;


select 
	P.vendedor
    ,SUM(P.valor_pedido) AS Total_Valor_Pedido
    ,SUM(P.comissao) AS Total_Comissao
    ,SUM(P.valor_veiculo) AS Total_Valor_Veiculo
    ,AVG(P.valor_pedido) AS Media_Valor_Pedido
    ,AVG(P.comissao) AS Media_Comissao
    ,AVG(P.valor_veiculo) AS Media_Valor_Veiculo
    ,COUNT(1) AS Qtde_Pedido
    ,COUNT(DISTINCT P.id_veiculo) AS qtde_veiculo
from 
	vw_pedido as P
group by 
	P.vendedor;
    
select
	v.veiculo
	,p.dt_pedido
	-- ,datediff(month,p.dt_pedido,getdate()) as meses_compra
	,TIMESTAMPDIFF(year,p.dt_pedido,now()) as anos_compra -- MySQL
	,TIMESTAMPDIFF(month,p.dt_pedido,now()) as meses_compra -- MySQL
	,TIMESTAMPDIFF(day,p.dt_pedido,now()) as dias_compra -- MySQL
from 
	tb_pedido p
	inner join tb_veiculo v
		on v.id_veiculo = p.id_veiculo
order by
	v.veiculo;
    

-- 01) Listar a quantidade total de clientes;

select count(cd_cliente) as total_cliente from tb_cliente;

select * from tb_cliente;

-- 02) Listar a média dos preços dos veículos

select round(avg(valor_veiculo),2) as 'media preço veículo' 
from tb_veiculo;

-- 03) Listar o veículo mais caro
SELECT veiculo, MAX(valor_veiculo) as valor_max FROM tb_veiculo
group by veiculo order by valor_max desc limit 1;

SELECT
	V.veiculo, V.valor_veiculo
FROM
	tb_veiculo V
WHERE
	V.valor_veiculo = (SELECT MAX(valor_veiculo) FROM tb_veiculo)
ORDER BY
	V.veiculo;

-- 04) Listar o veículo mais barato do vendedor “Sérgio Cozzetti”
select 
			v.vendedor
			,min(vc.valor_veiculo) as menor_valor  
		from 
			tb_pedido p
			inner join tb_vendedor v
				on v.id_vendedor = p.id_vendedor
			inner join tb_veiculo vc
				on vc.id_veiculo = p.id_veiculo
		group by
			v.vendedor;
            
select * from tb_pedido;

select 
	v2.vendedor
	,v1.veiculo
	,v1.valor_veiculo
from 
	tb_veiculo v1
	inner join 
		(select 
			v.vendedor
			,min(vc.valor_veiculo) as menor_valor  
		from 
			tb_pedido p
			inner join tb_vendedor v
				on v.id_vendedor = p.id_vendedor
			inner join tb_veiculo vc
				on vc.id_veiculo = p.id_veiculo
		group by
			v.vendedor) as v2
	on v2.menor_valor = v1.valor_veiculo
where
	v2.vendedor = 'Eider Nascimento';

-- sem o vendedor
select 	v.veiculo
,	v.valor_veiculo
from 
	tb_veiculo v
where 
	v.valor_veiculo in
	(select
		min(valor_veiculo)	
	from 
		tb_veiculo v1
		inner join tb_pedido p
			on v1.id_veiculo = p.id_veiculo
		inner join tb_vendedor ve
			on p.id_vendedor = ve.id_vendedor
	where 
		ve.vendedor = 'Eider Nascimento');

-- 05) Listar o total de pedidos por vendedor

select 
	v.id_vendedor
	,v.vendedor
	,count(p.id_pedido) as qtde_pedido
	,sum(p.valor_pedido) as valor_total_pedido 
	,avg(p.valor_pedido) as media_valor_pedido
from 
	tb_pedido p
	inner join tb_vendedor v
		on v.id_vendedor = p.id_vendedor
group by
	v.id_vendedor
	,v.vendedor;

-- 06) Listar o total de pedidos por veículo

select 
	v.id_veiculo
	,v.veiculo
	,count(p.id_pedido) as qtde_pedido
	,sum(p.valor_pedido) as valor_total_pedido 
	,avg(p.valor_pedido) as media_valor_pedido
from 
	tb_pedido p
	inner join tb_veiculo v
		on v.id_veiculo = p.id_veiculo
group by
	v.id_veiculo
	,v.veiculo;

-- 07) Listar o veículo, vendedor, cliente por ordem de ano do pedido, veículo e cliente

select
	year(p.dt_pedido) as ano_pedido
	,v.veiculo
	,c.cliente
	,vd.vendedor
from 
	tb_pedido p
	inner join tb_veiculo v
		on v.id_veiculo = p.id_veiculo
	inner join tb_vendedor vd
		on vd.id_vendedor = p.id_vendedor
	inner join tb_cliente c
		on c.id_cliente = p.id_cliente
order by
	year(p.dt_pedido) 
	,v.veiculo
	,c.cliente;

-- 08) Listar o veículo, cliente e quantos meses tem o pedido

select
	v.veiculo
	,c.cliente
	,p.dt_pedido
	,timestampdiff(month, p.dt_pedido, now()) as qtde_meses
from 
	tb_pedido p
	inner join tb_veiculo v
		on v.id_veiculo = p.id_veiculo
	inner join tb_cliente c
		on c.id_cliente = p.id_cliente
order by
	qtde_meses desc;

-- 10) Listar o veículo, cliente, vendedor, valor do pedido, valor do pedido + 100 como "valor+taxa", valor do pedido acrescido de 20% como "preço do reajuste"

select
	v.veiculo
	,c.cliente
	,vd.vendedor
	,p.valor_pedido
	,(p.valor_pedido + 100) as 'Valor+Taxa'
	,convert((p.valor_pedido * 1.2),decimal(9,2)) as 'Valor do Reajuste'
from 
	tb_pedido p
	inner join tb_veiculo v
		on v.id_veiculo = p.id_veiculo
	inner join tb_vendedor vd
		on vd.id_vendedor = p.id_vendedor
	inner join tb_cliente c
		on c.id_cliente = p.id_cliente
order by
	v.veiculo
	,c.cliente;

-- 11) Listar a média das vendas antes do mês 07 do ano 2021

select
	avg(p.valor_pedido) as media
from 
	tb_pedido p
where
	p.dt_pedido < '2021-07-01';
--  (year(dt_pedido) * 100) + month(dt_pedido) < 202107;

-- 12) Listar o valor total da vendas depois do mês 06 do ano 2021

select
	sum(p.valor_pedido) as vendas
from 
	tb_pedido p
where
	p.dt_pedido >= '2021-07-01';


-- 13) Listar a média das compras por cliente

select
	c.id_cliente
	,c.cliente
	,isnull(avg(p.valor_pedido),0) as media
from 
	tb_cliente c
	left join tb_pedido p
		on p.id_cliente = c.id_cliente
group by
	c.id_cliente
	,c.cliente

-- 14) Listar o veículo vendido, ano do pedido

select
	v.veiculo
	,year(p.dt_pedido) as ano_pedido
from 
	tb_pedido p
	inner join tb_veiculo v
		on v.id_veiculo = p.id_veiculo
order by
	v.veiculo;

-- 15) Listar o veículo vendido, quantidade de meses tem a compra

select
	v.veiculo
	,p.dt_pedido
	-- ,datediff(month,p.dt_pedido,getdate()) as meses_compra  -- SQLServer
	,TIMESTAMPDIFF(month,p.dt_pedido,now()) as meses_compra -- MySQL
from 
	tb_pedido p
	inner join tb_veiculo v
		on v.id_veiculo = p.id_veiculo
order by
	v.veiculo;

-- 16) Listar as veículos e a somatória das comissões por veiculo
-- select * from tb_pedido
-- update tb_pedido set comissao = valor_pedido * 0.02

select
	v.veiculo
	,sum(p.comissao) as total_comissao
from 
	tb_pedido p
	inner join tb_veiculo v
		on v.id_veiculo = p.id_veiculo
group by
	v.veiculo;

-- 17) Listar os vendedores e a somatória das comissões por vendedor
select
	v.vendedor
	,sum(case when p.comissao is null then 0 else p.comissao end) as total_comissao
from 
	tb_pedido p
	right join tb_vendedor v
		on v.id_vendedor = p.id_vendedor
group by
	v.vendedor;

-- 18) Listar os clientes e quantidade de compras realizadas
select
	c.cliente
	,count(p.id_pedido) as qtde_compras
from 
	tb_pedido p
	inner join tb_cliente c
		on c.id_cliente = p.id_cliente
group by
	c.cliente;

-- 19) Listar o menor valor vendido

select 
	min(p.valor_pedido) as menor_valor
from 
	tb_pedido p

select top 1
	p.*
from 
	tb_pedido p
order by 
	p.valor_pedido asc
	,p.dt_pedido desc;

-- 20) Listar nr_pedido, comissão e classificação
-- Classificação - (< 4000 = normal) (>=4000 e <5000 = Boa) (> 5000 = Ótima)
update tb_pedido set comissao = 3999.99 where nr_pedido = 1;
update tb_pedido set comissao = 4000 where nr_pedido = 2;
update tb_pedido set comissao = 4999.99 where nr_pedido = 3;
update tb_pedido set comissao = 5000 where nr_pedido = 4;
update tb_pedido set comissao = 5500 where nr_pedido = 5;

select 
	p.nr_pedido
	,p.comissao
	,case when p.comissao < 4000 then 'normal'
		  when p.comissao < 5000 then 'boa'
		  else 'ótima'
	end as classificação
from	
	tb_pedido p
order by
	classificação;


select 
	case when p.comissao < 4000 then 'normal'
		  when p.comissao < 5000 then 'boa'
		  else 'ótima'
	end as classificação
	,count(nr_pedido) as qtde
from	
	tb_pedido p
group by
	case when p.comissao < 4000 then 'normal'
		  when p.comissao < 5000 then 'boa'
		  else 'ótima'
	end;

select 
	v.vendedor
	,sum(case when p.comissao < 4000 then 1 else 0 end) as normal
	,sum(case when p.comissao between 4000 and 4999.99 then 1 else 0 end) as boa
	,sum(case when p.comissao >= 5000 then 1 else 0 end) as otima
	,count(nr_pedido) as total
from	
	tb_pedido p
	inner join tb_vendedor v
		on v.id_vendedor = p.id_vendedor
group by
	v.vendedor;


use db_rh;
-- 01 Criar view  Vw01 que Lista todos os campos tb_funcionario order nome desc

create view vw01 as
select * from tb_funcionario 
order by nome desc;

-- 02 Criar view  Vw02 que Lista funcionário cargo order by nome
create view vw02 as
select 
	f.id_funcionario
    ,f.matricula
    ,f.cpf
    ,f.nome
    ,f.dt_nascimento
    ,f.salario
    ,f.id_setor
    ,f.id_cargo
    ,f.id_funcionario_chefe
	,c.sigla
    ,c.cargo
from tb_funcionario f
	inner join tb_cargo c
		on c.id_Cargo = f.id_Cargo;

select * from vw02;

-- 03 Criar view  Vw03 que Lista a quantidade de funcionários por setor  - Lista por ordem de setor

-- 04 Criar view  Vw04 que Lista o funcionário, setor e cargo  - Lista por ordem de funcionário

-- 05 Criar view  Vw05 que Lista a quantidade dos salários dos funcionário por setor

