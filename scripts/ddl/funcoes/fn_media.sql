--Fun��o para conseguir a media de uma valor j� somado previamente e dividir pela quantidade

create or alter function fn_media (@valor numeric(7,2),@quantidade int) returns numeric(7,2) as 
	begin
		declare @media numeric(7,2);
		set @media = @valor / @quantidade;
		return @media;
	end
