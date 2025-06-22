--Solicita-se listar todos os tipos de manutenção cadastrados na empresa, apresentando para cada tipo o código (cd_tipo) e a descrição (descricao). Os resultados devem ser ordenados alfabeticamente pela descrição.”
-- Índice para otimizar busca por descrição na tabela tipo_manutencao
create index idx_tipo_manutencao_descricao
on tipo_manutencao(descricao);
GO

-- Função para contar quantos tipos de manutenção existem
create or alter function fn_contar_tipos_manutencao()
returns int as
begin
    declare @total int;
    select @total = count(*) from tipo_manutencao;
    return @total;
end;
GO

-- Procedure para listar tipos de manutenção ordenados por descrição
create or alter procedure pr_listar_tipos_manutencao as
begin
    select cd_tipo, descricao
    from tipo_manutencao
    order by descricao;
end;
GO

-- Execução da procedure para listar os tipos
exec pr_listar_tipos_manutencao;
