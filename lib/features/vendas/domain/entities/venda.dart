import 'item_venda.dart';

/// Entidade que representa uma venda no sistema
class Venda {
  final int? id;
  final String? nomeCliente;
  final double? valorTotal;
  final String? formaPagamento;
  final DateTime? dataVenda;
  final List<ItemVenda>? itens;
  final String? observacoes;

  const Venda({
    this.id,
    this.nomeCliente,
    this.valorTotal,
    this.formaPagamento,
    this.dataVenda,
    this.itens,
    this.observacoes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomeCliente': nomeCliente,
      'valorTotal': valorTotal,
      'formaPagamento': formaPagamento,
      'dataVenda': dataVenda?.toIso8601String(),
      'itens': itens?.map((item) => item.toJson()).toList(),
      'observacoes': observacoes,
    };
  }

  factory Venda.fromJson(Map<String, dynamic> json) {
    return Venda(
      id: json['id'],
      nomeCliente: json['nomeCliente'],
      valorTotal: json['valorTotal'].toDouble(),
      formaPagamento: json['formaPagamento'],
      dataVenda: json['dataVenda'] != null 
          ? DateTime.parse(json['dataVenda']) 
          : null,
      itens: json['itens'] != null
          ? (json['itens'] as List)
              .map((item) => ItemVenda.fromJson(item))
              .toList()
          : null,
      observacoes: json['observacoes'],
    );
  }
}