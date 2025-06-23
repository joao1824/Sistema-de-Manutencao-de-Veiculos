-- Função usada para conseguir a % de comissão do funcionario com base em quanto tempo eles esta na empressa

create or alter function fn_porcentagem_media (@valor numeric(7,2),@cd_funcionario int) returns numeric(7,2) as 
	begin
		declare @resposta numeric(7,2);
		declare @tempo_entrada date;
		declare @tempo_total int;
		set @tempo_entrada = (select data_entrada from funcionarios where cd_funcionario = @cd_funcionario);
		set @tempo_total = floor(datediff(year,@tempo_entrada,getdate()));
		set @resposta = (@valor * (@tempo_total*10))/100;

		return @resposta

	end