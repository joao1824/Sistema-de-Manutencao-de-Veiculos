
-- 2. Fun��o para contar quantos tipos de manuten��o existem
create or alter function fn_contar_tipos_manutencao()
returns int as
begin
    declare @total int;
    select @total = count(*) from tipos_manutencao;
    return @total;
end;
GO
