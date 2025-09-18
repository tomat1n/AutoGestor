import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/ordem_servico.dart';
import '../providers/ordens_servico_provider.dart';
import '../../../../core/widgets/loading_widget.dart';

class OrdemServicoFormPage extends StatefulWidget {
  final int? ordemId;
  
  const OrdemServicoFormPage({super.key, this.ordemId});

  @override
  State<OrdemServicoFormPage> createState() => _OrdemServicoFormPageState();
}

class _OrdemServicoFormPageState extends State<OrdemServicoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _numeroController = TextEditingController();
  final _nomeClienteController = TextEditingController();
  final _telefoneClienteController = TextEditingController();
  final _emailClienteController = TextEditingController();
  final _equipamentoController = TextEditingController();
  final _problemaRelatadoController = TextEditingController();
  final _observacoesController = TextEditingController();
  final _descontoController = TextEditingController(text: '0.00');
  
  DateTime _dataAgendamento = DateTime.now();
  StatusOrdemServico _status = StatusOrdemServico.agendada;
  PrioridadeOrdemServico _prioridade = PrioridadeOrdemServico.media;
  List<ItemOrdemServico> _itens = [];
  bool _isLoading = false;
  OrdemServico? _ordemExistente;
  
  @override
  void initState() {
    super.initState();
    if (widget.ordemId != null) {
      _carregarOrdem();
    } else {
      _gerarNumeroOrdem();
    }
  }
  
  Future<void> _carregarOrdem() async {
    setState(() => _isLoading = true);
    try {
      _ordemExistente = await context.read<OrdensServicoProvider>().buscarOrdemPorId(widget.ordemId!);
      if (_ordemExistente != null) {
        _preencherFormulario();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar ordem: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  void _preencherFormulario() {
    if (_ordemExistente == null) return;
    
    _numeroController.text = _ordemExistente!.numero;
    _nomeClienteController.text = _ordemExistente!.nomeCliente;
    _telefoneClienteController.text = _ordemExistente!.telefoneCliente ?? '';
    _emailClienteController.text = _ordemExistente!.emailCliente ?? '';
    _equipamentoController.text = _ordemExistente!.equipamento ?? '';
    _problemaRelatadoController.text = _ordemExistente!.problemaRelatado ?? '';
    _observacoesController.text = _ordemExistente!.observacoes ?? '';
    _descontoController.text = _ordemExistente!.desconto.toStringAsFixed(2);
    _dataAgendamento = _ordemExistente!.dataAgendamento;
    _status = _ordemExistente!.status;
    _prioridade = _ordemExistente!.prioridade;
    _itens = List.from(_ordemExistente!.itens);
  }
  
  void _gerarNumeroOrdem() {
    final agora = DateTime.now();
    final numero = 'OS${agora.year}${agora.month.toString().padLeft(2, '0')}${agora.day.toString().padLeft(2, '0')}${agora.hour.toString().padLeft(2, '0')}${agora.minute.toString().padLeft(2, '0')}';
    _numeroController.text = numero;
  }
  
  @override
  void dispose() {
    _numeroController.dispose();
    _nomeClienteController.dispose();
    _telefoneClienteController.dispose();
    _emailClienteController.dispose();
    _equipamentoController.dispose();
    _problemaRelatadoController.dispose();
    _observacoesController.dispose();
    _descontoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ordemId == null ? 'Nova Ordem de Serviço' : 'Editar Ordem de Serviço'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _salvarOrdem,
            child: const Text(
              'Salvar',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget()
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDadosGerais(),
                    const SizedBox(height: 24),
                    _buildDadosCliente(),
                    const SizedBox(height: 24),
                    _buildDadosServico(),
                    const SizedBox(height: 24),
                    _buildItensServico(),
                    const SizedBox(height: 24),
                    _buildResumoFinanceiro(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDadosGerais() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dados Gerais',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _numeroController,
                    decoration: const InputDecoration(
                      labelText: 'Número da OS',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Número é obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<StatusOrdemServico>(
                    initialValue: _status,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: StatusOrdemServico.values.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(_getStatusLabel(status)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _status = value);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<PrioridadeOrdemServico>(
                    initialValue: _prioridade,
                    decoration: const InputDecoration(
                      labelText: 'Prioridade',
                      border: OutlineInputBorder(),
                    ),
                    items: PrioridadeOrdemServico.values.map((prioridade) {
                      return DropdownMenuItem(
                        value: prioridade,
                        child: Text(_getPrioridadeLabel(prioridade)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _prioridade = value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _selecionarData(),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Data Agendamento',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        '${_dataAgendamento.day.toString().padLeft(2, '0')}/${_dataAgendamento.month.toString().padLeft(2, '0')}/${_dataAgendamento.year}',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDadosCliente() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dados do Cliente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nomeClienteController,
              decoration: const InputDecoration(
                labelText: 'Nome do Cliente',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nome do cliente é obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _telefoneClienteController,
                    decoration: const InputDecoration(
                      labelText: 'Telefone',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _emailClienteController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDadosServico() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dados do Serviço',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _equipamentoController,
              decoration: const InputDecoration(
                labelText: 'Equipamento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _problemaRelatadoController,
              decoration: const InputDecoration(
                labelText: 'Problema Relatado',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _observacoesController,
              decoration: const InputDecoration(
                labelText: 'Observações',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItensServico() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Itens do Serviço',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _adicionarItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar Item'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_itens.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'Nenhum item adicionado',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _itens.length,
                itemBuilder: (context, index) {
                  final item = _itens[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(item.nomeServico),
                      subtitle: Text('Qtd: ${item.quantidade} x R\$ ${item.valorUnitario.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'R\$ ${item.subtotal.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removerItem(index),
                          ),
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

  Widget _buildResumoFinanceiro() {
    final subtotal = _itens.fold<double>(0, (sum, item) => sum + item.subtotal);
    final desconto = double.tryParse(_descontoController.text) ?? 0;
    final total = subtotal - desconto;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumo Financeiro',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _descontoController,
                    decoration: const InputDecoration(
                      labelText: 'Desconto (R\$)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Subtotal: R\$ ${subtotal.toStringAsFixed(2)}'),
                      Text('Desconto: R\$ ${desconto.toStringAsFixed(2)}'),
                      const Divider(),
                      Text(
                        'Total: R\$ ${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataAgendamento,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (data != null) {
      setState(() => _dataAgendamento = data);
    }
  }

  void _adicionarItem() {
    // TODO: Implementar dialog para adicionar item
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Item'),
        content: const Text('Funcionalidade em desenvolvimento'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _removerItem(int index) {
    setState(() {
      _itens.removeAt(index);
    });
  }

  Future<void> _salvarOrdem() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final subtotal = _itens.fold<double>(0, (sum, item) => sum + item.subtotal);
      final desconto = double.tryParse(_descontoController.text) ?? 0;
      final total = subtotal - desconto;

      final ordem = OrdemServico(
        id: _ordemExistente?.id,
        numero: _numeroController.text,
        clienteId: _ordemExistente?.clienteId ?? 0,
        nomeCliente: _nomeClienteController.text,
        telefoneCliente: _telefoneClienteController.text.isEmpty ? null : _telefoneClienteController.text,
        emailCliente: _emailClienteController.text.isEmpty ? null : _emailClienteController.text,
        equipamento: _equipamentoController.text.isEmpty ? null : _equipamentoController.text,
        problemaRelatado: _problemaRelatadoController.text.isEmpty ? null : _problemaRelatadoController.text,
        observacoes: _observacoesController.text.isEmpty ? null : _observacoesController.text,
        itens: _itens,
        subtotal: subtotal,
        desconto: desconto,
        total: total,
        status: _status,
        prioridade: _prioridade,
        dataAgendamento: _dataAgendamento,
        createdAt: _ordemExistente?.createdAt ?? DateTime.now(),
      );

      if (widget.ordemId == null) {
        await context.read<OrdensServicoProvider>().criarOrdem(ordem);
      } else {
        await context.read<OrdensServicoProvider>().atualizarOrdem(ordem);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.ordemId == null ? 'Ordem criada com sucesso!' : 'Ordem atualizada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/ordens-servico');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar ordem: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String _getStatusLabel(StatusOrdemServico status) {
    switch (status) {
      case StatusOrdemServico.agendada:
        return 'Agendada';
      case StatusOrdemServico.emAndamento:
        return 'Em Andamento';
      case StatusOrdemServico.pausada:
        return 'Pausada';
      case StatusOrdemServico.concluida:
        return 'Concluída';
      case StatusOrdemServico.cancelada:
        return 'Cancelada';
    }
  }

  String _getPrioridadeLabel(PrioridadeOrdemServico prioridade) {
    switch (prioridade) {
      case PrioridadeOrdemServico.baixa:
        return 'Baixa';
      case PrioridadeOrdemServico.media:
        return 'Média';
      case PrioridadeOrdemServico.alta:
        return 'Alta';
      case PrioridadeOrdemServico.urgente:
        return 'Urgente';
    }
  }
}