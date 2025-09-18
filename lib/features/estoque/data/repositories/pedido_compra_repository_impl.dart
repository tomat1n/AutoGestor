import 'package:drift/drift.dart';
import '../../core/database/database.dart';
import '../../domain/entities/pedido_compra.dart';
import '../../domain/entities/item_compra.dart';
import '../../domain/entities/fornecedor.dart';
import '../../domain/entities/produto.dart';
import '../../domain/repositories/pedido_compra_repository.dart';

class PedidoCompraRepositoryImpl implements PedidoCompraRepository {
  final AppDatabase _database;

  PedidoCompraRepositoryImpl(this._database);

  @override
  Future<List<PedidoCompra>> buscarTodos() async {
    final query = _database.select(_database.pedidoCompraTable)
      .join([
        leftOuterJoin(_database.fornecedorTable, 
          _database.fornecedorTable.id.equalsExp(_database.pedidoCompraTable.fornecedorId)),
      ]);
    
    final results = await query.get();
    return results.map((row) => _mapToEntity(row)).toList();
  }

  @override
  Future<List<PedidoCompra>> buscarPorStatus(StatusPedidoCompra status) async {
    final query = _database.select(_database.pedidoCompraTable)
      .join([
        leftOuterJoin(_database.fornecedorTable, 
          _database.fornecedorTable.id.equalsExp(_database.pedidoCompraTable.fornecedorId)),
      ])
      ..where(_database.pedidoCompraTable.status.equals(status.name));
    
    final results = await query.get();
    return results.map((row) => _mapToEntity(row)).toList();
  }

  @override
  Future<List<PedidoCompra>> buscarPorFornecedor(int fornecedorId) async {
    final query = _database.select(_database.pedidoCompraTable)
      .join([
        leftOuterJoin(_database.fornecedorTable, 
          _database.fornecedorTable.id.equalsExp(_database.pedidoCompraTable.fornecedorId)),
      ])
      ..where(_database.pedidoCompraTable.fornecedorId.equals(fornecedorId));
    
    final results = await query.get();
    return results.map((row) => _mapToEntity(row)).toList();
  }

  @override
  Future<PedidoCompra?> buscarPorId(int id) async {
    final query = _database.select(_database.pedidoCompraTable)
      .join([
        leftOuterJoin(_database.fornecedorTable, 
          _database.fornecedorTable.id.equalsExp(_database.pedidoCompraTable.fornecedorId)),
      ])
      ..where(_database.pedidoCompraTable.id.equals(id));
    
    final result = await query.getSingleOrNull();
    if (result == null) return null;
    
    final pedido = _mapToEntity(result);
    final itens = await buscarItensPorPedido(id);
    
    return pedido.copyWith(itens: itens);
  }

  @override
  Future<PedidoCompra?> buscarPorNumero(String numero) async {
    final query = _database.select(_database.pedidoCompraTable)
      .join([
        leftOuterJoin(_database.fornecedorTable, 
          _database.fornecedorTable.id.equalsExp(_database.pedidoCompraTable.fornecedorId)),
      ])
      ..where(_database.pedidoCompraTable.numero.equals(numero));
    
    final result = await query.getSingleOrNull();
    return result != null ? _mapToEntity(result) : null;
  }

  @override
  Future<List<ItemCompra>> buscarItensPorPedido(int pedidoId) async {
    final query = _database.select(_database.itemCompraTable)
      .join([
        leftOuterJoin(_database.produtoTable, 
          _database.produtoTable.id.equalsExp(_database.itemCompraTable.produtoId)),
      ])
      ..where(_database.itemCompraTable.pedidoCompraId.equals(pedidoId));
    
    final results = await query.get();
    return results.map((row) => _mapItemToEntity(row)).toList();
  }

