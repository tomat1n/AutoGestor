import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../domain/entities/cliente.dart';
import '../../domain/repositories/cliente_repository.dart';

class ClienteRepositoryImpl implements ClienteRepository {
  final AppDatabase _database;

  ClienteRepositoryImpl(this._database);

  @override
  Future<List<Cliente>> getAllClientes() async {
    final clientes = await _database.select(_database.clienteTable).get();
    return clientes.map(_mapToEntity).toList();
  }

  @override
  Future<Cliente?> getClienteById(int id) async {
    final cliente = await (_database.select(_database.clienteTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return cliente != null ? _mapToEntity(cliente) : null;
  }

  @override
  Future<Cliente> createCliente(Cliente cliente) async {
    final companion = ClienteTableCompanion(
      nome: Value(cliente.nome),
      email: Value(cliente.email),
      telefone: Value(cliente.telefone),
      cpfCnpj: Value(cliente.cpfCnpj),
      endereco: Value(cliente.endereco),
      cidade: Value(cliente.cidade),
      estado: Value(cliente.estado),
      cep: Value(cliente.cep),
      observacoes: Value(cliente.observacoes),
      ativo: Value(cliente.ativo),
    );

    final id = await _database.into(_database.clienteTable).insert(companion);
    return cliente.copyWith(id: id);
  }

  @override
  Future<Cliente> updateCliente(Cliente cliente) async {
    final companion = ClienteTableCompanion(
      id: Value(cliente.id!),
      nome: Value(cliente.nome),
      email: Value(cliente.email),
      telefone: Value(cliente.telefone),
      cpfCnpj: Value(cliente.cpfCnpj),
      endereco: Value(cliente.endereco),
      cidade: Value(cliente.cidade),
      estado: Value(cliente.estado),
      cep: Value(cliente.cep),
      observacoes: Value(cliente.observacoes),
      ativo: Value(cliente.ativo),
      updatedAt: Value(DateTime.now()),
    );

    await _database.update(_database.clienteTable).replace(companion);
    return cliente;
  }

  @override
  Future<void> deleteCliente(int id) async {
    await (_database.delete(_database.clienteTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<List<Cliente>> searchClientes(String query) async {
    final clientes = await (_database.select(_database.clienteTable)
          ..where((tbl) => tbl.nome.contains(query) |
              tbl.email.contains(query) |
              tbl.telefone.contains(query) |
              tbl.cpfCnpj.contains(query)))
        .get();
    return clientes.map(_mapToEntity).toList();
  }

  @override
  Future<int> getTotalClientes() async {
    final count = await _database.clienteTable.count().getSingle();
    return count;
  }

  @override
  Future<List<Cliente>> getClientesAtivos() async {
    final clientes = await (_database.select(_database.clienteTable)
          ..where((tbl) => tbl.ativo.equals(true)))
        .get();
    return clientes.map(_mapToEntity).toList();
  }

  Cliente _mapToEntity(ClienteTableData data) {
    return Cliente(
      id: data.id,
      nome: data.nome,
      email: data.email,
      telefone: data.telefone,
      cpfCnpj: data.cpfCnpj,
      endereco: data.endereco,
      cidade: data.cidade,
      estado: data.estado,
      cep: data.cep,
      observacoes: data.observacoes,
      ativo: data.ativo,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}