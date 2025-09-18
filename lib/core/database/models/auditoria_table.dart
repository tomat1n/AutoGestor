import 'package:drift/drift.dart';

@DataClassName('AuditoriaData')
class AuditoriaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entidade => text().withLength(min: 1, max: 50)(); // OS, PRODUTO, ESTOQUE, etc.
  TextColumn get acao => text().withLength(min: 1, max: 50)(); // CRIAR, ATUALIZAR, DELETAR, FINALIZAR, CANCELAR, etc.
  IntColumn get entidadeId => integer()(); // ID da entidade afetada
  TextColumn get usuario => text().withLength(min: 1, max: 100)(); // Nome ou ID do usuário
  TextColumn get detalhes => text().nullable()(); // Detalhes adicionais da ação
  TextColumn get valoresAnteriores => text().nullable()(); // JSON com valores anteriores (para updates)
  TextColumn get valoresNovos => text().nullable()(); // JSON com valores novos
  DateTimeColumn get dataAcao => dateTime().withDefault(currentDateAndTime)();
}