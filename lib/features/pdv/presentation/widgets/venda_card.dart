import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/venda.dart';
import '../../domain/services/pdf_service.dart';
import '../../../../core/di/service_locator.dart';

class VendaCard extends StatelessWidget {
  final Venda venda;
  final VoidCallback onImprimir;
  final VoidCallback onDetalhes;

  const VendaCard({
    super.key,
    required this.venda,
    required this.onImprimir,
    required this.onDetalhes,
  });

  @override
  Widget build(BuildContext context) {
    final pdfService = getIt<PdfService>();
    final dateFormat = DateFormat('dd/MM/yyyy');
    final timeFormat = DateFormat('HH:mm');

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onDetalhes,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho da venda
              Row(
                children: [
                  // Ícone e ID da venda
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.receipt,
                      color: Colors.blue.shade700,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Informações principais
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Venda #${venda.id}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              dateFormat.format(venda.dataVenda),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              timeFormat.format(venda.dataVenda),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Valor total
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'R\$ ${venda.total.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Informações adicionais
              Row(
                children: [
                  // Forma de pagamento
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          _getIconeFormaPagamento(venda.formaPagamento),
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            venda.formaPagamento,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Desconto (se houver)
                  if (venda.desconto > 0) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Desc. ${venda.desconto.toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: Colors.orange.shade800,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  
                  // Botão imprimir
                  PopupMenuButton<String>(
                    onSelected: (value) => _handleImpressao(context, value),
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
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.print,
                        color: Colors.blue.shade700,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              
              // Observações (se houver)
              if (venda.observacoes != null && venda.observacoes!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.note,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          venda.observacoes!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade700,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _handleImpressao(BuildContext context, String tipo) async {
    final pdfService = getIt<PdfService>();
    try {
      if (tipo == 'a4') {
        await pdfService.gerarReciboA4(venda);
      } else if (tipo == 'termico') {
        await pdfService.gerarReciboTermico(venda);
      }
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recibo gerado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao gerar recibo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  IconData _getIconeFormaPagamento(String formaPagamento) {
    switch (formaPagamento.toLowerCase()) {
      case 'dinheiro':
        return Icons.attach_money;
      case 'cartão de débito':
      case 'cartão de crédito':
        return Icons.credit_card;
      case 'pix':
        return Icons.pix;
      case 'transferência':
        return Icons.account_balance;
      case 'cheque':
        return Icons.receipt;
      default:
        return Icons.payment;
    }
  }
}