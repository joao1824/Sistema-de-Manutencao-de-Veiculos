create nonclustered index idx_manutencoes_cd_manutencao on manutencoes(cd_manutencao)
create nonclustered index idx_manutencoes_placa on manutencoes(placa)
create nonclustered index idx_manutencoes_cd_funcionario on manutencoes(cd_funcionario)
create nonclustered index idx_manutencoes_vl_manutencao on manutencoes(vl_manutencao)

create nonclustered index idx_veiculos_cd_cliente on veiculos(cd_cliente)
create nonclustered index idx_veiculos_cd_seguro on veiculos(cd_seguro)

create nonclustered index idx_funcionarios_cd_status on funcionarios(cd_status_funcionario)

create nonclustered index idx_status_funcionarios_status on status_funcionarios(status)

create nonclustered index idx_seguros_cd_status on seguros(cd_status_seguros)

create nonclustered index idx_status_seguros_status on status_seguros(status)

create nonclustered index idx_clientes_nm_cliente on clientes(nm_cliente)
go
