/*==============================================================*/
/* Table: status_funcionarios                                   */
/*==============================================================*/


create table status_funcionarios(
	cd_status_funcionarios int not null primary key,
	status varchar(10) not null check(status in ('Ativo','Suspenso','Demitido','Férias'))
)
go
