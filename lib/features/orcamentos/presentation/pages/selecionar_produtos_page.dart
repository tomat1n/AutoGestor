import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../estoque/domain/entities/produto.dart';
import '../../../estoque/presentation/providers/estoque_provider.dart';

class SelecionarProdutosPage extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>> produtosSelecionados;

  const SelecionarProdutosPage({
    super.key,
    required this.produtosSelecionados,
  });

  @override
  ConsumerState<SelecionarProdutosPage> createState() => _SelecionarProdutosPageState();
}

class _SelecionarProdutosPageState extends ConsumerState<SelecionarProdutosPage> {
  List<Produto> _produtos = [];
  List<Map<String, dynamic>> _produtosSelecionados = [];
  String _searchQuery = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _produtosSelecionados = List.from(widget.produtosSelecionados);
    _carregarProdutos();
  }

  void _carregarProdutos() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final produtosAsync = ref.read(produtosAtivosComEstoqueProvider);
      produtosAsync.when(
        data: (produtos) {
          setState(() {
            _produtos = produtos;
            _isLoading = false;
          });
        },
        loading: () {
          setState(() {
            _isLoading = true;
          });
        },
        error: (error, stack) {
          setState(() {
            _isLoading = false;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro ao carregar produtos: $error')),
            );
          }
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar produtos: $e')),
        );
      }
    }
  }

  List<Produto> get _produtosFiltrados {
    if (_searchQuery.isEmpty) {
      return _produtos;
    }
    return _produtos.where((produto) {
      return produto.nome.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (produto.descricao?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          (produto.codigo.toLowerCase().contains(_searchQuery.toLowerCase()));
    }).toList();
  }

  bool _isProdutoSelecionado(Produto produto) {
    return _produtosSelecionados.any((item) => item['produto'].id == produto.id);
  }

  void _toggleProduto(Produto produto) {
    setState(() {
      final index = _produtosSelecionados.indexWhere((item) => item['produto'].id == produto.id);
      if (index >= 0) {
        _produtosSelecionados.removeAt(index);
      } else {
        _produtosSelecionados.add({
          'produto': produto,
          'quantidade': 1,
          'valor': produto.precoVenda,
        });
      }
    });
  }

  void _alterarQuantidade(Produto produto, int novaQuantidade) {
    if (novaQuantidade <= 0) {
      _toggleProduto(produto);
      return;
    }

    setState(() {
      final index = _produtosSelecionados.indexWhere((item) => item['produto'].id == produto.id);
      if (index >= 0) {
        _produtosSelecionados[index]['quantidade'] = novaQuantidade;
      }
    });
  }

  void _alterarValor(Produto produto, double novoValor) {
    setState(() {
      final index = _produtosSelecionados.indexWhere((item) => item['produto'].id == produto.id);
      if (index >= 0) {
        _produtosSelecionados[index]['valor'] = novoValor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Produtos/Peças'),
        actions: [
          TextButton(
            onPressed: _produtosSelecionados.isEmpty
                ? null
                : () {
                    Navigator.of(context).pop(_produtosSelecionados);
                  },
            child: Text(
              'Confirmar (${_produtosSelecionados.length})',
              style: TextStyle(
                color: _produtosSelecionados.isEmpty
                    ? Colors.grey
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de pesquisa
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Pesquisar produtos...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Lista de produtos
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _produtosFiltrados.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhum produto encontrado',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _produtosFiltrados.length,
                        itemBuilder: (context, index) {
                          final produto = _produtosFiltrados[index];
                          final isSelecionado = _isProdutoSelecionado(produto);
                          final itemSelecionado = _produtosSelecionados
                              .firstWhere(
                                (item) => item['produto'].id == produto.id,
                                orElse: () => {'quantidade': 1, 'valor': produto.precoVenda},
                              );

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: isSelecionado
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey[300],
                                child: Icon(
                                  isSelecionado ? Icons.check : Icons.inventory,
                                  color: isSelecionado ? Colors.white : Colors.grey[600],
                                ),
                              ),
                              title: Text(
                                produto.nome,
                                style: TextStyle(
                                  fontWeight: isSelecionado
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (produto.descricao != null)
                                    Text(produto.descricao!),
                                  Text(
                                    'Código: ${produto.codigo} | Estoque: ${produto.estoqueAtual ?? 0}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    'R\$ ${produto.precoVenda.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: isSelecionado
                                  ? SizedBox(
                                      width: 120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () => _alterarQuantidade(
                                              produto,
                                              itemSelecionado['quantidade'] - 1,
                                            ),
                                          ),
                                          Text(
                                            '${itemSelecionado['quantidade']}',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () => _alterarQuantidade(
                                              produto,
                                              itemSelecionado['quantidade'] + 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : null,
                              onTap: () => _toggleProduto(produto),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}