/* -- SCRIPT PARA CRIAÇÃO DE TODAS AS TABELAS -- */

-- create database sistema_manutencao_veiculos
-- go


use sistema_manutencao_veiculos
go


-- Tabela clientes
create table clientes(
	cd_cliente int not null primary key,
	nm_cliente varchar(50) not null,
	cpf varchar(14) null,
	telefone varchar(20) not null
)
go


-- Tabela status_seguros
create table status_seguros(
	cd_status_seguros tinyint not null primary key,
	status varchar(20) not null check(status in ('Ativo','Inativo'))
)
go


-- Tabela seguros
create table seguros(
	cd_seguro int not null primary key,
	nm_seguradora varchar(50) not null,
	cd_status_seguros tinyint not null,
	constraint fk_status_seguros foreign key (cd_status_seguros)
	references status_seguros(cd_status_seguros)
)
go


-- Tabela veiculos
create table veiculos(
	placa varchar(7) not null primary key,
	cd_cliente int not null,
	marca varchar(20) not null,
	modelo varchar(20) not null,
	ano smallint not null,
	cd_seguro int not null,
	constraint fk_cliente foreign key (cd_cliente)
	references clientes(cd_cliente),
	constraint fk_seguro foreign key (cd_seguro)
	references seguros(cd_seguro)
)
go


-- Tabela status_manutencoes
create table status_manutencoes(
	cd_status_manutencoes tinyint not null primary key,
	status varchar(40) not null check(status in ('Pronto', 'Em Andamento', 'Atrasado', 'Em espera de peças', 'Em espera de pagamento', 'Esperando o Seguro', 'Carro não veio', 'Em segundo Plano', 'Emergência', 'Sem espaço para armazenar'))
)
go


-- Tabela alas
create table alas(
	cd_alas tinyint not null primary key,
	ala varchar(50) not null,
	descricao varchar(200) null
)
go


-- Tabela status_agendamentos
create table status_agendamentos(
	cd_status_agendamento tinyint not null primary key,
	status varchar(20) not null check(status in ('Ativo','Cancelado','Retificada'))
)
go


-- Tabela status_funcionarios
create table status_funcionarios(
	cd_status_funcionarios tinyint not null primary key,
	status varchar(10) not null check(status in ('Ativo','Suspenso','Demitido','Férias'))
)
go


-- Tabela funcionarios
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


-- Tabela tipos_manutencao
create table tipos_manutencao(
	cd_tipo smallint not null primary key,
	descricao varchar(50) not null
)
go


-- Tabela agendamentos
create table agendamentos(
	cd_agenda int not null primary key,
	data_contatada date not null,
	data_agendada date not null,
	horario_agendado time not null,
	cd_funcionario	int not null,
	placa varchar(7) not null,
	cd_tipo smallint not null,
	cd_status_agendamento tinyint not null,	
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


-- Tabela manutencoes
create table manutencoes(
	cd_manutencao int identity(1,1) not null primary key,
	placa varchar(7) not null,
	cd_funcionario int not null,
	cd_tipo smallint not null,
	cd_alas tinyint not null,
	vl_manutencao numeric(7,2) null,
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
