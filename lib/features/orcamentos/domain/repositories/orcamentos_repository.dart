import '../entities/orcamento.dart';

abstract class OrcamentosRepository {
  Future<List<Orcamento>> buscarTodos();
  Future<List<Orcamento>> buscarAtivos();
  Future<Orcamento?> buscarPorId(int id);
  Future<Orcamento?> buscarPorNumero(String numero);
  Future<List<Orcamento>> buscarPorCliente(int clienteId);
  Future<List<Orcamento>> buscarPorStatus(StatusOrcamento status);
  Future<List<Orcamento>> buscarPorPeriodo(DateTime inicio, DateTime fim);
  Future<List<Orcamento>> buscarVencendoEm(int dias);
  Future<int> criar(Orcamento orcamento);
  Future<void> atualizar(Orcamento orcamento);
  Future<void> excluir(int id);
  Future<void> alterarStatus(int id, StatusOrcamento status);
  Future<void> aprovar(int id, DateTime dataAprovacao);
  Future<void> rejeitar(int id);
  Future<void> ativarDesativar(int id, bool ativo);
  Future<String> gerarProximoNumero();
}