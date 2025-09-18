import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/venda.dart';
import '../../domain/entities/item_venda.dart';
import '../../domain/services/csv_service.dart';
import '../../../../core/di/service_locator.dart';
import '../widgets/venda_card.dart';
import '../widgets/filtro_periodo_dialog.dart';
import '../providers/venda_provider.dart';

class HistoricoPage extends ConsumerStatefulWidget {
  const HistoricoPage({super.key});

  @override
  ConsumerState<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends ConsumerState<HistoricoPage> {
  final CsvService _csvService = getIt<CsvService>();
  DateTime _dataInicio = DateTime.now().subtract(const Duration(days: 30));
  DateTime _dataFim = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  // Método para recarregar vendas
  void _recarregarVendas() {
    ref.invalidate(vendasPorPeriodoProvider);
  }

  Future<void> _mostrarFiltroPeriodo() async {
    final resultado = await showDialog<Map<String, DateTime>>(
      context: context,
      builder: (context) => FiltroPeriodoDialog(
        dataInicio: _dataInicio,
        dataFim: _dataFim,
      ),
    );

    if (resultado != null) {
      setState(() {
        _dataInicio = resultado['inicio']!;
        _dataFim = resultado['fim']!;
      });
      _recarregarVendas();
    }
  }

  Future<void> _imprimirVenda(Venda venda) async {
    try {
      // TODO: Implementar impressão quando o repository estiver disponível
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Funcionalidade de impressão em desenvolvimento'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao gerar PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleExportacao(String tipo) async {
    final periodoKey = '${_dataInicio.millisecondsSinceEpoch}-${_dataFim.millisecondsSinceEpoch}';
    final vendasAsync = ref.read(vendasPorPeriodoProvider(periodoKey));

    final vendas = vendasAsync.value ?? [];
    
    if (vendas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não há vendas para exportar'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      // Mostrar indicador de carregamento
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      String filePath;
      String mensagem;
      
      // Criar mapa de itens de vendas vazio por enquanto
      final Map<int, List<ItemVenda>> itensVendas = {};

      switch (tipo) {
        case 'csv_resumo':
          filePath = await _csvService.exportarVendas(
            vendas: vendas,
            itensVendas: itensVendas,
          );
          mensagem = 'CSV de vendas (resumo) exportado com sucesso!';
          break;
        case 'csv_detalhado':
          filePath = await _csvService.exportarVendasDetalhadas(
            vendas: vendas,
            itensVendas: itensVendas,
          );
          mensagem = 'CSV de vendas (detalhado) exportado com sucesso!';
          break;
        case 'relatorio':
          filePath = await _csvService.exportarRelatorioVendas(
            vendas: vendas,
            itensVendas: itensVendas,
            dataInicio: _dataInicio,
            dataFim: _dataFim,
          );
          mensagem = 'Relatório completo exportado com sucesso!';
          break;
        default:
          throw Exception('Tipo de exportação não reconhecido');
      }

      // Fechar indicador de carregamento
      Navigator.of(context).pop();

      // Mostrar mensagem de sucesso com caminho do arquivo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mensagem),
              const SizedBox(height: 4),
              Text(
                'Arquivo salvo em: $filePath',
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
    } catch (e) {
      // Fechar indicador de carregamento se ainda estiver aberto
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao exportar: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Criar uma chave estável para o período para evitar rebuilds desnecessários
    final periodoKey = '${_dataInicio.millisecondsSinceEpoch}-${_dataFim.millisecondsSinceEpoch}';
    final vendasAsync = ref.watch(vendasPorPeriodoProvider(periodoKey));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Vendas'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.file_download),
            tooltip: 'Exportar dados',
            onSelected: _handleExportacao,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'csv_resumo',
                child: ListTile(
                  leading: Icon(Icons.table_chart),
                  title: Text('Exportar CSV (Resumo)'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'csv_detalhado',
                child: ListTile(
                  leading: Icon(Icons.view_list),
                  title: Text('Exportar CSV (Detalhado)'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'relatorio',
                child: ListTile(
                  leading: Icon(Icons.assessment),
                  title: Text('Relatório Completo'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _mostrarFiltroPeriodo,
            tooltip: 'Filtrar período',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _recarregarVendas,
            tooltip: 'Atualizar',
          ),
        ],
      ),
      body: vendasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar vendas: $error',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _recarregarVendas,
                child: const Text('Tentar Novamente'),
              ),
            ],
          ),
        ),
        data: (vendas) {
          final totalVendas = vendas.fold(0.0, (sum, venda) => sum + venda.total);
          
          return Column(
            children: [
              // Resumo do período
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue.shade200,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Período: ${_dateFormat.format(_dataInicio)} - ${_dateFormat.format(_dataFim)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildResumoCard(
                            'Total de Vendas',
                            vendas.length.toString(),
                            Icons.shopping_cart,
                            Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildResumoCard(
                            'Valor Total',
                            'R\$ ${totalVendas.toStringAsFixed(2)}',
                            Icons.attach_money,
                            Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Lista de vendas
              Expanded(
                child: vendas.isEmpty
                    ? _buildListaVazia()
                    : RefreshIndicator(
                        onRefresh: () async => _recarregarVendas(),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: vendas.length,
                          itemBuilder: (context, index) {
                            final venda = vendas[index];
                            return VendaCard(
                              venda: venda,
                              onImprimir: () => _imprimirVenda(venda),
                              onDetalhes: () => _mostrarDetalhesVenda(venda),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildResumoCard(
    String titulo,
    String valor,
    IconData icone,
    Color cor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            icone,
            color: cor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            titulo,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            valor,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: cor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildListaVazia() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 120,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 24),
          Text(
            'Nenhuma venda encontrada',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Não há vendas no período selecionado',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _mostrarFiltroPeriodo,
            icon: const Icon(Icons.filter_list),
            label: const Text('Alterar Período'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _mostrarDetalhesVenda(Venda venda) async {
    try {
      final repository = ref.read(vendaRepositoryProvider);
      final itens = await repository.buscarItensVenda(venda.id!);
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Venda #${venda.id}'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data: ${DateFormat('dd/MM/yyyy HH:mm').format(venda.dataVenda)}'),
                Text('Forma de Pagamento: ${venda.formaPagamento}'),
                if (venda.observacoes != null && venda.observacoes!.isNotEmpty)
                  Text('Observações: ${venda.observacoes}'),
                const SizedBox(height: 16),
                const Text('Itens:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...itens.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '${item.quantidade}x ${item.produto?.nome ?? 'Produto'} - R\$ ${item.subtotal.toStringAsFixed(2)}',
                  ),
                )),
                const SizedBox(height: 16),
                Text('Subtotal: R\$ ${venda.subtotal.toStringAsFixed(2)}'),
                if (venda.desconto > 0)
                  Text('Desconto: ${venda.desconto.toStringAsFixed(1)}%'),
                Text(
                  'Total: R\$ ${venda.total.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _imprimirVenda(venda);
              },
              child: const Text('Imprimir'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar detalhes: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}