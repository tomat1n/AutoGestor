import 'package:drift/drift.dart';

class ClienteTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text().withLength(min: 1, max: 100)();
  TextColumn get email => text().withLength(max: 100).nullable()();
  TextColumn get telefone => text().withLength(max: 20).nullable()();
  TextColumn get cpfCnpj => text().withLength(max: 18).nullable()();
  TextColumn get endereco => text().withLength(max: 200).nullable()();
  TextColumn get cidade => text().withLength(max: 50).nullable()();
  TextColumn get estado => text().withLength(max: 2).nullable()();
  TextColumn get cep => text().withLength(max: 10).nullable()();
  TextColumn get observacoes => text().nullable()();
  
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}