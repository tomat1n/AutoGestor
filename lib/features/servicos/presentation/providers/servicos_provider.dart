import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/di/service_locator.dart';
import '../../data/repositories/servicos_repository_impl.dart';
import '../../domain/entities/servico.dart';
import '../../domain/repositories/servicos_repository.dart';

// Provider do repositório
final servicosRepositoryProvider = Provider<ServicosRepository>((ref) {
  return ServicosRepositoryImpl(getIt<AppDatabase>());
});

// Provider para lista de serviços
final servicosProvider = StateNotifierProvider<ServicosNotifier, AsyncValue<List<Servico>>>((ref) {
  return ServicosNotifier(ref.read(servicosRepositoryProvider));
});

// Provider para serviços ativos
final servicosAtivosProvider = StateNotifierProvider<ServicosAtivosNotifier, AsyncValue<List<Servico>>>((ref) {
  return ServicosAtivosNotifier(ref.read(servicosRepositoryProvider));
});

class ServicosNotifier extends StateNotifier<AsyncValue<List<Servico>>> {
  final ServicosRepository _repository;

  ServicosNotifier(this._repository) : super(const AsyncValue.loading()) {
    carregarServicos();
  }

  Future<void> carregarServicos() async {
    try {
      state = const AsyncValue.loading();
      final servicos = await _repository.buscarTodos();
      state = AsyncValue.data(servicos);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> adicionarServico(Servico servico) async {
    try {
      await _repository.criar(servico);
      await carregarServicos();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> atualizarServico(Servico servico) async {
    try {
      await _repository.atualizar(servico);
      await carregarServicos();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> excluirServico(int id) async {
    try {
      await _repository.excluir(id);
      await carregarServicos();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> ativarDesativarServico(int id, bool ativo) async {
    try {
      await _repository.ativarDesativar(id, ativo);
      await carregarServicos();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

class ServicosAtivosNotifier extends StateNotifier<AsyncValue<List<Servico>>> {
  final ServicosRepository _repository;

  ServicosAtivosNotifier(this._repository) : super(const AsyncValue.loading()) {
    carregarServicosAtivos();
  }

  Future<void> carregarServicosAtivos() async {
    try {
      state = const AsyncValue.loading();
      final servicos = await _repository.buscarAtivos();
      state = AsyncValue.data(servicos);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}