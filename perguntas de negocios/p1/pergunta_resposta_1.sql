-- Pergunta

-- Quais os três clientes com o maior custo total de manutenções que foram realizadas nos últimos 12 meses,
-- por funcionários ativos, e em veículos com seguro ativo?
-- Na tabela resultado, para cada um desses três clientes, mostrar o nome completo, total gasto,
-- o número total de manutenções realizadas, e a média de valor dessas manutenções.
-- Além disso, atribuir a cada cliente um ranking de fidelidade (Ouro, Prata ou Bronze) baseando-se na soma
-- total de seus gastos com manutenções.


-- Resposta

-- function p/ ranking de fidelidade do cliente

drop function if exists dbo.fn_ranking_fidelidade
go

create function dbo.fn_ranking_fidelidade(@total_gasto numeric(10,2))
returns varchar(10)
as
begin
    declare @fidelidade varchar(10)

    if @total_gasto >= 1000
        set @fidelidade = 'Ouro'
    else if @total_gasto >= 500
        set @fidelidade = 'Prata'
    else
        set @fidelidade = 'Bronze'

    return @fidelidade
end
go

--== CONSULTA PRINCIPAL ==--
-- cte: filtra manutencoes
with cte_manutencoes as (																	-- cte
    select m.*, v.cd_cliente
    from manutencoes m
    join veiculos v on m.placa = v.placa													-- join triplo
    join funcionarios f on m.cd_funcionario = f.cd_funcionario
    join seguros s on v.cd_seguro = s.cd_seguro
    where f.cd_status_funcionario in (
            select cd_status_funcionarios from status_funcionarios where status = 'Ativo')  -- algumas subconsultas
      and s.cd_status_seguros in (
            select cd_status_seguros from status_seguros where status = 'Ativo')
      and m.vl_manutencao is not null
      and m.cd_manutencao in (
            select cd_manutencao from manutencoes
            where getdate() >= dateadd(year, -1, getdate()))
),

-- cte: consulta/calcula valores (qtde., soma, media)
valores_por_cliente as (
    select c.cd_cliente as 'Cód. Cliente',
           c.nm_cliente as 'Nome Cliente',
           count(*) as qtd_manutencoes,
           sum(m.vl_manutencao) as total_gasto,
           avg(m.vl_manutencao) as media_valor
    from cte_manutencoes m
    join clientes c on m.cd_cliente = c.cd_cliente
    group by c.cd_cliente, c.nm_cliente
),

-- cte: rankeando clientes
rank_clientes as (
    select t.*,
           rank() over (order by t.total_gasto desc) as ranking,							-- window function rank()
           dbo.fn_ranking_fidelidade(t.total_gasto) as fidelidade							-- chama funcao
    from valores_por_cliente t
)

select top 3 *
from rank_clientes
order by ranking;
