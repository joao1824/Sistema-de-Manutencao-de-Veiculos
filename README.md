# Sistema de Manutenção de Veículos | Grupo D
Este projeto consiste na elaboração de um modelo de banco de dados para um sistema hipotético de manutenção de veículos.
<br>
Utilizando SQLServer, em conjunto com o framework React e a ferramenta node.js, também foi elaborada uma aplicação do tipo CRUD
capaz de modificar a tabela manutencoes conforme o desejo do usuário.


## Equipe
- Bruno Pagani Rampinelli     - ```NaoSouOBruno```
- Gabriel dos Reis Klein      - ```Gabriel-dos-Reis-Klein```
- Gabriel Tramontin Aguiar    - ```GabrielTramontin```
- João Henrique Camilo Fogaça - ```joao1824```
- Yuri Cardoso Maciel         - ```DoppelsoldnerHRE```


## Modelo Físico
Através da ferramenta digital [dbdiagram.io](https://dbdiagram.io/), criamos os modelos das tabelas para o banco de dados, bem como suas interrelações e atributos.
<br><br>
![modelo-fisico](https://github.com/user-attachments/assets/248f93ff-6f0f-433a-9f26-ed28d499ce1c)
<br>
Fonte: [modelo-fisico.png](modelo_fisico/modelo-fisico.png)


## Dicionário de Dados
As informações sobre as tabelas e seus respectivos índices estão no arquivo [dicionario.xlsx](dicionario_tabelas/dicionario.xlsx).


## Scripts SQL
O projeto utiliza o banco de dados fornecido pela [Azure](https://azure.microsoft.com/pt-br/products/azure-sql/database).<br>
Para criar um banco de dados Azure, siga o [passo a passo](https://github.com/jlsilva01/sql-azure).<br><br>

A seguir estão dispostos os scripts SQL, separados por tipo:
- [Tabelas (DDL)](scripts/ddl/tabelas)
- [Índices](scripts/ddl/indices)
- [Triggers](scripts/ddl/triggers)
- [Stored Procedures](scripts/ddl/procedures)
- [Funções](scripts/ddl/funcoes)
- [DML](scripts/dml)

## CRUD
### Código Fonte
- HTML, CSS e JS
- Framework React
- Node.js (cliente MSSQL)

### Execução
1. Com o banco de dados Azure criado (passo a passo disponível na seção Scripts SQL), acessar a pasta raiz do projeto.
   
2. Garantir que, no arquivo [server.js](crud/API/server.js), as variáveis ```user```, ```password```, ```server``` e ```database``` correspondem aos atributos do banco de dados criado.
   
3. No diretório raiz, abrir um primeiro terminal e executar o seguinte comando:
    ```
    cd crud/API; npm install; npm init -y; node server.js
    ```
  
4. Com o primeiro terminal ainda rodando, abrir um segundo terminal, também no diretório raiz do programa, e executar o seguinte comando:
   ```
   cd crud; npm install; npm run dev
   ```
  
5. Acessar o link apresentado no terminal.

## Relatório Final

- Todas as informações pertinentes estão no [Relatório Final](https://github.com/joao1824/Sistema-de-Manutencao-de-Veiculos/blob/main/relatorio-final/relat%C3%B3rio.pdf)


## Referências
### Websites
- Integrar o Banco de Dado no react [mssql - npm](https://www.npmjs.com/package/mssql)
- Tags React e CRUD nos fóruns [StackOverflow](https://stackoverflow.com/search?q=react+crud)
- Exemplos de React Hooks em [W3School](https://www.w3schools.com/react/react_hooks.asp)
### Vídeos
- Montagem de CRUD em React https://www.youtube.com/watch?v=9pBdDVRmC2s
- React JS + Node JS + Sql Server https://www.youtube.com/watch?v=9pBdDVRmC2s
