/* -- SCRIPT PARA INSERÇÃO EM TODAS AS TABELAS -- */

use crud
go


/* Tabelas Status */
-- Tabela status_agendamentos
insert into status_agendamentos (cd_status_agendamento, status)
values (1, 'Ativo'),
	   (2, 'Cancelado'),
	   (3, 'Retificada');
go


-- Tabela status_funcionarios
insert into status_funcionarios (cd_status_funcionarios, status)
values (1, 'Ativo'),
	   (2, 'Suspenso'),
	   (3, 'Demitido'),
	   (4, 'Férias');
go


-- Tabela status_manutencoes
insert into status_manutencoes (cd_status_manutencoes, status)
values (1, 'Pronto'),
       (2, 'Em Andamento'),
       (3, 'Atrasado'),
       (4, 'Em espera de peças'),
       (5, 'Em espera de pagamento'),
       (6, 'Esperando o Seguro'),
       (7, 'Carro não veio'),
       (8, 'Em segundo Plano'),
       (9, 'Emergência'),
       (10, 'Sem espaço para armazenar');
go


-- Tabela status_seguros
insert into status_seguros (cd_status_seguros, status)
values (1, 'Ativo'),
	   (2, 'Inativo');
go


/* Tabelas Gerais */
-- Tabela tipos_manutencao
insert into tipos_manutencao (cd_tipo, descricao) 
values (1, 'Troca de óleo'),
	   (2, 'Troca de pneu'),
	   (3, 'Troca de bateria'),
	   (4, 'Verificação de freios'),
	   (5, 'Troca de pastilhas de freio'),
	   (6, 'Troca de amortecedores'),
	   (7, 'Troca de velas de ignição'),
	   (8, 'Verificação do sistema de arrefecimento'),
	   (9, 'Troca de embreagem'),
	   (10, 'Verificação do sistema de escapamento'),
	   (11, 'Revisão completa');
go


-- Tabela funcionarios
insert into funcionarios (cd_funcionario, nm_funcionario, cpf, telefone, data_nascimento, data_entrada, data_saida, sexo, cd_status_funcionario)
values (1, 'Ana Souza', '123.456.789-00', '11987654321', '1990-05-10', '2020-01-15', NULL, 'F', 1),
	   (2, 'Bruno Lima', '987.654.321-00', '21912345678', '1985-11-22', '2018-03-10', NULL, 'M', 1),
	   (3, 'Carlos Mendes', '111.222.333-44', '31987654321', '1992-07-08', '2021-06-01', NULL, 'M', 2),
	   (4, 'Daniela Castro', '222.333.444-55', '11999998888', '1995-09-15', '2022-04-20', NULL, 'F', 4),
	   (5, 'Eduardo Silva', '333.444.555-66', '31912344321', '1980-01-30', '2015-09-12', '2023-11-30', 'M', 3),
	   (6, 'Fernanda Dias', NULL, '21988887777', '1993-12-25', '2019-02-01', NULL, 'F', 1),
	   (7, 'Gabriel Torres', '444.555.166-77', '21955554444', '1988-06-10', '2017-08-05', NULL, 'M', 4),
	   (8, 'Helena Ribeiro', '555.626.777-88', '11944443333', '1991-03-18', '2016-11-21', '2022-12-15', 'F', 3),
	   (9, 'Igor Almeida', '662.777.888-99', '31999990000', '1983-04-14', '2010-07-09', NULL, 'M', 1),
	   (10, 'Juliana Martins', NULL, '11933332222', '1990-08-05', '2023-01-02', NULL, 'F', 2),
	   (11, 'Pedro Martins', '123.222.444-23', '11463532222', '1994-08-05', '2023-01-02', NULL, 'M', 1),
	   (12, 'João Gabriel', '412.244.543-12', '11146332222', '2000-08-05', '2023-03-02', NULL, 'M', 1),
	   (13, 'Marcos Fernandez', NULL, '11933311462', '1999-05-23', '2020-12-23', NULL, 'M', 1),
	   (14, 'Lara Camilo', '433.256.368-25', '11933132222', '1997-04-02', '2017-02-02', NULL, 'F', 1),
	   (15, 'Bianca Da Silva', '245.333.351-57', '11933332222', '1996-08-05', '2025-01-02', NULL, 'F', 1),
	   (16, 'Juliano Mendes', NULL, '11933331222', '1996-08-05', '2023-11-02', NULL, 'M', 1);
go


-- Tabela alas
insert into alas (cd_alas, ala, descricao) 
values (1, 'Norte', 'Ala da Equipe 1'),
       (2, 'Sul', 'Ala de revisao'),
       (3, 'Leste', 'Ala da Equipe 2'),
       (4, 'Oeste', 'Ala da Equipe 3'), 
       (5, 'Centro', 'Ala principal');
go


-- Tabela seguros
insert into seguros (cd_seguro, nm_seguradora, cd_status_seguros)
values  (1, 'Neo Seguradora', 1),
       	(2, 'Seguro Auto', 2),
       	(3, 'PROAUTO Santa Catarina', 2),
       	(4, 'Porto Seguro', 2),
       	(5, 'Seguro Auto Youse', 1),
       	(6, 'Alianca Segura', 1),
       	(7, 'Suhai Seguros', 1),
       	(8, 'Azul Seguros', 2),
       	(9, 'Ituran', 1),
       	(10, 'HDI Seguros', 2),
       	(11, 'Minuto Seguradora', 1),
	    (12, 'Youse', 2),
	    (13, 'Seguradora Catarinense', 2),
	    (14, 'Pier Seguradora', 1),
	    (15, 'Forte Proteção Veicular', 1),
	    (16, 'Liderança Proteção Veicular', 1),
	    (17, 'Seguradora Tokio Marine', 1),
	    (18, 'Allianz Brasil', 1);
