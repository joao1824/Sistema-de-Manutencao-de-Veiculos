const express = require('express');
const sql = require('mssql');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const dbConfig = {
  user: 'admin_user',
  password: 'satc123!',
  server: 'crud-server-satc-teste4.database.windows.net',
  database: 'sistema_manutencao_veiculos',
  options: {
    encrypt: true,
    trustServerCertificate: true
  }
};

// LISTAR TODAS
app.get('/manutencoes', async (req, res) => {
  try {
    await sql.connect(dbConfig);
    const resultado = await sql.query('SELECT * FROM manutencoes');
    res.json(resultado.recordset);
  } catch (err) {
    res.status(500).send('Erro ao buscar manutenções: ' + err.message);
  }
});

// ADICIONAR
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

// BUSCAR POR ID
app.get('/manutencoes/:id', async (req, res) => {
  try {
    await sql.connect(dbConfig);
    const id = req.params.id;
    const resultado = await sql.query`SELECT * FROM manutencoes WHERE cd_manutencao = ${id}`;

    if (resultado.recordset.length === 0) {
      return res.status(404).json({ message: 'Manutenção não encontrada.' });
    }

    res.json(resultado.recordset[0]);
  } catch (err) {
    res.status(500).send('Erro ao buscar manutenção: ' + err.message);
  }
});

// FUNÇÃO UPDATE
app.put('/manutencoes/:id', async (req, res) => {
  try {
    await sql.connect(dbConfig);
    const id = req.params.id;
    const {
      placa,
      cd_funcionario,
      cd_tipo,
      cd_alas,
      vl_manutencao,
      cd_status_manutencoes
    } = req.body;

    const query = `
      UPDATE manutencoes
      SET 
        placa = @placa,
        cd_funcionario = @cd_funcionario,
        cd_tipo = @cd_tipo,
        cd_alas = @cd_alas,
        vl_manutencao = @vl_manutencao,
        cd_status_manutencoes = @cd_status_manutencoes
      WHERE cd_manutencao = @id
    `;

    const request = new sql.Request();
    request.input('id', sql.Int, id);
    request.input('placa', sql.VarChar, placa);
    request.input('cd_funcionario', sql.Int, cd_funcionario);
    request.input('cd_tipo', sql.Int, cd_tipo);
    request.input('cd_alas', sql.Int, cd_alas);
    request.input('vl_manutencao', sql.Decimal(10, 2), vl_manutencao);
    request.input('cd_status_manutencoes', sql.Int, cd_status_manutencoes);

    await request.query(query);

    res.json({ message: 'Manutenção atualizada com sucesso!' });
  } catch (err) {
    res.status(500).send('Erro ao atualizar manutenção: ' + err.message);
  }
});

// DELETAR
app.delete('/manutencoes/:id', async (req, res) => {
  try {
    await sql.connect(dbConfig);
    const id = req.params.id;
    await sql.query`DELETE FROM manutencoes WHERE cd_manutencao = ${id}`;
    res.json({ message: 'Manutenção deletada com sucesso!' });
  } catch (err) {
    res.status(500).send('Erro ao deletar manutenção: ' + err.message);
  }
});

// Iniciar servidor
app.listen(3001, () => {
  console.log('API do CRUD de manutenções rodando na porta 3001');
});