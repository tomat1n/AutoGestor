import 'dart:convert';
import 'package:drift/drift.dart';
import '../database/database.dart';

class AuditoriaService {
  final AppDatabase _database;

  AuditoriaService(this._database);

  /// Registra uma ação de auditoria
  Future<void> registrarAcao({
    required String entidade,
    required String acao,
    required int entidadeId,
    required String usuario,
    String? detalhes,
    Map<String, dynamic>? valoresAnteriores,
    Map<String, dynamic>? valoresNovos,
  }) async {
    final companion = AuditoriaTableCompanion(
      entidade: Value(entidade),
      acao: Value(acao),
      entidadeId: Value(entidadeId),
      usuario: Value(usuario),
      detalhes: Value(detalhes),
      valoresAnteriores: Value(valoresAnteriores != null ? jsonEncode(valoresAnteriores) : null),
      valoresNovos: Value(valoresNovos != null ? jsonEncode(valoresNovos) : null),
    );

    await _database.into(_database.auditoriaTable).insert(companion);
  }

  /// Busca auditoria por entidade e ID
  Future<List<AuditoriaData>> buscarPorEntidade(String entidade, int entidadeId) async {
    return await (_database.select(_database.auditoriaTable)
          ..where((tbl) => tbl.entidade.equals(entidade) & tbl.entidadeId.equals(entidadeId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.dataAcao)]))
        .get();
  }

  /// Busca auditoria por usuário
  Future<List<AuditoriaData>> buscarPorUsuario(String usuario, {int? limite}) async {
    final query = _database.select(_database.auditoriaTable)
      ..where((tbl) => tbl.usuario.equals(usuario))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.dataAcao)]);
    
    if (limite != null) {
      query.limit(limite);
    }
    
    return await query.get();
  }

  /// Busca auditoria por período
  Future<List<AuditoriaData>> buscarPorPeriodo(DateTime inicio, DateTime fim) async {
    return await (_database.select(_database.auditoriaTable)
          ..where((tbl) => tbl.dataAcao.isBetweenValues(inicio, fim))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.dataAcao)]))
        .get();
  }

  /// Busca todas as auditorias com paginação
  Future<List<AuditoriaData>> buscarTodas({int? offset, int? limite}) async {
    final query = _database.select(_database.auditoriaTable)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.dataAcao)]);
    
    if (offset != null) {
      query.limit(limite ?? 50, offset: offset);
    } else if (limite != null) {
      query.limit(limite);
    }
    
    return await query.get();
  }
}

/// Constantes para entidades
class EntidadeAuditoria {
  static const String os = 'OS';
  static const String produto = 'PRODUTO';
  static const String estoque = 'ESTOQUE';
  static const String cliente = 'CLIENTE';
  static const String veiculo = 'VEICULO';
  static const String orcamento = 'ORCAMENTO';
  static const String pedidoCompra = 'PEDIDO_COMPRA';
  static const String fornecedor = 'FORNECEDOR';
}

/// Constantes para ações
class AcaoAuditoria {
  static const String criar = 'CRIAR';
  static const String atualizar = 'ATUALIZAR';
  static const String deletar = 'DELETAR';
  static const String finalizar = 'FINALIZAR';
  static const String cancelar = 'CANCELAR';
  static const String aprovar = 'APROVAR';
  static const String rejeitar = 'REJEITAR';
  static const String movimentarEstoque = 'MOVIMENTAR_ESTOQUE';
  static const String estornarEstoque = 'ESTORNAR_ESTOQUE';
}