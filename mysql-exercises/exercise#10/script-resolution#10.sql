USE BD_PEDIDO;
-- 01 criar uma consulta que faça ROLLBACK - deletar todos os pedidos do mês 10
BEGIN;
DELETE FROM TB_PEDIDO WHERE DT_PEDIDO >= '2021-10-01' AND DT_PEDIDO < '2021-11-30';
ROLLBACK;
-- 02 criar uma consulta que faça ROLLBACK - aumentar o valor da comissao em 50%
BEGIN;
UPDATE TB_PEDIDO SET COMISSAO = VALOR_PEDIDO * 0.50;
ROLLBACK;
-- 03 criar uma consulta que faça ROLLBACK - aumentar o valor dos veiculos (tb_veiculo) em 20%
