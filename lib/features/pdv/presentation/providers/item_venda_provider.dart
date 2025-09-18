import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/item_venda.dart';
import 'venda_provider.dart';

// Provider para itens de uma venda específica
final itensVendaProvider = FutureProvider.family<List<ItemVenda>, int>((ref, vendaId) async {
  final repository = ref.watch(vendaRepositoryProvider);
  return repository.buscarItensVenda(vendaId);
});