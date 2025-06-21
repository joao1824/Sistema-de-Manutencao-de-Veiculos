import React, { useEffect, useState } from 'react';
import './ManutencoesList.css'

export default function ManutencoesList() {
  const [manutencoes, setManutencoes] = useState([]);
  const [readManutencao, setReadManutencao] = useState(false);
  const [mostrarFormulario, setMostrarFormulario] = useState(false);
  const [novaManutencao, setNovaManutencao] = useState({
    placa: '',
    cd_funcionario: '',
    cd_tipo: '',
    cd_alas: '',
    vl_manutencao: '',
    cd_status_manutencoes: ''
  });

  useEffect(() => {
    fetch('http://localhost:3001/manutencoes')
      .then(response => response.json())
      .then(data => setManutencoes(data))
      .catch(error => console.error('Erro ao buscar manutenções:', error));
  }, []);

  const lerManutencao = async (id) => {
    try {
        const response = await fetch(`http://localhost:3001/manutencoes/${id}`, { method: 'SELECT' });
        if (response.ok) {
          setReadManutencao(true)
        } else {
          alert('Erro ao ler manutenção.');
      } 
    } catch (err) {
        alert('Erro no servidor.');
        console.log(err);
      }
  }

  const deletarManutencao = async (id) => {
    if (window.confirm('Tem certeza que deseja deletar esta manutenção?')) {
      try {
        const response = await fetch(`http://localhost:3001/manutencoes/${id}`, { method: 'DELETE' });
        if (response.ok) {
          setManutencoes(manutencoes.filter(m => m.cd_manutencao !== id));
          alert(`Manutenção n° ${id} deletada com sucesso!`);
        } else {
          alert('Erro ao deletar manutenção.');
        }
      } catch (err) {
        alert('Erro no servidor.');
        console.log(err);
      }
    }
  };

  return (
    <div id='crud'>
      <div id='cabecalho'>
        <h2>Lista de Manutenções</h2>
        <span onClick={() => setMostrarFormulario(!mostrarFormulario)} id='btnAdicionar'><b>+</b></span>
      </div>

      {mostrarFormulario && (
        <form
          onSubmit={async (e) => {
            e.preventDefault();
            try {
              const response = await fetch('http://localhost:3001/manutencoes', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(novaManutencao),
              });
              if (response.ok) {
                alert('Manutenção criada com sucesso!');
                setNovaManutencao({
                  placa: '',
                  cd_funcionario: '',
                  cd_tipo: '',
                  cd_alas: '',
                  vl_manutencao: '',
                  cd_status_manutencoes: ''
                });
                setMostrarFormulario(false);
                const listaAtualizada = await fetch('http://localhost:3001/manutencoes');
                const data = await listaAtualizada.json();
                setManutencoes(data);
              } else {
                alert('Erro ao criar manutenção');
              }
            } catch (err) {
              alert('Erro no servidor');
              console.error(err);
            }
          }}
          style={{ marginTop: '20px', background: '#f9f9f9', padding: '10px', borderRadius: '5px' }}
        >
          {Object.entries(novaManutencao).map(([campo, valor]) => (
            <input
              key={campo}
              placeholder={campo}
              value={valor}
              onChange={(e) => setNovaManutencao({ ...novaManutencao, [campo]: e.target.value })}
              required
              style={{ margin: '5px' }}
            />
          ))}
          <button type="submit">Salvar</button>
        </form>
      )}

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
           {manutencoes.map(m => (
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
                  onClick={() => alert('Função update (a adicionar)')}
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
      )}
    </div>
  );
}

