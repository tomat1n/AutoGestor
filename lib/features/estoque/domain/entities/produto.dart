class Produto {
  final int? id;
  final String codigo;
  final String nome;
  final String? descricao;
  final double precoCompra;
  final double precoVenda;
  final int estoqueMinimo;
  final int quantidade;
  final String unidade;
  final String? categoria;
  final String? codigoBarras;
  final String? qrCode;
  final String? imagemPath;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Campo calculado - não está na tabela
  final int? estoqueAtual;

  const Produto({
    this.id,
    required this.codigo,
    required this.nome,
    this.descricao,
    this.precoCompra = 0.0,
    required this.precoVenda,
    this.estoqueMinimo = 5,
    this.quantidade = 0,
    this.unidade = 'UN',
    this.categoria,
    this.codigoBarras,
    this.qrCode,
    this.imagemPath,
    this.ativo = true,
    required this.createdAt,
    required this.updatedAt,
    this.estoqueAtual,
  });

  Produto copyWith({
    int? id,
    String? codigo,
    String? nome,
    String? descricao,
    double? precoCompra,
    double? precoVenda,
    int? estoqueMinimo,
    int? quantidade,
    String? unidade,
    String? categoria,
    String? codigoBarras,
    String? qrCode,
    String? imagemPath,
    bool? ativo,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? estoqueAtual,
  }) {
    return Produto(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      precoCompra: precoCompra ?? this.precoCompra,
      precoVenda: precoVenda ?? this.precoVenda,
      estoqueMinimo: estoqueMinimo ?? this.estoqueMinimo,
      quantidade: quantidade ?? this.quantidade,
      unidade: unidade ?? this.unidade,
      categoria: categoria ?? this.categoria,
      codigoBarras: codigoBarras ?? this.codigoBarras,
      qrCode: qrCode ?? this.qrCode,
      imagemPath: imagemPath ?? this.imagemPath,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      estoqueAtual: estoqueAtual ?? this.estoqueAtual,
    );
  }

  // Verifica se o estoque está baixo
  bool get estoqueBaixo => (estoqueAtual ?? 0) <= estoqueMinimo;

  // Verifica se tem estoque disponível
  bool get temEstoque => (estoqueAtual ?? 0) > 0;

  // Calcula a margem de lucro
  double get margemLucro {
    if (precoCompra <= 0) return 0.0;
    return ((precoVenda - precoCompra) / precoCompra) * 100;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Produto && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Produto(id: $id, codigo: $codigo, nome: $nome, estoqueAtual: $estoqueAtual)';
  }
}