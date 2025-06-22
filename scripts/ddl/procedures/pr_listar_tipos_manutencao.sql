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