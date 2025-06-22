/*==============================================================*/
/* Table: funcionarios                                          */
/*==============================================================*/

create table funcionarios(
	cd_funcionario int primary key not null,
	nm_funcionario varchar(200) not null,
	cpf varchar(14) null,
	telefone varchar(20) not null,
	data_nascimento date null,
	data_entrada date not null,
	data_saida date null,
	sexo char(1) not null check(sexo in ('F','M')),
	cd_status_funcionario tinyint not null,
	constraint fk_status_funcionario foreign key (cd_status_funcionario)
	references status_funcionarios(cd_status_funcionarios) 
)
go
