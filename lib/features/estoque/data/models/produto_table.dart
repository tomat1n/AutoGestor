import 'package:drift/drift.dart';

class ProdutoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get codigo => text().withLength(min: 1, max: 50)();
  TextColumn get nome => text().withLength(min: 1, max: 100)();
  TextColumn get descricao => text().nullable()();
  RealColumn get precoCompra => real().withDefault(const Constant(0.0))();
  RealColumn get precoVenda => real()();
  IntColumn get estoqueMinimo => integer().withDefault(const Constant(5))();
  IntColumn get quantidade => integer().withDefault(const Constant(0))();
  TextColumn get unidade => text().withLength(max: 10).withDefault(const Constant('UN'))();
  TextColumn get categoria => text().withLength(max: 50).nullable()();
  
  // Novos campos para código de barras/QR e imagem
  TextColumn get codigoBarras => text().nullable()();
  TextColumn get qrCode => text().nullable()();
  TextColumn get imagemPath => text().nullable()();
  
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}