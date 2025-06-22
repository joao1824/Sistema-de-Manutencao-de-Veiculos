-- �ndice para otimizar busca por descri��o na tabela tipo_manutencao
create index idx_tipo_manutencao_descricao
on tipo_manutencao(descricao);
GO

-- Fun��o para contar quantos tipos de manuten��o existem
create or alter function fn_contar_tipos_manutencao()
returns int as
begin
    declare @total int;
    select @total = count(*) from tipo_manutencao;
    return @total;
end;
GO

-- Procedure para listar tipos de manuten��o ordenados por descri��o
create or alter procedure pr_listar_tipos_manutencao as
begin
    select cd_tipo, descricao
    from tipo_manutencao
    order by descricao;
end;
GO

-- Execu��o da procedure para listar os tipos
exec pr_listar_tipos_manutencao;
