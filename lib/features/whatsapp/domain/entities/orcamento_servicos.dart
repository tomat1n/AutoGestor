class OrcamentoServicos {
  final String id;
  final String nomeCliente;
  final String telefoneCliente;
  final List<ServicoOrcamento> servicos;
  final double valorTotal;
  final double desconto;
  final String? observacoes;
  final DateTime criadoEm;

  OrcamentoServicos({
    required this.id,
    required this.nomeCliente,
    required this.telefoneCliente,
    required this.servicos,
    required this.valorTotal,
    this.desconto = 0.0,
    this.observacoes,
    DateTime? criadoEm,
  }) : criadoEm = criadoEm ?? DateTime.now();

  OrcamentoServicos copyWith({
    String? id,
    String? nomeCliente,
    String? telefoneCliente,
    List<ServicoOrcamento>? servicos,
    double? valorTotal,
    double? desconto,
    String? observacoes,
    DateTime? criadoEm,
  }) {
    return OrcamentoServicos(
      id: id ?? this.id,
      nomeCliente: nomeCliente ?? this.nomeCliente,
      telefoneCliente: telefoneCliente ?? this.telefoneCliente,
      servicos: servicos ?? this.servicos,
      valorTotal: valorTotal ?? this.valorTotal,
      desconto: desconto ?? this.desconto,
      observacoes: observacoes ?? this.observacoes,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomeCliente': nomeCliente,
      'telefoneCliente': telefoneCliente,
      'servicos': servicos.map((s) => s.toJson()).toList(),
      'valorTotal': valorTotal,
      'desconto': desconto,
      'observacoes': observacoes,
      'criadoEm': criadoEm.toIso8601String(),
    };
  }

  factory OrcamentoServicos.fromJson(Map<String, dynamic> json) {
    return OrcamentoServicos(
      id: json['id'],
      nomeCliente: json['nomeCliente'],
      telefoneCliente: json['telefoneCliente'],
      servicos: (json['servicos'] as List)
          .map((s) => ServicoOrcamento.fromJson(s))
          .toList(),
      valorTotal: json['valorTotal'].toDouble(),
      desconto: json['desconto']?.toDouble() ?? 0.0,
      observacoes: json['observacoes'],
      criadoEm: DateTime.parse(json['criadoEm']),
    );
  }
}

class ServicoOrcamento {
  final String id;
  final String descricao;
  final double valor;
  final String? duracao;
  final String? observacoes;

  const ServicoOrcamento({
    required this.id,
    required this.descricao,
    required this.valor,
    this.duracao,
    this.observacoes,
  });

  ServicoOrcamento copyWith({
    String? id,
    String? descricao,
    double? valor,
    String? duracao,
    String? observacoes,
  }) {
    return ServicoOrcamento(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      duracao: duracao ?? this.duracao,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'duracao': duracao,
      'observacoes': observacoes,
    };
  }

  factory ServicoOrcamento.fromJson(Map<String, dynamic> json) {
    return ServicoOrcamento(
      id: json['id'],
      descricao: json['descricao'],
      valor: json['valor'].toDouble(),
      duracao: json['duracao'],
      observacoes: json['observacoes'],
    );
  }
}