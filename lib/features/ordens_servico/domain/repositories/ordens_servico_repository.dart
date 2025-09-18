import '../entities/ordem_servico.dart';

abstract class OrdensServicoRepository {
  Future<List<OrdemServico>> buscarTodas();
  Future<List<OrdemServico>> buscarAtivas();
  Future<OrdemServico?> buscarPorId(int id);
  Future<OrdemServico?> buscarPorNumero(String numero);
  Future<List<OrdemServico>> buscarPorCliente(int clienteId);
  Future<List<OrdemServico>> buscarPorStatus(StatusOrdemServico status);
  Future<List<OrdemServico>> buscarPorPrioridade(PrioridadeOrdemServico prioridade);
  Future<List<OrdemServico>> buscarPorTecnico(String tecnico);
  Future<List<OrdemServico>> buscarPorPeriodo(DateTime inicio, DateTime fim);
  Future<List<OrdemServico>> buscarAgendadasPara(DateTime data);
  Future<List<OrdemServico>> buscarAtrasadas();
  Future<List<OrdemServico>> buscarEmAndamento();
  Future<int> criar(OrdemServico ordemServico);
  Future<void> atualizar(OrdemServico ordemServico);
  Future<void> excluir(int id);
  Future<void> alterarStatus(int id, StatusOrdemServico status);
  Future<void> iniciarExecucao(int id, DateTime dataInicio);
  Future<void> pausarExecucao(int id);
  Future<void> concluirExecucao(int id, DateTime dataConclusao, String? solucaoAplicada);
  Future<void> cancelar(int id);
  Future<void> reagendar(int id, DateTime novaData);
  Future<void> ativarDesativar(int id, bool ativo);
  Future<String> gerarProximoNumero();
}