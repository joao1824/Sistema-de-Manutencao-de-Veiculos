

/*==============================================================*/
/* Table: seguros                                               */
/*==============================================================*/

create table seguros(
	cd_seguro int not null primary key,
	nm_seguradora varchar(50) not null,
	cd_status_seguros tinyint not null,
	constraint fk_status_seguros foreign key (cd_status_seguros)
	references status_seguros(cd_status_seguros)
)
go
