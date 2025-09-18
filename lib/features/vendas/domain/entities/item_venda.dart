/// Entidade que representa um item de venda
class ItemVenda {
  final int? id;
  final int? vendaId;
  final int? produtoId;
  final String? nomeProduto;
  final int? quantidade;
  final double? precoUnitario;
  final double? subtotal;

  const ItemVenda({
    this.id,
    this.vendaId,
    this.produtoId,
    this.nomeProduto,
    this.quantidade,
    this.precoUnitario,
    this.subtotal,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendaId': vendaId,
      'produtoId': produtoId,
      'nomeProduto': nomeProduto,
      'quantidade': quantidade,
      'precoUnitario': precoUnitario,
      'subtotal': subtotal,
    };
  }

  factory ItemVenda.fromJson(Map<String, dynamic> json) {
    return ItemVenda(
      id: json['id'],
      vendaId: json['vendaId'],
      produtoId: json['produtoId'],
      nomeProduto: json['nomeProduto'],
      quantidade: json['quantidade'],
      precoUnitario: json['precoUnitario']?.toDouble(),
      subtotal: json['subtotal']?.toDouble(),
    );
  }
}