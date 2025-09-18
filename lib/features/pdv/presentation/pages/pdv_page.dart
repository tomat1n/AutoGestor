import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:go_router/go_router.dart';
import '../../../estoque/domain/entities/produto.dart';
import '../../../estoque/presentation/providers/estoque_provider.dart';
import '../../domain/services/cart_service.dart';
import '../widgets/produto_card.dart';
import '../widgets/carrinho_fab.dart';

class PdvPage extends ConsumerStatefulWidget {
  const PdvPage({super.key});

  @override
  ConsumerState<PdvPage> createState() => _PdvPageState();
}

class _PdvPageState extends ConsumerState<PdvPage> {
  final _searchController = TextEditingController();
  final _quantidadeController = TextEditingController(text: '1');
  Produto? _produtoSelecionado;
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  Future<void> _scanBarcode() async {
    try {
      setState(() => _isLoading = true);
      
      final result = await BarcodeScanner.scan();
      
      if (result.type == ResultType.Cancelled) {
        setState(() => _isLoading = false);
        return;
      }
      
      final codigo = result.rawContent;
      
      if (mounted) {
        final produtosAsync = ref.read(produtosAtivosComEstoqueProvider);
        
        produtosAsync.whenData((produtos) {
          try {
            final produto = produtos.firstWhere(
              (p) => p.codigoBarras == codigo || p.qrCode == codigo,
              orElse: () => throw Exception('Produto não encontrado'),
            );
            
            setState(() {
              _produtoSelecionado = produto;
              _searchController.text = produto.nome;
            });
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Produto não encontrado: $codigo'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao escanear: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _processarCodigoEscaneado(String codigo) async {
    try {
      final produtosAsync = ref.read(produtosAtivosComEstoqueProvider);
      
      produtosAsync.when(
        loading: () {},
        error: (error, stack) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Erro ao carregar produtos: $error'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        data: (produtos) {
          try {
            final produto = produtos.firstWhere(
              (p) => p.codigoBarras == codigo || p.qrCode == codigo,
              orElse: () => throw Exception('Produto não encontrado'),
            );
            
            setState(() {
              _produtoSelecionado = produto;
              _searchController.text = produto.nome;
            });
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Produto não encontrado: $codigo'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _buscarProdutoPorNome(String nome) {
    if (nome.isEmpty) {
      setState(() => _produtoSelecionado = null);
      return;
    }
    
    // Usar ref.read() para obter o valor atual do provider
    final produtosAsync = ref.read(produtosAtivosComEstoqueProvider);
    
    produtosAsync.whenData((produtos) {
      try {
        final produto = produtos.firstWhere(
          (p) => p.nome.toLowerCase().contains(nome.toLowerCase()),
          orElse: () => throw Exception('Produto não encontrado'),
        );
        
        setState(() => _produtoSelecionado = produto);
      } catch (e) {
        setState(() => _produtoSelecionado = null);
      }
    });
  }

  void _adicionarAoCarrinho() {
    if (_produtoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione um produto primeiro'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    final quantidade = int.tryParse(_quantidadeController.text) ?? 1;
    
    if (quantidade <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quantidade deve ser maior que zero'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    try {
      ref.read(cartServiceProvider.notifier).adicionarItem(
        _produtoSelecionado!,
        quantidade,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_produtoSelecionado!.nome} adicionado ao carrinho'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );
      
      // Limpar seleção
      setState(() {
        _produtoSelecionado = null;
        _searchController.clear();
        _quantidadeController.text = '1';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quantidadeCarrinho = ref.watch(quantidadeTotalProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDV - Ponto de Venda'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.go('/pdv/historico'),
            tooltip: 'Histórico de Vendas',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Scanner e busca
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              labelText: 'Buscar produto',
                              hintText: 'Digite o nome do produto',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: _buscarProdutoPorNome,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : _scanBarcode,
                          icon: _isLoading 
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.qr_code_scanner),
                          label: const Text('Scanner'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _quantidadeController,
                            decoration: const InputDecoration(
                              labelText: 'Quantidade',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: _produtoSelecionado != null ? _adicionarAoCarrinho : null,
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Adicionar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Produto selecionado
            if (_produtoSelecionado != null) ...[
              const Text(
                'Produto Selecionado:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ProdutoCard(produto: _produtoSelecionado!),
              const SizedBox(height: 16),
            ],
            
            // Lista de produtos recentes ou sugestões
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Produtos Disponíveis',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, child) {
                            final produtosAsync = ref.watch(produtosAtivosComEstoqueProvider);
                            
                            return produtosAsync.when(
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              error: (error, stack) => Center(
                                child: Text('Erro: $error'),
                              ),
                              data: (produtos) {
                                if (produtos.isEmpty) {
                                  return const Center(
                                    child: Text('Nenhum produto cadastrado'),
                                  );
                                }
                                
                                // Filtrar produtos com estoque
                                final produtosComEstoque = produtos
                                    .where((p) => (p.estoqueAtual ?? 0) > 0)
                                    .take(10)
                                    .toList();
                            
                                return ListView.builder(
                                  itemCount: produtosComEstoque.length,
                                  itemBuilder: (context, index) {
                                    final produto = produtosComEstoque[index];
                                    return ListTile(
                                      leading: CircleAvatar(
                                        child: Text(produto.nome[0].toUpperCase()),
                                      ),
                                      title: Text(produto.nome),
                                      subtitle: Text(
                                        'Estoque: ${produto.estoqueAtual} | '
                                        'Preço: R\$ ${produto.precoVenda.toStringAsFixed(2) ?? '0,00'}',
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.add_circle),
                                        onPressed: () {
                                          setState(() {
                                            _produtoSelecionado = produto;
                                            _searchController.text = produto.nome;
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: quantidadeCarrinho > 0 
          ? CarrinhoFab(quantidadeItens: quantidadeCarrinho)
          : null,
    );
  }
}