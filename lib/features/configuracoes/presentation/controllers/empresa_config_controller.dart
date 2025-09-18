import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../../../core/providers/database_provider.dart';
import '../../data/repositories/empresa_config_repository.dart';

class EmpresaConfigController extends StateNotifier<AsyncValue<EmpresaConfigData?>> {
  final EmpresaConfigRepository _repository;

  EmpresaConfigController(this._repository) : super(const AsyncValue.loading()) {
    carregarConfiguracoes();
  }
  
  /// Carrega as configurações da empresa
  Future<void> carregarConfiguracoes() async {
    try {
      state = const AsyncValue.loading();
      final config = await _repository.buscarConfiguracoes();
      
      // Se não há configuração, cria uma configuração inicial vazia
      if (config == null) {
        final configInicial = EmpresaConfigData(
          id: 0,
          nomeEmpresa: 'Nome da Empresa',
          nomeFantasia: null,
          tipoEmpresa: 'PF',
          documento: '00000000000', // CPF padrão com 11 dígitos
          inscricaoEstadual: null,
          inscricaoMunicipal: null,
          endereco: 'Endereço',
          numero: '1',
          complemento: null,
          bairro: 'Bairro',
          cidade: 'Cidade',
          estado: 'SP',
          cep: '00000000',
          telefone: null,
          celular: null,
          email: null,
          website: null,
          exibirLogo: false,
          caminhoLogo: null,
          mensagemRodape: null,
          exibirQrCode: true,
          corPrimaria: null,
          banco: null,
          agencia: null,
          conta: null,
          pix: null,
          regimeTributario: null,
          emitirNfce: false,
          certificadoA1Path: null,
          senhaA1: null,
          criadoEm: DateTime.now(),
          atualizadoEm: DateTime.now(),
        );
        state = AsyncValue.data(configInicial);
      } else {
        state = AsyncValue.data(config);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Salva as configurações da empresa
  Future<bool> salvarConfiguracoes(Map<String, dynamic> dados) async {
    try {
      state = const AsyncValue.loading();
      
      // Cria o companion com os dados fornecidos
      final companion = EmpresaConfigsCompanion(
        tipoEmpresa: Value(dados['tipoEmpresa'] ?? 'PF'),
        nomeEmpresa: Value(dados['nomeEmpresa'] ?? ''),
        documento: Value(dados['documento'] ?? ''),
        inscricaoEstadual: dados['inscricaoEstadual'] != null ? Value(dados['inscricaoEstadual']) : const Value.absent(),
        inscricaoMunicipal: dados['inscricaoMunicipal'] != null ? Value(dados['inscricaoMunicipal']) : const Value.absent(),
        cep: Value(dados['cep'] ?? ''),
        endereco: Value(dados['endereco'] ?? ''),
        numero: Value(dados['numero'] ?? ''),
        complemento: dados['complemento'] != null ? Value(dados['complemento']) : const Value.absent(),
        bairro: Value(dados['bairro'] ?? ''),
        cidade: Value(dados['cidade'] ?? ''),
        estado: Value(dados['estado'] ?? ''),
        telefone: dados['telefone'] != null ? Value(dados['telefone']) : const Value.absent(),
        celular: dados['celular'] != null ? Value(dados['celular']) : const Value.absent(),
        email: dados['email'] != null ? Value(dados['email']) : const Value.absent(),
        website: dados['website'] != null ? Value(dados['website']) : const Value.absent(),
        exibirLogo: Value(dados['exibirLogo'] ?? false),
        banco: dados['banco'] != null ? Value(dados['banco']) : const Value.absent(),
        agencia: dados['agencia'] != null ? Value(dados['agencia']) : const Value.absent(),
        conta: dados['conta'] != null ? Value(dados['conta']) : const Value.absent(),
        pix: dados['pix'] != null ? Value(dados['pix']) : const Value.absent(),
        regimeTributario: dados['regimeTributario'] != null ? Value(dados['regimeTributario']) : const Value.absent(),
        emitirNfce: Value(dados['emitirNfce'] ?? false),
        certificadoA1Path: dados['certificadoA1Path'] != null ? Value(dados['certificadoA1Path']) : const Value.absent(),
        senhaA1: dados['senhaA1'] != null ? Value(dados['senhaA1']) : const Value.absent(),
        criadoEm: Value(DateTime.now()),
        atualizadoEm: Value(DateTime.now()),
      );
      
      final config = await _repository.salvarConfiguracoes(companion);
      state = AsyncValue.data(config);
      return true;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  // Métodos para atualizar campos individuais
  Future<void> updateTipoEmpresa(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(tipoEmpresa: value);
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateNomeEmpresa(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(nomeEmpresa: value);
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateDocumento(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(documento: value);
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateInscricaoEstadual(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(inscricaoEstadual: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateInscricaoMunicipal(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(inscricaoMunicipal: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateCep(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(cep: value);
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateEndereco(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(endereco: value);
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateNumero(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(numero: value);
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateComplemento(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(complemento: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateBairro(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(bairro: value);
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateCidade(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(cidade: value);
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateEstado(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(estado: value);
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateTelefone(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(telefone: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateCelular(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(celular: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateEmail(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(email: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateWebsite(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(website: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateExibirLogo(bool value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(exibirLogo: value);
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateBanco(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(banco: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateAgencia(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(agencia: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateConta(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(conta: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updatePix(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(pix: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateRegimeTributario(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(regimeTributario: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateEmitirNfce(bool value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(emitirNfce: value);
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateCertificadoA1Path(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(certificadoA1Path: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  Future<void> updateSenhaA1(String value) async {
    final currentConfig = state.value;
    if (currentConfig != null) {
      final updatedConfig = currentConfig.copyWith(senhaA1: Value(value));
      await _updateConfig(updatedConfig);
    }
  }

  /// Salva as configurações atuais
  Future<bool> salvarConfiguracaoAtual() async {
    try {
      final currentConfig = state.value;
      if (currentConfig == null) return false;
      
      await _updateConfig(currentConfig);
      return true;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  /// Método auxiliar para atualizar configuração
  Future<void> _updateConfig(EmpresaConfigData config) async {
    try {
      // Validações para garantir que os dados atendem às restrições da tabela
      final nomeEmpresa = config.nomeEmpresa.isEmpty ? 'Nome da Empresa' : config.nomeEmpresa;
      final documento = config.documento.length < 11 ? '00000000000' : config.documento;
      final endereco = config.endereco.isEmpty ? 'Endereço' : config.endereco;
      final numero = config.numero.isEmpty ? '1' : config.numero;
      final bairro = config.bairro.isEmpty ? 'Bairro' : config.bairro;
      final cidade = config.cidade.isEmpty ? 'Cidade' : config.cidade;
      final estado = config.estado.length != 2 ? 'SP' : config.estado;
      final cep = config.cep.length < 8 ? '00000000' : config.cep;
      
      final companion = EmpresaConfigsCompanion(
        id: Value(config.id),
        tipoEmpresa: Value(config.tipoEmpresa),
        nomeEmpresa: Value(nomeEmpresa),
        documento: Value(documento),
        inscricaoEstadual: config.inscricaoEstadual != null ? Value(config.inscricaoEstadual!) : const Value.absent(),
        inscricaoMunicipal: config.inscricaoMunicipal != null ? Value(config.inscricaoMunicipal!) : const Value.absent(),
        cep: Value(cep),
        endereco: Value(endereco),
        numero: Value(numero),
        complemento: config.complemento != null ? Value(config.complemento!) : const Value.absent(),
        bairro: Value(bairro),
        cidade: Value(cidade),
        estado: Value(estado),
        telefone: config.telefone != null ? Value(config.telefone!) : const Value.absent(),
        celular: config.celular != null ? Value(config.celular!) : const Value.absent(),
        email: config.email != null ? Value(config.email!) : const Value.absent(),
        website: config.website != null ? Value(config.website!) : const Value.absent(),
        exibirLogo: Value(config.exibirLogo),
        banco: config.banco != null ? Value(config.banco!) : const Value.absent(),
        agencia: config.agencia != null ? Value(config.agencia!) : const Value.absent(),
        conta: config.conta != null ? Value(config.conta!) : const Value.absent(),
        pix: config.pix != null ? Value(config.pix!) : const Value.absent(),
        regimeTributario: config.regimeTributario != null ? Value(config.regimeTributario!) : const Value.absent(),
        emitirNfce: Value(config.emitirNfce),
        certificadoA1Path: config.certificadoA1Path != null ? Value(config.certificadoA1Path!) : const Value.absent(),
        senhaA1: config.senhaA1 != null ? Value(config.senhaA1!) : const Value.absent(),
        criadoEm: config.criadoEm != null ? Value(config.criadoEm!) : const Value.absent(),
        atualizadoEm: Value(DateTime.now()),
      );
      
      final updatedConfig = await _repository.salvarConfiguracoes(companion);
      state = AsyncValue.data(updatedConfig);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Reseta as configurações da empresa
  Future<void> resetarConfiguracoes() async {
    try {
      state = const AsyncValue.loading();
      await _repository.resetarConfiguracoes();
      await carregarConfiguracoes();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Providers
final empresaConfigRepositoryProvider = Provider<EmpresaConfigRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return EmpresaConfigRepository(database);
});

final empresaConfigControllerProvider = StateNotifierProvider<EmpresaConfigController, AsyncValue<EmpresaConfigData?>>((ref) {
  final repository = ref.watch(empresaConfigRepositoryProvider);
  return EmpresaConfigController(repository);
});