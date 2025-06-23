--Pergunta

--Solicita-se a identificação dos três funcionários que mais geraram lucro líquido para a empresa, considerando como custo operacional um desconto de 20% sobre o valor de cada manutenção.
--Devem ser levadas em conta apenas as manutenções com valor igual ou superior a R$ 200,00, realizadas por funcionários que estejam atualmente ativos na empresa. 
--Para cada um desses três funcionários, devem ser apresentados o nome, a quantidade total de manutenções realizadas,
--o valor total das manutenções considerando o desconto de 20% (ou seja, o lucro líquido gerado), a média do lucro líquido por manutenção e o valor de uma comissão.
--Essa comissão deve ser calculada como uma porcentagem da média do lucro líquido, sendo essa porcentagem equivalente ao tempo de empresa do funcionário (em anos completos, se for menos que 1, considera 1 ano) multiplicado por 10. 
--Por exemplo, um funcionário com 3 anos de empresa receberá 30% de comissão sobre a média do lucro líquido.



--Aplica um desconto de 20% sobre o valor informado.

create or alter function fn_20 (@valor numeric(7,2)) returns numeric(7,2) as  
	begin
		declare @descontado numeric(7,2);
		set @descontado = @valor * 0.8;
		return @descontado;
	end


--Função para conseguir a media de uma valor já somado préviamente e dividir pela quantidade

create or alter function fn_media (@valor numeric(7,2),@quantidade int) returns numeric(7,2) as 
	begin
		declare @media numeric(7,2);
		set @media = @valor / @quantidade;
		return @media;
	end

-- Função usada para conseguir a % de comissão do funcionario com base em quanto tempo eles esta na empressa

create or alter function fn_porcentagem_media (@valor numeric(7,2),@cd_funcionario int) returns numeric(7,2) as 
	begin
		declare @resposta numeric(7,2);
		declare @tempo_entrada date;
		declare @tempo_total int;
		declare @tempo_meses int;
		set @tempo_entrada = (select data_entrada from funcionarios where cd_funcionario = @cd_funcionario);
		set @tempo_total = floor((datediff(month,@tempo_entrada,getdate())) / 12) ;
		
		if @tempo_total <= 0
			begin
				set @tempo_total = 1
			end


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


select * from funcionarios






