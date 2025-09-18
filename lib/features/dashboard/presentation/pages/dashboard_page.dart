import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/dashboard_provider.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Carrega as métricas quando a página é inicializada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardNotifierProvider.notifier).carregarMetricas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final isLoading = dashboardState.isLoading;
    final error = dashboardState.error;
    final metrics = dashboardState.metrics;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    if (metrics != null)
                      Text(
                        'Atualizado: ${DateFormat('HH:mm').format(metrics.ultimaAtualizacao)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: isLoading ? null : () {
                        ref.read(dashboardNotifierProvider.notifier).atualizarMetricas();
                      },
                      icon: isLoading 
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.refresh),
                      tooltip: 'Atualizar métricas',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Tratamento de erro
            if (error != null)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  border: Border.all(color: Colors.red[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red[600]),
                      ),
                    ),
                  ],
                ),
              ),
            
            // Cards de métricas
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Layout responsivo
                  final isDesktop = constraints.maxWidth > 800;
                  final crossAxisCount = isDesktop ? 4 : 2;
                  
                  if (isLoading && metrics == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  
                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isDesktop ? 1.5 : 1.2,
                    children: [
                      _buildMetricCard(
                        context,
                        'Vendas Hoje',
                        _formatCurrency(metrics?.vendasHoje ?? 0),
                        Icons.trending_up,
                        Colors.green,
                        isLoading,
                      ),
                      _buildMetricCard(
                        context,
                        'Produtos',
                        '${metrics?.totalProdutos ?? 0}',
                        Icons.inventory,
                        Colors.blue,
                        isLoading,
                      ),
                      _buildMetricCard(
                        context,
                        'Clientes',
                        '${metrics?.totalClientes ?? 0}',
                        Icons.people,
                        Colors.orange,
                        isLoading,
                      ),
                      _buildMetricCard(
                        context,
                        'Pedidos',
                        '${metrics?.pedidosPendentes ?? 0}',
                        Icons.shopping_cart,
                        Colors.purple,
                        isLoading,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    );
    return formatter.format(value);
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    bool isLoading,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: isLoading ? Colors.grey[400] : color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            if (isLoading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}