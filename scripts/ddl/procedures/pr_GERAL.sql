--Ranquear as alas que fizeram mais manutenções para a empresa e quanto que 
--geraram de renda em média com um desconto de 15% sobre o valor como custo de 
--peças, mostrando: o nome dessa ala, a quantidade de manutenções que fizeram, 
--a renda média (sem desconto) e o lucro líquido

create or alter procedure pr_AlaLucro as
  BEGIN
    select alas.ala AS NomeAla, 
    COUNT(manutencoes.cd_alas) AS Quant,
    AVG(manutencoes.vl_manutencao) AS Media,
    SUM(manutencoes.vl_manutencao * 0.85) AS LucroLiquido
  from
    manutencoes
  Inner Join 
    alas on manutencoes.cd_alas = alas.cd_alas
  group by 
    alas.ala
  order by
    Quant DESC
  END
  
  
-- 3. Procedure para listar tipos de manutenção ordenados por descrição
create or alter procedure pr_listar_tipos_manutencao as
begin
    select cd_tipo, descricao
    from tipos_manutencao
    order by descricao;
end;
GO



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
			dbo.fn_porcentagem_media(dbo.fn_media(soma_manutencoes,quantidade_de_manutencao),cd_funcionario) as comissao from cte_soma_manutencao
			where ranke <= 3
		)


		select * from cte_media_manutencao
	end


-- Procedure verifica seguro
create or alter procedure pr_VerificaSeguro as 
  BEGIN
    select 
        manutencoes.placa,
        seguros.nm_seguradora AS Nome,
        CASE 
            WHEN seguros.cd_status_seguros = 1 THEN 'Ativa'
            WHEN seguros.cd_status_seguros = 2 THEN 'Inativa'
            ELSE 'Desconhecido'
        END AS StatusSeguradora,
        CASE 
            WHEN seguros.cd_status_seguros = 2 THEN CAST(manutencoes.vl_manutencao * 1.15 as numeric(5,2))
            ELSE manutencoes.vl_manutencao
        END AS ValorManutencao
    FROM
        manutencoes
    INNER JOIN
        veiculos ON manutencoes.placa = veiculos.placa
    INNER JOIN
        seguros ON veiculos.cd_seguro = seguros.cd_seguro
    WHERE
        manutencoes.cd_status_manutencoes = 6
end


-- Procedimento para calcular benefícios para mulheres (completo e testado)
CREATE OR ALTER PROCEDURE sp_beneficios_mulheres AS
BEGIN
    -- Tabela temporária para armazenar os resultados
    CREATE TABLE #Resultados (
        cd_funcionario INT,
        nm_funcionario VARCHAR(200),
        tempo_empresa_anos INT,
        dias_folga INT,
        total_manutencoes DECIMAL(10,2),
        comissao DECIMAL(10,2),
        valor_comissao DECIMAL(10,2)
    )
    
    -- Inserir dados das funcionárias com número correto de colunas
    INSERT INTO #Resultados 
    (cd_funcionario, nm_funcionario, tempo_empresa_anos, dias_folga, total_manutencoes, comissao, valor_comissao)
    SELECT 
        f.cd_funcionario,
        f.nm_funcionario,
        dbo.fn_calcular_tempo_empresa(f.data_entrada),
        CASE 
            WHEN dbo.fn_calcular_tempo_empresa(f.data_entrada) < 1 THEN 1
            ELSE dbo.fn_calcular_tempo_empresa(f.data_entrada)
        END,
        0, -- total_manutencoes inicial
        0, -- comissao inicial
        0  -- valor_comissao inicial
    FROM 
        funcionarios f
    WHERE 
        f.sexo = 'F' 
        AND f.cd_status_funcionario = 1
        AND f.data_saida IS NULL
    
    -- Atualizar totais de manutenções
    UPDATE r
    SET total_manutencoes = ISNULL((
        SELECT SUM(m.vl_manutencao)
        FROM manutencoes m
        WHERE m.cd_funcionario = r.cd_funcionario
    ), 0)
    FROM #Resultados r
    
    -- Calcular comissões
    UPDATE r
    SET 
        comissao = CASE 
            WHEN tempo_empresa_anos < 1 THEN 0
            ELSE tempo_empresa_anos * 2
        END,
        valor_comissao = (total_manutencoes * 
            CASE 
                WHEN tempo_empresa_anos < 1 THEN 0
                ELSE tempo_empresa_anos * 2 
            END) / 100
    FROM #Resultados r
    
    -- Resultado final
    SELECT 
        cd_funcionario AS 'Código',
        nm_funcionario AS 'Nome',
        tempo_empresa_anos AS 'Anos de Empresa',
        dias_folga AS 'Dias de Folga',
        FORMAT(total_manutencoes, 'C', 'pt-BR') AS 'Total Manutenções',
        CONCAT(comissao, '%') AS '% Comissão',
        FORMAT(valor_comissao, 'C', 'pt-BR') AS 'Valor Comissão'
    FROM #Resultados
    ORDER BY nm_funcionario
    
    DROP TABLE #Resultados
END
GO
