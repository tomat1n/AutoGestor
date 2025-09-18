class Fornecedor {
  final int? id;
  final String nome;
  final String? razaoSocial;
  final String? cnpj;
  final String? cpf;
  final String? email;
  final String? telefone;
  final String? endereco;
  final String? cidade;
  final String? estado;
  final String? cep;
  final bool ativo;
  final DateTime criadoEm;
  final DateTime atualizadoEm;

  const Fornecedor({
    this.id,
    required this.nome,
    this.razaoSocial,
    this.cnpj,
    this.cpf,
    this.email,
    this.telefone,
    this.endereco,
    this.cidade,
    this.estado,
    this.cep,
    this.ativo = true,
    required this.criadoEm,
    required this.atualizadoEm,
  });

  Fornecedor copyWith({
    int? id,
    String? nome,
    String? razaoSocial,
    String? cnpj,
    String? cpf,
    String? email,
    String? telefone,
    String? endereco,
    String? cidade,
    String? estado,
    String? cep,
    bool? ativo,
    DateTime? criadoEm,
    DateTime? atualizadoEm,
  }) {
    return Fornecedor(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      razaoSocial: razaoSocial ?? this.razaoSocial,
      cnpj: cnpj ?? this.cnpj,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      ativo: ativo ?? this.ativo,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Fornecedor && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Fornecedor(id: $id, nome: $nome, cnpj: $cnpj, ativo: $ativo)';
  }
}