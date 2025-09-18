import '../entities/orcamento.dart';
import '../repositories/orcamentos_repository.dart';

class OrcamentosService {
  final OrcamentosRepository _repository;

  OrcamentosService(this._repository);
  Future<List<Orcamento>> listarOrcamentos() async {
    return await _repository.buscarTodos();
  }

  Future<int> criarOrcamento(Orcamento orcamento) async {
    return await _repository.criar(orcamento);
  }

  Future<Orcamento> atualizarOrcamento(Orcamento orcamento) async {
    await _repository.atualizar(orcamento);
    return orcamento;
  }

  Future<Orcamento?> buscarOrcamentoPorId(int id) async {
    return await _repository.buscarPorId(id);
  }

  Future<void> excluirOrcamento(int id) async {
    await _repository.excluir(id);
  }

  Future<void> aprovar(int id, DateTime dataAprovacao) async {
    await _repository.aprovar(id, dataAprovacao);
  }

  Future<String> gerarProximoNumero() async {
    return await _repository.gerarProximoNumero();
  }
}