import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/database/database.dart';
import '../../domain/entities/venda.dart' as domain;
import '../../domain/entities/item_venda.dart' as domain;
import '../../domain/entities/item_carrinho.dart';
import '../../../estoque/domain/entities/produto.dart' as domain_produto;


class VendaRepository {
  final AppDatabase _database = GetIt.instance<AppDatabase>();

  // Criar uma nova venda com transação atômica
  Future<int> criarVenda({
    required List<ItemCarrinho> itensCarrinho,
    required double desconto,
    required String formaPagamento,
    String? observacoes,
  }) async {
    return await _database.transaction(() async {
      final agora = DateTime.now();
      final subtotal = itensCarrinho.fold(0.0, (total, item) => total + item.subtotal);
      final total = subtotal - desconto;

      // Criar a venda
      final vendaId = await _database.into(_database.vendaTable).insert(
        VendaTableCompanion.insert(
          dataVenda: Value(agora),
          subtotal: subtotal,
          desconto: Value(desconto),
          total: total,
          formaPagamento: formaPagamento,
          observacoes: Value(observacoes),
          criadoEm: Value(agora),
          atualizadoEm: Value(agora),
        ),
      );

      // Criar os itens da venda e baixar estoque
      for (final itemCarrinho in itensCarrinho) {
        // Inserir item da venda
        await _database.into(_database.itemVendaTable).insert(
          ItemVendaTableCompanion.insert(
            vendaId: vendaId,
            produtoId: itemCarrinho.produto.id!,
            quantidade: itemCarrinho.quantidade,
            precoUnitario: itemCarrinho.precoUnitario,
            subtotal: itemCarrinho.subtotal,
            criadoEm: Value(agora),
          ),
        );

        // Baixar estoque do produto
        final produto = await (_database.select(_database.produtoTable)
              ..where((p) => p.id.equals(itemCarrinho.produto.id!)))
            .getSingle();

        // Atualizar estoque do produto diretamente
        final novaQuantidade = produto.quantidade - itemCarrinho.quantidade;
        await (_database.update(_database.produtoTable)
              ..where((p) => p.id.equals(itemCarrinho.produto.id!)))
            .write(ProdutoTableCompanion(
              quantidade: Value(novaQuantidade),
              updatedAt: Value(agora),
            ));
      }

      return vendaId;
    });
  }

  // Buscar todas as vendas
  Future<List<domain.Venda>> buscarTodasVendas() async {
    final query = _database.select(_database.vendaTable)
      ..orderBy([(v) => OrderingTerm.desc(v.dataVenda)]);
    
    final results = await query.get();
    
    return results.map((row) => domain.Venda(
      id: row.id,
      dataVenda: row.dataVenda,
      subtotal: row.subtotal,
      desconto: row.desconto,
      total: row.total,
      formaPagamento: row.formaPagamento,
      observacoes: row.observacoes,
      criadoEm: row.criadoEm,
      atualizadoEm: row.atualizadoEm,
    )).toList();
  }

  // Buscar venda por ID
  Future<domain.Venda?> buscarVendaPorId(int id) async {
    final query = _database.select(_database.vendaTable)
      ..where((v) => v.id.equals(id));
    
    final result = await query.getSingleOrNull();
    
    if (result == null) return null;
    
    return domain.Venda(
      id: result.id,
      dataVenda: result.dataVenda,
      subtotal: result.subtotal,
      desconto: result.desconto,
      total: result.total,
      formaPagamento: result.formaPagamento,
      observacoes: result.observacoes,
      criadoEm: result.criadoEm,
      atualizadoEm: result.atualizadoEm,
    );
  }

  // Buscar itens de uma venda
  Future<List<domain.ItemVenda>> buscarItensVenda(int vendaId) async {
    final query = _database.select(_database.itemVendaTable).join([
      leftOuterJoin(
        _database.produtoTable,
        _database.produtoTable.id.equalsExp(_database.itemVendaTable.produtoId),
      ),
    ])
      ..where(_database.itemVendaTable.vendaId.equals(vendaId));
    
    final results = await query.get();
    
    return results.map((row) {
      final itemVenda = row.readTable(_database.itemVendaTable);
      final produto = row.readTableOrNull(_database.produtoTable);
      
      return domain.ItemVenda(
        id: itemVenda.id,
        vendaId: itemVenda.vendaId,
        produtoId: itemVenda.produtoId,
        quantidade: itemVenda.quantidade,
        precoUnitario: itemVenda.precoUnitario,
        subtotal: itemVenda.subtotal,
        criadoEm: itemVenda.criadoEm,
        produto: produto != null ? domain_produto.Produto(
          id: produto.id,
          codigo: produto.codigo ?? '',
          nome: produto.nome,
          precoVenda: produto.precoVenda,
          unidade: produto.unidade ?? 'UN',
          categoria: produto.categoria,
          codigoBarras: produto.codigoBarras,
          qrCode: produto.qrCode,
          imagemPath: produto.imagemPath,
          precoCompra: produto.precoCompra ?? 0.0,
          estoqueMinimo: produto.estoqueMinimo ?? 0,
          ativo: produto.ativo ?? true,
          createdAt: produto.createdAt,
          updatedAt: produto.updatedAt,
        ) : null,
      );
    }).toList();
  }

  // Buscar vendas por período
  Future<List<domain.Venda>> buscarVendasPorPeriodo(DateTime inicio, DateTime fim) async {
    final query = _database.select(_database.vendaTable)
      ..where((v) => v.dataVenda.isBetweenValues(inicio, fim))
      ..orderBy([(v) => OrderingTerm.desc(v.dataVenda)]);
    
    final results = await query.get();
    
    return results.map((row) => domain.Venda(
      id: row.id,
      dataVenda: row.dataVenda,
      subtotal: row.subtotal,
      desconto: row.desconto,
      total: row.total,
      formaPagamento: row.formaPagamento,
      observacoes: row.observacoes,
      criadoEm: row.criadoEm,
      atualizadoEm: row.atualizadoEm,
    )).toList();
  }

  // Calcular total de vendas do dia
  Future<double> calcularTotalVendasDia(DateTime data) async {
    final inicioDia = DateTime(data.year, data.month, data.day);
    final fimDia = inicioDia.add(const Duration(days: 1));
    
    final query = _database.selectOnly(_database.vendaTable)
      ..addColumns([_database.vendaTable.total.sum()])
      ..where(_database.vendaTable.dataVenda.isBetweenValues(inicioDia, fimDia));
    
    final result = await query.getSingle();
    return result.read(_database.vendaTable.total.sum()) ?? 0.0;
  }

  // Contar vendas do dia
  Future<int> contarVendasDia(DateTime data) async {
    final inicioDia = DateTime(data.year, data.month, data.day);
    final fimDia = inicioDia.add(const Duration(days: 1));
    
    final query = _database.selectOnly(_database.vendaTable)
      ..addColumns([_database.vendaTable.id.count()])
      ..where(_database.vendaTable.dataVenda.isBetweenValues(inicioDia, fimDia));
    
    final result = await query.getSingle();
    return result.read(_database.vendaTable.id.count()) ?? 0;
  }
}