enum StatusOrdemServico {
  agendada,
  emAndamento,
  pausada,
  concluida,
  cancelada,
}

enum PrioridadeOrdemServico {
  baixa,
  media,
  alta,
  urgente,
}

class ItemOrdemServico {
  final int? id;
  final int? ordemServicoId;
  final int? servicoId;
  final String nomeServico;
  final String? descricaoServico;
  final int quantidade;
  final double valorUnitario;
  final double subtotal;
  final int? duracaoMinutos;

  const ItemOrdemServico({
    this.id,
    this.ordemServicoId,
    this.servicoId,
    required this.nomeServico,
    this.descricaoServico,
    required this.quantidade,
    required this.valorUnitario,
    required this.subtotal,
    this.duracaoMinutos,
  });

  ItemOrdemServico copyWith({
    int? id,
    int? ordemServicoId,
    int? servicoId,
    String? nomeServico,
    String? descricaoServico,
    int? quantidade,
    double? valorUnitario,
    double? subtotal,
    int? duracaoMinutos,
  }) {
    return ItemOrdemServico(
      id: id ?? this.id,
      ordemServicoId: ordemServicoId ?? this.ordemServicoId,
      servicoId: servicoId ?? this.servicoId,
      nomeServico: nomeServico ?? this.nomeServico,
      descricaoServico: descricaoServico ?? this.descricaoServico,
      quantidade: quantidade ?? this.quantidade,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      subtotal: subtotal ?? this.subtotal,
      duracaoMinutos: duracaoMinutos ?? this.duracaoMinutos,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemOrdemServico &&
        other.id == id &&
        other.ordemServicoId == ordemServicoId &&
        other.servicoId == servicoId &&
        other.nomeServico == nomeServico &&
        other.descricaoServico == descricaoServico &&
        other.quantidade == quantidade &&
        other.valorUnitario == valorUnitario &&
        other.subtotal == subtotal &&
        other.duracaoMinutos == duracaoMinutos;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      ordemServicoId,
      servicoId,
      nomeServico,
      descricaoServico,
      quantidade,
      valorUnitario,
      subtotal,
      duracaoMinutos,
    );
  }

  @override
  String toString() {
    return 'ItemOrdemServico(id: $id, nomeServico: $nomeServico, quantidade: $quantidade, valorUnitario: $valorUnitario, subtotal: $subtotal)';
  }
}

class OrdemServico {
  final int? id;
  final String numero;
  final int clienteId;
  final String nomeCliente;
  final String? emailCliente;
  final String? telefoneCliente;
  final List<ItemOrdemServico> itens;
  final double subtotal;
  final double desconto;
  final double total;
  final StatusOrdemServico status;
  final PrioridadeOrdemServico prioridade;
  final DateTime dataAgendamento;
  final DateTime? dataInicio;
  final DateTime? dataConclusao;
  final DateTime? dataPrevista;
  final String? observacoes;
  final String? observacoesInternas;
  final String? tecnicoResponsavel;
  final String? equipamento;
  final String? problemaRelatado;
  final String? solucaoAplicada;
  final bool ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OrdemServico({
    this.id,
    required this.numero,
    required this.clienteId,
    required this.nomeCliente,
    this.emailCliente,
    this.telefoneCliente,
    required this.itens,
    required this.subtotal,
    this.desconto = 0.0,
    required this.total,
    this.status = StatusOrdemServico.agendada,
    this.prioridade = PrioridadeOrdemServico.media,
    required this.dataAgendamento,
    this.dataInicio,
    this.dataConclusao,
    this.dataPrevista,
    this.observacoes,
    this.observacoesInternas,
    this.tecnicoResponsavel,
    this.equipamento,
    this.problemaRelatado,
    this.solucaoAplicada,
    this.ativo = true,
    this.createdAt,
    this.updatedAt,
  });

