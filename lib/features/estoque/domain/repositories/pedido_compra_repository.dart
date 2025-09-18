import '../entities/pedido_compra.dart';
import '../entities/item_compra.dart';

abstract class PedidoCompraRepository {
  Future<List<PedidoCompra>> buscarTodos();
  Future<List<PedidoCompra>> buscarPorStatus(StatusPedidoCompra status);
  Future<List<PedidoCompra>> buscarPorFornecedor(int fornecedorId);
  Future<PedidoCompra?> buscarPorId(int id);
  Future<PedidoCompra?> buscarPorNumero(String numero);
  Future<List<ItemCompra>> buscarItensPorPedido(int pedidoId);
  Future<int> criar(PedidoCompra pedido);
  Future<bool> atualizar(PedidoCompra pedido);
  Future<bool> excluir(int id);
  Future<bool> aprovar(int id);
  Future<bool> cancelar(int id);
  Future<bool> marcarComoRecebido(int id);
  Future<int> adicionarItem(ItemCompra item);
  Future<bool> atualizarItem(ItemCompra item);
  Future<bool> removerItem(int itemId);
  Future<bool> atualizarValorTotal(int pedidoId);
}