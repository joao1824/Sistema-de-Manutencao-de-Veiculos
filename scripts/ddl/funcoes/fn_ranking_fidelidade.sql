-- function p/ ranking de fidelidade do cliente

drop function if exists dbo.fn_ranking_fidelidade
go

create function dbo.fn_ranking_fidelidade(@total_gasto numeric(10,2))
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
