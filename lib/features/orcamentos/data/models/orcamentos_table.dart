import 'package:drift/drift.dart';

class OrcamentosTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get numero => integer().unique()();
  IntColumn get clienteId => integer()();
  TextColumn get nomeCliente => text().withLength(min: 1, max: 255)();
  TextColumn get emailCliente => text().nullable()();
  TextColumn get telefoneCliente => text().nullable()();
  RealColumn get subtotal => real()();
  RealColumn get desconto => real().withDefault(const Constant(0.0))();
  RealColumn get total => real()();
  TextColumn get status => text().withLength(min: 1, max: 50)();
  IntColumn get validadeDias => integer().withDefault(const Constant(30))();
  DateTimeColumn get dataVencimento => dateTime()();
  DateTimeColumn get dataAprovacao => dateTime().nullable()();
  TextColumn get observacoes => text().nullable()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'orcamentos';
}

class ItensOrcamentoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orcamentoId => integer()();
  IntColumn get servicoId => integer().nullable()();
  TextColumn get nomeServico => text().withLength(min: 1, max: 255)();
  TextColumn get descricaoServico => text().nullable()();
  IntColumn get quantidade => integer()();
  RealColumn get valorUnitario => real()();
  RealColumn get subtotal => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'itens_orcamento';
}