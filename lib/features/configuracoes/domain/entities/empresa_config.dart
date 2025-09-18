class EmpresaConfig {
  final int? id;
  final String nomeEmpresa;
  final String? nomeFantasia;
  final String tipoEmpresa; // 'fisica' ou 'juridica'
  
  // Documentos
  final String documento; // CPF ou CNPJ
  final String? inscricaoEstadual;
  final String? inscricaoMunicipal;
  
  // Endereço
  final String endereco;
  final String numero;
  final String? complemento;
  final String bairro;
  final String cidade;
  final String estado;
  final String cep;
  
  // Contatos
  final String? telefone;
  final String? celular;
  final String? email;
  final String? website;
  
  // Configurações de impressão
  final bool exibirLogo;
  final String? caminhoLogo;
  final String? mensagemRodape;
  final bool exibirQrCode;
  final String? corPrimaria;
  
  // Dados bancários (opcional)
  final String? banco;
  final String? agencia;
  final String? conta;
  final String? pix;
  
  // Configurações fiscais
  final String? regimeTributario; // 'simples', 'lucro_presumido', 'lucro_real'
  final bool emitirNFCe;
  final String? certificadoA1Path;
  final String? senhaA1;
  
  // Timestamps
  final DateTime? criadoEm;
  final DateTime? atualizadoEm;

  const EmpresaConfig({
    this.id,
    required this.nomeEmpresa,
    this.nomeFantasia,
    required this.tipoEmpresa,
    required this.documento,
    this.inscricaoEstadual,
    this.inscricaoMunicipal,
    required this.endereco,
    required this.numero,
    this.complemento,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.cep,
    this.telefone,
    this.celular,
    this.email,
    this.website,
    this.exibirLogo = false,
    this.caminhoLogo,
    this.mensagemRodape,
    this.exibirQrCode = false,
    this.corPrimaria,
    this.banco,
    this.agencia,
    this.conta,
    this.pix,
    this.regimeTributario,
    this.emitirNFCe = false,
    this.certificadoA1Path,
    this.senhaA1,
    this.criadoEm,
    this.atualizadoEm,
  });

  EmpresaConfig copyWith({
    int? id,
    String? nomeEmpresa,
    String? nomeFantasia,
    String? tipoEmpresa,
    String? documento,
    String? inscricaoEstadual,
    String? inscricaoMunicipal,
    String? endereco,
    String? numero,
    String? complemento,
    String? bairro,
    String? cidade,
    String? estado,
    String? cep,
    String? telefone,
    String? celular,
    String? email,
    String? website,
    bool? exibirLogo,
    String? caminhoLogo,
    String? mensagemRodape,
    bool? exibirQrCode,
    String? corPrimaria,
    String? banco,
    String? agencia,
    String? conta,
    String? pix,
    String? regimeTributario,
    bool? emitirNFCe,
    String? certificadoA1Path,
    String? senhaA1,
    DateTime? criadoEm,
    DateTime? atualizadoEm,
  }) {
    return EmpresaConfig(
      id: id ?? this.id,
      nomeEmpresa: nomeEmpresa ?? this.nomeEmpresa,
      nomeFantasia: nomeFantasia ?? this.nomeFantasia,
      tipoEmpresa: tipoEmpresa ?? this.tipoEmpresa,
      documento: documento ?? this.documento,
      inscricaoEstadual: inscricaoEstadual ?? this.inscricaoEstadual,
      inscricaoMunicipal: inscricaoMunicipal ?? this.inscricaoMunicipal,
      endereco: endereco ?? this.endereco,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      telefone: telefone ?? this.telefone,
      celular: celular ?? this.celular,
      email: email ?? this.email,
      website: website ?? this.website,
      exibirLogo: exibirLogo ?? this.exibirLogo,
      caminhoLogo: caminhoLogo ?? this.caminhoLogo,
      mensagemRodape: mensagemRodape ?? this.mensagemRodape,
      exibirQrCode: exibirQrCode ?? this.exibirQrCode,
      corPrimaria: corPrimaria ?? this.corPrimaria,
      banco: banco ?? this.banco,
      agencia: agencia ?? this.agencia,
      conta: conta ?? this.conta,
      pix: pix ?? this.pix,
      regimeTributario: regimeTributario ?? this.regimeTributario,
      emitirNFCe: emitirNFCe ?? this.emitirNFCe,
      certificadoA1Path: certificadoA1Path ?? this.certificadoA1Path,
      senhaA1: senhaA1 ?? this.senhaA1,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome_empresa': nomeEmpresa,
      'nome_fantasia': nomeFantasia,
      'tipo_empresa': tipoEmpresa,
      'documento': documento,
      'inscricao_estadual': inscricaoEstadual,
      'inscricao_municipal': inscricaoMunicipal,
      'endereco': endereco,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'cep': cep,
      'telefone': telefone,
      'celular': celular,
      'email': email,
      'website': website,
      'exibir_logo': exibirLogo ? 1 : 0,
      'caminho_logo': caminhoLogo,
      'mensagem_rodape': mensagemRodape,
      'exibir_qr_code': exibirQrCode ? 1 : 0,
      'cor_primaria': corPrimaria,
      'banco': banco,
      'agencia': agencia,
      'conta': conta,
      'pix': pix,
      'regime_tributario': regimeTributario,
      'emitir_nfce': emitirNFCe ? 1 : 0,
      'certificado_a1_path': certificadoA1Path,
      'senha_a1': senhaA1,
      'criado_em': criadoEm?.toIso8601String(),
      'atualizado_em': atualizadoEm?.toIso8601String(),
    };
  }

  factory EmpresaConfig.fromMap(Map<String, dynamic> map) {
    return EmpresaConfig(
      id: map['id']?.toInt(),
      nomeEmpresa: map['nome_empresa'] ?? '',
      nomeFantasia: map['nome_fantasia'],
      tipoEmpresa: map['tipo_empresa'] ?? 'juridica',
      documento: map['documento'] ?? '',
      inscricaoEstadual: map['inscricao_estadual'],
      inscricaoMunicipal: map['inscricao_municipal'],
      endereco: map['endereco'] ?? '',
      numero: map['numero'] ?? '',
      complemento: map['complemento'],
      bairro: map['bairro'] ?? '',
      cidade: map['cidade'] ?? '',
      estado: map['estado'] ?? '',
      cep: map['cep'] ?? '',
      telefone: map['telefone'],
      celular: map['celular'],
      email: map['email'],
      website: map['website'],
      exibirLogo: (map['exibir_logo'] ?? 0) == 1,
      caminhoLogo: map['caminho_logo'],
      mensagemRodape: map['mensagem_rodape'],
      exibirQrCode: (map['exibir_qr_code'] ?? 0) == 1,
      corPrimaria: map['cor_primaria'],
      banco: map['banco'],
      agencia: map['agencia'],
      conta: map['conta'],
      pix: map['pix'],
      regimeTributario: map['regime_tributario'],
      emitirNFCe: (map['emitir_nfce'] ?? 0) == 1,
      certificadoA1Path: map['certificado_a1_path'],
      senhaA1: map['senha_a1'],
      criadoEm: map['criado_em'] != null ? DateTime.parse(map['criado_em']) : null,
      atualizadoEm: map['atualizado_em'] != null ? DateTime.parse(map['atualizado_em']) : null,
    );
  }

  @override
  String toString() {
    return 'EmpresaConfig(id: $id, nomeEmpresa: $nomeEmpresa, tipoEmpresa: $tipoEmpresa, documento: $documento)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EmpresaConfig && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  // Getters úteis
  bool get isPessoaFisica => tipoEmpresa == 'fisica';
  bool get isPessoaJuridica => tipoEmpresa == 'juridica';
  
  String get enderecoCompleto {
    final partes = [endereco, numero];
    if (complemento?.isNotEmpty == true) partes.add(complemento!);
    partes.addAll([bairro, cidade, estado]);
    return partes.join(', ');
  }
  
  String get documentoFormatado {
    if (isPessoaFisica) {
      // Formatar CPF: 000.000.000-00
      if (documento.length == 11) {
        return '${documento.substring(0, 3)}.${documento.substring(3, 6)}.${documento.substring(6, 9)}-${documento.substring(9)}';
      }
    } else {
      // Formatar CNPJ: 00.000.000/0000-00
      if (documento.length == 14) {
        return '${documento.substring(0, 2)}.${documento.substring(2, 5)}.${documento.substring(5, 8)}/${documento.substring(8, 12)}-${documento.substring(12)}';
      }
    }
    return documento;
  }
  
  String get cepFormatado {
    if (cep.length == 8) {
      return '${cep.substring(0, 5)}-${cep.substring(5)}';
    }
    return cep;
  }
}