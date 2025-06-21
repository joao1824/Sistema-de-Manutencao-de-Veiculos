create nonclustered index idx_funcionarios_cd_status on funcionarios(cd_status_funcionario)
create index idx_func_fn_porcentagem_media on funcionarios (cd_funcionario) include (data_entrada)
create index idx_func_relatorio_top3 on funcionarios (cd_funcionario, cd_status_funcionario) include (nm_funcionario, data_entrada);
go