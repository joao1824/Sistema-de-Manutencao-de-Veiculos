/*==============================================================*/
/* Table: clientes                                               */
/*==============================================================*/
create table clientes(
	cd_cliente int not null primary key,
	nm_cliente varchar(50) not null,
	cpf varchar(14) null,
	telefone varchar(20) not null
)
go
