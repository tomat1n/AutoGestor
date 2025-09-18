import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarrinhoFab extends StatelessWidget {
  final int quantidadeItens;

  const CarrinhoFab({
    super.key,
    required this.quantidadeItens,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => context.go('/pdv/carrinho'),
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      icon: Stack(
        children: [
          const Icon(Icons.shopping_cart),
          if (quantidadeItens > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  quantidadeItens > 99 ? '99+' : quantidadeItens.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      label: Text(
        quantidadeItens == 1 
            ? '$quantidadeItens item'
            : '$quantidadeItens itens',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}