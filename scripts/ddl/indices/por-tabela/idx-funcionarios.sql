create nonclustered index idx_funcionarios_cd_status on funcionarios(cd_status_funcionario)
create nonclustered index idx_func_fn_porcentagem_media on funcionarios (cd_funcionario) include (data_entrada)
create nonclustered index idx_func_relatorio_top3 on funcionarios (cd_funcionario, cd_status_funcionario) include (nm_funcionario);
CREATE NONCLUSTERED INDEX IX_funcionarios_sexo_status ON funcionarios (sexo, cd_status_funcionario) INCLUDE (cd_funcionario, nm_funcionario, data_saida, data_entrada);
CREATE NONCLUSTERED INDEX IX_manutencoes_funcionario_valor ON manutencoes (cd_funcionario) INCLUDE (vl_manutencao);
go
