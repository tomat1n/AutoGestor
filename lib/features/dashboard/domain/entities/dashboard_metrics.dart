class DashboardMetrics {
  final double vendasHoje;
  final int totalProdutos;
  final int totalClientes;
  final int pedidosPendentes;
  final DateTime ultimaAtualizacao;

  const DashboardMetrics({
    required this.vendasHoje,
    required this.totalProdutos,
    required this.totalClientes,
    required this.pedidosPendentes,
    required this.ultimaAtualizacao,
  });

  DashboardMetrics copyWith({
    double? vendasHoje,
    int? totalProdutos,
    int? totalClientes,
    int? pedidosPendentes,
    DateTime? ultimaAtualizacao,
  }) {
    return DashboardMetrics(
      vendasHoje: vendasHoje ?? this.vendasHoje,
      totalProdutos: totalProdutos ?? this.totalProdutos,
      totalClientes: totalClientes ?? this.totalClientes,
      pedidosPendentes: pedidosPendentes ?? this.pedidosPendentes,
      ultimaAtualizacao: ultimaAtualizacao ?? this.ultimaAtualizacao,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DashboardMetrics &&
        other.vendasHoje == vendasHoje &&
        other.totalProdutos == totalProdutos &&
        other.totalClientes == totalClientes &&
        other.pedidosPendentes == pedidosPendentes &&
        other.ultimaAtualizacao == ultimaAtualizacao;
  }

  @override
  int get hashCode {
    return vendasHoje.hashCode ^
        totalProdutos.hashCode ^
        totalClientes.hashCode ^
        pedidosPendentes.hashCode ^
        ultimaAtualizacao.hashCode;
  }

  @override
  String toString() {
    return 'DashboardMetrics(vendasHoje: $vendasHoje, totalProdutos: $totalProdutos, totalClientes: $totalClientes, pedidosPendentes: $pedidosPendentes, ultimaAtualizacao: $ultimaAtualizacao)';
  }
}