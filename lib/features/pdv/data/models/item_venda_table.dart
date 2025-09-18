import 'package:drift/drift.dart';
import 'venda_table.dart';
import '../../../estoque/data/models/produto_table.dart';

@DataClassName('ItemVenda')
class ItemVendaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vendaId => integer().references(VendaTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get produtoId => integer().references(ProdutoTable, #id)();
  IntColumn get quantidade => integer()();
  RealColumn get precoUnitario => real()();
  RealColumn get subtotal => real()();
  DateTimeColumn get criadoEm => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'itens_venda';
}