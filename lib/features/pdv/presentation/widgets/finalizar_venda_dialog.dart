import 'package:flutter/material.dart';

class FinalizarVendaDialog extends StatefulWidget {
  final double subtotal;
  final double desconto;
  final double total;

  const FinalizarVendaDialog({
    super.key,
    required this.subtotal,
    required this.desconto,
    required this.total,
  });

  @override
  State<FinalizarVendaDialog> createState() => _FinalizarVendaDialogState();
}

class _FinalizarVendaDialogState extends State<FinalizarVendaDialog> {
  String _formaPagamento = 'Dinheiro';
  final TextEditingController _observacoesController = TextEditingController();

  final List<String> _formasPagamento = [
    'Dinheiro',
    'Cartão de Débito',
    'Cartão de Crédito',
    'PIX',
    'Transferência',
    'Cheque',
  ];

  @override
  void dispose() {
    _observacoesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.point_of_sale, color: Colors.green),
          SizedBox(width: 8),
          Text('Finalizar Venda'),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.7,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Resumo da venda
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                children: [
                  _buildResumoLinha('Subtotal', 'R\$ ${widget.subtotal.toStringAsFixed(2)}'),
                  if (widget.desconto > 0) ...[
                    const SizedBox(height: 4),
                    _buildResumoLinha(
                      'Desconto (${widget.desconto.toStringAsFixed(1)}%)',
                      '- R\$ ${(widget.subtotal * widget.desconto / 100).toStringAsFixed(2)}',
                      isDesconto: true,
                    ),
                  ],
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  _buildResumoLinha(
                    'TOTAL',
                    'R\$ ${widget.total.toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Forma de pagamento
            Text(
              'Forma de Pagamento',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Grid de formas de pagamento
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _formasPagamento.length,
              itemBuilder: (context, index) {
                final forma = _formasPagamento[index];
                final isSelected = _formaPagamento == forma;
                
                return InkWell(
                  onTap: () {
                    setState(() {
                      _formaPagamento = forma;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? Colors.green.shade100 
                          : Colors.grey.shade100,
                      border: Border.all(
                        color: isSelected 
                            ? Colors.green 
                            : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getIconeFormaPagamento(forma),
                          size: 20,
                          color: isSelected 
                              ? Colors.green.shade700 
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            forma,
                            style: TextStyle(
                              color: isSelected 
                                  ? Colors.green.shade700 
                                  : Colors.grey.shade700,
                              fontWeight: isSelected 
                                  ? FontWeight.bold 
                                  : FontWeight.normal,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            
            // Observações
            Text(
              'Observações (opcional)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _observacoesController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Digite observações sobre a venda...',
                border: OutlineInputBorder(),
              ),
            ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop({
              'formaPagamento': _formaPagamento,
              'observacoes': _observacoesController.text.trim(),
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirmar Venda'),
        ),
      ],
    );
  }

  Widget _buildResumoLinha(String label, String valor, {
    bool isTotal = false,
    bool isDesconto = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          valor,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            fontSize: isTotal ? 16 : 14,
            color: isTotal
                ? Colors.green.shade700
                : isDesconto
                    ? Colors.red.shade600
                    : Colors.green.shade600,
          ),
        ),
      ],
    );
  }

  IconData _getIconeFormaPagamento(String forma) {
    switch (forma) {
      case 'Dinheiro':
        return Icons.attach_money;
      case 'Cartão de Débito':
      case 'Cartão de Crédito':
        return Icons.credit_card;
      case 'PIX':
        return Icons.pix;
      case 'Transferência':
        return Icons.account_balance;
      case 'Cheque':
        return Icons.receipt;
      default:
        return Icons.payment;
    }
  }
}