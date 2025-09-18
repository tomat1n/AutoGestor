import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/venda.dart';
import '../../domain/entities/item_venda.dart';
import '../../domain/services/pdf_service.dart';
import '../../../../core/di/service_locator.dart';

class DetalhesVendaDialog extends StatefulWidget {
  final Venda venda;
  final List<ItemVenda> itens;

  const DetalhesVendaDialog({
    super.key,
    required this.venda,
    required this.itens,
  });

  @override
  State<DetalhesVendaDialog> createState() => _DetalhesVendaDialogState();
}

class _DetalhesVendaDialogState extends State<DetalhesVendaDialog> {
  final PdfService _pdfService = getIt<PdfService>();
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy HH:mm');
  
  List<ItemVenda> _itens = [];
  bool _carregando = false;
  String? _erro;

  @override
  void initState() {
    super.initState();
    // TODO: Implementar carregamento de itens quando o repository estiver disponível
  }

  Future<void> _carregarItens() async {
    try {
      setState(() {
        _carregando = true;
        _erro = null;
      });

      // TODO: Carregar itens da venda
      // final itens = await _vendaRepository.buscarItensVenda(widget.venda.id!);
      
      setState(() {
        _itens = [];
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _erro = 'Erro ao carregar itens: $e';
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.receipt_long,
                    color: Colors.blue.shade700,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detalhes da Venda',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Venda #${widget.venda.id}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Informações da venda
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          'Data/Hora',
                          _dateFormat.format(widget.venda.dataVenda),
                          Icons.access_time,
                        ),
                      ),
                      Expanded(
                        child: _buildInfoItem(
                          'Forma de Pagamento',
                          widget.venda.formaPagamento,
                          Icons.payment,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          'Subtotal',
                          _currencyFormat.format(widget.venda.subtotal),
                          Icons.calculate,
                        ),
                      ),
                      Expanded(
                        child: _buildInfoItem(
                          'Desconto',
                          widget.venda.desconto > 0
                              ? _currencyFormat.format(widget.venda.desconto)
                              : 'Sem desconto',
                          Icons.discount,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.green.shade700,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total da Venda',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              _currencyFormat.format(widget.venda.total),
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Observações (se houver)
                  if (widget.venda.observacoes?.isNotEmpty == true) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.note,
                                color: Colors.amber.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Observações',
                                style: TextStyle(
                                  color: Colors.amber.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.venda.observacoes!,
                            style: TextStyle(
                              color: Colors.amber.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Lista de itens
            Text(
              'Itens da Venda',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            Expanded(
              child: _carregando
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Carregando itens...'),
                        ],
                      ),
                    )
                  : _erro != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 48,
                                color: Colors.red.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _erro!,
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _carregarItens,
                                child: const Text('Tentar Novamente'),
                              ),
                            ],
                          ),
                        )
                      : _itens.isEmpty
                          ? const Center(
                              child: Text('Nenhum item encontrado'),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  // Cabeçalho da tabela
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: const Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            'Produto',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Qtd',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Preço Unit.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Subtotal',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // Lista de itens
                                  Expanded(
                                    child: ListView.separated(
                                      itemCount: _itens.length,
                                      separatorBuilder: (context, index) => Divider(
                                        height: 1,
                                        color: Colors.grey.shade300,
                                      ),
                                      itemBuilder: (context, index) {
                                        final item = _itens[index];
                                        return Container(
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.produto?.nome ?? 'Produto não encontrado',
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    if (item.produto?.codigoBarras?.isNotEmpty == true)
                                                      Text(
                                                        'Código: ${item.produto!.codigoBarras}',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey.shade600,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  item.quantidade.toStringAsFixed(0),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  _currencyFormat.format(item.precoUnitario),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  _currencyFormat.format(item.subtotal),
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
            ),
            
            const SizedBox(height: 24),
            
            // Botões de ação
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Fechar'),
                ),
                const SizedBox(width: 12),
PopupMenuButton<String>(
                  onSelected: (value) => _handleImpressao(value),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'a4',
                      child: Row(
                        children: [
                          Icon(Icons.description, size: 20),
                          SizedBox(width: 8),
                          Text('Imprimir A4'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'termico',
                      child: Row(
                        children: [
                          Icon(Icons.receipt, size: 20),
                          SizedBox(width: 8),
                          Text('Imprimir Térmico'),
                        ],
                      ),
                    ),
                  ],
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.print, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Imprimir',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
                      ],
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

  void _handleImpressao(String tipo) async {
    try {
      if (tipo == 'a4') {
        await _pdfService.gerarReciboA4(widget.venda);
      } else if (tipo == 'termico') {
        await _pdfService.gerarReciboTermico(widget.venda);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recibo gerado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao gerar recibo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}