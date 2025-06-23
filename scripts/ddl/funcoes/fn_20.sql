--Aplica um desconto de 20% sobre o valor informado.

create or alter function fn_20 (@valor numeric(7,2)) returns numeric(7,2) as  
	begin
		declare @descontado numeric(7,2);
		set @descontado = @valor * 0.8;
		return @descontado;
	end