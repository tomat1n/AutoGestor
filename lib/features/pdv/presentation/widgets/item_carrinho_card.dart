import 'package:flutter/material.dart';
import '../../domain/entities/item_carrinho.dart';

class ItemCarrinhoCard extends StatelessWidget {
  final ItemCarrinho item;
  final Function(int) onQuantidadeChanged;
  final VoidCallback onRemover;

  const ItemCarrinhoCard({
    super.key,
    required this.item,
    required this.onQuantidadeChanged,
    required this.onRemover,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Imagem do produto
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: item.produto.imagemPath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item.produto.imagemPath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.inventory_2,
                            size: 30,
                            color: Theme.of(context).colorScheme.primary,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.inventory_2,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
            const SizedBox(width: 16),
            
            // Informações do produto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.produto.nome,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'R\$ ${item.precoUnitario.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Controles de quantidade
                  Row(
                    children: [
                      // Botão diminuir
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {
                            onQuantidadeChanged(item.quantidade - 1);
                          },
                          icon: const Icon(Icons.remove, size: 16),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      
                      // Quantidade
                      Container(
                        width: 60,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),
                        child: Text(
                          item.quantidade.toString(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      // Botão aumentar
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Verificar se há estoque suficiente
                            if (item.quantidade < (item.produto.estoqueAtual ?? 0)) {
                              onQuantidadeChanged(item.quantidade + 1);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Estoque insuficiente'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.add, size: 16),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Subtotal e botão remover
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Botão remover
                IconButton(
                  onPressed: onRemover,
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                  tooltip: 'Remover item',
                ),
                
                // Subtotal
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
                    'R\$ ${item.subtotal.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
}