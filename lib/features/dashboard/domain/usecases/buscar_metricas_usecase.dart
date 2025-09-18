import '../entities/dashboard_metrics.dart';
import '../repositories/dashboard_repository.dart';

class BuscarMetricasUsecase {
  final DashboardRepository _repository;

  const BuscarMetricasUsecase(this._repository);

  Future<DashboardMetrics> call() async {
    try {
      return await _repository.buscarMetricas();
    } catch (e) {
      // Em caso de erro, retorna métricas vazias
      return DashboardMetrics(
        vendasHoje: 0.0,
        totalProdutos: 0,
        totalClientes: 0,
        pedidosPendentes: 0,
        ultimaAtualizacao: DateTime.now(),
      );
    }
  }
}