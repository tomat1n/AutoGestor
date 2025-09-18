import 'package:get_it/get_it.dart';
import 'database.dart';
import 'seeds.dart';

/// Classe utilitária para executar seeds do banco de dados
class SeedRunner {
  static final AppDatabase _database = GetIt.instance<AppDatabase>();

  /// Executa todos os seeds do banco de dados
  static Future<void> executarSeeds() async {
    try {
      print('=== Iniciando execução dos seeds ===');
      
      final seeds = DatabaseSeeds(_database);
      await seeds.executarSeeds();
      
      print('=== Seeds executados com sucesso! ===');
    } catch (e) {
      print('Erro ao executar seeds: $e');
      rethrow;
    }
  }

  /// Limpa todos os dados de teste
  static Future<void> limparDadosTeste() async {
    try {
      print('=== Iniciando limpeza dos dados de teste ===');
      
      final seeds = DatabaseSeeds(_database);
      await seeds.limparDadosTeste();
      
      print('=== Dados de teste limpos com sucesso! ===');
    } catch (e) {
      print('Erro ao limpar dados de teste: $e');
      rethrow;
    }
  }

  /// Reexecuta os seeds (limpa e cria novamente)
  static Future<void> reexecutarSeeds() async {
    try {
      print('=== Reexecutando seeds ===');
      
      await limparDadosTeste();
      await executarSeeds();
      
      print('=== Seeds reexecutados com sucesso! ===');
    } catch (e) {
      print('Erro ao reexecutar seeds: $e');
      rethrow;
    }
  }

  /// Verifica se os seeds já foram executados
  static Future<bool> seedsJaExecutados() async {
    try {
      final produtos = await _database.select(_database.produtoTable).get();
      final vendas = await _database.select(_database.vendaTable).get();
      return produtos.isNotEmpty && vendas.isNotEmpty;
    } catch (e) {
      print('Erro ao verificar seeds: $e');
      return false;
    }
  }

  /// Executa seeds automaticamente se necessário (útil para desenvolvimento)
  static Future<void> executarSeedsSeNecessario() async {
    try {
      final jaExecutados = await seedsJaExecutados();
      
      if (!jaExecutados) {
        print('Seeds não encontrados, executando automaticamente...');
        await executarSeeds();
      } else {
        print('Seeds já executados anteriormente.');
      }
    } catch (e) {
      print('Erro ao verificar/executar seeds: $e');
    }
  }
}