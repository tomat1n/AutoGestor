import 'package:drift/drift.dart';
import 'fornecedor_table.dart';

@DataClassName('PedidoCompraData')
class PedidoCompraTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fornecedorId => integer().references(FornecedorTable, #id)();
  TextColumn get numero => text().withLength(min: 1, max: 50)();
  TextColumn get status => text().withLength(max: 20).withDefault(const Constant('pendente'))(); // pendente, aprovado, cancelado, recebido
  RealColumn get valorTotal => real().withDefault(const Constant(0.0))();
  TextColumn get observacoes => text().nullable()();
  DateTimeColumn get dataEmissao => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get dataAprovacao => dateTime().nullable()();
  DateTimeColumn get dataRecebimento => dateTime().nullable()();
  DateTimeColumn get criadoEm => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get atualizadoEm => dateTime().withDefault(currentDateAndTime)();
}