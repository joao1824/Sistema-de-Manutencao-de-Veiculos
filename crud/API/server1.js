const express = require('express'); // permiti criar as rotas http
const sql = require('mssql'); // comunica com o banco sql server
const cors = require('cors'); // acessar o back end em outro endereço

const app = express(); // coloco o express com função em app para eu poder usalo 
app.use(cors()); //para coneguir requisição de outro dominio
app.use(express.json()); //para conseguir ler em JSON


// configurar conexão com SQL Server (local ou Azure)
const dbConfig = {    // atenção aqui tem que ser igualzinho as config do servidor se não não funfa
  user: 'admin_user',  // essas config fui eu que usei, se quiser pofe replicar dai não precisar alterar aqui (eu usei o azure mas pode ser usado o local só que ainda não tentei)
  password: 'P@ssw0rd',
  server: 'termina.database.windows.net',
  database: 'sistema_manutencao_veiculos',
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
app.post('/manutencoes', async (req, res) => {
  try {
    await sql.connect(dbConfig);
    const {
      placa,
      cd_funcionario,
      cd_tipo,
      cd_alas,
      vl_manutencao,
      cd_status_manutencoes
    } = req.body;

    const query = `
      INSERT INTO manutencoes 
        (placa, cd_funcionario, cd_tipo, cd_alas, vl_manutencao, cd_status_manutencoes)
      VALUES 
        (@placa, @cd_funcionario, @cd_tipo, @cd_alas, @vl_manutencao, @cd_status_manutencoes)
    `;

    const request = new sql.Request();
    request.input('placa', sql.VarChar, placa);
    request.input('cd_funcionario', sql.Int, cd_funcionario);
    request.input('cd_tipo', sql.Int, cd_tipo);
    request.input('cd_alas', sql.Int, cd_alas);
    request.input('vl_manutencao', sql.Decimal(10, 2), vl_manutencao);
    request.input('cd_status_manutencoes', sql.Int, cd_status_manutencoes);

    await request.query(query);

    res.status(201).json({ message: 'Manutenção adicionada com sucesso!' });
  } catch (err) {
    res.status(500).send('Erro ao adicionar manutenção: ' + err.message);
  }
});

// FUNÇÃO READ
app.get('/manutencoes/:id', async (req, res) => {
  const id = req.params.id; // ler parametro chave salvo no req da url  
  try {
        await sql.connect(dbConfig); // esperar conectar ao banco
        
        const resultado = await db.query('SELECT * FROM manutencoes WHERE cd_manutencao = ?', [id]); // esperar para executar script com where na variavel dinamica (id)
        if (resultado.length === 0) {
          return res.status(404).json({ message: 'Manutenção não encontrada.' });
        }
    
        return res.json(resultado[0]); // 👈 aqui você devolve os dados reais da manutenção
    } catch (error) {
      console.error(error);
      return res.status(500).json({ message: 'Erro ao buscar manutenção.' });
    }
});


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
