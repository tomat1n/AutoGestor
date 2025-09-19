import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/whatsapp_sales_provider.dart';
import '../providers/whatsapp_sales_stats_provider.dart';
import '../../../vendas/domain/entities/venda.dart' as VendasVenda;
import '../../../../core/di/service_locator.dart';

class WhatsAppDemoPage extends ConsumerStatefulWidget {
  const WhatsAppDemoPage({super.key});

  @override
  ConsumerState<WhatsAppDemoPage> createState() => _WhatsAppDemoPageState();
}

class _WhatsAppDemoPageState extends ConsumerState<WhatsAppDemoPage> {
  final _telefoneController = TextEditingController();
  final _nomeClienteController = TextEditingController();
  final _valorController = TextEditingController();
  final _observacoesController = TextEditingController();
  
  bool _isLoading = false;

  @override
  void dispose() {
    _telefoneController.dispose();
    _nomeClienteController.dispose();
    _valorController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  Future<void> _testarEnvioRecibo() async {
    if (_telefoneController.text.isEmpty || _nomeClienteController.text.isEmpty) {
      _mostrarErro('Preencha telefone e nome do cliente');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final whatsappProvider = getIt<WhatsAppSalesProvider>();
      
      // Create a demo Venda object
      final vendaDemo = VendasVenda.Venda(
        id: DateTime.now().millisecondsSinceEpoch,
        nomeCliente: _nomeClienteController.text,
        valorTotal: double.tryParse(_valorController.text) ?? 100.0,
        formaPagamento: 'Dinheiro',
        dataVenda: DateTime.now(),
        observacoes: 'Venda de demonstração',
      );
      
      await whatsappProvider.enviarRecibo(
        venda: vendaDemo,
        telefoneCliente: _telefoneController.text,
        nomeEmpresa: 'AutoGestor Demo',
        observacoes: 'Recibo de demonstração',
      );

      _mostrarSucesso('Recibo enviado com sucesso!');
    } catch (e) {
      _mostrarErro('Erro ao enviar recibo: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _testarEnvioOrcamento() async {
    if (_telefoneController.text.isEmpty || _nomeClienteController.text.isEmpty) {
      _mostrarErro('Preencha telefone e nome do cliente');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final whatsappProvider = getIt<WhatsAppSalesProvider>();
      
      await whatsappProvider.enviarOrcamento(
        telefoneCliente: _telefoneController.text,
        nomeCliente: _nomeClienteController.text,
        servicos: [
          {
            'nome': 'Serviço de Teste 1',
            'descricao': 'Descrição do serviço 1',
            'valor': 150.0,
            'duracao': '2 horas',
          },
          {
            'nome': 'Serviço de Teste 2',
            'descricao': 'Descrição do serviço 2',
            'valor': 200.0,
            'duracao': '3 horas',
          },
        ],
        nomeEmpresa: 'AutoGestor Demo',
        observacoes: _observacoesController.text,
      );

      _mostrarSucesso('Orçamento enviado com sucesso!');
    } catch (e) {
      _mostrarErro('Erro ao enviar orçamento: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _testarConfirmacaoOrcamento() async {
    if (_telefoneController.text.isEmpty || _nomeClienteController.text.isEmpty) {
      _mostrarErro('Preencha telefone e nome do cliente');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final whatsappProvider = getIt<WhatsAppSalesProvider>();
      
      await whatsappProvider.confirmarOrcamento(
        numeroOrcamento: 'ORC-${DateTime.now().millisecondsSinceEpoch}',
        telefone: _telefoneController.text,
        orcamentoId: 'ORC-${DateTime.now().millisecondsSinceEpoch}',
        nomeCliente: _nomeClienteController.text,
        telefoneCliente: _telefoneController.text,
        nomeEmpresa: 'AutoGestor Demo',
        observacoes: 'Orçamento de demonstração',
      );

      _mostrarSucesso('Confirmação de orçamento enviada!');
    } catch (e) {
      _mostrarErro('Erro ao enviar confirmação: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _mostrarSucesso(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste WhatsApp'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campos de entrada
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dados do Cliente',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _telefoneController,
                      decoration: const InputDecoration(
                        labelText: 'Telefone',
                        hintText: '(11) 99999-9999',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nomeClienteController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Cliente',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _valorController,
                      decoration: const InputDecoration(
                        labelText: 'Valor Total',
                        hintText: '100.00',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _observacoesController,
                      decoration: const InputDecoration(
                        labelText: 'Observações (opcional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.note),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Botões de teste
            const Text(
              'Testes de Envio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _testarEnvioRecibo,
              icon: const Icon(Icons.receipt),
              label: const Text('Testar Envio de Recibo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _testarEnvioOrcamento,
              icon: const Icon(Icons.description),
              label: const Text('Testar Envio de Orçamento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _testarConfirmacaoOrcamento,
              icon: const Icon(Icons.check_circle),
              label: const Text('Testar Confirmação de Orçamento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
            
            if (_isLoading) ...[
              const SizedBox(height: 24),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
            
            const Spacer(),
            
            // Estatísticas
            Consumer(
              builder: (context, ref, child) {
                final stats = ref.watch(whatsappSalesStatsProvider);
                
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Estatísticas de Envio',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Recibos enviados: ${stats.recibosSucesso}'),
                        Text('Orçamentos enviados: ${stats.orcamentosSucesso}'),
                        Text('Confirmações enviadas: ${stats.confirmacoesSucesso}'),
                        Text('Erros: ${stats.erros}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}