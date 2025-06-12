insert into veiculos (placa, cd_cliente, marca, modelo, ano, cd_seguro)
	      values ('HSU3792', 1, 'Jeep', 'Grand Cherokee', 2019, 1),
		     ('IZC1490', 2, 'Citroen', 'C4 Tendance', 2023, 2),
		     ('IDL5690', 3, 'Hyundai', 'Elantra', 2014, 3),
		     ('EKW3904', 4, 'Chevrolet', 'Corsa Wind Piquet', 2019, 4),
		     ('KSX3812', 5, 'Chevrolet', 'Omega CD', 2023, 5),
		     ('GES2653', 6, 'Volvo', 'S80', 2013, 6),
		     ('NGM2579', 7, 'BMW', 'i3', 2019, 7),
		     ('HZO6425', 8, 'Fiat', 'UNO', 2012, 8),
		     ('FSZ7576', 9, 'Nissan', 'XTerra', 2023, 9),
		     ('ADH2381', 10, 'Honda', 'Accord', 2018, 10)

create [nonclustered] index Idx_seguros_placa on veiculos (placa)