  OrdemServico copyWith({
    int? id,
    String? numero,
    int? clienteId,
    String? nomeCliente,
    String? emailCliente,
    String? telefoneCliente,
    List<ItemOrdemServico>? itens,
    double? subtotal,
    double? desconto,
    double? total,
    StatusOrdemServico? status,
    PrioridadeOrdemServico? prioridade,
    DateTime? dataAgendamento,
    DateTime? dataInicio,
    DateTime? dataConclusao,
    DateTime? dataPrevista,
    String? observacoes,
    String? observacoesInternas,
    String? tecnicoResponsavel,
    String? equipamento,
    String? problemaRelatado,
    String? solucaoAplicada,
    bool? ativo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrdemServico(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      clienteId: clienteId ?? this.clienteId,
      nomeCliente: nomeCliente ?? this.nomeCliente,
      emailCliente: emailCliente ?? this.emailCliente,
      telefoneCliente: telefoneCliente ?? this.telefoneCliente,
      itens: itens ?? this.itens,
      subtotal: subtotal ?? this.subtotal,
      desconto: desconto ?? this.desconto,
      total: total ?? this.total,
      status: status ?? this.status,
      prioridade: prioridade ?? this.prioridade,
      dataAgendamento: dataAgendamento ?? this.dataAgendamento,
      dataInicio: dataInicio ?? this.dataInicio,
      dataConclusao: dataConclusao ?? this.dataConclusao,
      dataPrevista: dataPrevista ?? this.dataPrevista,
      observacoes: observacoes ?? this.observacoes,
      observacoesInternas: observacoesInternas ?? this.observacoesInternas,
      tecnicoResponsavel: tecnicoResponsavel ?? this.tecnicoResponsavel,
      equipamento: equipamento ?? this.equipamento,
      problemaRelatado: problemaRelatado ?? this.problemaRelatado,
      solucaoAplicada: solucaoAplicada ?? this.solucaoAplicada,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrdemServico &&
        other.id == id &&
        other.numero == numero &&
        other.clienteId == clienteId &&
        other.nomeCliente == nomeCliente &&
        other.emailCliente == emailCliente &&
        other.telefoneCliente == telefoneCliente &&
        other.subtotal == subtotal &&
        other.desconto == desconto &&
        other.total == total &&
        other.status == status &&
        other.prioridade == prioridade &&
        other.dataAgendamento == dataAgendamento &&
        other.dataInicio == dataInicio &&
        other.dataConclusao == dataConclusao &&
        other.dataPrevista == dataPrevista &&
        other.observacoes == observacoes &&
        other.observacoesInternas == observacoesInternas &&
        other.tecnicoResponsavel == tecnicoResponsavel &&
        other.equipamento == equipamento &&
        other.problemaRelatado == problemaRelatado &&
        other.solucaoAplicada == solucaoAplicada &&
        other.ativo == ativo;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      numero,
      clienteId,
      nomeCliente,
      emailCliente,
      telefoneCliente,
      subtotal,
      desconto,
      total,
      status,
      prioridade,
      dataAgendamento,
      dataInicio,
      dataConclusao,
      dataPrevista,
      observacoes,
      observacoesInternas,
      tecnicoResponsavel,
      equipamento,
    );
  }

  @override
  String toString() {
    return 'OrdemServico(id: $id, numero: $numero, nomeCliente: $nomeCliente, total: $total, status: $status, dataAgendamento: $dataAgendamento)';
  }

  // Métodos auxiliares
  bool get isAgendada => status == StatusOrdemServico.agendada;
  bool get isEmAndamento => status == StatusOrdemServico.emAndamento;
  bool get isPausada => status == StatusOrdemServico.pausada;
  bool get isConcluida => status == StatusOrdemServico.concluida;
  bool get isCancelada => status == StatusOrdemServico.cancelada;
  
  bool get isAtrasada {
    if (dataPrevista == null) return false;
    return DateTime.now().isAfter(dataPrevista!) && !isConcluida;
  }

  Duration? get tempoExecucao {
    if (dataInicio == null) return null;
    final fim = dataConclusao ?? DateTime.now();
    return fim.difference(dataInicio!);
  }

  int get diasParaPrevista {
    if (dataPrevista == null) return 0;
    return dataPrevista!.difference(DateTime.now()).inDays;
  }
}