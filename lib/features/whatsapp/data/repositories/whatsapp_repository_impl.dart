import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../domain/entities/whatsapp_message.dart';
import '../../domain/entities/whatsapp_config.dart';
import '../../domain/repositories/whatsapp_repository.dart';

class WhatsAppRepositoryImpl implements WhatsAppRepository {
  final AppDatabase _database;

  WhatsAppRepositoryImpl(this._database);

  @override
  Future<WhatsAppConfig?> obterConfiguracao() async {
    final query = _database.select(_database.whatsAppConfigTable);
    final configData = await query.getSingleOrNull();
    
    if (configData == null) return null;
    
    return _mapConfigToEntity(configData);
  }

  @override
  Future<void> salvarConfiguracao(WhatsAppConfig config) async {
    final companion = WhatsAppConfigTableCompanion(
      apiUrl: Value(config.apiUrl),
      apiToken: Value(config.apiToken),
      instanceId: Value(config.instanceId),
      ativo: Value(config.ativo),
      enviarAgendamento: Value(config.enviarAgendamento),
      enviarLembretes: Value(config.enviarLembretes),
      enviarConfirmacoes: Value(config.enviarConfirmacoes),
      enviarPromocoes: Value(config.enviarPromocoes),
      horasAntesLembrete: Value(config.horasAntesLembrete ?? 24),
      horarioInicioEnvio: Value(config.horarioInicioEnvio ?? '08:00'),
      horarioFimEnvio: Value(config.horarioFimEnvio ?? '18:00'),
      diasSemanaEnvio: Value(jsonEncode(config.diasSemanaEnvio ?? [1,2,3,4,5,6])),
      updatedAt: Value(DateTime.now()),
    );

    if (config.id == null) {
      await _database.into(_database.whatsAppConfigTable).insert(companion);
    } else {
      await (_database.update(_database.whatsAppConfigTable)
            ..where((tbl) => tbl.id.equals(config.id!)))
          .write(companion);
    }
  }

  @override
  Future<List<WhatsAppMessage>> listarMensagens({
    String? clienteId,
    String? tipo,
    String? status,
    DateTime? dataInicio,
    DateTime? dataFim,
    int? limite,
  }) async {
    final query = _database.select(_database.whatsAppMessagesTable);
    
    if (clienteId != null) {
      query.where((tbl) => tbl.clienteId.equals(clienteId));
    }
    if (tipo != null) {
      query.where((tbl) => tbl.tipo.equals(tipo));
    }
    if (status != null) {
      query.where((tbl) => tbl.status.equals(status));
    }
    if (dataInicio != null) {
      query.where((tbl) => tbl.createdAt.isBiggerOrEqualValue(dataInicio));
    }
    if (dataFim != null) {
      query.where((tbl) => tbl.createdAt.isSmallerOrEqualValue(dataFim));
    }
    
    query.orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);
    
    if (limite != null) {
      query.limit(limite);
    }
    
