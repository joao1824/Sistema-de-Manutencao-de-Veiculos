--Fun��o para conseguir a media de uma valor j� somado pr�viamente e dividir pela quantidade

create or alter function fn_media (@valor numeric(5,2),@quantidade int) returns numeric(5,2) as 
	begin
		declare @media numeric(5,2);
		set @media = @valor / @quantidade;
		return @media;
	end
