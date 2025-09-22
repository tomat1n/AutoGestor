import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../providers/whatsapp_sales_provider.dart';
import '../../../pdv/domain/entities/venda.dart';

/// Página de demonstração para testar as funcionalidades de WhatsApp Sales
class WhatsAppSalesDemoPage extends StatefulWidget {
  const WhatsAppSalesDemoPage({super.key});

  @override
  State<WhatsAppSalesDemoPage> createState() => _WhatsAppSalesDemoPageState();
}

class _WhatsAppSalesDemoPageState extends State<WhatsAppSalesDemoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeClienteController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _nomeEmpresaController = TextEditingController(text: 'AutoGestor Demo');
  final _observacoesController = TextEditingController();

  @override
  void dispose() {
    _nomeClienteController.dispose();
    _telefoneController.dispose();
    _nomeEmpresaController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GetIt.instance<WhatsAppSalesProvider>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp Sales - Demo'),
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white,
        ),
        body: Consumer(
          builder: (context, WhatsAppSalesProvider provider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildClientForm(),
                    const SizedBox(height: 24),
                    _buildActionButtons(provider),
                    const SizedBox(height: 24),
                    _buildStatusSection(provider),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.chat,
              size: 48,
              color: Colors.green[700],
            ),
            const SizedBox(height: 8),
            Text(
              'Demonstração WhatsApp Sales',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Teste o envio de recibos e orçamentos via WhatsApp',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dados do Cliente',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nomeClienteController,
              decoration: const InputDecoration(
                labelText: 'Nome do Cliente',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome do cliente';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _telefoneController,
              decoration: const InputDecoration(
                labelText: 'Telefone (com DDD)',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
                hintText: 'Ex: 11999999999',
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o telefone';
                }
                final provider = Provider.of<WhatsAppSalesProvider>(context, listen: false);
                if (!provider.validarTelefone(value)) {
                  return 'Telefone inválido. Use formato: 11999999999';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nomeEmpresaController,
              decoration: const InputDecoration(
                labelText: 'Nome da Empresa',
                prefixIcon: Icon(Icons.business),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome da empresa';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _observacoesController,
              decoration: const InputDecoration(
                labelText: 'Observações (opcional)',
                prefixIcon: Icon(Icons.note),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(WhatsAppSalesProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ações Disponíveis',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: provider.isLoading ? null : () => _enviarReciboDemo(provider),
                    icon: const Icon(Icons.receipt),
                    label: const Text('Enviar Recibo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: provider.isLoading ? null : () => _enviarOrcamentoDemo(provider),
                    icon: const Icon(Icons.calculate),
                    label: const Text('Enviar Orçamento'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: provider.isLoading ? null : () => _enviarConfirmacaoDemo(provider),
                icon: const Icon(Icons.check_circle),
                label: const Text('Enviar Confirmação de Orçamento'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            if (provider.isLoading) ...[
              const SizedBox(height: 16),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection(WhatsAppSalesProvider provider) {
    if (provider.lastError == null && provider.lastSuccessMessage == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (provider.lastError != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  border: Border.all(color: Colors.red[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        provider.lastError!,
                        style: TextStyle(color: Colors.red[700]),
                      ),
                    ),
                  ],
                ),
              ),
            if (provider.lastSuccessMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  border: Border.all(color: Colors.green[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        provider.lastSuccessMessage!,
                        style: TextStyle(color: Colors.green[700]),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => provider.clearMessages(),
              child: const Text('Limpar Status'),
            ),
          ],
        ),
      ),
    );
  }

  void _enviarReciboDemo(WhatsAppSalesProvider provider) async {
    if (!_formKey.currentState!.validate()) return;

    // Criar venda de exemplo
    final venda = Venda(
      id: DateTime.now().millisecondsSinceEpoch,
      dataVenda: DateTime.now(),
      subtotal: 350.00,
      desconto: 0.0,
      total: 350.00,
      formaPagamento: 'Cartão de Crédito',
      observacoes: _observacoesController.text.isEmpty ? null : _observacoesController.text,
      nomeCliente: _nomeClienteController.text,
      criadoEm: DateTime.now(),
      atualizadoEm: DateTime.now(),
    );

    final sucesso = await provider.enviarReciboVenda(
      venda: venda,
      telefoneCliente: provider.formatarTelefone(_telefoneController.text),
      nomeEmpresa: _nomeEmpresaController.text,
      observacoes: _observacoesController.text.isEmpty ? null : _observacoesController.text,
    );

    if (sucesso && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recibo enviado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _enviarOrcamentoDemo(WhatsAppSalesProvider provider) async {
    if (!_formKey.currentState!.validate()) return;

    final sucesso = await provider.enviarOrcamentoServicos(
      telefone: provider.formatarTelefone(_telefoneController.text),
      nomeCliente: _nomeClienteController.text,
      servicos: [
        {
          'nome': 'Troca de óleo',
          'valor': 150.0,
        },
        {
          'nome': 'Filtro de ar',
          'valor': 80.0,
        },
      ],
      valorTotal: 230.0,
      observacoes: _observacoesController.text.isEmpty ? null : _observacoesController.text,
    );

    if (sucesso && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Orçamento enviado com sucesso!'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _enviarConfirmacaoDemo(WhatsAppSalesProvider provider) async {
    if (!_formKey.currentState!.validate()) return;

    final sucesso = await provider.enviarConfirmacaoOrcamento(
      telefone: provider.formatarTelefone(_telefoneController.text),
      nomeCliente: _nomeClienteController.text,
      numeroOrcamento: 'ORC-${DateTime.now().millisecondsSinceEpoch}',
      observacoes: _observacoesController.text.isEmpty ? null : _observacoesController.text,
    );

    if (sucesso && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Confirmação enviada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}