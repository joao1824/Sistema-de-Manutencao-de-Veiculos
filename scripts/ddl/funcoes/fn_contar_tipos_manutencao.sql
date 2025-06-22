
-- 2. Função para contar quantos tipos de manutenção existem
create or alter function fn_contar_tipos_manutencao()
returns int as
begin
    declare @total int;
    select @total = count(*) from tipos_manutencao;
    return @total;
end;
GO
