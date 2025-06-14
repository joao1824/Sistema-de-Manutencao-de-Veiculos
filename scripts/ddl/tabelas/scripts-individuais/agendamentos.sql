/*==============================================================*/
/* Table: agendamentos                                          */
/*==============================================================*/

create table agendamentos(
	cd_agenda int not null primary key,
	data_contatada date not null,
	data_agendada date not null,
	horario_agendado time not null,
	cd_funcionario	int not null,
	placa varchar(7) not null,
	cd_tipo int not null,
	cd_status_agendamento int not null,	
	constraint fk_status_agendamento foreign key (cd_status_agendamento)
	references status_agendamentos(cd_status_agendamento),
	constraint fk_tipo_agendamento foreign key (cd_tipo)
	references tipos_manutencao(cd_tipo),
	constraint fk_placa_agendamento foreign key (placa)
	references veiculos(placa),
	constraint fk_funcionario_agendamento foreign key (cd_funcionario)
	references funcionarios(cd_funcionario)
)
go
