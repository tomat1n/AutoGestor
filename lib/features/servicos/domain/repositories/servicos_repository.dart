import '../entities/servico.dart';

abstract class ServicosRepository {
  Future<List<Servico>> buscarTodos();
  Future<List<Servico>> buscarAtivos();
  Future<Servico?> buscarPorId(int id);
  Future<List<Servico>> buscarPorCategoria(String categoria);
  Future<int> criar(Servico servico);
  Future<void> atualizar(Servico servico);
  Future<void> excluir(int id);
  Future<void> ativarDesativar(int id, bool ativo);
}