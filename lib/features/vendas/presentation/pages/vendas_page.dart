import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../pdv/presentation/providers/venda_provider.dart';
import '../../../pdv/domain/entities/venda.dart' as domain;
import '../../../whatsapp/presentation/providers/whatsapp_sales_provider.dart';
import '../../domain/entities/venda.dart';
import '../../../../core/di/service_locator.dart';

class VendasPage extends ConsumerStatefulWidget {
  const VendasPage({super.key});

  @override
  ConsumerState<VendasPage> createState() => _VendasPageState();
}

class _VendasPageState extends ConsumerState<VendasPage> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _itensVenda = [];
  double _totalVenda = 0.0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _adicionarItem(Map<String, dynamic> item) {
    setState(() {
      _itensVenda.add(item);
      _calcularTotal();
    });
  }

  void _removerItem(int index) {
    setState(() {
      _itensVenda.removeAt(index);
      _calcularTotal();
    });
  }

  void _calcularTotal() {
    _totalVenda = _itensVenda.fold(0.0, (total, item) {
      return total + (item['preco'] * item['quantidade']);
    });
  }

  void _finalizarVenda() {
    if (_itensVenda.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Adicione pelo menos um item para finalizar a venda'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Finalizar Venda'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total de itens: ${_itensVenda.length}'),
            const SizedBox(height: 8),
            Text(
              'Valor total: R\$ ${_totalVenda.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
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
            onPressed: () {
              Navigator.pop(context);
              _confirmarVenda();
            },
            child: const Text('Confirmar Venda'),
          ),
        ],
      ),
    );
  }

  void _confirmarVenda() async {
    try {
      // Criar objeto de venda
      final venda = domain.Venda(
        dataVenda: DateTime.now(),
        subtotal: _totalVenda,
        desconto: 0.0,
        total: _totalVenda,
        formaPagamento: 'Dinheiro', // TODO: Implementar seleção de forma de pagamento
        criadoEm: DateTime.now(),
        atualizadoEm: DateTime.now(),
      );

      // Salvar venda no banco de dados
       final vendaRepository = ref.read(vendaRepositoryProvider);
       final vendaId = await vendaRepository.criarVenda(
         itensCarrinho: [], // Implementar conversão dos itens se necessário
         desconto: 0.0,
         formaPagamento: 'Dinheiro',
         observacoes: 'Venda criada via sistema',
       );

      // Mostrar dialog para envio do recibo por WhatsApp
      _mostrarDialogEnvioRecibo(vendaId, venda);

      setState(() {
        _itensVenda.clear();
        _totalVenda = 0.0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Venda finalizada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao finalizar venda: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.add_shopping_cart),
              text: 'Nova Venda',
            ),
            Tab(
              icon: Icon(Icons.history),
              text: 'Histórico',
            ),
          ],
        ),
        actions: [
          if (_itensVenda.isNotEmpty && _tabController.index == 0)
            IconButton(
              onPressed: _finalizarVenda,
              icon: const Icon(Icons.check),
              tooltip: 'Finalizar Venda',
            ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNovaVenda(),
          _buildHistoricoVendas(),
        ],
      ),
    );
  }

  Widget _buildNovaVenda() {
    return Column(
        children: [
          // Resumo da venda
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Itens: ${_itensVenda.length}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total: R\$ ${_totalVenda.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (_itensVenda.isNotEmpty)
                  ElevatedButton(
                    onPressed: _finalizarVenda,
                    child: const Text('Finalizar'),
                  ),
              ],
            ),
          ),
          // Lista de itens
          Expanded(
            child: _itensVenda.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nenhum item adicionado',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Use o scanner no estoque para adicionar produtos',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _itensVenda.length,
                    itemBuilder: (context, index) {
                      final item = _itensVenda[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          title: Text(item['nome']),
                          subtitle: Text(
                            'Código: ${item['codigo'] ?? 'N/A'}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Qtd: ${item['quantidade']}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    'R\$ ${(item['preco'] * item['quantidade']).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: () => _removerItem(index),
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      );
  }

  Widget _buildHistoricoVendas() {
    final vendasAsync = ref.watch(todasVendasProvider);
    
    return vendasAsync.when(
      data: (vendas) {
        if (vendas.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'Nenhuma venda registrada',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: vendas.length,
          itemBuilder: (context, index) {
            final venda = vendas[index];
            return _buildVendaCard(venda);
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Erro ao carregar vendas: $error',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(todasVendasProvider),
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVendaCard(domain.Venda venda) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(
            '#${venda.id}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        title: Text(
          'Venda #${venda.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formatarDataVenda(venda.dataVenda),
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              'Total: R\$ ${venda.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 16,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetalheVenda('Subtotal', 'R\$ ${venda.subtotal.toStringAsFixed(2)}'),
                if (venda.desconto > 0)
                  _buildDetalheVenda('Desconto', 'R\$ ${venda.desconto.toStringAsFixed(2)}'),
                _buildDetalheVenda('Total', 'R\$ ${venda.total.toStringAsFixed(2)}'),
                _buildDetalheVenda('Forma de Pagamento', venda.formaPagamento),
                if (venda.observacoes != null && venda.observacoes!.isNotEmpty)
                  _buildDetalheVenda('Observações', venda.observacoes!),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                _buildItensVenda(venda.id!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetalheVenda(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(valor),
        ],
      ),
    );
  }

  Widget _buildItensVenda(int vendaId) {
    final itensAsync = ref.watch(itensVendaProvider(vendaId));
    
    return itensAsync.when(
      data: (itens) {
        if (itens.isEmpty) {
          return const Text(
            'Nenhum item encontrado',
            style: TextStyle(color: Colors.grey),
          );
        }
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Itens da Venda:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            ...itens.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Produto ID: ${item.produtoId}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    '${item.quantidade}x R\$ ${item.precoUnitario.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    'R\$ ${item.subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )),
          ],
        );
      },
      loading: () => const Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (error, stack) => Text(
        'Erro ao carregar itens: $error',
        style: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }

  String _formatarDataVenda(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year} às ${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}';
  }

  void _mostrarDialogEnvioRecibo(int vendaId, domain.Venda venda) {
    final TextEditingController telefoneController = TextEditingController();
    final TextEditingController nomeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enviar Recibo por WhatsApp'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Cliente',
                hintText: 'Digite o nome do cliente',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: telefoneController,
              decoration: const InputDecoration(
                labelText: 'Telefone (WhatsApp)',
                hintText: '(11) 99999-9999',
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Pular'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (telefoneController.text.isNotEmpty && nomeController.text.isNotEmpty) {
                Navigator.pop(context);
                await _enviarReciboPorWhatsApp(
                  vendaId,
                  venda,
                  telefoneController.text,
                  nomeController.text,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Preencha todos os campos'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  Future<void> _enviarReciboPorWhatsApp(
    int vendaId,
    domain.Venda venda,
    String telefone,
    String nomeCliente,
  ) async {
    try {
      final whatsappProvider = getIt<WhatsAppSalesProvider>();
      
      final sucesso = await whatsappProvider.enviarReciboVenda(
        venda: venda,
        telefoneCliente: telefone,
        nomeEmpresa: 'AutoGestor',
        observacoes: 'Recibo de venda',
      );

      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recibo enviado por WhatsApp com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao enviar recibo por WhatsApp'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar recibo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Método público para adicionar produtos vindos do scanner
  void adicionarProdutoDoScanner(Map<String, dynamic> produto) {
    final item = {
      'nome': produto['nome'],
      'codigo': produto['codigo'],
      'preco': produto['preco'] ?? 0.0,
      'quantidade': 1,
    };
    _adicionarItem(item);
  }
}