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
       		     (10, 'José Pereira Martins', '59231115006', '4525104608')

create [nonclustered] index Idx_clientes_nm_cliente on clientes (nm_cliente)
create unique [nonclustered] index Idx_clientes_cpf on clientes (cpf)