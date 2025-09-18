class WhatsAppMessage {
  final int? id;
  final String clienteId;
  final String telefone;
  final String mensagem;
  final String tipo; // 'agendamento', 'lembrete', 'confirmacao', 'promocional'
  final String status; // 'pendente', 'enviado', 'entregue', 'lido', 'erro'
  final DateTime? dataEnvio;
  final DateTime? dataEntrega;
  final DateTime? dataLeitura;
  final String? erro;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WhatsAppMessage({
    this.id,
    required this.clienteId,
    required this.telefone,
    required this.mensagem,
    required this.tipo,
    this.status = 'pendente',
    this.dataEnvio,
    this.dataEntrega,
    this.dataLeitura,
    this.erro,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  WhatsAppMessage copyWith({
    int? id,
    String? clienteId,
    String? telefone,
    String? mensagem,
    String? tipo,
    String? status,
    DateTime? dataEnvio,
    DateTime? dataEntrega,
    DateTime? dataLeitura,
    String? erro,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WhatsAppMessage(
      id: id ?? this.id,
      clienteId: clienteId ?? this.clienteId,
      telefone: telefone ?? this.telefone,
      mensagem: mensagem ?? this.mensagem,
      tipo: tipo ?? this.tipo,
      status: status ?? this.status,
      dataEnvio: dataEnvio ?? this.dataEnvio,
      dataEntrega: dataEntrega ?? this.dataEntrega,
      dataLeitura: dataLeitura ?? this.dataLeitura,
      erro: erro ?? this.erro,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'WhatsAppMessage(id: $id, clienteId: $clienteId, telefone: $telefone, tipo: $tipo, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WhatsAppMessage && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}