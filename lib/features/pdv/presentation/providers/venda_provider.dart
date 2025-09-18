import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/venda_repository.dart';
import '../../domain/entities/venda.dart';
import '../../domain/entities/item_venda.dart';

// Provider do repositório de vendas
final vendaRepositoryProvider = Provider<VendaRepository>((ref) {
  return VendaRepository();
});

// Provider para todas as vendas
final todasVendasProvider = FutureProvider<List<Venda>>((ref) async {
  final repository = ref.watch(vendaRepositoryProvider);
  return repository.buscarTodasVendas();
});

// Provider para vendas por período
final vendasPorPeriodoProvider = FutureProvider.family<List<Venda>, String>((ref, periodoKey) async {
  final repository = ref.watch(vendaRepositoryProvider);
  
  // Decodificar a chave do período
  final parts = periodoKey.split('-');
  final inicio = DateTime.fromMillisecondsSinceEpoch(int.parse(parts[0]));
  final fim = DateTime.fromMillisecondsSinceEpoch(int.parse(parts[1]));
  
  return repository.buscarVendasPorPeriodo(inicio, fim);
});

// Provider para venda por ID
final vendaPorIdProvider = FutureProvider.family<Venda?, int>((ref, id) async {
  final repository = ref.watch(vendaRepositoryProvider);
  return repository.buscarVendaPorId(id);
});

// Provider para itens de uma venda
final itensVendaProvider = FutureProvider.family<List<ItemVenda>, int>((ref, vendaId) async {
  final repository = ref.watch(vendaRepositoryProvider);
  return repository.buscarItensVenda(vendaId);
});

// Provider para vendas do dia
final vendasDiaProvider = FutureProvider.family<int, DateTime>((ref, data) async {
  final repository = ref.watch(vendaRepositoryProvider);
  return repository.contarVendasDia(data);
});

// Provider para total de vendas do dia
final totalVendasDiaProvider = FutureProvider.family<double, DateTime>((ref, data) async {
  final repository = ref.watch(vendaRepositoryProvider);
  return repository.calcularTotalVendasDia(data);
});

// Provider para estatísticas de vendas
final estatisticasVendasProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(vendaRepositoryProvider);
  final hoje = DateTime.now();
  final inicioDia = DateTime(hoje.year, hoje.month, hoje.day);
  
  final vendasHoje = await repository.contarVendasDia(hoje);
  final totalHoje = await repository.calcularTotalVendasDia(hoje);
  
  return {
    'vendasHoje': vendasHoje,
    'totalHoje': totalHoje,
  };
});