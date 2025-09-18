import 'package:flutter/material.dart';

class ResumoCarrinho extends StatelessWidget {
  final double subtotal;
  final double desconto;
  final int quantidadeItens;

  const ResumoCarrinho({
    super.key,
    required this.subtotal,
    required this.desconto,
    required this.quantidadeItens,
  });

  @override
  Widget build(BuildContext context) {
    final valorDesconto = subtotal * (desconto / 100);
    final total = subtotal - valorDesconto;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          // Cabeçalho
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Resumo da Venda',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
          ),
          const SizedBox(height: 16),
          
          // Quantidade de itens
          _buildLinha(
            context,
            'Itens',
            quantidadeItens == 1 
                ? '$quantidadeItens item'
                : '$quantidadeItens itens',
            isInfo: true,
          ),
          const SizedBox(height: 8),
          
          // Subtotal
          _buildLinha(
            context,
            'Subtotal',
            'R\$ ${subtotal.toStringAsFixed(2)}',
          ),
          
          // Desconto (se houver)
          if (desconto > 0) ...[
            const SizedBox(height: 8),
            _buildLinha(
              context,
              'Desconto (${desconto.toStringAsFixed(1)}%)',
              '- R\$ ${valorDesconto.toStringAsFixed(2)}',
              isDesconto: true,
            ),
          ],
          
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          
          // Total
          _buildLinha(
            context,
            'TOTAL',
            'R\$ ${total.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLinha(
    BuildContext context,
    String label,
    String valor, {
    bool isTotal = false,
    bool isDesconto = false,
    bool isInfo = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : null,
            color: isInfo 
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : null,
          ),
        ),
        Text(
          valor,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            fontSize: isTotal ? 18 : null,
            color: isTotal
                ? Colors.green.shade700
                : isDesconto
                    ? Colors.red.shade600
                    : isInfo
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : Colors.green.shade600,
          ),
        ),
      ],
    );
  }
}