import '../entities/fornecedor.dart';

abstract class FornecedorRepository {
  Future<List<Fornecedor>> buscarTodos();
  Future<List<Fornecedor>> buscarAtivos();
  Future<Fornecedor?> buscarPorId(int id);
  Future<List<Fornecedor>> buscarPorNome(String nome);
  Future<Fornecedor?> buscarPorCnpj(String cnpj);
  Future<Fornecedor?> buscarPorCpf(String cpf);
  Future<int> criar(Fornecedor fornecedor);
  Future<bool> atualizar(Fornecedor fornecedor);
  Future<bool> excluir(int id);
  Future<bool> ativarDesativar(int id, bool ativo);
}