go


-- Tabela clientes
insert into clientes (cd_cliente, nm_cliente, cpf, telefone)
values (1, 'Melissa Ferreira Rocha', '81866913085', '4838565857'),
       (2, 'Victor Cardoso Melo', '52926093071', '1925341664'),
       (3, 'Kaua Barros Barbosa', '28081666052', '8121087022'),
       (4, 'Júlia Sousa Carvalho', '51192887077', '4827155874'),
       (5, 'Nicole Gomes Alves', '72345121017', '4829375332'),
       (6, 'Leonor Castro Barros', '53646858028', '4729228642'),
       (7, 'Rafael Rocha Melo', '75916462069', '4933671675'),
       (8, 'Raissa Pereira Cavalcanti', '52392248036', '5134278273'),
       (9, 'Vitoria Pereira Dias', '83681483086', '4439490267'),
       (10, 'José Pereira Martins', '59231115006', '4525104608');
go


-- Tabela veiculos
insert into veiculos (placa, cd_cliente, marca, modelo, ano, cd_seguro)
values ('HSU3792', 1, 'Jeep', 'Grand Cherokee', 2019, 1),
	   ('IZC1490', 2, 'Citroen', 'C4 Tendance', 2023, 2),
	   ('IDL5690', 3, 'Hyundai', 'Elantra', 2014, 3),
	   ('EKW3904', 4, 'Chevrolet', 'Corsa Wind Piquet', 2019, 4),
	   ('KSX3812', 5, 'Chevrolet', 'Omega CD', 2023, 5),
	   ('GES2653', 6, 'Volvo', 'S80', 2013, 6),
	   ('NGM2579', 7, 'BMW', 'i3', 2019, 7),
	   ('HZO6425', 8, 'Fiat', 'UNO', 2012, 8),
	   ('FSZ7576', 9, 'Nissan', 'XTerra', 2023, 9),
	   ('ADH2381', 10, 'Honda', 'Accord', 2018, 10);
go


-- Tabela agendamentos
insert into agendamentos (cd_agenda, data_contatada, data_agendada, horario_agendado,
					      cd_funcionario, placa, cd_tipo, cd_status_agendamento)
values (1, '2025-06-01', '2025-06-05', '08:00:00', 1, 'HSU3792', 3, 1),
	   (2, '2025-06-02', '2025-06-06', '09:30:00', 2, 'IZC1490', 7, 1),
	   (3, '2025-06-03', '2025-06-07', '10:00:00', 13, 'IDL5690', 1, 2),
	   (4, '2025-06-04', '2025-06-08', '08:00:00', 15, 'EKW3904', 11, 1),
	   (5, '2025-06-04', '2025-06-08', '10:30:00', 2, 'KSX3812', 5, 3),
	   (6, '2025-06-04', '2025-06-08', '15:00:00', 6, 'GES2653', 9, 1),
	   (7, '2025-06-07', '2025-06-11', '15:45:00', 11, 'NGM2579', 2, 1),
	   (8, '2025-06-08', '2025-06-12', '16:30:00', 16, 'HZO6425', 10, 2),
	   (9, '2025-06-09', '2025-06-13', '08:45:00', 9, 'FSZ7576', 4, 1),
	   (10, '2025-06-10', '2025-06-14', '10:30:00', 14, 'ADH2381', 8, 1),
	   (11, '2025-07-01', '2025-07-14', '14:30:00', 1, 'ADH2381', 8, 1),
	   (12, '2025-07-01', '2025-07-10', '10:30:00', 6, 'IZC1490', 8, 1),
	   (13, '2025-07-10', '2025-07-12', '08:30:00', 15, 'NGM2579', 8, 2),
	   (14, '2025-07-16', '2025-08-07', '17:00:00', 1, 'EKW3904', 8, 1),
	   (15, '2025-07-12', '2025-07-11', '15:30:00', 12, 'ADH2381', 8, 2),
	   (16, '2025-07-23', '2025-07-23', '07:30:00', 1, 'NGM2579', 8, 3),
	   (17, '2025-07-25', '2025-08-10', '10:30:00', 9, 'FSZ7576', 8, 1);
go


-- Tabela anutencoes
insert into manutencoes (cd_manutencao, placa, cd_funcionario, cd_tipo, cd_alas, vl_manutencao, cd_status_manutencoes)
values (1, 'HSU3792', '2', '11', '2', '250.00', '1'),
       (2, 'HSU3792', '6', '3', '1', '350.00', '2'),
       (3, 'EKW3904', '12', '11', '2', '250.00', '1'),
       (4, 'NGM2579', '12', '5', '4', '450.00', '5'),
       (5, 'EKW3904', '1', '9', '5', '500.00', '3'),
       (6, 'IZC1490', '9', '11', '2', '250.00', '2'),
       (7, 'IDL5690', '15', '11', '2', '250.00', '1'),
       (8, 'KSX3812', '15', '8', '1', '300.00', '7'),
       (9, 'GES2653', '9', '10', '4', '450.00', '6'),
       (10, 'FSZ7576', '1', '11', '2', '250.00', '8'),
       (11, 'ADH2381', '11', '11', '2', '250.00', '9'),
       (12, 'HZO6425', '15', '11', '2', '250.00', '8'),
       (13, 'ADH2381', '8', '3', '2', '450.00', '9'),
       (14, 'ADH2381', '14', '6', '2', '450.00', '9'),
       (15, 'IDL5690', '13', '2', '5', '375.00', '10');
go