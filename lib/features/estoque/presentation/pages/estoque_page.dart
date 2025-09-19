import '../../../../core/utils/platform_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:io';
import '../../../../core/database/database.dart';
import '../../domain/entities/produto.dart';


import '../providers/estoque_provider.dart';
import 'produto_form_page.dart';
import 'scanner_estoque_page.dart';

class EstoquePage extends ConsumerStatefulWidget {
  const EstoquePage({super.key});

  @override
  ConsumerState<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends ConsumerState<EstoquePage> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  String? _categoriaSelecionada;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _abrirFormularioProduto([ProdutoTableData? produto]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProdutoFormPage(produto: produto),
      ),
    );
  }

  void _abrirFormularioProdutoComEntidade(Produto produto) {
    // Converter Produto para ProdutoTableData para compatibilidade
    final produtoTableData = ProdutoTableData(
      id: produto.id!,
      codigo: produto.codigo,
      nome: produto.nome,
      descricao: produto.descricao,
      precoCompra: produto.precoCompra,
      precoVenda: produto.precoVenda,
      estoqueMinimo: produto.estoqueMinimo,
      quantidade: produto.quantidade,
      unidade: produto.unidade,
      categoria: produto.categoria,
      codigoBarras: produto.codigoBarras,
      qrCode: produto.qrCode,
      imagemPath: produto.imagemPath,
      ativo: produto.ativo,
      createdAt: produto.createdAt,
      updatedAt: produto.updatedAt,
    );
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProdutoFormPage(produto: produtoTableData),
      ),
    );
  }

  void _abrirScannerVenda() {
    // Verificar se está rodando na web
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Scanner não disponível na versão web'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ScannerVendaPage(),
      ),
    );
  }

  void _abrirScannerEstoque() {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Scanner não disponível na versão web'),
        ),
      );
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScannerEstoquePage(
          onProdutoEncontrado: (produto) {
            Navigator.pop(context);
            _mostrarDialogoProdutoEncontrado(produto);
          },
        ),
      ),
    );
  }

  void _buscarProdutos(String termo) {
    if (termo.isEmpty) {
      ref.read(buscaProdutosProvider.notifier).limparBusca();
    } else {
      ref.read(buscaProdutosProvider.notifier).buscarPorNome(termo);
    }
  }

  void _filtrarPorCategoria(String? categoria) {
    setState(() {
      _categoriaSelecionada = categoria;
    });
    
    if (categoria != null) {
      ref.read(buscaProdutosProvider.notifier).buscarPorCategoria(categoria);
    } else {
      ref.read(buscaProdutosProvider.notifier).limparBusca();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Todos', icon: Icon(Icons.inventory_2)),
            Tab(text: 'Estoque Baixo', icon: Icon(Icons.warning)),
            Tab(text: 'Buscar', icon: Icon(Icons.search)),
            Tab(text: 'Fornecedores', icon: Icon(Icons.business)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: _abrirScannerVenda,
            tooltip: 'Scanner para Venda',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodosProdutos(),
          _buildEstoqueBaixo(),
          _buildBuscarProdutos(),
          _buildFornecedores(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormularioProduto(),
        tooltip: 'Adicionar Produto',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodosProdutos() {
    final produtosAsync = ref.watch(produtosAtivosComEstoqueProvider);
    
    return Column(
      children: [
        // Barra de ações com scanner
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _abrirScannerEstoque,
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text('Escanear Código'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Lista de produtos
        Expanded(
          child: produtosAsync.when(
            data: (produtos) {
              if (produtos.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inventory_2, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Nenhum produto cadastrado', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                );
              }
              
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(produtosAtivosComEstoqueProvider);
                },
                child: ListView.builder(
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    final produto = produtos[index];
                    return ProdutoCardComEstoque(
                      produto: produto,
                      onTap: () => _mostrarDetalhesProduto(produto),
                      onEdit: () => _abrirFormularioProdutoComEntidade(produto),
                      onDelete: () => _confirmarExclusaoProduto(produto),
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Erro: $error'),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(produtosAtivosComEstoqueProvider),
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEstoqueBaixo() {
    final produtosAsync = ref.watch(produtosEstoqueBaixoComEstoqueProvider);
    
    return produtosAsync.when(
      data: (produtos) {
        if (produtos.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 64, color: Colors.green),
                SizedBox(height: 16),
                Text('Todos os produtos estão com estoque adequado!', 
                     style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          );
        }
        
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(produtosEstoqueBaixoComEstoqueProvider);
          },
          child: ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return ProdutoCardComEstoque(
                produto: produto,
                onTap: () => _mostrarDetalhesProduto(produto),
                onEdit: () => _abrirFormularioProdutoComEntidade(produto),
                onDelete: () => _confirmarExclusaoProduto(produto),
                showWarning: true,
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Erro: $error'),
            ElevatedButton(
              onPressed: () => ref.invalidate(produtosEstoqueBaixoComEstoqueProvider),
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuscarProdutos() {
    final categoriasAsync = ref.watch(categoriasProvider);
    final buscaAsync = ref.watch(buscaProdutosProvider);
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Buscar produtos...',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _buscarProdutos('');
                          },
                        )
                      : null,
                ),
                onChanged: _buscarProdutos,
              ),
              const SizedBox(height: 8),
              categoriasAsync.when(
                data: (categorias) {
                  if (categorias.isEmpty) return const SizedBox.shrink();
                  
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterChip(
                          label: const Text('Todas'),
                          selected: _categoriaSelecionada == null,
                          onSelected: (selected) {
                            if (selected) _filtrarPorCategoria(null);
                          },
                        ),
                        const SizedBox(width: 8),
                        ...categorias.map((categoria) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(categoria),
                            selected: _categoriaSelecionada == categoria,
                            onSelected: (selected) {
                              _filtrarPorCategoria(selected ? categoria : null);
                            },
                          ),
                        )),
                      ],
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        Expanded(
          child: buscaAsync.when(
            data: (produtos) {
              if (produtos.isEmpty && _searchController.text.isNotEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Nenhum produto encontrado', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                );
              }
              
              if (produtos.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Digite para buscar produtos', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                );
              }
              
              return ListView.builder(
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  final produto = produtos[index];
                  return ProdutoCard(
                    produto: produto,
                    estoqueAtual: produto.quantidade,
                    onTap: () => _abrirFormularioProduto(produto),
                    onVenda: () => _mostrarDialogoVenda(produto),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Erro: $error'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _mostrarDialogoProdutoEncontrado(ProdutoTableData produto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Produto Encontrado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descrição:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(produto.nome),
            const SizedBox(height: 16),
            Text(
              'Código:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(produto.codigo ?? 'Não informado'),
            const SizedBox(height: 16),
            Text(
              'Valor:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'R\$ ${produto.precoVenda.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Estoque:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text('Estoque mínimo: ${produto.estoqueMinimo} ${produto.unidade}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDetalhesProduto(Produto produto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(produto.nome),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetalheItem('Código', produto.codigo),
              _buildDetalheItem('Descrição', produto.descricao ?? 'Não informado'),
              _buildDetalheItem('Categoria', produto.categoria ?? 'Não informado'),
              _buildDetalheItem('Preço de Compra', 'R\$ ${produto.precoCompra.toStringAsFixed(2)}'),
              _buildDetalheItem('Preço de Venda', 'R\$ ${produto.precoVenda.toStringAsFixed(2)}'),
              _buildDetalheItem('Estoque Atual', '${produto.estoqueAtual ?? 0} ${produto.unidade}'),
              _buildDetalheItem('Estoque Mínimo', '${produto.estoqueMinimo} ${produto.unidade}'),
              _buildDetalheItem('Unidade', produto.unidade),
              if (produto.codigoBarras != null)
                _buildDetalheItem('Código de Barras', produto.codigoBarras!),
              _buildDetalheItem('Status', produto.ativo ? 'Ativo' : 'Inativo'),
              _buildDetalheItem('Criado em', _formatarData(produto.createdAt)),
              _buildDetalheItem('Atualizado em', _formatarData(produto.updatedAt)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _abrirFormularioProdutoComEntidade(produto);
            },
            child: const Text('Editar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetalheItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year} ${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}';
  }

  void _confirmarExclusaoProduto(Produto produto) {
    final confirmacaoController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tem certeza que deseja excluir o produto "${produto.nome}"?'),
            const SizedBox(height: 16),
            const Text(
              'Esta ação não pode ser desfeita. Para confirmar, digite "excluir" no campo abaixo:',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmacaoController,
              decoration: const InputDecoration(
                labelText: 'Digite "excluir" para confirmar',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              if (confirmacaoController.text.toLowerCase() == 'excluir') {
                try {
                  await ref.read(produtoRepositoryProvider).deletar(produto.id!);
                  
                  // Atualizar automaticamente as listas
                  ref.invalidate(produtosAtivosComEstoqueProvider);
                  ref.invalidate(produtosEstoqueBaixoComEstoqueProvider);
                  
                  Navigator.pop(context);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Produto "${produto.nome}" excluído com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao excluir produto: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Digite "excluir" para confirmar a exclusão'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoVenda(ProdutoTableData produto) async {
    final estoqueAtual = produto.quantidade;
    
    if (!mounted) return;
    
    final quantidadeController = TextEditingController(text: '1');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Vender ${produto.nome}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
               children: [
                 Text('Estoque atual: $estoqueAtual ${produto.unidade}'),
                 if (estoqueAtual <= produto.estoqueMinimo) ...[
                   const SizedBox(width: 8),
                   Icon(
                     estoqueAtual <= 0 ? Icons.error : Icons.warning,
                     color: estoqueAtual <= 0 ? Colors.red : Colors.orange,
                     size: 16,
                   ),
                 ],
               ],
             ),
            const SizedBox(height: 16),
            TextField(
              controller: quantidadeController,
              decoration: const InputDecoration(
                labelText: 'Quantidade a vender',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final quantidade = int.tryParse(quantidadeController.text);
              if (quantidade != null && quantidade > 0 && quantidade <= estoqueAtual) {
                final sucesso = await ref.read(produtoRepositoryProvider).reduzirQuantidade(produto.id, quantidade);
                if (sucesso) {
                  ref.invalidate(produtosAtivosProvider);
                  ref.invalidate(produtosEstoqueBaixoProvider);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Venda realizada: $quantidade ${produto.unidade} de ${produto.nome}'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro ao realizar venda'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } else if (quantidade != null && quantidade > estoqueAtual) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Quantidade indisponível. Estoque atual: $estoqueAtual ${produto.unidade}'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Quantidade inválida'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Vender'),
          ),
        ],
      ),
    );
  }



  Widget _buildFornecedores() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.business, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Gerenciar Fornecedores',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Acesse a página completa de fornecedores',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.go('/estoque/fornecedores'),
            icon: const Icon(Icons.business),
            label: const Text('Ir para Fornecedores'),
          ),
        ],
      ),
    );
  }
}

class ProdutoCardComEstoque extends StatelessWidget {
  final Produto produto;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;
  final bool showWarning;

  const ProdutoCardComEstoque({
    super.key,
    required this.produto,
    required this.onTap,
    required this.onEdit,
    this.onDelete,
    this.showWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final estoqueAtual = produto.estoqueAtual ?? 0;
    final isEstoqueBaixo = produto.estoqueBaixo;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: showWarning || isEstoqueBaixo ? Colors.orange : Colors.blue,
          child: produto.imagemPath != null
              ? ClipOval(
                  child: Image.file(
                    File(produto.imagemPath!),
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.inventory_2,
                        color: Colors.white,
                      );
                    },
                  ),
                )
              : const Icon(
                  Icons.inventory_2,
                  color: Colors.white,
                ),
        ),
        title: Text(
          produto.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Código: ${produto.codigo}'),
            Text('Preço: R\$ ${produto.precoVenda.toStringAsFixed(2)}'),
            Row(
              children: [
                Text('Estoque: $estoqueAtual ${produto.unidade}'),
                if (isEstoqueBaixo) ...[
                  const SizedBox(width: 8),
                  Icon(
                    estoqueAtual <= 0 ? Icons.error : Icons.warning,
                    color: estoqueAtual <= 0 ? Colors.red : Colors.orange,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    estoqueAtual <= 0 ? 'SEM ESTOQUE' : 'ESTOQUE BAIXO',
                    style: TextStyle(
                      color: estoqueAtual <= 0 ? Colors.red : Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
            if (produto.categoria != null)
              Text('Categoria: ${produto.categoria}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
              tooltip: 'Editar',
            ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
                tooltip: 'Excluir',
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class ProdutoCard extends StatelessWidget {
  final ProdutoTableData produto;
  final int estoqueAtual;
  final VoidCallback onTap;
  final VoidCallback onVenda;
  final bool showWarning;

  const ProdutoCard({
    super.key,
    required this.produto,
    required this.estoqueAtual,
    required this.onTap,
    required this.onVenda,
    this.showWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final isEstoqueBaixo = estoqueAtual <= produto.estoqueMinimo;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: showWarning || isEstoqueBaixo ? Colors.orange : Colors.blue,
          child: produto.imagemPath != null && !kIsWeb
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const Icon(
                    Icons.image,
                    size: 40,
                    color: Colors.grey,
                  ),
                )
              : const Icon(
                  Icons.inventory_2,
                  size: 40,
                  color: Colors.grey,
                ),
        ),
        title: Text(
          produto.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Código: ${produto.codigo}'),
            Text('Preço: R\$ ${produto.precoVenda.toStringAsFixed(2)}'),
            Row(
              children: [
                Text('Estoque: $estoqueAtual ${produto.unidade}'),
                if (estoqueAtual <= produto.estoqueMinimo) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: estoqueAtual <= 0 ? Colors.red.shade100 : Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: estoqueAtual <= 0 ? Colors.red.shade300 : Colors.orange.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          estoqueAtual <= 0 ? Icons.error_outline : Icons.warning_outlined,
                          color: estoqueAtual <= 0 ? Colors.red.shade700 : Colors.orange.shade700,
                          size: 12,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          estoqueAtual <= 0 ? 'Sem estoque' : 'Baixo',
                          style: TextStyle(
                            color: estoqueAtual <= 0 ? Colors.red.shade700 : Colors.orange.shade700,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            if (produto.categoria != null)
              Text('Categoria: ${produto.categoria}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.point_of_sale),
              onPressed: onVenda, // TODO: Validar estoque calculado
              tooltip: 'Vender',
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onTap,
              tooltip: 'Editar',
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class ScannerVendaPage extends ConsumerStatefulWidget {
  const ScannerVendaPage({super.key});

  @override
  ConsumerState<ScannerVendaPage> createState() => _ScannerVendaPageState();
}

class _ScannerVendaPageState extends ConsumerState<ScannerVendaPage> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner para Venda'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: _foundBarcode,
      ),
    );
  }

  void _foundBarcode(BarcodeCapture capture) async {
    if (!_screenOpened && capture.barcodes.isNotEmpty) {
      final String code = capture.barcodes.first.rawValue ?? "";
      _screenOpened = true;
      
      // Buscar produto por código de barras ou QR code
      ProdutoTableData? produto = await ref.read(buscaProdutosProvider.notifier).buscarPorCodigoBarras(code);
      produto ??= await ref.read(buscaProdutosProvider.notifier).buscarPorQrCode(code);
      
      if (produto != null) {
        Navigator.pop(context);
        _mostrarDialogoVendaRapida(produto);
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produto não encontrado'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _mostrarDialogoVendaRapida(ProdutoTableData produto) {
    final quantidadeController = TextEditingController(text: '1');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Venda Rápida'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Produto: ${produto.nome}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text('Preço: R\$ 0,00'), // TODO: Adicionar campo preço na tabela
            Text('Estoque: 0 ${produto.unidade}'), // TODO: Calcular estoque por movimentações
            const SizedBox(height: 16),
            TextField(
              controller: quantidadeController,
              decoration: const InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final quantidade = int.tryParse(quantidadeController.text);
              if (quantidade != null && quantidade > 0) { // TODO: Validar contra estoque calculado
                final sucesso = await ref.read(produtoRepositoryProvider).reduzirQuantidade(produto.id, quantidade);
                if (sucesso) {
                  ref.invalidate(produtosAtivosProvider);
                  ref.invalidate(produtosEstoqueBaixoProvider);
                  Navigator.pop(context);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Venda realizada!\n$quantidade ${produto.unidade}'), // TODO: Adicionar cálculo de preço
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 4),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro ao realizar venda'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Quantidade inválida'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Confirmar Venda'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}