--Identificar quais carros estão a espera do seguros e verificar se esses seguros estão ativos ou não, 
--caso não estiverem aumentar o valor da manutenção por 15% por demora de pagamento, mostrar no resultado: 
--placa do carro, nome da seguradora, status da seguradora, valor da manutenção

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

exec pr_VerificaSeguro