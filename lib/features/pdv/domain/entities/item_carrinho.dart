import '../../../estoque/domain/entities/produto.dart';

class ItemCarrinho {
  final Produto produto;
  final int quantidade;
  final double precoUnitario;

  const ItemCarrinho({
    required this.produto,
    required this.quantidade,
    required this.precoUnitario,
  });

  double get subtotal => quantidade * precoUnitario;

  ItemCarrinho copyWith({
    Produto? produto,
    int? quantidade,
    double? precoUnitario,
  }) {
    return ItemCarrinho(
      produto: produto ?? this.produto,
      quantidade: quantidade ?? this.quantidade,
      precoUnitario: precoUnitario ?? this.precoUnitario,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemCarrinho &&
        other.produto.id == produto.id &&
        other.quantidade == quantidade &&
        other.precoUnitario == precoUnitario;
  }

  @override
  int get hashCode {
    return Object.hash(
      produto.id,
      quantidade,
      precoUnitario,
    );
  }

  @override
  String toString() {
    return 'ItemCarrinho(produto: ${produto.nome}, quantidade: $quantidade, precoUnitario: $precoUnitario, subtotal: $subtotal)';
  }
}