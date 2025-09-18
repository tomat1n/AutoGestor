import 'package:drift/drift.dart';

enum StatusOrcamento {
  rascunho,
  pendente,
  aprovado,
  rejeitado,
  expirado
}

@DataClassName('OrcamentoData')
class OrcamentoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get numero => text().withLength(min: 1, max: 50)();
  IntColumn get clienteId => integer().nullable()();
  TextColumn get descricao => text().nullable()();
  RealColumn get valorTotal => real()();
  RealColumn get desconto => real().withDefault(const Constant(0.0))();
  RealColumn get valorFinal => real()();
  TextColumn get status => textEnum<StatusOrcamento>().withDefault(const Constant('rascunho'))();
  DateTimeColumn get dataVencimento => dateTime().nullable()();
  TextColumn get observacoes => text().nullable()();
  TextColumn get fotosDefeitoUrls => text().nullable()();
  TextColumn get fotosReposicaoUrls => text().nullable()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('ItemOrcamentoData')
class ItemOrcamentoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orcamentoId => integer().references(OrcamentoTable, #id)();
  IntColumn get produtoId => integer().nullable()();
  IntColumn get servicoId => integer().nullable()();
  TextColumn get descricao => text()();
  IntColumn get quantidade => integer()();
  RealColumn get valorUnitario => real()();
  RealColumn get valorTotal => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}