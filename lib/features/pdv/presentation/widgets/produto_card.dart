import 'package:flutter/material.dart';
import '../../../estoque/domain/entities/produto.dart';

class ProdutoCard extends StatelessWidget {
  final Produto produto;
  final VoidCallback? onTap;

  const ProdutoCard({
    super.key,
    required this.produto,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Imagem ou ícone do produto
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: produto.imagemPath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              produto.imagemPath!,
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
                          produto.nome,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (produto.descricao != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            produto.descricao!,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const SizedBox(height: 8),
                        
                        // Preço e estoque
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'R\$ ${produto.precoVenda.toStringAsFixed(2) ?? '0,00'}',
                                style: TextStyle(
                                  color: Colors.green.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: (produto.estoqueAtual ?? 0) > (produto.estoqueMinimo ?? 0)
                                    ? Colors.blue.shade100
                                    : Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Estoque: ${produto.estoqueAtual ?? 0}',
                                style: TextStyle(
                                  color: (produto.estoqueAtual ?? 0) > (produto.estoqueMinimo ?? 0)
                                      ? Colors.blue.shade800
                                      : Colors.orange.shade800,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              // Informações adicionais
              if (produto.categoria != null || produto.codigoBarras != null) ...[
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (produto.categoria != null) ...[
                      Icon(
                        Icons.category,
                        size: 16,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        produto.categoria!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                    if (produto.categoria != null && produto.codigoBarras != null)
                      const SizedBox(width: 16),
                    if (produto.codigoBarras != null) ...[
                      Icon(
                        Icons.qr_code,
                        size: 16,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          produto.codigoBarras!,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}