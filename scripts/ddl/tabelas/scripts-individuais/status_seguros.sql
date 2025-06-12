
/*==============================================================*/
/* Table: status_seguros                                        */
/*==============================================================*/


create table status_seguros(
	cd_status_seguros int not null primary key,
	status varchar(20) not null check(status in ('Ativo','Inativo'))
)
go