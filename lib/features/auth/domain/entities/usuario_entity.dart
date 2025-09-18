import '../../../../core/database/enums/user_role.dart';

class UsuarioEntity {
  final int? id;
  final String nome;
  final String email;
  final String empresa;
  final String? cnpj;
  final String? telefone;
  final String? endereco;
  final String? cidade;
  final String? estado;
  final String? cep;
  final String? logoPath;
  final String? corPrimaria;
  final String? corSecundaria;
  final String? nomeFantasia;
  final UserRole role;
  final bool ativo;
  final DateTime criadoEm;
  final DateTime atualizadoEm;
  final DateTime? ultimoLogin;

  const UsuarioEntity({
    this.id,
    required this.nome,
    required this.email,
    required this.empresa,
    this.cnpj,
    this.telefone,
    this.endereco,
    this.cidade,
    this.estado,
    this.cep,
    this.logoPath,
    this.corPrimaria,
    this.corSecundaria,
    this.nomeFantasia,
    this.role = UserRole.user,
    this.ativo = true,
    required this.criadoEm,
    required this.atualizadoEm,
    this.ultimoLogin,
  });

  factory UsuarioEntity.fromJson(Map<String, dynamic> json) {
    return UsuarioEntity(
      id: json['id'] as int?,
      nome: json['nome'] as String,
      email: json['email'] as String,
      empresa: json['empresa'] as String,
      cnpj: json['cnpj'] as String?,
      telefone: json['telefone'] as String?,
      endereco: json['endereco'] as String?,
      cidade: json['cidade'] as String?,
      estado: json['estado'] as String?,
      cep: json['cep'] as String?,
      logoPath: json['logoPath'] as String?,
      corPrimaria: json['corPrimaria'] as String?,
      corSecundaria: json['corSecundaria'] as String?,
      nomeFantasia: json['nomeFantasia'] as String?,
      role: UserRole.fromString(json['role'] as String),
      ativo: json['ativo'] as bool? ?? true,
      criadoEm: json['criadoEm'] != null ? DateTime.parse(json['criadoEm'] as String) : DateTime.now(),
      atualizadoEm: json['atualizadoEm'] != null ? DateTime.parse(json['atualizadoEm'] as String) : DateTime.now(),
      ultimoLogin: json['ultimoLogin'] != null ? DateTime.parse(json['ultimoLogin'] as String) : null,
    );
  }

  UsuarioEntity copyWith({
    int? id,
    String? nome,
    String? email,
    String? empresa,
    String? cnpj,
    String? telefone,
    String? endereco,
    String? cidade,
    String? estado,
    String? cep,
    String? logoPath,
    String? corPrimaria,
    String? corSecundaria,
    String? nomeFantasia,
    UserRole? role,
    bool? ativo,
    DateTime? criadoEm,
    DateTime? atualizadoEm,
    DateTime? ultimoLogin,
  }) {
    return UsuarioEntity(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      empresa: empresa ?? this.empresa,
      cnpj: cnpj ?? this.cnpj,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      logoPath: logoPath ?? this.logoPath,
      corPrimaria: corPrimaria ?? this.corPrimaria,
      corSecundaria: corSecundaria ?? this.corSecundaria,
      nomeFantasia: nomeFantasia ?? this.nomeFantasia,
      role: role ?? this.role,
      ativo: ativo ?? this.ativo,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
      ultimoLogin: ultimoLogin ?? this.ultimoLogin,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UsuarioEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UsuarioEntity(id: $id, nome: $nome, email: $email, empresa: $empresa)';
  }
}