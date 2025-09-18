import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/di/service_locator.dart';

import '../../data/repositories/produto_repository.dart';
import '../../domain/entities/produto.dart';

// Provider do repositório
final produtoRepositoryProvider = Provider<ProdutoRepository>((ref) {
  return ProdutoRepository(getIt<AppDatabase>());
});



// Provider para lista de produtos
final produtosProvider = StateNotifierProvider<ProdutosNotifier, AsyncValue<List<ProdutoTableData>>>((ref) {
  return ProdutosNotifier(ref.read(produtoRepositoryProvider), ref);
});

// Provider para produtos ativos
final produtosAtivosProvider = StateNotifierProvider<ProdutosAtivosNotifier, AsyncValue<List<ProdutoTableData>>>((ref) {
  return ProdutosAtivosNotifier(ref.read(produtoRepositoryProvider));
});

// Provider para produtos com estoque baixo
final produtosEstoqueBaixoProvider = StateNotifierProvider<ProdutosEstoqueBaixoNotifier, AsyncValue<List<ProdutoTableData>>>((ref) {
  return ProdutosEstoqueBaixoNotifier(ref.read(produtoRepositoryProvider));
});

// Novos providers que retornam produtos com estoque calculado
final produtosComEstoqueProvider = FutureProvider<List<Produto>>((ref) async {
  final repository = ref.watch(produtoRepositoryProvider);
  return repository.buscarProdutosComEstoque();
});

final produtosAtivosComEstoqueProvider = FutureProvider<List<Produto>>((ref) async {
  final repository = ref.watch(produtoRepositoryProvider);
  return repository.buscarProdutosAtivosComEstoque();
});

final produtosEstoqueBaixoComEstoqueProvider = FutureProvider<List<Produto>>((ref) async {
  final repository = ref.watch(produtoRepositoryProvider);
  return repository.buscarProdutosEstoqueBaixoComEstoque();
});

final produtoPorIdComEstoqueProvider = FutureProvider.family<Produto?, int>((ref, id) async {
  final repository = ref.watch(produtoRepositoryProvider);
  return repository.buscarPorIdComEstoque(id);
});

// Provider para categorias
final categoriasProvider = StateNotifierProvider<CategoriasNotifier, AsyncValue<List<String>>>((ref) {
  return CategoriasNotifier(ref.read(produtoRepositoryProvider));
});

// Provider para busca de produtos
final buscaProdutosProvider = StateNotifierProvider<BuscaProdutosNotifier, AsyncValue<List<ProdutoTableData>>>((ref) {
  return BuscaProdutosNotifier(ref.read(produtoRepositoryProvider));
});

// Provider para produto selecionado
final produtoSelecionadoProvider = StateProvider<ProdutoTableData?>((ref) => null);

// Provider para filtro de categoria
final filtroCategoriaSelecionadaProvider = StateProvider<String?>((ref) => null);

// Provider para termo de busca
final termoBuscaProvider = StateProvider<String>((ref) => '');

// Notifier para gerenciar lista de produtos
class ProdutosNotifier extends StateNotifier<AsyncValue<List<ProdutoTableData>>> {
  final ProdutoRepository _repository;
  final Ref _ref;

  ProdutosNotifier(this._repository, this._ref) : super(const AsyncValue.loading()) {
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    try {
      state = const AsyncValue.loading();
      final produtos = await _repository.buscarTodos();
      state = AsyncValue.data(produtos);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<int> adicionarProduto(ProdutoTableCompanion produto) async {
    try {
      // Salvar produto localmente
      final localId = await _repository.criar(produto);
      
      // Recarregar lista local
      await carregarProdutos();
      
      return localId;
    } catch (error, stackTrace) {
      print('Erro ao adicionar produto: $error');
      print('StackTrace: $stackTrace');
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> atualizarProduto(int id, ProdutoTableCompanion produto) async {
    try {
      // Atualizar produto localmente
      await _repository.atualizar(id, produto);
      
      // Recarregar lista local
      await carregarProdutos();
    } catch (error, stackTrace) {
      print('Erro ao atualizar produto: $error');
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> deletarProduto(int id) async {
    try {
      await _repository.deletar(id);
      await carregarProdutos();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> atualizarQuantidade(int id, int novaQuantidade) async {
    try {
      await _repository.atualizarQuantidade(id, novaQuantidade);
      await carregarProdutos();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Notifier para produtos ativos
class ProdutosAtivosNotifier extends StateNotifier<AsyncValue<List<ProdutoTableData>>> {
  final ProdutoRepository _repository;

  ProdutosAtivosNotifier(this._repository) : super(const AsyncValue.loading()) {
    carregarProdutosAtivos();
  }

  Future<void> carregarProdutosAtivos() async {
    try {
      state = const AsyncValue.loading();
      final produtos = await _repository.buscarAtivos();
      state = AsyncValue.data(produtos);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Notifier para produtos com estoque baixo
class ProdutosEstoqueBaixoNotifier extends StateNotifier<AsyncValue<List<ProdutoTableData>>> {
  final ProdutoRepository _repository;

  ProdutosEstoqueBaixoNotifier(this._repository) : super(const AsyncValue.loading()) {
    carregarProdutosEstoqueBaixo();
  }

  Future<void> carregarProdutosEstoqueBaixo() async {
    try {
      state = const AsyncValue.loading();
      final produtos = await _repository.buscarEstoqueBaixo();
      state = AsyncValue.data(produtos);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Notifier para categorias
class CategoriasNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final ProdutoRepository _repository;

  CategoriasNotifier(this._repository) : super(const AsyncValue.loading()) {
    carregarCategorias();
  }

  Future<void> carregarCategorias() async {
    try {
      state = const AsyncValue.loading();
      final categorias = await _repository.buscarCategorias();
      state = AsyncValue.data(categorias);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Notifier para busca de produtos
class BuscaProdutosNotifier extends StateNotifier<AsyncValue<List<ProdutoTableData>>> {
  final ProdutoRepository _repository;

  BuscaProdutosNotifier(this._repository) : super(const AsyncValue.data([]));

  Future<void> buscarPorNome(String nome) async {
    if (nome.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    try {
      state = const AsyncValue.loading();
      final produtos = await _repository.buscarPorNome(nome);
      state = AsyncValue.data(produtos);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> buscarPorCategoria(String categoria) async {
    try {
      state = const AsyncValue.loading();
      final produtos = await _repository.buscarPorCategoria(categoria);
      state = AsyncValue.data(produtos);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<ProdutoTableData?> buscarPorCodigoBarras(String codigoBarras) async {
    try {
      return await _repository.buscarPorCodigoBarras(codigoBarras);
    } catch (error) {
      return null;
    }
  }

  Future<ProdutoTableData?> buscarPorQrCode(String qrCode) async {
    try {
      return await _repository.buscarPorQrCode(qrCode);
    } catch (error) {
      return null;
    }
  }

  void limparBusca() {
    state = const AsyncValue.data([]);
  }
}