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

create nonclustered index idx_tipos_manutencao_cd_tipo on tipos_manutencao(cd_tipo)
create nonclustered index idx_tipos_manutencao_descricao on tipos_manutencao(descricao)


create nonclustered index idx_func_fn_porcentagem_media on funcionarios (cd_funcionario) include (data_entrada)
create nonclustered index idx_func_relatorio_top3 on funcionarios (cd_funcionario, cd_status_funcionario) include (nm_funcionario);
create nonclustered index idx_manut_relatorio_top3 on manutencoes(cd_funcionario) include (vl_manutencao);


CREATE NONCLUSTERED INDEX IX_funcionarios_sexo_status ON funcionarios (sexo, cd_status_funcionario) INCLUDE (cd_funcionario, nm_funcionario, data_saida, data_entrada);
CREATE NONCLUSTERED INDEX IX_funcionarios_data_entrada ON funcionarios (data_entrada) INCLUDE (cd_funcionario);
CREATE NONCLUSTERED INDEX IX_manutencoes_funcionario_valor ON manutencoes (cd_funcionario) INCLUDE (vl_manutencao);

go
