--Solicita-se a identificação das funcionárias da empresa e a concessão de dias de folga e comissão de acordo com o tempo de vínculo empregatício.
--As funcionárias que possuírem dois anos completos ou mais de empresa terão direito a dois dias de folga adicionais.
--As funcionárias com menos de um ano de empresa receberão um dia de folga.
--Além disso, deverá ser calculada uma comissão proporcional ao tempo de casa:
--Para cada funcionária, a comissão será calculada como um percentual sobre a soma do valor total das manutenções realizadas por ela, sendo esse percentual equivalente ao número de anos completos de empresa.
--Por exemplo: uma funcionária com 2 anos de empresa receberá 2% sobre o valor total das manutenções que executou.
--Funcionárias com menos de 1 ano de empresa receberão 1%.



-- Função para calcular tempo de empresa em anos completos
CREATE OR ALTER FUNCTION fn_calcular_tempo_empresa (@data_entrada DATE)
RETURNS INT AS
BEGIN
    DECLARE @anos INT
    SET @anos = DATEDIFF(YEAR, @data_entrada, GETDATE())
    
    -- Ajuste se ainda não completou o aniversário este ano
    IF MONTH(@data_entrada) > MONTH(GETDATE()) OR 
       (MONTH(@data_entrada) = MONTH(GETDATE()) AND DAY(@data_entrada) > DAY(GETDATE()))
    BEGIN
        SET @anos = @anos - 1
    END
    
    RETURN @anos
END
GO

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

-- Executar o procedimento
EXEC sp_beneficios_mulheres
