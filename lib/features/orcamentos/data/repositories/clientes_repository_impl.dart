import 'package:autogestor/features/clientes/domain/entities/cliente.dart';
import 'package:autogestor/features/orcamentos/domain/repositories/clientes_repository.dart';

class ClientesRepositoryImpl implements ClientesRepository {
  @override
  Future<List<Cliente>> obterTodos() async {
    // Implementação temporária
    return [];
  }

  @override
  Future<Cliente?> obterPorId(int id) async {
    // Implementação temporária
    return null;
  }

  @override
  Future<List<Cliente>> buscarPorNome(String nome) async {
    // Implementação temporária
    return [];
  }
}