    final mensagensData = await query.get();
    return mensagensData.map((data) => _mapMessageToEntity(data)).toList();
  }

  @override
  Future<WhatsAppMessage> salvarMensagem(WhatsAppMessage mensagem) async {
    final companion = WhatsAppMessagesTableCompanion(
      clienteId: Value(mensagem.clienteId),
      telefone: Value(mensagem.telefone),
      mensagem: Value(mensagem.mensagem),
      tipo: Value(mensagem.tipo),
      status: Value(mensagem.status),
      dataEnvio: Value(mensagem.dataEnvio),
      dataEntrega: Value(mensagem.dataEntrega),
      dataLeitura: Value(mensagem.dataLeitura),
      erro: Value(mensagem.erro),
      metadata: Value(mensagem.metadata != null ? jsonEncode(mensagem.metadata) : null),
      updatedAt: Value(DateTime.now()),
    );

    final id = await _database.into(_database.whatsAppMessagesTable).insert(companion);
    return mensagem.copyWith(id: id);
  }

  @override
  Future<WhatsAppMessage> atualizarMensagem(WhatsAppMessage mensagem) async {
    final companion = WhatsAppMessagesTableCompanion(
      clienteId: Value(mensagem.clienteId),
      telefone: Value(mensagem.telefone),
      mensagem: Value(mensagem.mensagem),
      tipo: Value(mensagem.tipo),
      status: Value(mensagem.status),
      dataEnvio: Value(mensagem.dataEnvio),
      dataEntrega: Value(mensagem.dataEntrega),
      dataLeitura: Value(mensagem.dataLeitura),
      erro: Value(mensagem.erro),
      metadata: Value(mensagem.metadata != null ? jsonEncode(mensagem.metadata) : null),
      updatedAt: Value(DateTime.now()),
    );

    await (_database.update(_database.whatsAppMessagesTable)
          ..where((tbl) => tbl.id.equals(mensagem.id!)))
        .write(companion);
    
    return mensagem.copyWith(updatedAt: DateTime.now());
  }

  @override
  Future<void> excluirMensagem(int id) async {
    await (_database.delete(_database.whatsAppMessagesTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<WhatsAppMessage?> obterMensagemPorId(int id) async {
    final query = _database.select(_database.whatsAppMessagesTable)
      ..where((tbl) => tbl.id.equals(id));
    
    final mensagemData = await query.getSingleOrNull();
    if (mensagemData == null) return null;
    
    return _mapMessageToEntity(mensagemData);
  }

  @override
  Future<List<WhatsAppMessage>> obterMensagensPendentes() async {
    final query = _database.select(_database.whatsAppMessagesTable)
      ..where((tbl) => tbl.status.equals('pendente'))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)]);
    
    final mensagensData = await query.get();
    return mensagensData.map((data) => _mapMessageToEntity(data)).toList();
  }

  @override
  Future<void> marcarComoEnviada(int id, DateTime dataEnvio) async {
    await (_database.update(_database.whatsAppMessagesTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(WhatsAppMessagesTableCompanion(
          status: const Value('enviado'),
          dataEnvio: Value(dataEnvio),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<void> marcarComoEntregue(int id, DateTime dataEntrega) async {
    await (_database.update(_database.whatsAppMessagesTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(WhatsAppMessagesTableCompanion(
          status: const Value('entregue'),
          dataEntrega: Value(dataEntrega),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<void> marcarComoLida(int id, DateTime dataLeitura) async {
    await (_database.update(_database.whatsAppMessagesTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(WhatsAppMessagesTableCompanion(
          status: const Value('lido'),
          dataLeitura: Value(dataLeitura),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<void> marcarComoErro(int id, String erro) async {
    await (_database.update(_database.whatsAppMessagesTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(WhatsAppMessagesTableCompanion(
          status: const Value('erro'),
          erro: Value(erro),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<Map<String, int>> obterEstatisticas({
    DateTime? dataInicio,
    DateTime? dataFim,
  }) async {
    final query = _database.select(_database.whatsAppMessagesTable);
    
    if (dataInicio != null) {
      query.where((tbl) => tbl.createdAt.isBiggerOrEqualValue(dataInicio));
    }
    if (dataFim != null) {
      query.where((tbl) => tbl.createdAt.isSmallerOrEqualValue(dataFim));
    }
    
    final mensagens = await query.get();
    
    final stats = <String, int>{
      'total': mensagens.length,
      'pendente': 0,
      'enviado': 0,
      'entregue': 0,
      'lido': 0,
      'erro': 0,
    };
    
    for (final mensagem in mensagens) {
      stats[mensagem.status] = (stats[mensagem.status] ?? 0) + 1;
    }
    
    return stats;
  }

  WhatsAppMessage _mapMessageToEntity(WhatsAppMessagesTableData data) {
    return WhatsAppMessage(
      id: data.id,
      clienteId: data.clienteId,
      telefone: data.telefone,
      mensagem: data.mensagem,
      tipo: data.tipo,
      status: data.status,
      dataEnvio: data.dataEnvio,
      dataEntrega: data.dataEntrega,
      dataLeitura: data.dataLeitura,
      erro: data.erro,
      metadata: data.metadata != null ? jsonDecode(data.metadata!) : null,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  WhatsAppConfig _mapConfigToEntity(WhatsAppConfigTableData data) {
    return WhatsAppConfig(
      id: data.id,
      apiUrl: data.apiUrl,
      apiToken: data.apiToken,
      instanceId: data.instanceId,
      ativo: data.ativo,
      enviarAgendamento: data.enviarAgendamento,
      enviarLembretes: data.enviarLembretes,
      enviarConfirmacoes: data.enviarConfirmacoes,
      enviarPromocoes: data.enviarPromocoes,
      horasAntesLembrete: data.horasAntesLembrete,
      horarioInicioEnvio: data.horarioInicioEnvio,
      horarioFimEnvio: data.horarioFimEnvio,
      diasSemanaEnvio: List<int>.from(jsonDecode(data.diasSemanaEnvio)),
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}