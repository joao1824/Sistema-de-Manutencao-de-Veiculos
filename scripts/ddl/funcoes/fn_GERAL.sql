--Aplica um desconto de 20% sobre o valor informado.

create or alter function fn_20 (@valor numeric(7,2)) returns numeric(7,2) as  
	begin
		declare @descontado numeric(7,2);
		set @descontado = @valor * 0.8;
		return @descontado;
	end

	
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


-- 2. Função para contar quantos tipos de manutenção existem
create or alter function fn_contar_tipos_manutencao()
returns int as
begin
    declare @total int;
    select @total = count(*) from tipos_manutencao;
    return @total;
end;
GO


--Função para conseguir a media de uma valor já somado previamente e dividir pela quantidade

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
	

-- function p/ ranking de fidelidade do cliente

create or alter function dbo.fn_ranking_fidelidade(@total_gasto numeric(10,2))
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