  @override
  Future<int> criar(PedidoCompra pedido) async {
    final companion = PedidoCompraTableCompanion(
      fornecedorId: Value(pedido.fornecedorId),
      numero: Value(pedido.numero),
      status: Value(pedido.status.name),
      valorTotal: Value(pedido.valorTotal),
      observacoes: Value(pedido.observacoes),
      dataEmissao: Value(pedido.dataEmissao),
    );
    
    return await _database.into(_database.pedidoCompraTable).insert(companion);
  }

  @override
  Future<bool> atualizar(PedidoCompra pedido) async {
    final companion = PedidoCompraTableCompanion(
      id: Value(pedido.id!),
      fornecedorId: Value(pedido.fornecedorId),
      numero: Value(pedido.numero),
      status: Value(pedido.status.name),
      valorTotal: Value(pedido.valorTotal),
      observacoes: Value(pedido.observacoes),
      dataEmissao: Value(pedido.dataEmissao),
      dataAprovacao: Value(pedido.dataAprovacao),
      dataRecebimento: Value(pedido.dataRecebimento),
      atualizadoEm: Value(DateTime.now()),
    );
    
    final result = await _database.update(_database.pedidoCompraTable).replace(companion);
    return result;
  }

  @override
  Future<bool> excluir(int id) async {
    // Primeiro excluir os itens
    await (_database.delete(_database.itemCompraTable)
      ..where((tbl) => tbl.pedidoCompraId.equals(id))).go();
    
    // Depois excluir o pedido
    final result = await (_database.delete(_database.pedidoCompraTable)
      ..where((tbl) => tbl.id.equals(id))).go();
    return result > 0;
  }

  @override
  Future<bool> aprovar(int id) async {
    final result = await (_database.update(_database.pedidoCompraTable)
      ..where((tbl) => tbl.id.equals(id)))
      .write(PedidoCompraTableCompanion(
        status: Value(StatusPedidoCompra.aprovado.name),
        dataAprovacao: Value(DateTime.now()),
        atualizadoEm: Value(DateTime.now()),
      ));
    return result > 0;
  }

  @override
  Future<bool> cancelar(int id) async {
    final result = await (_database.update(_database.pedidoCompraTable)
      ..where((tbl) => tbl.id.equals(id)))
      .write(PedidoCompraTableCompanion(
        status: Value(StatusPedidoCompra.cancelado.name),
        atualizadoEm: Value(DateTime.now()),
      ));
    return result > 0;
  }

  @override
  Future<bool> marcarComoRecebido(int id) async {
    final result = await (_database.update(_database.pedidoCompraTable)
      ..where((tbl) => tbl.id.equals(id)))
      .write(PedidoCompraTableCompanion(
        status: Value(StatusPedidoCompra.recebido.name),
        dataRecebimento: Value(DateTime.now()),
        atualizadoEm: Value(DateTime.now()),
      ));
    return result > 0;
  }

  @override
  Future<int> adicionarItem(ItemCompra item) async {
    final companion = ItemCompraTableCompanion(
      pedidoCompraId: Value(item.pedidoCompraId),
      produtoId: Value(item.produtoId),
      quantidade: Value(item.quantidade),
      precoUnitario: Value(item.precoUnitario),
      precoTotal: Value(item.precoTotal),
      observacoes: Value(item.observacoes),
    );
    
    final itemId = await _database.into(_database.itemCompraTable).insert(companion);
    await atualizarValorTotal(item.pedidoCompraId);
    return itemId;
  }

  @override
  Future<bool> atualizarItem(ItemCompra item) async {
    final companion = ItemCompraTableCompanion(
      id: Value(item.id!),
      pedidoCompraId: Value(item.pedidoCompraId),
      produtoId: Value(item.produtoId),
      quantidade: Value(item.quantidade),
      precoUnitario: Value(item.precoUnitario),
      precoTotal: Value(item.precoTotal),
      observacoes: Value(item.observacoes),
    );
    
    final result = await _database.update(_database.itemCompraTable).replace(companion);
    if (result) {
      await atualizarValorTotal(item.pedidoCompraId);
    }
    return result;
  }

