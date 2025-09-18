import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/cliente.dart';
import '../../domain/repositories/cliente_repository.dart';

// Provider do repositório
final clienteRepositoryProvider = Provider<ClienteRepository>((ref) {
  return getIt<ClienteRepository>();
});

// Provider para lista de clientes
final clientesProvider = StateNotifierProvider<ClientesNotifier, AsyncValue<List<Cliente>>>((ref) {
  return ClientesNotifier(ref.read(clienteRepositoryProvider));
});

// Provider para clientes ativos
final clientesAtivosProvider = FutureProvider<List<Cliente>>((ref) async {
  final repository = ref.watch(clienteRepositoryProvider);
  return repository.getClientesAtivos();
});

// Provider para busca de clientes
final buscaClientesProvider = StateNotifierProvider<BuscaClientesNotifier, AsyncValue<List<Cliente>>>((ref) {
  return BuscaClientesNotifier(ref.read(clienteRepositoryProvider));
});

// Provider para cliente selecionado
final clienteSelecionadoProvider = StateProvider<Cliente?>((ref) => null);

// Provider para termo de busca
final termoBuscaClienteProvider = StateProvider<String>((ref) => '');

// Notifier para gerenciar lista de clientes
class ClientesNotifier extends StateNotifier<AsyncValue<List<Cliente>>> {
  final ClienteRepository _repository;

  ClientesNotifier(this._repository) : super(const AsyncValue.loading()) {
    carregarClientes();
  }

  Future<void> carregarClientes() async {
    try {
      state = const AsyncValue.loading();
      final clientes = await _repository.getAllClientes();
      state = AsyncValue.data(clientes);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> adicionarCliente(Cliente cliente) async {
    try {
      await _repository.createCliente(cliente);
      await carregarClientes();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> atualizarCliente(Cliente cliente) async {
    try {
      await _repository.updateCliente(cliente);
      await carregarClientes();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> deletarCliente(int id) async {
    try {
      await _repository.deleteCliente(id);
      await carregarClientes();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> alternarStatusCliente(int id, bool ativo) async {
    try {
      final cliente = await _repository.getClienteById(id);
      if (cliente != null) {
        final clienteAtualizado = cliente.copyWith(ativo: ativo);
        await _repository.updateCliente(clienteAtualizado);
        await carregarClientes();
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Notifier para busca de clientes
class BuscaClientesNotifier extends StateNotifier<AsyncValue<List<Cliente>>> {
  final ClienteRepository _repository;

  BuscaClientesNotifier(this._repository) : super(const AsyncValue.data([]));

  Future<void> buscarPorNome(String termo) async {
    if (termo.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    try {
      state = const AsyncValue.loading();
      final clientes = await _repository.searchClientes(termo);
      state = AsyncValue.data(clientes);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void limparBusca() {
    state = const AsyncValue.data([]);
  }
}