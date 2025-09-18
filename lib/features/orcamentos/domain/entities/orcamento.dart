import 'package:flutter/foundation.dart';

enum StatusOrcamento {
  rascunho,
  enviado,
  aprovado,
  rejeitado,
  expirado,
}

class ItemOrcamento {
  final int? id;
  final int? orcamentoId;
  final int? servicoId;
  final String nomeServico;
  final String? descricaoServico;
  final int quantidade;
  final double valorUnitario;
  final double subtotal;

  const ItemOrcamento({
    this.id,
    this.orcamentoId,
    this.servicoId,
    required this.nomeServico,
    this.descricaoServico,
    required this.quantidade,
    required this.valorUnitario,
    required this.subtotal,
  });

  ItemOrcamento copyWith({
    int? id,
    int? orcamentoId,
    int? servicoId,
    String? nomeServico,
    String? descricaoServico,
    int? quantidade,
    double? valorUnitario,
    double? subtotal,
  }) {
    return ItemOrcamento(
      id: id ?? this.id,
      orcamentoId: orcamentoId ?? this.orcamentoId,
      servicoId: servicoId ?? this.servicoId,
      nomeServico: nomeServico ?? this.nomeServico,
      descricaoServico: descricaoServico ?? this.descricaoServico,
      quantidade: quantidade ?? this.quantidade,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemOrcamento &&
        other.id == id &&
        other.orcamentoId == orcamentoId &&
        other.servicoId == servicoId &&
        other.nomeServico == nomeServico &&
        other.descricaoServico == descricaoServico &&
        other.quantidade == quantidade &&
        other.valorUnitario == valorUnitario &&
        other.subtotal == subtotal;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      orcamentoId,
      servicoId,
      nomeServico,
      descricaoServico,
      quantidade,
      valorUnitario,
      subtotal,
    );
  }

  @override
  String toString() {
    return 'ItemOrcamento(id: $id, nomeServico: $nomeServico, quantidade: $quantidade, valorUnitario: $valorUnitario, subtotal: $subtotal)';
  }
}

class Orcamento {
  final int? id;
  final String numero;
  final int clienteId;
  final String nomeCliente;
  final String? emailCliente;
  final String? telefoneCliente;
  final List<ItemOrcamento> itens;
  final double subtotal;
  final double desconto;
  final double total;
  final StatusOrcamento status;
  final DateTime dataEmissao;
  final DateTime? dataValidade;
  final DateTime? dataAprovacao;
  final String? observacoes;
  final String? condicoesPagamento;
  final List<String>? fotosDefeitoUrls;
  final List<String>? fotosReposicaoUrls;
  final bool ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Orcamento({
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
    this.status = StatusOrcamento.rascunho,
    required this.dataEmissao,
    this.dataValidade,
    this.dataAprovacao,
    this.observacoes,
    this.condicoesPagamento,
    this.fotosDefeitoUrls,
    this.fotosReposicaoUrls,
    this.ativo = true,
    this.createdAt,
    this.updatedAt,
  });

  Orcamento copyWith({
    int? id,
    String? numero,
    int? clienteId,
    String? nomeCliente,
    String? emailCliente,
    String? telefoneCliente,
    List<ItemOrcamento>? itens,
    double? subtotal,
    double? desconto,
    double? total,
    StatusOrcamento? status,
    DateTime? dataEmissao,
    DateTime? dataValidade,
    DateTime? dataAprovacao,
    String? observacoes,
    String? condicoesPagamento,
    List<String>? fotosDefeitoUrls,
    List<String>? fotosReposicaoUrls,
    bool? ativo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Orcamento(
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
      dataEmissao: dataEmissao ?? this.dataEmissao,
      dataValidade: dataValidade ?? this.dataValidade,
      dataAprovacao: dataAprovacao ?? this.dataAprovacao,
      observacoes: observacoes ?? this.observacoes,
      condicoesPagamento: condicoesPagamento ?? this.condicoesPagamento,
      fotosDefeitoUrls: fotosDefeitoUrls ?? this.fotosDefeitoUrls,
      fotosReposicaoUrls: fotosReposicaoUrls ?? this.fotosReposicaoUrls,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Orcamento &&
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
        other.dataEmissao == dataEmissao &&
        other.dataValidade == dataValidade &&
        other.dataAprovacao == dataAprovacao &&
        other.observacoes == observacoes &&
        other.condicoesPagamento == condicoesPagamento &&
        listEquals(other.fotosDefeitoUrls, fotosDefeitoUrls) &&
        listEquals(other.fotosReposicaoUrls, fotosReposicaoUrls) &&
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
      dataEmissao,
      dataValidade,
      dataAprovacao,
      observacoes,
      condicoesPagamento,
      fotosDefeitoUrls,
      fotosReposicaoUrls,
      ativo,
    );
  }

  @override
  String toString() {
    return 'Orcamento(id: $id, numero: $numero, nomeCliente: $nomeCliente, total: $total, status: $status, dataEmissao: $dataEmissao)';
  }

  // Métodos auxiliares
  bool get isAprovado => status == StatusOrcamento.aprovado;
  bool get isRejeitado => status == StatusOrcamento.rejeitado;
  bool get isExpirado => status == StatusOrcamento.expirado;
  bool get isPendente => status == StatusOrcamento.enviado;
  bool get isRascunho => status == StatusOrcamento.rascunho;
  
  bool get isVencido {
    if (dataValidade == null) return false;
    return DateTime.now().isAfter(dataValidade!);
  }

  int get diasParaVencimento {
    if (dataValidade == null) return 0;
    return dataValidade!.difference(DateTime.now()).inDays;
  }

  // Getter para compatibilidade
  double get valorTotal => total;
}