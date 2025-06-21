create nonclustered index idx_manutencoes_placa on manutencoes(placa)
create nonclustered index idx_manutencoes_cd_funcionario on manutencoes(cd_funcionario)
create nonclustered index idx_manutencoes_vl_manutencao on manutencoes(vl_manutencao)
create nonclustered index idx_manut_relatorio_top3 on manutencoes (cd_funcionario) include (vl_manutencao);
go