import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/entities/dashboard_metrics.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/usecases/buscar_metricas_usecase.dart';

// Provider para o repositório
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl();
});

// Provider para o caso de uso
final buscarMetricasUsecaseProvider = Provider<BuscarMetricasUsecase>((ref) {
  final repository = ref.read(dashboardRepositoryProvider);
  return BuscarMetricasUsecase(repository);
});

// Estado das métricas do dashboard
class DashboardState {
  final DashboardMetrics? metrics;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.metrics,
    this.isLoading = false,
    this.error,
  });

  DashboardState copyWith({
    DashboardMetrics? metrics,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      metrics: metrics ?? this.metrics,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Notifier para gerenciar o estado do dashboard
class DashboardNotifier extends StateNotifier<DashboardState> {
  final BuscarMetricasUsecase _buscarMetricasUsecase;

  DashboardNotifier(this._buscarMetricasUsecase) : super(const DashboardState());

  Future<void> carregarMetricas() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final metrics = await _buscarMetricasUsecase();
      state = state.copyWith(
        metrics: metrics,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erro ao carregar métricas: ${e.toString()}',
      );
    }
  }

  Future<void> atualizarMetricas() async {
    await carregarMetricas();
  }
}

// Provider para o notifier
final dashboardNotifierProvider = StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final usecase = ref.read(buscarMetricasUsecaseProvider);
  return DashboardNotifier(usecase);
});

// Provider conveniente para acessar apenas as métricas
final dashboardMetricsProvider = Provider<DashboardMetrics?>((ref) {
  return ref.watch(dashboardNotifierProvider).metrics;
});

// Provider para verificar se está carregando
final dashboardLoadingProvider = Provider<bool>((ref) {
  return ref.watch(dashboardNotifierProvider).isLoading;
});

// Provider para acessar erros
final dashboardErrorProvider = Provider<String?>((ref) {
  return ref.watch(dashboardNotifierProvider).error;
});