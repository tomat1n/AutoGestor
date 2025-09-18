import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/services/cart_service.dart';
import '../widgets/item_carrinho_card.dart';
import '../widgets/resumo_carrinho.dart';
import '../widgets/finalizar_venda_dialog.dart';
import '../../../whatsapp/presentation/providers/whatsapp_sales_provider.dart';
import '../../../../core/di/service_locator.dart';
import '../../../vendas/domain/entities/venda.dart';
import '../../../estoque/presentation/providers/estoque_provider.dart';

class CarrinhoPage extends ConsumerStatefulWidget {
  const CarrinhoPage({super.key});

  @override
  ConsumerState<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends ConsumerState<CarrinhoPage> {
  final TextEditingController _descontoController = TextEditingController();
  double _desconto = 0.0;

  @override
  void dispose() {
    _descontoController.dispose();
    super.dispose();
  }

  void _aplicarDesconto() {
    final desconto = double.tryParse(_descontoController.text) ?? 0.0;
    if (desconto >= 0 && desconto <= 100) {
      setState(() {
        _desconto = desconto;
      });
      ref.read(cartServiceProvider.notifier).setDesconto(_desconto);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Desconto deve estar entre 0% e 100%'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _finalizarVenda() async {
    final itens = ref.read(cartServiceProvider);
    if (itens.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Carrinho está vazio'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Verificar estoque antes de finalizar
    final cartService = ref.read(cartServiceProvider.notifier);
    final produtosSemEstoque = await cartService.getProdutosSemEstoque();
    
    if (produtosSemEstoque.isNotEmpty) {
      final nomes = produtosSemEstoque.map((p) => p.nome).join(', ');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produtos sem estoque suficiente: $nomes'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
      return;
    }

    // Mostrar dialog de finalização
    final resultado = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => FinalizarVendaDialog(
        subtotal: ref.read(subtotalProvider),
        desconto: _desconto,
        total: ref.read(subtotalProvider) * (1 - _desconto / 100),
      ),
    );

    if (resultado != null) {
      try {
        // Finalizar venda
        await cartService.finalizarVenda(
          formaPagamento: resultado['formaPagamento'],
          observacoes: resultado['observacoes'],
        );

        // Limpar carrinho e desconto
        cartService.limparCarrinho();
        setState(() {
          _desconto = 0.0;
          _descontoController.clear();
        });
        
        // Invalidar providers para atualizar o PDV com novos estoques
        ref.invalidate(produtosAtivosComEstoqueProvider);
        ref.invalidate(produtosComEstoqueProvider);
        ref.invalidate(produtosEstoqueBaixoComEstoqueProvider);

        // Mostrar sucesso e perguntar sobre envio por WhatsApp
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Venda finalizada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        // Mostrar dialog para envio de recibo por WhatsApp
        _mostrarDialogEnvioRecibo();

        context.go('/pdv');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao finalizar venda: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _mostrarDialogEnvioRecibo() {
    final TextEditingController telefoneController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enviar Recibo por WhatsApp'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Deseja enviar o recibo por WhatsApp?'),
            const SizedBox(height: 16),
            TextField(
              controller: telefoneController,
              decoration: const InputDecoration(
                labelText: 'Telefone do Cliente',
                hintText: '(11) 99999-9999',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Pular'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _enviarReciboPorWhatsApp(telefoneController.text);
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  Future<void> _enviarReciboPorWhatsApp(String telefone) async {
    if (telefone.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, informe o telefone do cliente'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final whatsappProvider = getIt<WhatsAppSalesProvider>();
      
      // Criar uma venda fictícia para o recibo
      final itensCarrinho = ref.read(cartServiceProvider);
      final valorTotal = ref.read(subtotalProvider) * (1 - _desconto / 100);
      
      // Criar uma venda básica para o recibo
       final venda = Venda(
         id: DateTime.now().millisecondsSinceEpoch,
         nomeCliente: 'Cliente',
         valorTotal: valorTotal,
         formaPagamento: 'Não informado',
         dataVenda: DateTime.now(),
         observacoes: 'Venda via carrinho',
       );
       
       final sucesso = await whatsappProvider.enviarReciboVenda(
         venda: venda,
         telefoneCliente: telefone,
         nomeEmpresa: 'AutoGestor',
         observacoes: 'Recibo de venda - Total: R\$ ${valorTotal.toStringAsFixed(2)}',
       );
      
      if (!sucesso) {
        throw Exception('Falha ao enviar recibo');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recibo enviado por WhatsApp com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar recibo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final itens = ref.watch(cartServiceProvider);
    final subtotal = ref.watch(subtotalProvider);
    final quantidadeTotal = ref.watch(quantidadeTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          if (itens.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Limpar Carrinho'),
                    content: const Text('Deseja remover todos os itens do carrinho?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(cartServiceProvider.notifier).limparCarrinho();
                          setState(() {
                            _desconto = 0.0;
                            _descontoController.clear();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('Limpar'),
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'Limpar carrinho',
            ),
        ],
      ),
      body: itens.isEmpty
          ? _buildCarrinhoVazio()
          : Column(
              children: [
                // Lista de itens
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: itens.length,
                    itemBuilder: (context, index) {
                      final item = itens[index];
                      return ItemCarrinhoCard(
                        item: item,
                        onQuantidadeChanged: (novaQuantidade) {
                          if (novaQuantidade <= 0) {
                            ref.read(cartServiceProvider.notifier)
                                .removerItem(item.produto.id!);
                          } else {
                            ref.read(cartServiceProvider.notifier)
                                .atualizarQuantidade(item.produto.id!, novaQuantidade);
                          }
                        },
                        onRemover: () {
                          ref.read(cartServiceProvider.notifier)
                              .removerItem(item.produto.id!);
                        },
                      );
                    },
                  ),
                ),
                
                // Área de desconto e resumo
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Campo de desconto
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _descontoController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Desconto (%)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.percent),
                              ),
                              onSubmitted: (_) => _aplicarDesconto(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _aplicarDesconto,
                            child: const Text('Aplicar'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Resumo do carrinho
                      ResumoCarrinho(
                        subtotal: subtotal,
                        desconto: _desconto,
                        quantidadeItens: quantidadeTotal,
                      ),
                      const SizedBox(height: 16),
                      
                      // Botão finalizar venda
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _finalizarVenda,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            'Finalizar Venda - R\$ ${(subtotal * (1 - _desconto / 100)).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCarrinhoVazio() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 24),
          Text(
            'Carrinho vazio',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Adicione produtos para começar uma venda',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => context.go('/pdv'),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Adicionar Produtos'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}