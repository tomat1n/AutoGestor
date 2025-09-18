import 'package:drift/drift.dart';

@DataClassName('Venda')
class VendaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get dataVenda => dateTime().withDefault(currentDateAndTime)();
  RealColumn get subtotal => real()();
  RealColumn get desconto => real().withDefault(const Constant(0.0))();
  RealColumn get total => real()();
  TextColumn get formaPagamento => text().withLength(min: 1, max: 50)();
  TextColumn get observacoes => text().nullable()();
  DateTimeColumn get criadoEm => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get atualizadoEm => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'vendas';
}