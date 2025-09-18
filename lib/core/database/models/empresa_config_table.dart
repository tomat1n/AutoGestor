import 'package:drift/drift.dart';

@DataClassName('EmpresaConfigData')
class EmpresaConfigs extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Informações básicas da empresa
  TextColumn get nomeEmpresa => text().withLength(min: 1, max: 200)();
  TextColumn get nomeFantasia => text().nullable().withLength(max: 200)();
  TextColumn get tipoEmpresa => text().withLength(min: 1, max: 20)(); // 'fisica' ou 'juridica'
  
  // Documentos
  TextColumn get documento => text().withLength(min: 11, max: 18)(); // CPF ou CNPJ
  TextColumn get inscricaoEstadual => text().nullable().withLength(max: 20)();
  TextColumn get inscricaoMunicipal => text().nullable().withLength(max: 20)();
  
  // Endereço
  TextColumn get endereco => text().withLength(min: 1, max: 200)();
  TextColumn get numero => text().withLength(min: 1, max: 20)();
  TextColumn get complemento => text().nullable().withLength(max: 100)();
  TextColumn get bairro => text().withLength(min: 1, max: 100)();
  TextColumn get cidade => text().withLength(min: 1, max: 100)();
  TextColumn get estado => text().withLength(min: 2, max: 2)(); // UF
  TextColumn get cep => text().withLength(min: 8, max: 10)();
  
  // Contatos
  TextColumn get telefone => text().nullable().withLength(max: 20)();
  TextColumn get celular => text().nullable().withLength(max: 20)();
  TextColumn get email => text().nullable().withLength(max: 200)();
  TextColumn get website => text().nullable().withLength(max: 200)();
  
  // Configurações de impressão
  BoolColumn get exibirLogo => boolean().withDefault(const Constant(false))();
  TextColumn get caminhoLogo => text().nullable().withLength(max: 500)();
  TextColumn get mensagemRodape => text().nullable().withLength(max: 500)();
  BoolColumn get exibirQrCode => boolean().withDefault(const Constant(true))();
  TextColumn get corPrimaria => text().nullable().withLength(max: 7)(); // Hex color
  
  // Dados bancários
  TextColumn get banco => text().nullable().withLength(max: 100)();
  TextColumn get agencia => text().nullable().withLength(max: 20)();
  TextColumn get conta => text().nullable().withLength(max: 30)();
  TextColumn get pix => text().nullable().withLength(max: 200)();
  
  // Configurações fiscais
  TextColumn get regimeTributario => text().nullable().withLength(max: 50)();
  BoolColumn get emitirNfce => boolean().withDefault(const Constant(false))();
  TextColumn get certificadoA1Path => text().nullable().withLength(max: 500)();
  TextColumn get senhaA1 => text().nullable().withLength(max: 100)();
  
  // Timestamps
  DateTimeColumn get criadoEm => dateTime().nullable()();
  DateTimeColumn get atualizadoEm => dateTime().nullable()();
}