  @override
  Future<bool> removerItem(int itemId) async {
    // Buscar o pedido antes de remover
    final item = await (_database.select(_database.itemCompraTable)
      ..where((tbl) => tbl.id.equals(itemId))).getSingleOrNull();
    
    if (item == null) return false;
    
    final result = await (_database.delete(_database.itemCompraTable)
      ..where((tbl) => tbl.id.equals(itemId))).go();
    
    if (result > 0) {
      await atualizarValorTotal(item.pedidoCompraId);
    }
    
    return result > 0;
  }

  @override
  Future<bool> atualizarValorTotal(int pedidoId) async {
    final itens = await (_database.select(_database.itemCompraTable)
      ..where((tbl) => tbl.pedidoCompraId.equals(pedidoId))).get();
    
    final valorTotal = itens.fold<double>(0, (sum, item) => sum + item.precoTotal);
    
    final result = await (_database.update(_database.pedidoCompraTable)
      ..where((tbl) => tbl.id.equals(pedidoId)))
      .write(PedidoCompraTableCompanion(
        valorTotal: Value(valorTotal),
        atualizadoEm: Value(DateTime.now()),
      ));
    
    return result > 0;
  }

  PedidoCompra _mapToEntity(TypedResult row) {
    final pedidoData = row.readTable(_database.pedidoCompraTable);
    final fornecedorData = row.readTableOrNull(_database.fornecedorTable);
    
    return PedidoCompra(
      id: pedidoData.id,
      fornecedorId: pedidoData.fornecedorId,
      fornecedor: fornecedorData != null ? _mapFornecedorToEntity(fornecedorData) : null,
      numero: pedidoData.numero,
      status: StatusPedidoCompra.values.firstWhere(
        (e) => e.name == pedidoData.status,
        orElse: () => StatusPedidoCompra.pendente,
      ),
      valorTotal: pedidoData.valorTotal,
      observacoes: pedidoData.observacoes,
      dataEmissao: pedidoData.dataEmissao,
      dataAprovacao: pedidoData.dataAprovacao,
      dataRecebimento: pedidoData.dataRecebimento,
      criadoEm: pedidoData.criadoEm,
      atualizadoEm: pedidoData.atualizadoEm,
      itens: [],
    );
  }

  ItemCompra _mapItemToEntity(TypedResult row) {
    final itemData = row.readTable(_database.itemCompraTable);
    final produtoData = row.readTableOrNull(_database.produtoTable);
    
    return ItemCompra(
      id: itemData.id,
      pedidoCompraId: itemData.pedidoCompraId,
      produtoId: itemData.produtoId,
      produto: produtoData != null ? _mapProdutoToEntity(produtoData) : null,
      quantidade: itemData.quantidade,
      precoUnitario: itemData.precoUnitario,
      precoTotal: itemData.precoTotal,
      observacoes: itemData.observacoes,
      criadoEm: itemData.criadoEm,
    );
  }

  Fornecedor _mapFornecedorToEntity(FornecedorData data) {
    return Fornecedor(
      id: data.id,
      nome: data.nome,
      razaoSocial: data.razaoSocial,
      cnpj: data.cnpj,
      cpf: data.cpf,
      email: data.email,
      telefone: data.telefone,
      endereco: data.endereco,
      cidade: data.cidade,
      estado: data.estado,
      cep: data.cep,
      ativo: data.ativo,
      criadoEm: data.criadoEm,
      atualizadoEm: data.atualizadoEm,
    );
  }

  Produto _mapProdutoToEntity(ProdutoData data) {
    return Produto(
      id: data.id,
      nome: data.nome,
      descricao: data.descricao,
      codigoBarras: data.codigoBarras,
      precoCompra: data.precoCompra,
      precoVenda: data.precoVenda,
      categoria: data.categoria,
      unidade: data.unidade,
      estoqueMinimo: data.estoqueMinimo,
      ativo: data.ativo,
      imagemPath: data.imagemPath,
      criadoEm: data.criadoEm,
      atualizadoEm: data.atualizadoEm,
    );
  }
}