class Cliente {
  final int? id;
  final String nome;
  final String? email;
  final String? telefone;
  final String? cpfCnpj;
  final String? endereco;
  final String? cidade;
  final String? estado;
  final String? cep;
  final String? observacoes;
  final bool ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Cliente({
    this.id,
    required this.nome,
    this.email,
    this.telefone,
    this.cpfCnpj,
    this.endereco,
    this.cidade,
    this.estado,
    this.cep,
    this.observacoes,
    this.ativo = true,
    this.createdAt,
    this.updatedAt,
  });

  Cliente copyWith({
    int? id,
    String? nome,
    String? email,
    String? telefone,
    String? cpfCnpj,
    String? endereco,
    String? cidade,
    String? estado,
    String? cep,
    String? observacoes,
    bool? ativo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Cliente(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      cpfCnpj: cpfCnpj ?? this.cpfCnpj,
      endereco: endereco ?? this.endereco,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      observacoes: observacoes ?? this.observacoes,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Cliente &&
        other.id == id &&
        other.nome == nome &&
        other.email == email &&
        other.telefone == telefone &&
        other.cpfCnpj == cpfCnpj &&
        other.endereco == endereco &&
        other.cidade == cidade &&
        other.estado == estado &&
        other.cep == cep &&
        other.observacoes == observacoes &&
        other.ativo == ativo;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      nome,
      email,
      telefone,
      cpfCnpj,
      endereco,
      cidade,
      estado,
      cep,
      observacoes,
      ativo,
    );
  }

  @override
  String toString() {
    return 'Cliente(id: $id, nome: $nome, email: $email, telefone: $telefone, cpfCnpj: $cpfCnpj, ativo: $ativo)';
  }
}