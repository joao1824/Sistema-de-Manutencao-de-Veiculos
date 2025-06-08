insert into seguros  (cd_seguro, nm_seguradora, cd_status_seguros)
	     values  (1, 'Neo Seguradora', 1),
       		     (2, 'Seguro Auto', 2),
       		     (3, 'PROAUTO Santa Catarina', 2),
       		     (4, 'Porto Seguro', 2),
       		     (5, 'Seguro Auto Youse', 1),
       		     (6, 'Alianca Segura', 1),
       		     (7, 'Suhai Seguros', 1),
       		     (8, 'Azul Seguros', 2),
       		     (9, 'Ituran', 1),
       		     (10, 'HDI Seguros', 2)

create [nonclustered] index Idx_seguros_nm_seguradora on seguros (nm_seguradora)