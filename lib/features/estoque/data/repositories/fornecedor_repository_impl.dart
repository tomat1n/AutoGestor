import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../domain/entities/fornecedor.dart';
import '../../domain/repositories/fornecedor_repository.dart';

class FornecedorRepositoryImpl implements FornecedorRepository {
  final AppDatabase _database;

  FornecedorRepositoryImpl(this._database);

  @override
  Future<List<Fornecedor>> buscarTodos() async {
    final query = _database.select(_database.fornecedorTable);
    final results = await query.get();
    
    return results.map((data) => _mapToEntity(data)).toList();
  }

  @override
  Future<List<Fornecedor>> buscarAtivos() async {
    final query = _database.select(_database.fornecedorTable)
      ..where((tbl) => tbl.ativo.equals(true));
    final results = await query.get();
    
    return results.map((data) => _mapToEntity(data)).toList();
  }

  @override
  Future<Fornecedor?> buscarPorId(int id) async {
    final query = _database.select(_database.fornecedorTable)
      ..where((tbl) => tbl.id.equals(id));
    final result = await query.getSingleOrNull();
    
    return result != null ? _mapToEntity(result) : null;
  }

  @override
  Future<List<Fornecedor>> buscarPorNome(String nome) async {
    final query = _database.select(_database.fornecedorTable)
      ..where((tbl) => tbl.nome.like('%$nome%'));
    final results = await query.get();
    
    return results.map((data) => _mapToEntity(data)).toList();
  }

  @override
  Future<Fornecedor?> buscarPorCnpj(String cnpj) async {
    final query = _database.select(_database.fornecedorTable)
      ..where((tbl) => tbl.cnpj.equals(cnpj));
    final result = await query.getSingleOrNull();
    
    return result != null ? _mapToEntity(result) : null;
  }

  @override
  Future<Fornecedor?> buscarPorCpf(String cpf) async {
    final query = _database.select(_database.fornecedorTable)
      ..where((tbl) => tbl.cpf.equals(cpf));
    final result = await query.getSingleOrNull();
    
    return result != null ? _mapToEntity(result) : null;
  }

  @override
  Future<int> criar(Fornecedor fornecedor) async {
    final companion = FornecedorTableCompanion(
      nome: Value(fornecedor.nome),
      razaoSocial: Value(fornecedor.razaoSocial),
      cnpj: Value(fornecedor.cnpj),
      cpf: Value(fornecedor.cpf),
      email: Value(fornecedor.email),
      telefone: Value(fornecedor.telefone),
      endereco: Value(fornecedor.endereco),
      cidade: Value(fornecedor.cidade),
      estado: Value(fornecedor.estado),
      cep: Value(fornecedor.cep),
      ativo: Value(fornecedor.ativo),
    );
    
    return await _database.into(_database.fornecedorTable).insert(companion);
  }

  @override
  Future<bool> atualizar(Fornecedor fornecedor) async {
    final companion = FornecedorTableCompanion(
      id: Value(fornecedor.id!),
      nome: Value(fornecedor.nome),
      razaoSocial: Value(fornecedor.razaoSocial),
      cnpj: Value(fornecedor.cnpj),
      cpf: Value(fornecedor.cpf),
      email: Value(fornecedor.email),
      telefone: Value(fornecedor.telefone),
      endereco: Value(fornecedor.endereco),
      cidade: Value(fornecedor.cidade),
      estado: Value(fornecedor.estado),
      cep: Value(fornecedor.cep),
      ativo: Value(fornecedor.ativo),
      atualizadoEm: Value(DateTime.now()),
    );
    
    final result = await _database.update(_database.fornecedorTable).replace(companion);
    return result;
  }

  @override
  Future<bool> excluir(int id) async {
    final result = await (_database.delete(_database.fornecedorTable)
      ..where((tbl) => tbl.id.equals(id))).go();
    return result > 0;
  }

  @override
  Future<bool> ativarDesativar(int id, bool ativo) async {
    final result = await (_database.update(_database.fornecedorTable)
      ..where((tbl) => tbl.id.equals(id)))
      .write(FornecedorTableCompanion(
        ativo: Value(ativo),
        atualizadoEm: Value(DateTime.now()),
      ));
    return result > 0;
  }

  Fornecedor _mapToEntity(FornecedorData data) {
    return Fornecedor(
      id: data.id,
      nome: data.nome,
      razaoSocial: data.razaoSocial,
      cnpj: data.cnpj,
      cpf: data.cpf,
      email: data.email,
      telefone: data.telefone,
      endereco: data.endereco,
      cidade: data.cidade,
      estado: data.estado,
      cep: data.cep,
      ativo: data.ativo,
      criadoEm: data.criadoEm,
      atualizadoEm: data.atualizadoEm,
    );
  }
}