import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/ordem_servico.dart';
import '../providers/ordens_servico_provider.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';

class OrdensServicoPage extends StatefulWidget {
  const OrdensServicoPage({super.key});

  @override
  State<OrdensServicoPage> createState() => _OrdensServicoPageState();
}

class _OrdensServicoPageState extends State<OrdensServicoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrdensServicoProvider>().carregarOrdens();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordens de Serviço'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/ordens-servico/nova'),
            tooltip: 'Nova Ordem de Serviço',
          ),
        ],
      ),
      body: Consumer<OrdensServicoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingWidget();
          }

          if (provider.error != null) {
            return CustomErrorWidget(
              message: provider.error!,
              onRetry: () => provider.carregarOrdens(),
            );
          }

          final ordens = provider.ordens;

          if (ordens.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.build_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nenhuma ordem de serviço encontrada',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Clique no botão + para criar uma nova ordem',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.carregarOrdens(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ordens.length,
              itemBuilder: (context, index) {
                final ordem = ordens[index];
                return _buildOrdemCard(context, ordem);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrdemCard(BuildContext context, OrdemServico ordem) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.go('/ordens-servico/${ordem.id}'),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'OS #${ordem.numero}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildStatusChip(ordem.status),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      ordem.nomeCliente,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Agendado: ${_formatDate(ordem.dataAgendamento)}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              if (ordem.equipamento != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.build, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        ordem.equipamento!,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPrioridadeChip(ordem.prioridade),
                  Text(
                    'R\$ ${ordem.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(StatusOrdemServico status) {
    Color color;
    String label;

    switch (status) {
      case StatusOrdemServico.agendada:
        color = Colors.blue;
        label = 'Agendada';
        break;
      case StatusOrdemServico.emAndamento:
        color = Colors.orange;
        label = 'Em Andamento';
        break;
      case StatusOrdemServico.pausada:
        color = Colors.red;
        label = 'Pausada';
        break;
      case StatusOrdemServico.concluida:
        color = Colors.green;
        label = 'Concluída';
        break;
      case StatusOrdemServico.cancelada:
        color = Colors.grey;
        label = 'Cancelada';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPrioridadeChip(PrioridadeOrdemServico prioridade) {
    Color color;
    String label;

    switch (prioridade) {
      case PrioridadeOrdemServico.baixa:
        color = Colors.green;
        label = 'Baixa';
        break;
      case PrioridadeOrdemServico.media:
        color = Colors.orange;
        label = 'Média';
        break;
      case PrioridadeOrdemServico.alta:
        color = Colors.red;
        label = 'Alta';
        break;
      case PrioridadeOrdemServico.urgente:
        color = Colors.purple;
        label = 'Urgente';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}