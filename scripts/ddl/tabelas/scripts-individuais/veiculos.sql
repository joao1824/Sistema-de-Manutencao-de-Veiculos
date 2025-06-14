
/*==============================================================*/
/* Table: veiculos                                              */
/*==============================================================*/


create table veiculos(
	placa varchar(7) not null primary key,
	cd_cliente int not null,
	marca varchar(20) not null,
	modelo varchar(20) not null,
	ano int not null,
	cd_seguro int not null,
	constraint fk_cliente foreign key (cd_cliente)
	references cliente(cd_cliente),
	constraint fk_seguro foreign key (cd_seguro)
	references seguros(cd_seguro)
)
go