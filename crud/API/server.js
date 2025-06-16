const express = require('express'); // permiti criar as rotas http
const sql = require('mssql'); // comunica com o banco sql server
const cors = require('cors'); // acessar o back end em outro endereço

const app = express(); // coloco o express com função em app para eu poder usalo 
app.use(cors()); //para coneguir requisição de outro dominio
app.use(express.json()); //para conseguir ler em JSON


// configurar conexão com SQL Server (local ou Azure)
const dbConfig = {    // atenção aqui tem que ser igualzinho as config do servidor se não não funfa
  user: 'admin_user',  // essas config fui eu que usei, se quiser pofe replicar dai não precisar alterar aqui (eu usei o azure mas pode ser usado o local só que ainda não tentei)
  password: 'satc123!',
  server: 'crud-server-satc.database.windows.net',
  database: 'crud',
  options: {
    encrypt: true, //precisa disso se for fazer no azure
    trustServerCertificate: true //precisa disso se for fazer no azure
  }
};

// FUNÇÃO EXIBIR TABELA
app.get('/manutencoes', async(req , res) => { // req e res vai set usado dependendo do metodo tipo post, put etc...
    try{ // tento 
        await sql.connect(dbConfig); /// aqui é espero conectar (await só pode ser usado quando tiver async logo acima)
        const resultado = await sql.query('select * from manutencoes'); // declaro uma variavel e essa variavel dentro dela ta esperando completar o select  
        res.json(resultado.recordset); //acesso o resultado da variavel pelo recordset e já mando em formato jsno pelo "res"
    } catch(err) { // se der erro
        res.status(500).send('Deu Ruim No SERVIDOR') // ele responde com status de 500 de erro 
    }
})


// FUNÇÃO CREATE
// [...]


// FUNÇÃO READ
// [...]


// FUNÇÃO UPDATE
// [...]


// FUNÇÃO DELETE
app.delete('/manutencoes/:id', async (req, res) => {
    try {
        await sql.connect(dbConfig); // esperar conectar ao banco
        const id = req.params.id; // ler parametro chave salvo no req da url
        await sql.query`delete from manutencoes where cd_manutencao = ${id}`; // esperar para executar script com where na variavel dinamica (id)
        res.json({ message: 'Manutenção deletada com sucesso!' });
    } catch (err) {
        res.status(500).send('Deu Ruim No SERVIDOR: ' + err.message);
    }
});

// Iniciar o servidor na poprta 3001, senão der nessa porta tem que mudar, mas vai ter que mudar em ManutencoesList.jsx tambem
app.listen(3001, () => { 
    console.log('API do CRUD de manutenções rodando na porta 3001');
});
// Iniciar o servidor