create or alter procedure pr_VerificaSeguro as 
  BEGIN
    select 
        manutencoes.placa,
        seguros.nm_seguradora AS Nome,
        CASE 
            WHEN seguros.cd_status_seguros = 1 THEN 'Ativa'
            WHEN seguros.cd_status_seguros = 2 THEN 'Inativa'
            ELSE 'Desconhecido'
        END AS StatusSeguradora,
        CASE 
            WHEN seguros.cd_status_seguros = 2 THEN CAST(manutencoes.vl_manutencao * 1.15 as numeric(5,2))
            ELSE manutencoes.vl_manutencao
        END AS ValorManutencao
    FROM
        manutencoes
    INNER JOIN
        veiculos ON manutencoes.placa = veiculos.placa
    INNER JOIN
        seguros ON veiculos.cd_seguro = seguros.cd_seguro
    WHERE
        manutencoes.cd_status_manutencoes = 6
end
