import 'package:flutter/material.dart';

enum CategoriaProduto {
  iluminacao('Iluminação', Icons.lightbulb),
  suspensao('Suspensão', Icons.settings),
  acessorios('Acessórios', Icons.build),
  motor('Motor', Icons.engineering),
  freios('Freios', Icons.stop_circle),
  pneus('Pneus', Icons.circle),
  oleo('Óleo e Lubrificantes', Icons.opacity),
  eletrica('Elétrica', Icons.electrical_services),
  carroceria('Carroceria', Icons.directions_car),
  interior('Interior', Icons.airline_seat_recline_normal),
  outros('Outros', Icons.category);

  const CategoriaProduto(this.nome, this.icone);
  
  final String nome;
  final IconData icone;

  static List<String> get todasCategorias => CategoriaProduto.values
      .map((categoria) => categoria.nome)
      .toList();

  static CategoriaProduto? fromNome(String nome) {
    try {
      return CategoriaProduto.values.firstWhere(
        (categoria) => categoria.nome == nome,
      );
    } catch (e) {
      return null;
    }
  }
}