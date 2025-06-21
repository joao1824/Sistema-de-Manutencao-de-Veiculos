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
            WHEN seguros.cd_status_seguros = 2 THEN CAST(manutencoes.vl_manutencao * 1.15)
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




CREATE PROCEDURE CarrosAguardandoSeguro
AS
BEGIN
    SELECT
        m.placa,
        sg.nome AS NomeSeguradora,
        CASE 
            WHEN sg.status = 1 THEN 'Ativa'
            WHEN sg.status = 2 THEN 'Inativa'
            ELSE 'Desconhecido'
        END AS StatusSeguradora,
        CASE 
            WHEN sg.status = 2 THEN CAST(m.vl_manutencao * 1.15 AS NUMERIC(6,2))
            ELSE m.vl_manutencao
        END AS ValorManutencao
    FROM
        manutencoes m
    INNER JOIN
        carros c ON m.placa = c.placa
    INNER JOIN
        seguradoras sg ON c.id_seguradora = sg.id_seguradora
    WHERE
        m.cd_status_manutencoes = 6
END;
