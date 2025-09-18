import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../domain/entities/servico.dart';
import '../../domain/repositories/servicos_repository.dart';
import '../models/servicos_table.dart';

class ServicosRepositoryImpl implements ServicosRepository {
  final AppDatabase _database;

  ServicosRepositoryImpl(this._database);

  @override
  Future<List<Servico>> buscarTodos() async {
    final query = _database.select(_database.servicosTable);
    final servicosData = await query.get();
    return servicosData.map((data) => _mapToEntity(data)).toList();
  }

  @override
  Future<List<Servico>> buscarAtivos() async {
    final query = _database.select(_database.servicosTable)
      ..where((tbl) => tbl.ativo.equals(true));
    final servicosData = await query.get();
    return servicosData.map((data) => _mapToEntity(data)).toList();
  }

  @override
  Future<Servico?> buscarPorId(int id) async {
    final query = _database.select(_database.servicosTable)
      ..where((tbl) => tbl.id.equals(id));
    final servicoData = await query.getSingleOrNull();
    return servicoData != null ? _mapToEntity(servicoData) : null;
  }

  @override
  Future<List<Servico>> buscarPorCategoria(String categoria) async {
    final query = _database.select(_database.servicosTable)
      ..where((tbl) => tbl.categoria.equals(categoria) & tbl.ativo.equals(true));
    final servicosData = await query.get();
    return servicosData.map(_mapToEntity).toList();
  }

  @override
  Future<int> criar(Servico servico) async {
    final companion = ServicosTableCompanion(
      nome: Value(servico.nome),
      descricao: Value(servico.descricao),
      valor: Value(servico.valor),
      categoria: Value(servico.categoria),
      duracaoMinutos: Value(servico.duracaoMinutos),
      ativo: Value(servico.ativo),
      updatedAt: Value(DateTime.now()),
    );
    return await _database.into(_database.servicosTable).insert(companion);
  }

  @override
  Future<void> atualizar(Servico servico) async {
    final companion = ServicosTableCompanion(
      id: Value(servico.id!),
      nome: Value(servico.nome),
      descricao: Value(servico.descricao),
      valor: Value(servico.valor),
      categoria: Value(servico.categoria),
      duracaoMinutos: Value(servico.duracaoMinutos),
      ativo: Value(servico.ativo),
      updatedAt: Value(DateTime.now()),
    );
    await (_database.update(_database.servicosTable)
          ..where((tbl) => tbl.id.equals(servico.id!)))
        .write(companion);
  }

  @override
  Future<void> excluir(int id) async {
    await (_database.delete(_database.servicosTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<void> ativarDesativar(int id, bool ativo) async {
    await (_database.update(_database.servicosTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(ServicosTableCompanion(
          ativo: Value(ativo),
          updatedAt: Value(DateTime.now()),
        ));
  }

  Servico _mapToEntity(ServicosTableData data) {
    return Servico(
      id: data.id,
      nome: data.nome,
      descricao: data.descricao,
      valor: data.valor,
      categoria: data.categoria,
      duracaoMinutos: data.duracaoMinutos,
      ativo: data.ativo,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}