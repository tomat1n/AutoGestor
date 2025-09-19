class Venda {
  final int? id;
  final DateTime dataVenda;
  final double subtotal;
  final double desconto;
  final double total;
  final String formaPagamento;
  final String? observacoes;
  final String? nomeCliente;
  final DateTime criadoEm;
  final DateTime atualizadoEm;

  const Venda({
    this.id,
    required this.dataVenda,
    required this.subtotal,
    this.desconto = 0.0,
    required this.total,
    required this.formaPagamento,
    this.observacoes,
    this.nomeCliente,
    required this.criadoEm,
    required this.atualizadoEm,
  });

  Venda copyWith({
    int? id,
    DateTime? dataVenda,
    double? subtotal,
    double? desconto,
    double? total,
    String? formaPagamento,
    String? observacoes,
    String? nomeCliente,
    DateTime? criadoEm,
    DateTime? atualizadoEm,
  }) {
    return Venda(
      id: id ?? this.id,
      dataVenda: dataVenda ?? this.dataVenda,
      subtotal: subtotal ?? this.subtotal,
      desconto: desconto ?? this.desconto,
      total: total ?? this.total,
      formaPagamento: formaPagamento ?? this.formaPagamento,
      observacoes: observacoes ?? this.observacoes,
      nomeCliente: nomeCliente ?? this.nomeCliente,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Venda &&
        other.id == id &&
        other.dataVenda == dataVenda &&
        other.subtotal == subtotal &&
        other.desconto == desconto &&
        other.total == total &&
        other.formaPagamento == formaPagamento &&
        other.observacoes == observacoes &&
        other.nomeCliente == nomeCliente &&
        other.criadoEm == criadoEm &&
        other.atualizadoEm == atualizadoEm;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      dataVenda,
      subtotal,
      desconto,
      total,
      formaPagamento,
      observacoes,
      nomeCliente,
      criadoEm,
      atualizadoEm,
    );
  }

  @override
  String toString() {
    return 'Venda(id: $id, dataVenda: $dataVenda, subtotal: $subtotal, desconto: $desconto, total: $total, formaPagamento: $formaPagamento, observacoes: $observacoes, nomeCliente: $nomeCliente, criadoEm: $criadoEm, atualizadoEm: $atualizadoEm)';
  }
}