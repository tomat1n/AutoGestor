import 'package:drift/drift.dart';

class ServicosTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text().withLength(min: 1, max: 255)();
  TextColumn get descricao => text().nullable()();
  RealColumn get valor => real()();
  TextColumn get categoria => text().nullable()();
  IntColumn get duracaoMinutos => integer().nullable()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'servicos';
}