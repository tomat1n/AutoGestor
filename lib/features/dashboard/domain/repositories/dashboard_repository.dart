import '../entities/dashboard_metrics.dart';

abstract class DashboardRepository {
  /// Busca as métricas do dashboard
  Future<DashboardMetrics> buscarMetricas();
  
  /// Busca o total de vendas do dia atual
  Future<double> buscarVendasHoje();
  
  /// Busca o total de produtos cadastrados
  Future<int> buscarTotalProdutos();
  
  /// Busca o total de clientes cadastrados
  Future<int> buscarTotalClientes();
  
  /// Busca o número de pedidos pendentes
  Future<int> buscarPedidosPendentes();
}