import 'package:drift/drift.dart';

class OrdensServicoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get numero => text().withLength(min: 1, max: 20).unique()();
  IntColumn get clienteId => integer()();
  TextColumn get nomeCliente => text().withLength(min: 1, max: 255)();
  TextColumn get emailCliente => text().nullable()();
  TextColumn get telefoneCliente => text().nullable()();
  RealColumn get subtotal => real()();
  RealColumn get desconto => real().withDefault(const Constant(0.0))();
  RealColumn get total => real()();
  TextColumn get status => text().withLength(min: 1, max: 50)();
  TextColumn get prioridade => text().withLength(min: 1, max: 20)();
  DateTimeColumn get dataAgendamento => dateTime()();
  DateTimeColumn get dataPrevista => dateTime().nullable()();
  DateTimeColumn get dataInicio => dateTime().nullable()();
  DateTimeColumn get dataConclusao => dateTime().nullable()();
  TextColumn get observacoes => text().nullable()();
  TextColumn get observacoesInternas => text().nullable()();
  TextColumn get tecnicoResponsavel => text().nullable()();
  TextColumn get equipamento => text().nullable()();
  TextColumn get problemaRelatado => text().nullable()();
  TextColumn get solucaoAplicada => text().nullable()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'ordens_servico';
}

class ItensOrdemServicoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordemServicoId => integer()();
  IntColumn get servicoId => integer().nullable()();
  TextColumn get nomeServico => text().withLength(min: 1, max: 255)();
  TextColumn get descricaoServico => text().nullable()();
  IntColumn get quantidade => integer()();
  RealColumn get valorUnitario => real()();
  RealColumn get subtotal => real()();
  IntColumn get duracaoMinutos => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'itens_ordem_servico';
}