
/*==============================================================*/
/* Table: status_manutencoes                                    */
/*==============================================================*/



create table status_manutencoes(
	cd_status_manutencoes int not null primary key,
	status varchar(20) not null check(status in ('Em progresso','Concluída','Cancelada'))
)
go