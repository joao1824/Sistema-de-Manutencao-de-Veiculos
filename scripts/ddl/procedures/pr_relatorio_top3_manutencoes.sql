--Pergunta

--Solicita-se a identificação dos três funcionários que mais geraram lucro líquido para a empresa, considerando como custo operacional um desconto de 20% sobre o valor de cada manutenção.
--Devem ser levadas em conta apenas as manutenções com valor igual ou superior a R$ 200,00, realizadas por funcionários que estejam atualmente ativos na empresa. 
--Para cada um desses três funcionários, devem ser apresentados o nome, a quantidade total de manutenções realizadas,
--o valor total das manutenções considerando o desconto de 20% (ou seja, o lucro líquido gerado), a média do lucro líquido por manutenção e o valor de uma comissão.
--Essa comissão deve ser calculada como uma porcentagem da média do lucro líquido, sendo essa porcentagem equivalente ao tempo de empresa do funcionário (em anos completos) multiplicado por 10. 
--Por exemplo, um funcionário com 3 anos de empresa receberá 30% de comissão sobre a média do lucro líquido.


--Gera um relatório com os três funcionários que mais geraram lucro líquido para a empresa, 
--    considerando as manutenções com valor igual ou superior a R$200,00, realizadas por funcionários ativos.

--    CRITÉRIOS:
--    - Apenas manutenções com valor >= R$200,00 são consideradas.
--    - Apenas funcionários com status ativo (cd_status_funcionario = 1) são incluídos.
--    - É aplicado um desconto operacional de 20% sobre o valor de cada manutenção, representando o custo da operação.

--    PARA CADA UM DOS TRÊS FUNCIONÁRIOS COM MAIOR VALOR TOTAL LÍQUIDO:
--    - Nome do funcionário.
--    - Quantidade total de manutenções realizadas.
--    - Soma total dos valores das manutenções com o desconto de 20% aplicado.
--    - Média do lucro líquido por manutenção.
--    - Comissão baseada nessa média: 
--        (tempo de empresa, em anos completos, * 10%) da média.

--    FUNÇÕES AUXILIARES:
--    - fn_20: Aplica o desconto de 20% sobre o valor informado.
--    - fn_media_3: Calcula a média do valor total dividido pela quantidade (nome pode ser ajustado).
--    - fn_porcentagem_media: Calcula a comissão com base no tempo de empresa.

--    OBSERVAÇÕES:
--    - O tempo de empresa é calculado em anos inteiros com base em data_entrada.
--    - DENSE_RANK é utilizado para garantir que empates sejam considerados.

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

