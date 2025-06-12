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



  return (
    <div id='crud'>
      <h2 id='titulo'>Lista de Manutenções</h2>
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
              <td>{m.cd_manutencao}</td>
              <td>{m.placa}</td>
              <td>{m.cd_funcionario}</td>
              <td>{m.cd_tipo}</td>
              <td>{m.cd_alas}</td>
              <td>{m.vl_manutencao}</td>
              <td>{m.cd_status_manutencoes}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

