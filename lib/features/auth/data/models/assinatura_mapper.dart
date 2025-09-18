import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/models/assinatura_table.dart' as db;
import '../../domain/entities/assinatura_entity.dart' as entity;

class AssinaturaMapper {
  static entity.AssinaturaEntity fromDatabase(Assinatura assinatura) {
    return entity.AssinaturaEntity(
      id: assinatura.id,
      usuarioId: assinatura.usuarioId,
      tipo: entity.TipoAssinatura.values[assinatura.tipo.index],
      status: entity.StatusAssinatura.values[assinatura.status.index],
      dataInicio: assinatura.dataInicio,
      dataFim: assinatura.dataFim,
      criadoEm: assinatura.criadoEm,
      atualizadoEm: assinatura.atualizadoEm,
      valor: assinatura.valor,
      pago: assinatura.pago,
      dataPagamento: assinatura.dataPagamento,
      metodoPagamento: assinatura.metodoPagamento,
      transacaoId: assinatura.transacaoId,
      observacoes: assinatura.observacoes,
    );
  }

  static AssinaturaTableCompanion toCompanion(entity.AssinaturaEntity assinatura) {
    return AssinaturaTableCompanion(
      id: assinatura.id != null ? Value(assinatura.id!) : const Value.absent(),
      usuarioId: Value(assinatura.usuarioId),
      tipo: Value(db.TipoAssinatura.values[assinatura.tipo.index]),
      status: Value(db.StatusAssinatura.values[assinatura.status.index]),
      dataInicio: Value(assinatura.dataInicio),
      dataFim: Value(assinatura.dataFim),
      criadoEm: Value(assinatura.criadoEm),
      atualizadoEm: Value(assinatura.atualizadoEm),
      valor: Value(assinatura.valor),
      pago: Value(assinatura.pago),
      dataPagamento: Value(assinatura.dataPagamento),
      metodoPagamento: Value(assinatura.metodoPagamento),
      transacaoId: Value(assinatura.transacaoId),
      observacoes: Value(assinatura.observacoes),
    );
  }
}