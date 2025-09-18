import '../../../clientes/domain/entities/cliente.dart';

abstract class ClientesRepository {
  Future<List<Cliente>> obterTodos();
  Future<Cliente?> obterPorId(int id);
  Future<List<Cliente>> buscarPorNome(String nome);
}