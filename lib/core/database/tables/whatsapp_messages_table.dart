import 'package:drift/drift.dart';

class WhatsAppMessagesTable extends Table {
  @override
  String get tableName => 'whatsapp_messages';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get clienteId => text()();
  TextColumn get telefone => text()();
  TextColumn get mensagem => text()();
  TextColumn get tipo => text()(); // 'agendamento', 'lembrete', 'confirmacao', 'promocional'
  TextColumn get status => text().withDefault(const Constant('pendente'))(); // 'pendente', 'enviado', 'entregue', 'lido', 'erro'
  DateTimeColumn get dataEnvio => dateTime().nullable()();
  DateTimeColumn get dataEntrega => dateTime().nullable()();
  DateTimeColumn get dataLeitura => dateTime().nullable()();
  TextColumn get erro => text().nullable()();
  TextColumn get metadata => text().nullable()(); // JSON string
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}