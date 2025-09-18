import 'package:drift/drift.dart';
import 'pedido_compra_table.dart';
import 'produto_table.dart';

@DataClassName('ItemCompraData')
class ItemCompraTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pedidoCompraId => integer().references(PedidoCompraTable, #id)();
  IntColumn get produtoId => integer().references(ProdutoTable, #id)();
  IntColumn get quantidade => integer()();
  RealColumn get precoUnitario => real()();
  RealColumn get precoTotal => real()();
  TextColumn get observacoes => text().nullable()();
  DateTimeColumn get criadoEm => dateTime().withDefault(currentDateAndTime)();
}