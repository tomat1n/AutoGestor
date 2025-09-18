import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/servico.dart';
import '../providers/servicos_provider.dart';
import '../../../whatsapp/presentation/providers/whatsapp_sales_provider.dart';
import '../../../whatsapp/domain/entities/orcamento_servicos.dart';
import '../../../../core/di/service_locator.dart';

class OrcamentoServicosPage extends ConsumerStatefulWidget {
  const OrcamentoServicosPage({super.key});

  @override
  ConsumerState<OrcamentoServicosPage> createState() => _OrcamentoServicosPageState();
}

class _OrcamentoServicosPageState extends ConsumerState<OrcamentoServicosPage> {
  final List<Map<String, dynamic>> _servicosSelecionados = [];
  final TextEditingController _nomeClienteController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _observacoesController = TextEditingController();
  double _totalOrcamento = 0.0;
  double _desconto = 0.0;

  @override
  void dispose() {
    _nomeClienteController.dispose();
    _telefoneController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  void _adicionarServico(Servico servico) {
    setState(() {
      _servicosSelecionados.add({
        'servico': servico,
        'quantidade': 1,
        'valor': servico.valor,
      });
      _calcularTotal();
    });
  }

  void _removerServico(int index) {
    setState(() {
      _servicosSelecionados.removeAt(index);
      _calcularTotal();
    });
  }

  void _alterarQuantidade(int index, int novaQuantidade) {
    if (novaQuantidade > 0) {
      setState(() {
        _servicosSelecionados[index]['quantidade'] = novaQuantidade;
        _calcularTotal();
      });
    }
  }

  void _calcularTotal() {
    double subtotal = _servicosSelecionados.fold(0.0, (total, item) {
      return total + (item['valor'] * item['quantidade']);
    });
    _totalOrcamento = subtotal - _desconto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orçamento de Serviços'),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _servicosSelecionados.isNotEmpty ? _enviarOrcamento : null,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildDadosCliente(),
          _buildResumoOrcamento(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildListaServicos(),
                ),
                Expanded(
                  flex: 1,
                  child: _buildServicosSelecionados(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDadosCliente() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _nomeClienteController,
              decoration: const InputDecoration(
                labelText: 'Nome do Cliente',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: _telefoneController,
              decoration: const InputDecoration(
                labelText: 'Telefone (WhatsApp)',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
                hintText: '(11) 99999-9999',
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumoOrcamento() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Serviços: ${_servicosSelecionados.length}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Total: R\$ ${_totalOrcamento.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Desconto',
                    prefixText: 'R\$ ',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _desconto = double.tryParse(value) ?? 0.0;
                      _calcularTotal();
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _servicosSelecionados.isNotEmpty ? _enviarOrcamento : null,
                child: const Text('Enviar Orçamento'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListaServicos() {
    final servicosAsync = ref.watch(servicosProvider);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            child: Text(
              'Serviços Disponíveis',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: servicosAsync.when(
              data: (servicos) {
                final servicosAtivos = servicos.where((s) => s.ativo).toList();
                
                if (servicosAtivos.isEmpty) {
                  return const Center(
                    child: Text('Nenhum serviço ativo encontrado'),
                  );
                }

                return ListView.builder(
                  itemCount: servicosAtivos.length,
                  itemBuilder: (context, index) {
                    final servico = servicosAtivos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: ListTile(
                        title: Text(servico.nome),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (servico.descricao != null)
                              Text(servico.descricao!),
                            Text(
                              'R\$ ${servico.valor.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            if (servico.duracaoMinutos != null)
                              Text(
                                'Duração: ${servico.duracaoMinutos} min',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.add_circle, color: Colors.green),
                          onPressed: () => _adicionarServico(servico),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Erro ao carregar serviços: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicosSelecionados() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
          ),
          child: Text(
            'Serviços Selecionados',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: _servicosSelecionados.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhum serviço selecionado',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _servicosSelecionados.length,
                  itemBuilder: (context, index) {
                    final item = _servicosSelecionados[index];
                    final servico = item['servico'] as Servico;
                    final quantidade = item['quantidade'] as int;
                    final valor = item['valor'] as double;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: ListTile(
                        title: Text(servico.nome),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'R\$ ${valor.toStringAsFixed(2)} x $quantidade',
                            ),
                            Text(
                              'Total: R\$ ${(valor * quantidade).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: quantidade > 1
                                  ? () => _alterarQuantidade(index, quantidade - 1)
                                  : null,
                            ),
                            Text('$quantidade'),
                            IconButton(
                              icon: const Icon(Icons.add_circle),
                              onPressed: () => _alterarQuantidade(index, quantidade + 1),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removerServico(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        if (_servicosSelecionados.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _observacoesController,
              decoration: const InputDecoration(
                labelText: 'Observações',
                border: OutlineInputBorder(),
                hintText: 'Informações adicionais sobre o orçamento...',
              ),
              maxLines: 3,
            ),
          ),
      ],
    );
  }

  void _enviarOrcamento() async {
    if (_nomeClienteController.text.isEmpty || _telefoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha o nome e telefone do cliente'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_servicosSelecionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione pelo menos um serviço'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final whatsappProvider = getIt<WhatsAppSalesProvider>();
      
      final orcamento = OrcamentoServicos(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nomeCliente: _nomeClienteController.text,
        telefoneCliente: _telefoneController.text,
        servicos: _servicosSelecionados.map((item) {
          final servico = item['servico'] as Servico;
          return ServicoOrcamento(
            id: servico.id?.toString() ?? '',
            descricao: servico.nome,
            valor: item['valor'] as double,
          );
        }).toList(),
        valorTotal: _totalOrcamento,
        desconto: _desconto,
        observacoes: _observacoesController.text,
      );
      
      final sucesso = await whatsappProvider.enviarOrcamentoServicos(
        telefone: _telefoneController.text,
        nomeCliente: _nomeClienteController.text,
        servicos: _servicosSelecionados,
        valorTotal: _totalOrcamento,
        observacoes: _observacoesController.text,
      );

      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Orçamento enviado por WhatsApp com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Limpar formulário
        setState(() {
          _servicosSelecionados.clear();
          _nomeClienteController.clear();
          _telefoneController.clear();
          _observacoesController.clear();
          _totalOrcamento = 0.0;
          _desconto = 0.0;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao enviar orçamento por WhatsApp'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar orçamento: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}