import 'package:drift/drift.dart';
import 'usuario_table.dart';

enum TipoAssinatura {
  teste,
  mensal,
  trimestral,
  semestral,
  anual
}

enum StatusAssinatura {
  ativa,
  expirada,
  cancelada,
  suspensa
}

@DataClassName('Assinatura')
class AssinaturaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get usuarioId => integer().references(UsuarioTable, #id)();
  
  // Tipo e status da assinatura
  IntColumn get tipo => intEnum<TipoAssinatura>()();
  IntColumn get status => intEnum<StatusAssinatura>().withDefault(const Constant(0))();
  
  // Datas de controle
  DateTimeColumn get dataInicio => dateTime()();
  DateTimeColumn get dataFim => dateTime()();
  DateTimeColumn get criadoEm => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get atualizadoEm => dateTime().withDefault(currentDateAndTime)();
  
  // Controle de pagamento
  RealColumn get valor => real().nullable()();
  BoolColumn get pago => boolean().withDefault(const Constant(false))();
  DateTimeColumn get dataPagamento => dateTime().nullable()();
  TextColumn get metodoPagamento => text().nullable()();
  TextColumn get transacaoId => text().nullable()();
  
  // Observações
  TextColumn get observacoes => text().nullable()();
}