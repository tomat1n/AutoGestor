import 'package:drift/drift.dart';
import '../enums/user_role.dart';

@DataClassName('Usuario')
class UsuarioTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text().withLength(min: 1, max: 100)();
  TextColumn get email => text().unique()();
  TextColumn get senha => text()(); // Hash da senha
  TextColumn get empresa => text().withLength(min: 1, max: 100)();
  TextColumn get cnpj => text().nullable()();
  TextColumn get telefone => text().nullable()();
  TextColumn get endereco => text().nullable()();
  TextColumn get cidade => text().nullable()();
  TextColumn get estado => text().nullable()();
  TextColumn get cep => text().nullable()();
  
  // Configurações de personalização
  TextColumn get logoPath => text().nullable()();
  TextColumn get corPrimaria => text().nullable()();
  TextColumn get corSecundaria => text().nullable()();
  TextColumn get nomeFantasia => text().nullable()();
  
  // Controle de acesso
  TextColumn get role => text().withDefault(const Constant('user'))();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get criadoEm => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get atualizadoEm => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get ultimoLogin => dateTime().nullable()();
}