use DB_AGENDA;

INSERT INTO `db_agenda`.`tb_localatendimento`
(`nmLocalAtendimento`,
`deEndereco`)
VALUES
('NAJ Central Trabalhista',
'SEPS Quadra 707/907, Bloco 3, 1º Andar, Campus Asa Norte - Ceub');

INSERT INTO `db_agenda`.`tb_localatendimento`
(`nmLocalAtendimento`,
`deEndereco`)
select distinct NAJ, Endereço from excel_najs
where NAJ <> 'NAJ Central Trabalhista';

INSERT INTO `db_agenda`.`tb_areajuridica`
(`sgAreaJuridica`,
`nmAreaJuridica`)
select 
	upper(LEFT(Area,3)) as sigla
    ,Area
from excel_area;

SELECT * FROM TB_LocalAtendimento;
SELECT * FROM excel_NAJS;

select * from tb_areajuridica;

select * from tb_localatendimentoareajuridica;
-- delete from tb_localatendimentoareajuridica where idlocalatendimentoareajuridica = 1;

INSERT INTO `db_agenda`.`tb_localatendimentoareajuridica`
(
`idAreaJuridica`,
`idLocalAtendimento`)
SELECT DISTINCT
    AJ.idAreaJuridica
	,LA.idLocalAtendimento
FROM
	excel_najs N
	INNER JOIN TB_LocalAtendimento LA
		ON LA.nmLocalAtendimento = N.NAJ
	INNER JOIN TB_AreaJuridica AJ
		ON N.`Áreas de Atuação` LIKE CONCAT('%',AJ.nmAreaJuridica,'%');

select N.`Áreas de Atuação`
       ,CONCAT('%',AJ.nmAreaJuridica,'%') AS AREA
FROM excel_najs N
	INNER JOIN TB_AreaJuridica AJ
		ON N.`Áreas de Atuação` LIKE CONCAT('%',AJ.nmAreaJuridica,'%');

SELECT * FROM TB_HorarioAtendimento;
SELECT LEFT(NOW(),10), CONVERT(NOW(), DATE);
select * from excel_najs;

INSERT INTO `db_agenda`.`tb_horarioatendimento`
(`dtAtendimento`,
`hrInicioAtendimento`,
`hrFimAtendimento`,
`qtVagas`,
`icAtivo`,
`idLocalAtendimentoAreaJuridica`)
SELECT 
	CONVERT(NOW(), DATE) as dtAtendimento
    ,left(trim(n.`Horário de atendimento presencial`),5) as hrInicioAtendimento
    ,right(trim(n.`Horário de atendimento presencial`),5) as hrFimAtendimento
	,n.`Qtde Vagas` as qtVagas
	,1 as icAtivo
	,LAJ.idLocalAtendimentoAreaJuridica as idLocalAtendimentoAreaJuridica
FROM 
	excel_najs n
	INNER JOIN TB_LocalAtendimento LA
		ON LA.nmLocalAtendimento = N.NAJ
	INNER JOIN TB_AreaJuridica AJ
		ON N.`Áreas de Atuação` LIKE CONCAT('%',AJ.nmAreaJuridica,'%')
	INNER JOIN TB_LocalAtendimentoAreaJuridica LAJ
		ON LAJ.idLocalAtendimento = LA.idLocalAtendimento
        AND LAJ.idAreaJuridica = AJ.idAreaJuridica;

