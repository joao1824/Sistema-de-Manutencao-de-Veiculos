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