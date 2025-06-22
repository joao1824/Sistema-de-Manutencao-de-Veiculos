/*==============================================================*/
/* Table: manutencoes                                           */
/*==============================================================*/

create table manutencoes(
	cd_manutencao int identity(1,1) not null primary key,
	placa varchar(7) not null,
	cd_funcionario int not null,
	cd_tipo smallint not null,
	cd_alas tinyint not null,
	vl_manutencao numeric(5,2) null,
	cd_status_manutencoes tinyint not null,
	constraint fk_status_manutencao foreign key (cd_status_manutencoes)
	references status_manutencoes(cd_status_manutencoes),
	constraint fk_alas foreign key (cd_alas)
	references alas(cd_alas),
	constraint fk_tipo_manutencao foreign key (cd_tipo)
	references tipos_manutencao(cd_tipo),
	constraint fk_funcionario_manutencao foreign key (cd_funcionario)
	references funcionarios(cd_funcionario),
	constraint fk_placa_manutencao foreign key (placa)
	references veiculos(placa)
)
go
