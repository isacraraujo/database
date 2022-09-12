use db_rh;

select * from tb_funcionario f 
	right join tb_cargo c
		on c.id_Cargo = f.id_Cargo
where f.id_funcionario is null;

select c.* from tb_cargo c
	left join tb_funcionario f 
		on c.id_Cargo = f.id_Cargo
where f.id_funcionario is null;


select * from tb_funcionario f 
 left join tb_funcionario c
	on c.id_funcionario = f.id_funcionario_chefe;
    
select * from tb_cargo c
	cross join tb_setor s
order by cargo, setor;


-- 01 - Listar todos os campos tb_funcionario ordenados por nome decrescente;

SELECT * FROM tb_funcionario ORDER BY nome DESC;

-- 02 - Listar os dois primeiros registros (todos campos) da  tb_funcionario

select * from tb_funcionario order by id_funcionario limit 2;

-- 03 - Listar todos os campos da tb_funcionario cujo nome contenha “an”

select * from tb_funcionario where nome like '%an%';

-- 04 - Listar as três primeiras matrículas com álias “Código”, nome do funcionário da tb_funcionario

SELECT matricula as Código , nome  from tb_funcionario order by matricula limit 3;

-- 05 - Listar os código de cargo “cd_cargo” existentes na tb_funcionario sem repetição

select distinct id_cargo from tb_funcionario;

-- 06 - Listar ‘Matrícula = ‘ + matricula + ‘ nome = ‘ + nome da tb_funcionario

SELECT CONCAT('Matrícula = ', matricula, '   nome = ', nome) AS mat_nome FROM tb_Funcionario;

-- 07 - Listar os setores da tabela tb_setor em ordem decrescente

select * from tb_setor order by setor desc;

-- 08 - Listar todos os setores cujo nome termina em “aria”

select * from tb_setor WHERE setor LIKE '%aria';

-- 09 - Listar todos os registros onde o setor comece com “E”

select * from tb_setor WHERE setor LIKE 'E%';

-- 10 - Listar qual é o setor que paga o maior salário
update tb_funcionario set salario = 20000 where id_funcionario = 4;
select * from tb_funcionario order by salario desc;

select setor, salario
from tb_setor s
	inner join tb_funcionario f
		on f.id_Setor = s.id_setor
where f.salario = 
	(select f1.salario 
	from tb_funcionario f1
	order by f1.salario desc limit 1);

-- 11 - Listar os funcionários que são do setor diferente de 1 ou salario > 5000 por ordem alfabética de nomes

select * from tb_funcionario 
where id_setor <> 1 
      or salario > 5000 
order by nome;

-- 12 - Listar os funcionários que são do setor “Administração” e salario > ou = 16000 por ordem decrescente de nomes

SELECT * FROM tb_setor;
SELECT * FROM tb_funcionario;

SELECT f.nome, f.salario, s.setor FROM tb_funcionario F
	INNER JOIN tb_setor S
		ON S.id_setor = F.id_setor
	WHERE s.setor='Administração' and f.salario>=16000 ORDER BY f.nome DESC;

-- 13 -- Listar os nomes dos funcionários, salario e salário com aumento de 20% por ordem decrescente de salário aumentado

SELECT nome, salario, (salario * 1.2) AS salario_reajustado FROM tb_funcionario 
ORDER BY salario_reajustado DESC;

-- 14 -- Listar o cargo que tem o menor salário

SELECT * FROM tb_funcionario;
select * from tb_cargo;
update tb_funcionario set salario = 3000 , id_cargo = 3
where id_Funcionario = 5;

SELECT salario FROM tb_funcionario order by salario asc limit 1;

SELECT f.salario, c.cargo FROM tb_funcionario f
	INNER JOIN tb_cargo c
		ON c.id_cargo = f.id_cargo
WHERE F.salario = (SELECT salario 
                   FROM tb_funcionario 
				order by salario asc limit 1);
                
-- 15 -- Listar todos os funcionários com matrícula, nome, salário, nome do cargo e nome do setor em ordem de setor, cargo e nome do funcionário

select 
    f.matricula, f.nome, f.salario, c.cargo, s.setor 
FROM
	tb_funcionario f
	INNER JOIN tb_cargo c
			ON c.id_cargo = f.id_cargo
	INNER JOIN tb_setor s
			ON s.id_setor = f.id_setor 
ORDER BY 
	setor, cargo, nome;

-- 16 -- Listar todos os chefes e seus funcionários ex: matrícula do chefe, nome do chefe, nome do funcionário, salário do funcionário, cargo do funcionário e setor do funcionário

SELECT 
	FC.matricula
    ,FC.nome
    ,CC.cargo
    ,SC.setor
    ,F.nome
    ,F.salario
    ,C.cargo
    ,S.setor
FROM 
	tb_funcionario F 
	INNER JOIN tb_funcionario FC 
		ON FC.id_funcionario = F.id_funcionario_chefe
	INNER JOIN tb_cargo C
		ON C.id_cargo = F.id_cargo
	INNER JOIN tb_setor S
		ON S.id_setor = F.id_setor
	INNER JOIN tb_cargo CC
		ON CC.id_cargo = FC.id_cargo
	INNER JOIN tb_setor SC
		ON SC.id_setor = FC.id_setor
ORDER BY 
	FC.nome
    ,F.nome;