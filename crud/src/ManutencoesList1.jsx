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

  useEffect(() => {
    fetch('http://localhost:3001/manutencoes')  //busco na url (o servidor tem que estar iniciado)
      .then(response => response.json()) // ele pega as resposta do servidor (aquele res.json(resultado.recordset)) os res é response, aqui não preciso especificar que o metodo é get mas nois outros precisa
      .then(data => setManutencoes(data)) // ele pega os ddos e set em manutencoes que foi declarado logo acima
      .catch(error => console.error('Erro ao buscar manutenções:', error));// aqui é se der erro apartir daqui dai ele da a mensahem
  }, []);

  const [isPopupAberto, setIsPopupAberto] = useState(false);
  const [dadosManutencao, setDadosManutencao] = useState(null);

  const lerManutencao = async (id) => {
    try {
        const response = await fetch(`http://localhost:3001/manutencoes/${id}`);// procura o id da linha da tabela na url de manutencoes
        console.log('Resposta bruta:', response);
        if (response.ok) { // se achar...
          const data = await response.json();
          console.log('Dados recebidos:', data);
          setDadosManutencao(data);     // guarda os dados
          setIsPopupAberto(true);       // abre o popup
    } else {
      const erro = await response.json();
      console.error('Erro do servidor:', erro);
      alert('Erro ao ler manutenção.');
    }
    } catch (err) {
        alert('Erro no servidor:' + err.message);
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
                  onClick={() => lerManutencao(m.cd_manutencao)} 
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
)},
      
    </div>

    
  );
}