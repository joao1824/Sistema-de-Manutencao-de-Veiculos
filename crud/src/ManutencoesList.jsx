import React, { useEffect, useState } from 'react';
import './ManutencoesList.css'

export default function ManutencoesList() {
  const [mostrarFormulario, setMostrarFormulario] = useState(false);
  const [novaManutencao, setNovaManutencao] = useState({
    placa: '',
    cd_funcionario: '',
    cd_tipo: '',
    cd_alas: '',
    vl_manutencao: '',
    cd_status_manutencoes: ''
  });
  const [manutencoes, setManutencoes] = useState([]);
  const [manutencaoEdicao, setManutencaoEdicao] = useState(null); // Adicionado para o UPDATE

  useEffect(() => {
    fetch('http://localhost:3001/manutencoes')
      .then(response => response.json())
      .then(data => setManutencoes(data))
      .catch(error => console.error('Erro ao buscar manutenções:', error));
  }, []);

  const [isPopupAberto, setIsPopupAberto] = useState(false);
  const [dadosManutencao, setDadosManutencao] = useState(null);

  // Função de UPDATE transferida do original
  const editarManutencao = (manutencao) => {
    setManutencaoEdicao(manutencao);
  };

  const lerManutencao = async (id) => {
    try {
        const response = await fetch(`http://localhost:3001/manutencoes/${id}`);
        console.log('Resposta bruta:', response);
        if (response.ok) {
          const data = await response.json();
          console.log('Dados recebidos:', data);
          setDadosManutencao(data);
          setIsPopupAberto(true);
    } else {
      const erro = await response.json();
      console.error('Erro do servidor:', erro);
      alert('Erro ao ler manutenção.');
    }
    } catch (err) {
        alert('Erro no servidor:' + err.message);
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

  console.log('Conteúdo da manutenção:', dadosManutencao);


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

      {/* Formulário de UPDATE transferido do original */}
      {manutencaoEdicao && (
        <form
          onSubmit={async (e) => {
            e.preventDefault();
            try {
              const manutencaoAtualizada = {
                ...manutencaoEdicao,
                vl_manutencao: parseFloat(manutencaoEdicao.vl_manutencao),
                cd_funcionario: parseInt(manutencaoEdicao.cd_funcionario),
                cd_tipo: parseInt(manutencaoEdicao.cd_tipo),
                cd_alas: parseInt(manutencaoEdicao.cd_alas),
                cd_status_manutencoes: parseInt(manutencaoEdicao.cd_status_manutencoes),
              };

              const response = await fetch(`http://localhost:3001/manutencoes/${manutencaoAtualizada.cd_manutencao}`, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(manutencaoAtualizada),
              });

              if (response.ok) {
                alert('Manutenção atualizada com sucesso!');
                setManutencaoEdicao(null);
                const listaAtualizada = await fetch('http://localhost:3001/manutencoes');
                const data = await listaAtualizada.json();
                setManutencoes(data);
              } else {
                const erro = await response.text();
                console.error('Erro no update:', erro);
                alert('Erro ao atualizar manutenção');
              }
            } catch (err) {
              alert('Erro no servidor');
              console.error(err);
            }
          }}
          style={{ marginTop: '20px', background: '#f1f1f1', padding: '10px', borderRadius: '5px' }}
        >
          {Object.entries(manutencaoEdicao).map(([campo, valor]) =>
            campo !== 'cd_manutencao' && (
              <input
                key={campo}
                placeholder={campo}
                value={valor}
                onChange={(e) =>
                  setManutencaoEdicao({ ...manutencaoEdicao, [campo]: e.target.value })
                }
                required
                style={{ margin: '5px' }}
              />
            )
          )}
          <button type="submit">Salvar Alterações</button>
          <button type="button" onClick={() => setManutencaoEdicao(null)}>Cancelar</button>
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
                  onClick={() => lerManutencao(m.cd_manutencao)} 
                />
              </td>

              <td>
                <img
                  src='https://img.icons8.com/?size=100&id=59856&format=png&color=5a6f9c'
                  onClick={() => editarManutencao(m)} // Atualizado para chamar a função correta
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

      {isPopupAberto && dadosManutencao && (
        <div className='popupOverlay'>
          <div className='popupBody'>
            <h3>Detalhes da Manutenção</h3>
            <p><b>Código:</b> {dadosManutencao.cd_manutencao}</p>
            <p><b>Placa:</b> {dadosManutencao.placa}</p>
            <p><b>Funcionário:</b> {dadosManutencao.cd_funcionario}</p>
            <p><b>Tipo:</b> {dadosManutencao.cd_tipo}</p>
            <p><b>Ala:</b> {dadosManutencao.cd_alas}</p>
            <p><b>Valor:</b> {dadosManutencao.vl_manutencao}</p>
            <p><b>Status:</b> {dadosManutencao.cd_status_manutencoes}</p>
            <button onClick={() => setIsPopupAberto(false)}>Fechar</button>
          </div>
        </div>
      )}
    </div>
  );
}