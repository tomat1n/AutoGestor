import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/item_carrinho.dart';
import '../entities/venda.dart';
import '../../../estoque/domain/entities/produto.dart';
import '../../data/repositories/venda_repository.dart';

class CartService extends StateNotifier<List<ItemCarrinho>> {
  CartService() : super([]);

  double _desconto = 0.0;
  double get desconto => _desconto;
  
  VendaRepository? _vendaRepository;
  
  VendaRepository _getRepository() {
    _vendaRepository ??= VendaRepository();
    return _vendaRepository!;
  }

  // Adicionar item ao carrinho
  void adicionarItem(Produto produto, int quantidade) {
    if (quantidade <= 0) return;
    
    // Verificar se o produto já está no carrinho
    final index = state.indexWhere((item) => item.produto.id == produto.id);
    
    if (index >= 0) {
      // Produto já existe, atualizar quantidade
      final item = state[index];
      final novaQuantidade = item.quantidade + quantidade;
      
      // Verificar estoque disponível
      if (novaQuantidade > (produto.estoqueAtual ?? 0)) {
        throw Exception('Estoque insuficiente. Disponível: ${produto.estoqueAtual ?? 0}');
      }
      
      final novoItem = item.copyWith(quantidade: novaQuantidade);
      state = [
        ...state.sublist(0, index),
        novoItem,
        ...state.sublist(index + 1),
      ];
    } else {
      // Novo produto
      if (quantidade > (produto.estoqueAtual ?? 0)) {
        throw Exception('Estoque insuficiente. Disponível: ${produto.estoqueAtual ?? 0}');
      }
      
      final novoItem = ItemCarrinho(
        produto: produto,
        quantidade: quantidade,
        precoUnitario: produto.precoVenda ?? 0.0,
      );
      
      state = [...state, novoItem];
    }
  }

  // Atualizar quantidade de um item
  void atualizarQuantidade(int produtoId, int novaQuantidade) {
    if (novaQuantidade <= 0) {
      removerItem(produtoId);
      return;
    }
    
    final index = state.indexWhere((item) => item.produto.id == produtoId);
    if (index >= 0) {
      final item = state[index];
      
      // Verificar estoque disponível
      if (novaQuantidade > (item.produto.estoqueAtual ?? 0)) {
        throw Exception('Estoque insuficiente. Disponível: ${item.produto.estoqueAtual}');
      }
      
      final novoItem = item.copyWith(quantidade: novaQuantidade);
      state = [
        ...state.sublist(0, index),
        novoItem,
        ...state.sublist(index + 1),
      ];
    }
  }

  // Remover item do carrinho
  void removerItem(int produtoId) {
    state = state.where((item) => item.produto.id != produtoId).toList();
  }

  // Limpar carrinho
  void limparCarrinho() {
    state = [];
  }

  // Calcular subtotal
  double get subtotal {
    return state.fold(0.0, (total, item) => total + item.subtotal);
  }

  // Calcular total com desconto
  double calcularTotal(double desconto) {
    final sub = subtotal;
    return sub - desconto;
  }

  // Validar se há itens no carrinho
  bool get temItens => state.isNotEmpty;

  // Obter quantidade total de itens
  int get quantidadeTotal {
    return state.fold(0, (total, item) => total + item.quantidade);
  }

  // Validar estoque para todos os itens
  bool validarEstoque() {
    for (final item in state) {
      if (item.quantidade > (item.produto.estoqueAtual ?? 0)) {
        return false;
      }
    }
    return true;
  }

  // Obter lista de produtos com estoque insuficiente
  List<String> obterProdutosComEstoqueInsuficiente() {
    final produtosInsuficientes = <String>[];
    
    for (final item in state) {
      if (item.quantidade > (item.produto.estoqueAtual ?? 0)) {
        produtosInsuficientes.add(
          '${item.produto.nome} (Solicitado: ${item.quantidade}, Disponível: ${item.produto.estoqueAtual ?? 0})'
        );
      }
    }
    
    return produtosInsuficientes;
  }
  
  // Validar estoque antes de finalizar venda
  Future<List<Produto>> getProdutosSemEstoque() async {
    final produtosSemEstoque = <Produto>[];
    
    for (final item in state) {
      if ((item.produto.estoqueAtual ?? 0) < item.quantidade) {
        produtosSemEstoque.add(item.produto);
      }
    }
    
    return produtosSemEstoque;
  }
  
  // Finalizar venda
  Future<Venda> finalizarVenda({
    required String formaPagamento,
    String? observacoes,
  }) async {
    if (state.isEmpty) {
      throw Exception('Carrinho está vazio');
    }
    
    final repository = _getRepository();
    
    final subtotalValue = subtotal;
    final valorDesconto = subtotalValue * (_desconto / 100);
    final total = subtotalValue - valorDesconto;
    
    final vendaId = await repository.criarVenda(
      itensCarrinho: state,
      desconto: _desconto,
      formaPagamento: formaPagamento,
      observacoes: observacoes,
    );
    
    // Criar e retornar a entidade Venda
    final venda = Venda(
      id: vendaId,
      dataVenda: DateTime.now(),
      subtotal: subtotalValue,
      desconto: _desconto,
      total: total,
      formaPagamento: formaPagamento,
      observacoes: observacoes,
      criadoEm: DateTime.now(),
      atualizadoEm: DateTime.now(),
    );
    
    return venda;
  }
  
  // Definir desconto
  void setDesconto(double novoDesconto) {
    _desconto = novoDesconto.clamp(0.0, 100.0);
  }
}

// Provider do CartService
final cartServiceProvider = StateNotifierProvider<CartService, List<ItemCarrinho>>(
  (ref) => CartService(),
);

// Provider para subtotal
final subtotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartServiceProvider);
  return cart.fold(0.0, (total, item) => total + item.subtotal);
});

// Provider para quantidade total
final quantidadeTotalProvider = Provider<int>((ref) {
  final cart = ref.watch(cartServiceProvider);
  return cart.fold(0, (total, item) => total + item.quantidade);
});