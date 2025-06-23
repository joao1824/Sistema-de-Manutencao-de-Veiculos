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
