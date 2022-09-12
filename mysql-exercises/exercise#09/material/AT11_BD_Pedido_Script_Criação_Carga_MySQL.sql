-- drop database db_pedido
create database bd_pedido;

use bd_pedido;

create table tb_cliente
(id_cliente int not null primary key auto_increment,
cd_cliente int not null unique,
cliente varchar(50));

create table tb_veiculo
(id_veiculo int not null primary key auto_increment,
cd_veiculo int not null unique, 
veiculo char(50), 
valor_veiculo numeric(10,2)); 

create table tb_vendedor
(id_vendedor int not null primary key auto_increment,
cd_vendedor int not null unique,
vendedor varchar(50),
id_vendedor_chefe int);

create table tb_pedido
(id_pedido int not null primary key auto_increment,
nr_pedido int not null unique, 
dt_pedido date, 
id_veiculo int, 
id_cliente int, 
id_vendedor int, 
valor_pedido numeric(9,2), 
comissao numeric(9,2));

-- veiculo / pedido
alter table tb_pedido
add constraint fk_veiculo foreign key (id_veiculo) 
references tb_veiculo (id_veiculo);

-- cliente / pedido
alter table tb_pedido
add constraint fk_cliente foreign key (id_cliente) 
references tb_cliente (id_cliente);

-- vendedor / pedido
alter table tb_pedido 
add constraint fk_vendedor foreign key (id_vendedor) 
references tb_vendedor (id_vendedor);

-- vendedor / vendedor chefe
alter table tb_vendedor
add constraint fk_vendedor_chefe foreign key (id_vendedor_chefe) 
references tb_vendedor (id_vendedor);

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
update tb_vendedor set id_vendedor_chefe = 3
where cd_vendedor in (1,2);

-- Deise é chefe do Eider
update tb_vendedor set id_vendedor_chefe = 4
where cd_vendedor in (5);

-- Fernando Guimarães é chefe da Deise e Barbara 
update tb_vendedor set id_vendedor_chefe = 6
where cd_vendedor in (3,4);

-- FIM

select * from tb_vendedor;