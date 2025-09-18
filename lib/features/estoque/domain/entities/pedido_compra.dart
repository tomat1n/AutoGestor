import 'fornecedor.dart';
import 'item_compra.dart';

enum StatusPedidoCompra {
  pendente,
  aprovado,
  cancelado,
  recebido;

  String get displayName {
    switch (this) {
      case StatusPedidoCompra.pendente:
        return 'Pendente';
      case StatusPedidoCompra.aprovado:
        return 'Aprovado';
      case StatusPedidoCompra.cancelado:
        return 'Cancelado';
      case StatusPedidoCompra.recebido:
        return 'Recebido';
    }
  }
}

class PedidoCompra {
  final int? id;
  final int fornecedorId;
  final Fornecedor? fornecedor;
  final String numero;
  final StatusPedidoCompra status;
  final double valorTotal;
  final String? observacoes;
  final DateTime dataEmissao;
  final DateTime? dataAprovacao;
  final DateTime? dataRecebimento;
  final DateTime criadoEm;
  final DateTime atualizadoEm;
  final List<ItemCompra>? itens;

  const PedidoCompra({
    this.id,
    required this.fornecedorId,
    this.fornecedor,
    required this.numero,
    this.status = StatusPedidoCompra.pendente,
    this.valorTotal = 0.0,
    this.observacoes,
    required this.dataEmissao,
    this.dataAprovacao,
    this.dataRecebimento,
    required this.criadoEm,
    required this.atualizadoEm,
    this.itens,
  });

  PedidoCompra copyWith({
    int? id,
    int? fornecedorId,
    Fornecedor? fornecedor,
    String? numero,
    StatusPedidoCompra? status,
    double? valorTotal,
    String? observacoes,
    DateTime? dataEmissao,
    DateTime? dataAprovacao,
    DateTime? dataRecebimento,
    DateTime? criadoEm,
    DateTime? atualizadoEm,
    List<ItemCompra>? itens,
  }) {
    return PedidoCompra(
      id: id ?? this.id,
      fornecedorId: fornecedorId ?? this.fornecedorId,
      fornecedor: fornecedor ?? this.fornecedor,
      numero: numero ?? this.numero,
      status: status ?? this.status,
      valorTotal: valorTotal ?? this.valorTotal,
      observacoes: observacoes ?? this.observacoes,
      dataEmissao: dataEmissao ?? this.dataEmissao,
      dataAprovacao: dataAprovacao ?? this.dataAprovacao,
      dataRecebimento: dataRecebimento ?? this.dataRecebimento,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
      itens: itens ?? this.itens,
    );
  }

  bool get podeAprovar => status == StatusPedidoCompra.pendente;
  bool get podeCancelar => status == StatusPedidoCompra.pendente || status == StatusPedidoCompra.aprovado;
  bool get podeReceber => status == StatusPedidoCompra.aprovado;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PedidoCompra && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'PedidoCompra(id: $id, numero: $numero, status: $status, valorTotal: $valorTotal)';
  }
}