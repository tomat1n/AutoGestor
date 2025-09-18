import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/database/database.dart';
import '../../domain/entities/dashboard_metrics.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final AppDatabase _database = GetIt.instance<AppDatabase>();

  @override
  Future<DashboardMetrics> buscarMetricas() async {
    final vendasHoje = await buscarVendasHoje();
    final totalProdutos = await buscarTotalProdutos();
    final totalClientes = await buscarTotalClientes();
    final pedidosPendentes = await buscarPedidosPendentes();

    return DashboardMetrics(
      vendasHoje: vendasHoje,
      totalProdutos: totalProdutos,
      totalClientes: totalClientes,
      pedidosPendentes: pedidosPendentes,
      ultimaAtualizacao: DateTime.now(),
    );
  }

  @override
  Future<double> buscarVendasHoje() async {
    final hoje = DateTime.now();
    final inicioHoje = DateTime(hoje.year, hoje.month, hoje.day);
    final fimHoje = inicioHoje.add(const Duration(days: 1));

    final query = _database.select(_database.vendaTable)
      ..where((v) => v.dataVenda.isBetweenValues(inicioHoje, fimHoje));

    final vendas = await query.get();
    
    return vendas.fold<double>(0.0, (total, venda) => total + venda.total);
  }

  @override
  Future<int> buscarTotalProdutos() async {
    final query = _database.select(_database.produtoTable)
      ..where((p) => p.ativo.equals(true));
    
    final produtos = await query.get();
    return produtos.length;
  }

  @override
  Future<int> buscarTotalClientes() async {
    final query = _database.select(_database.clienteTable)
      ..where((c) => c.ativo.equals(true));
    
    final clientes = await query.get();
    return clientes.length;
  }

  @override
  Future<int> buscarPedidosPendentes() async {
    // Vamos contar as vendas do dia como "pedidos pendentes"
    final hoje = DateTime.now();
    final inicioHoje = DateTime(hoje.year, hoje.month, hoje.day);
    final fimHoje = inicioHoje.add(const Duration(days: 1));

    final query = _database.select(_database.vendaTable)
      ..where((v) => v.dataVenda.isBetweenValues(inicioHoje, fimHoje));

    final vendas = await query.get();
    return vendas.length;
  }
}