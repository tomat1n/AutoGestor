import '../../../estoque/domain/entities/produto.dart';

class ItemVenda {
  final int? id;
  final int vendaId;
  final int produtoId;
  final int quantidade;
  final double precoUnitario;
  final double subtotal;
  final DateTime criadoEm;
  final Produto? produto; // Para joins

  const ItemVenda({
    this.id,
    required this.vendaId,
    required this.produtoId,
    required this.quantidade,
    required this.precoUnitario,
    required this.subtotal,
    required this.criadoEm,
    this.produto,
  });

  ItemVenda copyWith({
    int? id,
    int? vendaId,
    int? produtoId,
    int? quantidade,
    double? precoUnitario,
    double? subtotal,
    DateTime? criadoEm,
    Produto? produto,
  }) {
    return ItemVenda(
      id: id ?? this.id,
      vendaId: vendaId ?? this.vendaId,
      produtoId: produtoId ?? this.produtoId,
      quantidade: quantidade ?? this.quantidade,
      precoUnitario: precoUnitario ?? this.precoUnitario,
      subtotal: subtotal ?? this.subtotal,
      criadoEm: criadoEm ?? this.criadoEm,
      produto: produto ?? this.produto,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemVenda &&
        other.id == id &&
        other.vendaId == vendaId &&
        other.produtoId == produtoId &&
        other.quantidade == quantidade &&
        other.precoUnitario == precoUnitario &&
        other.subtotal == subtotal &&
        other.criadoEm == criadoEm;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      vendaId,
      produtoId,
      quantidade,
      precoUnitario,
      subtotal,
      criadoEm,
    );
  }

  @override
  String toString() {
    return 'ItemVenda(id: $id, vendaId: $vendaId, produtoId: $produtoId, quantidade: $quantidade, precoUnitario: $precoUnitario, subtotal: $subtotal, criadoEm: $criadoEm)';
  }
}