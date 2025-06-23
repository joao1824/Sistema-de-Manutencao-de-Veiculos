--Pergunta

--Solicita-se a identifica��o dos tr�s funcion�rios que mais geraram lucro l�quido para a empresa, considerando como custo operacional um desconto de 20% sobre o valor de cada manuten��o.
--Devem ser levadas em conta apenas as manuten��es com valor igual ou superior a R$ 200,00, realizadas por funcion�rios que estejam atualmente ativos na empresa. 
--Para cada um desses tr�s funcion�rios, devem ser apresentados o nome, a quantidade total de manuten��es realizadas,
--o valor total das manuten��es considerando o desconto de 20% (ou seja, o lucro l�quido gerado), a m�dia do lucro l�quido por manuten��o e o valor de uma comiss�o.
--Essa comiss�o deve ser calculada como uma porcentagem da m�dia do lucro l�quido, sendo essa porcentagem equivalente ao tempo de empresa do funcion�rio (em anos completos) multiplicado por 10. 
--Por exemplo, um funcion�rio com 3 anos de empresa receber� 30% de comiss�o sobre a m�dia do lucro l�quido.



--Aplica um desconto de 20% sobre o valor informado.

create or alter function fn_20 (@valor numeric(15,2)) returns numeric(15,2) as  
	begin
		declare @descontado numeric(15,2);
		set @descontado = @valor * 0.8;
		return @descontado;
	end


--Fun��o para conseguir a media de uma valor j� somado pr�viamente e dividir pela quantidade

create or alter function fn_media (@valor numeric(15,2),@quantidade int) returns numeric(15,2) as 
	begin
		declare @media numeric(15,2);
		set @media = @valor / @quantidade;
		return @media;
	end

-- Fun��o usada para conseguir a % de comiss�o do funcionario com base em quanto tempo eles esta na empressa

create or alter function fn_porcentagem_media (@valor numeric(15,2),@cd_funcionario int) returns numeric(15,2) as 
	begin
		declare @resposta numeric(15,2);
		declare @tempo_entrada date;
		declare @tempo_total int;
		set @tempo_entrada = (select data_entrada from funcionarios where cd_funcionario = @cd_funcionario);
		set @tempo_total = floor(datediff(year,@tempo_entrada,getdate()));
		set @resposta = (@valor * (@tempo_total*10))/100;

		return @resposta

	end



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
			dbo.fn_porcentagem_media(dbo.fn_media(soma_manutencoes,quantidade_de_manutencao),cd_funcionario) as comissao from cte_soma_manutencao
			where ranke <= 3
		)


		select * from cte_media_manutencao
	end


exec pr_relatorio_top3_manutencoes