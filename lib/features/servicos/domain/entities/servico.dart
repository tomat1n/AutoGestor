class Servico {
  final int? id;
  final String nome;
  final String? descricao;
  final double valor;
  final String? categoria;
  final int? duracaoMinutos;
  final bool ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Servico({
    this.id,
    required this.nome,
    this.descricao,
    required this.valor,
    this.categoria,
    this.duracaoMinutos,
    this.ativo = true,
    this.createdAt,
    this.updatedAt,
  });

  Servico copyWith({
    int? id,
    String? nome,
    String? descricao,
    double? valor,
    String? categoria,
    int? duracaoMinutos,
    bool? ativo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Servico(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      categoria: categoria ?? this.categoria,
      duracaoMinutos: duracaoMinutos ?? this.duracaoMinutos,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Servico &&
        other.id == id &&
        other.nome == nome &&
        other.descricao == descricao &&
        other.valor == valor &&
        other.categoria == categoria &&
        other.duracaoMinutos == duracaoMinutos &&
        other.ativo == ativo;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      nome,
      descricao,
      valor,
      categoria,
      duracaoMinutos,
      ativo,
    );
  }

  @override
  String toString() {
    return 'Servico(id: $id, nome: $nome, valor: $valor, categoria: $categoria, ativo: $ativo)';
  }
}