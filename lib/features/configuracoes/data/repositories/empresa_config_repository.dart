import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';

class EmpresaConfigRepository {
  final AppDatabase _database;

  EmpresaConfigRepository(this._database);

  /// Busca as configurações da empresa
  /// Retorna null se não houver configurações salvas
  Future<EmpresaConfigData?> buscarConfiguracoes() async {
    try {
      final query = _database.select(_database.empresaConfigs);
      final result = await query.getSingleOrNull();
      return result;
    } catch (e) {
      throw Exception('Erro ao buscar configurações da empresa: $e');
    }
  }

  /// Salva ou atualiza as configurações da empresa
  Future<EmpresaConfigData> salvarConfiguracoes(EmpresaConfigsCompanion configuracao) async {
    try {
      // Verifica se já existe uma configuração
      final existente = await buscarConfiguracoes();
      
      if (existente != null) {
        // Atualiza a configuração existente
        final configAtualizada = configuracao.copyWith(
          id: Value(existente.id),
          atualizadoEm: Value(DateTime.now()),
        );
        
        _database.update(_database.empresaConfigs)
          ..where((tbl) => tbl.id.equals(existente.id))
          ..write(configAtualizada);
        
        // Retorna a configuração atualizada
        final resultado = await buscarConfiguracoes();
        return resultado!;
      } else {
        // Cria uma nova configuração
        final novaConfig = configuracao.copyWith(
          criadoEm: Value(DateTime.now()),
          atualizadoEm: Value(DateTime.now()),
        );
        
        final id = await _database.into(_database.empresaConfigs).insert(novaConfig);
        
        // Retorna a configuração criada
        final resultado = await (_database.select(_database.empresaConfigs)
           ..where((tbl) => tbl.id.equals(id))).getSingle();
        return resultado;
      }
    } catch (e) {
      throw Exception('Erro ao salvar configurações da empresa: $e');
    }
  }

  /// Reseta as configurações da empresa (remove do banco)
  Future<void> resetarConfiguracoes() async {
    try {
      await _database.delete(_database.empresaConfigs).go();
    } catch (e) {
      throw Exception('Erro ao resetar configurações da empresa: $e');
    }
  }

  /// Verifica se existem configurações salvas
  Future<bool> temConfiguracoes() async {
    try {
      final config = await buscarConfiguracoes();
      return config != null;
    } catch (e) {
      return false;
    }
  }



  /// Exporta as configurações como Map para backup/exportação
  Future<Map<String, dynamic>?> exportarConfiguracoes() async {
    try {
      final config = await buscarConfiguracoes();
      if (config == null) return null;
      
      return {
        'tipoEmpresa': config.tipoEmpresa,
        'nomeEmpresa': config.nomeEmpresa,
        'documento': config.documento,
        'inscricaoEstadual': config.inscricaoEstadual,
        'inscricaoMunicipal': config.inscricaoMunicipal,
        'cep': config.cep,
        'endereco': config.endereco,
        'numero': config.numero,
        'complemento': config.complemento,
        'bairro': config.bairro,
        'cidade': config.cidade,
        'estado': config.estado,
        'telefone': config.telefone,
        'celular': config.celular,
        'email': config.email,
        'website': config.website,
        'criadoEm': config.criadoEm?.toIso8601String(),
        'atualizadoEm': config.atualizadoEm?.toIso8601String(),
      };
    } catch (e) {
      throw Exception('Erro ao exportar configurações: $e');
    }
  }
}