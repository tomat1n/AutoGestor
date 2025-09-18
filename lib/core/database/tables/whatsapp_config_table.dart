import 'package:drift/drift.dart';

class WhatsAppConfigTable extends Table {
  @override
  String get tableName => 'whatsapp_config';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get apiUrl => text()();
  TextColumn get apiToken => text()();
  TextColumn get instanceId => text()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  BoolColumn get enviarAgendamento => boolean().withDefault(const Constant(true))();
  BoolColumn get enviarLembretes => boolean().withDefault(const Constant(true))();
  BoolColumn get enviarConfirmacoes => boolean().withDefault(const Constant(true))();
  BoolColumn get enviarPromocoes => boolean().withDefault(const Constant(false))();
  IntColumn get horasAntesLembrete => integer().withDefault(const Constant(24))();
  TextColumn get horarioInicioEnvio => text().withDefault(const Constant('08:00'))();
  TextColumn get horarioFimEnvio => text().withDefault(const Constant('18:00'))();
  TextColumn get diasSemanaEnvio => text().withDefault(const Constant('[1,2,3,4,5,6]'))(); // JSON array
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}