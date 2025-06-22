
/*==============================================================*/
/* Table: status_manutencoes                                    */
/*==============================================================*/



create table status_manutencoes(
	cd_status_manutencoes tinyint not null primary key,
	status varchar(40) not null check(status in ('Pronto', 'Em Andamento', 'Atrasado', 'Em espera de peças', 'Em espera de pagamento', 'Esperando o Seguro', 'Carro não veio', 'Em segundo Plano', 'Emergência', 'Sem espaço para armazenar'))
)
go
