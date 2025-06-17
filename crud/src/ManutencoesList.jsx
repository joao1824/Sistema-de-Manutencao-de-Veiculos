import React, { useEffect, useState } from 'react';
import './ManutencoesList.css'

export default function ManutencoesList() {
  const [manutencoes, setManutencoes] = useState([]);

  useEffect(() => {
    fetch('http://localhost:3001/manutencoes')  //busco na url (o servidor tem que estar iniciado)
      .then(response => response.json()) // ele pega as resposta do servidor (aquele res.json(resultado.recordset)) os res é response, aqui não preciso especificar que o metodo é get mas nois outros precisa
      .then(data => setManutencoes(data)) // ele pega os ddos e set em manutencoes que foi declarado logo acima
      .catch(error => console.error('Erro ao buscar manutenções:', error));// aqui é se der erro apartir daqui dai ele da a mensahem
  }, []);

  const [readManutencao, setReadManutencao] = useState(false);
  
  const lerManutencao = async (id) => {
    try {
        const response = await fetch(`http://localhost:3001/manutencoes/${id}`, { method: 'SELECT' });// procura o id da linha da tabela na url de manutencoes
        if (response.ok) { // se achar...
          setReadManutencao(true)
        } else {
          alert('Erro ao ler manutenção.');
      } 
    } catch (err) {
        alert('Erro no servidor.');
        console.log(err); // debug
      }
  }
  
  const deletarManutencao = async (id) => {
    if (window.confirm('Tem certeza que deseja deletar esta manutenção?')) {
      try {
        const response = await fetch(`http://localhost:3001/manutencoes/${id}`, { method: 'DELETE' });// procura o id da linha da tabela na url de manutencoes
        if (response.ok) { // se achar...
          setManutencoes(manutencoes.filter(m => m.cd_manutencao !== id)); // filtra a manutencao deletada para fora do array de manutencoes
          alert(`Manutenção n° ${id} deletada com sucesso!`);
        } else {
          alert('Erro ao deletar manutenção.');
        }
      } catch (err) {
        alert('Erro no servidor.');
        console.log(err); // debug
      }
    }
  };

  return (
    <div id='crud'>
      
      <div id='cabecalho'>
        <h2>Lista de Manutenções</h2>
        <span onClick={() => alert('Função create (a adicionar)')} id='btnAdicionar'><b>+</b></span> {/* ADICIONAR FUNCAO CREATE*/}
      </div>
      
      <table>
        <thead>
          <tr>
            <th>Código</th>
            <th>Placa</th>
            <th>Funcionário</th>
            <th>Tipo</th>
            <th>Ala</th>
            <th>Valor</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
           {manutencoes.map(m => (  // aqui só represento por meio de um .map padrão
            <tr key={m.cd_manutencao}>
              <td><b>{m.cd_manutencao}</b></td>
              <td>{m.placa}</td>
              <td>{m.cd_funcionario}</td>
              <td>{m.cd_tipo}</td>
              <td>{m.cd_alas}</td>
              <td>{m.vl_manutencao}</td>
              <td>{m.cd_status_manutencoes}</td>

              <td>
                <img
                  src='https://img.icons8.com/?size=100&id=60022&format=png&color=5a6f9c'
                  onClick={() => setReadManutencao(true)} 
                />
              </td>

              <td>
                <img
                  src='https://img.icons8.com/?size=100&id=59856&format=png&color=5a6f9c'
                  onClick={() => alert('Função update (a adicionar)')} /* ADICIONAR FUNCAO UPDATE*/
                />
              </td>

              <td>
                <img
                    src='https://img.icons8.com/?size=100&id=68064&format=png&color=5a6f9c'
                    onClick={() => deletarManutencao(m.cd_manutencao)}
                  />
              </td>

            </tr>
          ))}
        </tbody>
      </table>

      {readManutencao && (
        <div className='testePopup'>
          <h3>Detalhes da Manutenção</h3>
          <p><b>Código:</b> {readManutencao.cd_manutencao}</p>
          <p><b>Placa:</b> {readManutencao.placa}</p>
          <p><b>Funcionário:</b> {readManutencao.cd_funcionario}</p>
          <p><b>Tipo:</b> {readManutencao.cd_tipo}</p>
          <p><b>Ala:</b> {readManutencao.cd_alas}</p>
          <p><b>Valor:</b> {readManutencao.vl_manutencao}</p>
          <p><b>Status:</b> {readManutencao.cd_status_manutencoes}</p>
          <button onClick={() => setReadManutencao(false)}>Fechar</button>
        </div>
        )
      }
      
    </div>
  );
}

