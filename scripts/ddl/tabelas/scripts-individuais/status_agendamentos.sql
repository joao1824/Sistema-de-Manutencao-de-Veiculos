/*==============================================================*/
/* Table: status_agendamentos                                   */
/*==============================================================*/

create table status_agendamentos(
	cd_status_agendamento tinyint not null primary key,
	status varchar(20) not null check(status in ('Ativo','Cancelado','Retificada'))
)
go
