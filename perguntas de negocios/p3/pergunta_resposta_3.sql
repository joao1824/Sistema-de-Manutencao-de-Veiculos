--Ranquear as alas que fizeram mais manutenções para a empresa e quanto que 
--geraram de renda em média com um desconto de 15% sobre o valor como custo de 
--peças, mostrando: o nome dessa ala, a quantidade de manutenções que fizeram, 
--a renda média (sem desconto) e o lucro líquido

create or alter procedure pr_AlaLucro as
  BEGIN
    select alas.ala AS NomeAla, 
    COUNT(manutencoes.cd_alas) AS Quant,
    AVG(manutencoes.vl_manutencao) AS Media,
    AVG(manutencoes.vl_manutencao * 0.85) AS LucroLiquido
  from
    manutencoes
  Inner Join 
    alas on manutencoes.cd_alas = alas.cd_alas
  group by 
    alas.ala
  order by
    Quant DESC
  END

exec pr_AlaLucro
