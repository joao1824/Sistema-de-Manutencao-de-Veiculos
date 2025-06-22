--Solicita-se listar todos os tipos de manutenção cadastrados na empresa, apresentando para cada tipo o código (cd_tipo) e a descrição (descricao). Os resultados devem ser ordenados alfabeticamente pela descrição.”
-- 1. Índice para otimizar busca por descrição
create index idx_tipos_manutencao_descricao
on tipos_manutencao(descricao);
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

-- 3. Procedure para listar tipos de manutenção ordenados por descrição
create or alter procedure pr_listar_tipos_manutencao as
begin
    select cd_tipo, descricao
    from tipos_manutencao
    order by descricao;
end;
GO

-- 4. Executar a procedure
exec pr_listar_tipos_manutencao;