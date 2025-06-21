--Pergunta

--Solicita-se a identifica��o dos tr�s funcion�rios que mais geraram lucro l�quido para a empresa, considerando como custo operacional um desconto de 20% sobre o valor de cada manuten��o.
--Devem ser levadas em conta apenas as manuten��es com valor igual ou superior a R$ 200,00, realizadas por funcion�rios que estejam atualmente ativos na empresa. 
--Para cada um desses tr�s funcion�rios, devem ser apresentados o nome, a quantidade total de manuten��es realizadas,
--o valor total das manuten��es considerando o desconto de 20% (ou seja, o lucro l�quido gerado), a m�dia do lucro l�quido por manuten��o e o valor de uma comiss�o.
--Essa comiss�o deve ser calculada como uma porcentagem da m�dia do lucro l�quido, sendo essa porcentagem equivalente ao tempo de empresa do funcion�rio (em anos completos) multiplicado por 10. 
--Por exemplo, um funcion�rio com 3 anos de empresa receber� 30% de comiss�o sobre a m�dia do lucro l�quido.


--Gera um relat�rio com os tr�s funcion�rios que mais geraram lucro l�quido para a empresa, 
--    considerando as manuten��es com valor igual ou superior a R$200,00, realizadas por funcion�rios ativos.

--    CRIT�RIOS:
--    - Apenas manuten��es com valor >= R$200,00 s�o consideradas.
--    - Apenas funcion�rios com status ativo (cd_status_funcionario = 1) s�o inclu�dos.
--    - � aplicado um desconto operacional de 20% sobre o valor de cada manuten��o, representando o custo da opera��o.

--    PARA CADA UM DOS TR�S FUNCION�RIOS COM MAIOR VALOR TOTAL L�QUIDO:
--    - Nome do funcion�rio.
--    - Quantidade total de manuten��es realizadas.
--    - Soma total dos valores das manuten��es com o desconto de 20% aplicado.
--    - M�dia do lucro l�quido por manuten��o.
--    - Comiss�o baseada nessa m�dia: 
--        (tempo de empresa, em anos completos, * 10%) da m�dia.

--    FUN��ES AUXILIARES:
--    - fn_20: Aplica o desconto de 20% sobre o valor informado.
--    - fn_media_3: Calcula a m�dia do valor total dividido pela quantidade (nome pode ser ajustado).
--    - fn_porcentagem_media: Calcula a comiss�o com base no tempo de empresa.

--    OBSERVA��ES:
--    - O tempo de empresa � calculado em anos inteiros com base em data_entrada.
--    - DENSE_RANK � utilizado para garantir que empates sejam considerados.

create or alter procedure pr_relatorio_top3_manutencoes as

	begin
		with cte_vl_manutencao_cd as( 
			select f.nm_funcionario, f.cd_funcionario ,m.vl_manutencao,dbo.fn_20(m.vl_manutencao) as sem_custos from manutencoes m  
			inner join funcionarios f
			on m.cd_funcionario = f.cd_funcionario
			where m.vl_manutencao >= 200 and f.cd_status_funcionario = 1 
		),

		cte_soma_manutencao as ( 
			select nm_funcionario, cd_funcionario, SUM(sem_custos) as soma_manutencoes ,
			COUNT(sem_custos) as quantidade_de_manutencao,(DENSE_RANK() over(order by (sum(sem_custos)) desc)) as ranke 
			from cte_vl_manutencao_cd
			group by cd_funcionario,nm_funcionario
		),

		cte_media_manutencao as (
			select nm_funcionario as nome,quantidade_de_manutencao,soma_manutencoes,dbo.fn_media(soma_manutencoes,quantidade_de_manutencao) as media,
			dbo.fn_porcentagem_media(dbo.fn_media_3(soma_manutencoes,quantidade_de_manutencao),cd_funcionario) as comissao from cte_soma_manutencao
			where ranke <= 3
		)


		select * from cte_media_manutencao
	end

