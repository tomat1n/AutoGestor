enum TipoAssinatura {
  teste,
  mensal,
  trimestral,
  semestral,
  anual;

  String get nome {
    switch (this) {
      case TipoAssinatura.teste:
        return 'Período de Teste';
      case TipoAssinatura.mensal:
        return 'Mensal';
      case TipoAssinatura.trimestral:
        return 'Trimestral';
      case TipoAssinatura.semestral:
        return 'Semestral';
      case TipoAssinatura.anual:
        return 'Anual';
    }
  }

  int get diasDuracao {
    switch (this) {
      case TipoAssinatura.teste:
        return 7; // 7 dias de teste
      case TipoAssinatura.mensal:
        return 30;
      case TipoAssinatura.trimestral:
        return 90;
      case TipoAssinatura.semestral:
        return 180;
      case TipoAssinatura.anual:
        return 365;
    }
  }

  double get valor {
    switch (this) {
      case TipoAssinatura.teste:
        return 0.0;
      case TipoAssinatura.mensal:
        return 49.90;
      case TipoAssinatura.trimestral:
        return 129.90;
      case TipoAssinatura.semestral:
        return 239.90;
      case TipoAssinatura.anual:
        return 449.90;
    }
  }
}

enum StatusAssinatura {
  ativa,
  expirada,
  cancelada,
  suspensa;

  String get nome {
    switch (this) {
      case StatusAssinatura.ativa:
        return 'Ativa';
      case StatusAssinatura.expirada:
        return 'Expirada';
      case StatusAssinatura.cancelada:
        return 'Cancelada';
      case StatusAssinatura.suspensa:
        return 'Suspensa';
    }
  }

  bool get permiteAcesso {
    return this == StatusAssinatura.ativa;
  }
}

class AssinaturaEntity {
  final int? id;
  final int usuarioId;
  final TipoAssinatura tipo;
  final StatusAssinatura status;
  final DateTime dataInicio;
  final DateTime dataFim;
  final DateTime criadoEm;
  final DateTime atualizadoEm;
  final double? valor;
  final bool pago;
  final DateTime? dataPagamento;
  final String? metodoPagamento;
  final String? transacaoId;
  final String? observacoes;

  const AssinaturaEntity({
    this.id,
    required this.usuarioId,
    required this.tipo,
    this.status = StatusAssinatura.ativa,
    required this.dataInicio,
    required this.dataFim,
    required this.criadoEm,
    required this.atualizadoEm,
    this.valor,
    this.pago = false,
    this.dataPagamento,
    this.metodoPagamento,
    this.transacaoId,
    this.observacoes,
  });

  // Calcula os dias restantes da assinatura
  int get diasRestantes {
    final agora = DateTime.now();
    if (agora.isAfter(dataFim)) return 0;
    return dataFim.difference(agora).inDays;
  }

  // Verifica se a assinatura está expirada
  bool get isExpirada {
    return DateTime.now().isAfter(dataFim) || status == StatusAssinatura.expirada;
  }

  // Verifica se é período de teste
  bool get isTeste {
    return tipo == TipoAssinatura.teste;
  }

  // Verifica se permite acesso ao sistema
  bool get permiteAcesso {
    return status.permiteAcesso && !isExpirada;
  }

  AssinaturaEntity copyWith({
    int? id,
    int? usuarioId,
    TipoAssinatura? tipo,
    StatusAssinatura? status,
    DateTime? dataInicio,
    DateTime? dataFim,
    DateTime? criadoEm,
    DateTime? atualizadoEm,
    double? valor,
    bool? pago,
    DateTime? dataPagamento,
    String? metodoPagamento,
    String? transacaoId,
    String? observacoes,
  }) {
    return AssinaturaEntity(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      tipo: tipo ?? this.tipo,
      status: status ?? this.status,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
      valor: valor ?? this.valor,
      pago: pago ?? this.pago,
      dataPagamento: dataPagamento ?? this.dataPagamento,
      metodoPagamento: metodoPagamento ?? this.metodoPagamento,
      transacaoId: transacaoId ?? this.transacaoId,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AssinaturaEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AssinaturaEntity(id: $id, tipo: ${tipo.nome}, status: ${status.nome}, diasRestantes: $diasRestantes)';
  }
}