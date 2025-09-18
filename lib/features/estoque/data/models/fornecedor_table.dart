import 'package:drift/drift.dart';

@DataClassName('FornecedorData')
class FornecedorTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text().withLength(min: 1, max: 100)();
  TextColumn get razaoSocial => text().withLength(max: 150).nullable()();
  TextColumn get cnpj => text().withLength(max: 18).nullable()();
  TextColumn get cpf => text().withLength(max: 14).nullable()();
  TextColumn get email => text().withLength(max: 100).nullable()();
  TextColumn get telefone => text().withLength(max: 20).nullable()();
  TextColumn get endereco => text().withLength(max: 200).nullable()();
  TextColumn get cidade => text().withLength(max: 100).nullable()();
  TextColumn get estado => text().withLength(max: 2).nullable()();
  TextColumn get cep => text().withLength(max: 10).nullable()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get criadoEm => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get atualizadoEm => dateTime().withDefault(currentDateAndTime)();


}