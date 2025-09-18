class WhatsAppConfig {
  final int? id;
  final String apiUrl;
  final String apiToken;
  final String instanceId;
  final bool ativo;
  final bool enviarAgendamento;
  final bool enviarLembretes;
  final bool enviarConfirmacoes;
  final bool enviarPromocoes;
  final int? horasAntesLembrete;
  final String? horarioInicioEnvio; // HH:mm
  final String? horarioFimEnvio; // HH:mm
  final List<int>? diasSemanaEnvio; // 1-7 (segunda a domingo)
  final DateTime createdAt;
  final DateTime updatedAt;

  const WhatsAppConfig({
    this.id,
    required this.apiUrl,
    required this.apiToken,
    required this.instanceId,
    this.ativo = true,
    this.enviarAgendamento = true,
    this.enviarLembretes = true,
    this.enviarConfirmacoes = true,
    this.enviarPromocoes = false,
    this.horasAntesLembrete = 24,
    this.horarioInicioEnvio = '08:00',
    this.horarioFimEnvio = '18:00',
    this.diasSemanaEnvio = const [1, 2, 3, 4, 5, 6], // Segunda a sábado
    required this.createdAt,
    required this.updatedAt,
  });

  WhatsAppConfig copyWith({
    int? id,
    String? apiUrl,
    String? apiToken,
    String? instanceId,
    bool? ativo,
    bool? enviarAgendamento,
    bool? enviarLembretes,
    bool? enviarConfirmacoes,
    bool? enviarPromocoes,
    int? horasAntesLembrete,
    String? horarioInicioEnvio,
    String? horarioFimEnvio,
    List<int>? diasSemanaEnvio,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WhatsAppConfig(
      id: id ?? this.id,
      apiUrl: apiUrl ?? this.apiUrl,
      apiToken: apiToken ?? this.apiToken,
      instanceId: instanceId ?? this.instanceId,
      ativo: ativo ?? this.ativo,
      enviarAgendamento: enviarAgendamento ?? this.enviarAgendamento,
      enviarLembretes: enviarLembretes ?? this.enviarLembretes,
      enviarConfirmacoes: enviarConfirmacoes ?? this.enviarConfirmacoes,
      enviarPromocoes: enviarPromocoes ?? this.enviarPromocoes,
      horasAntesLembrete: horasAntesLembrete ?? this.horasAntesLembrete,
      horarioInicioEnvio: horarioInicioEnvio ?? this.horarioInicioEnvio,
      horarioFimEnvio: horarioFimEnvio ?? this.horarioFimEnvio,
      diasSemanaEnvio: diasSemanaEnvio ?? this.diasSemanaEnvio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isConfigured => apiUrl.isNotEmpty && apiToken.isNotEmpty && instanceId.isNotEmpty;

  bool podeEnviarAgora() {
    if (!ativo) return false;
    
    final agora = DateTime.now();
    final diaSemana = agora.weekday;
    
    // Verifica se hoje é um dia permitido
    if (diasSemanaEnvio != null && !diasSemanaEnvio!.contains(diaSemana)) {
      return false;
    }
    
    // Verifica horário
    if (horarioInicioEnvio != null && horarioFimEnvio != null) {
      final horaAtual = '${agora.hour.toString().padLeft(2, '0')}:${agora.minute.toString().padLeft(2, '0')}';
      return horaAtual.compareTo(horarioInicioEnvio!) >= 0 && 
             horaAtual.compareTo(horarioFimEnvio!) <= 0;
    }
    
    return true;
  }

  @override
  String toString() {
    return 'WhatsAppConfig(id: $id, instanceId: $instanceId, ativo: $ativo)';
  }
}