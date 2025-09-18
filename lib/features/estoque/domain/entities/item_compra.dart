import 'produto.dart';

class ItemCompra {
  final int? id;
  final int pedidoCompraId;
  final int produtoId;
  final Produto? produto;
  final int quantidade;
  final double precoUnitario;
  final double precoTotal;
  final String? observacoes;
  final DateTime criadoEm;

  const ItemCompra({
    this.id,
    required this.pedidoCompraId,
    required this.produtoId,
    this.produto,
    required this.quantidade,
    required this.precoUnitario,
    required this.precoTotal,
    this.observacoes,
    required this.criadoEm,
  });

  ItemCompra copyWith({
    int? id,
    int? pedidoCompraId,
    int? produtoId,
    Produto? produto,
    int? quantidade,
    double? precoUnitario,
    double? precoTotal,
    String? observacoes,
    DateTime? criadoEm,
  }) {
    return ItemCompra(
      id: id ?? this.id,
      pedidoCompraId: pedidoCompraId ?? this.pedidoCompraId,
      produtoId: produtoId ?? this.produtoId,
      produto: produto ?? this.produto,
      quantidade: quantidade ?? this.quantidade,
      precoUnitario: precoUnitario ?? this.precoUnitario,
      precoTotal: precoTotal ?? this.precoTotal,
      observacoes: observacoes ?? this.observacoes,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  // Calcula o preço total automaticamente
  static ItemCompra calcularPrecoTotal({
    int? id,
    required int pedidoCompraId,
    required int produtoId,
    Produto? produto,
    required int quantidade,
    required double precoUnitario,
    String? observacoes,
    required DateTime criadoEm,
  }) {
    return ItemCompra(
      id: id,
      pedidoCompraId: pedidoCompraId,
      produtoId: produtoId,
      produto: produto,
      quantidade: quantidade,
      precoUnitario: precoUnitario,
      precoTotal: quantidade * precoUnitario,
      observacoes: observacoes,
      criadoEm: criadoEm,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemCompra && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ItemCompra(id: $id, produtoId: $produtoId, quantidade: $quantidade, precoTotal: $precoTotal)';
  }
}