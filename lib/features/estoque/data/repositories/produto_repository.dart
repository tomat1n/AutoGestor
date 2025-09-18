import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../domain/entities/produto.dart';
class ProdutoRepository {
  final AppDatabase _database;

  ProdutoRepository(this._database);

  // Buscar todos os produtos
  Future<List<ProdutoTableData>> buscarTodos() async {
    return await _database.select(_database.produtoTable).get();
  }

  // Buscar produtos ativos
  Future<List<ProdutoTableData>> buscarAtivos() async {
    return await (_database.select(_database.produtoTable)
          ..where((tbl) => tbl.ativo.equals(true)))
        .get();
  }

  // Buscar produto por ID
  Future<ProdutoTableData?> buscarPorId(int id) async {
    return await (_database.select(_database.produtoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  // Buscar produto por código
  Future<ProdutoTableData?> buscarPorCodigo(String codigo) async {
    return await (_database.select(_database.produtoTable)
          ..where((tbl) => tbl.codigo.equals(codigo)))
        .getSingleOrNull();
  }

  // Buscar produto por código de barras
  Future<ProdutoTableData?> buscarPorCodigoBarras(String codigoBarras) async {
    return await (_database.select(_database.produtoTable)
          ..where((tbl) => tbl.codigoBarras.equals(codigoBarras)))
        .getSingleOrNull();
  }

  // Buscar produto por QR Code
  Future<ProdutoTableData?> buscarPorQrCode(String qrCode) async {
    return await (_database.select(_database.produtoTable)
          ..where((tbl) => tbl.qrCode.equals(qrCode)))
        .getSingleOrNull();
  }

  // Buscar produtos por nome (busca parcial)
  Future<List<ProdutoTableData>> buscarPorNome(String nome) async {
    return await (_database.select(_database.produtoTable)
          ..where((tbl) => tbl.nome.like('%$nome%')))
        .get();
  }

  // Buscar produtos por categoria
  Future<List<ProdutoTableData>> buscarPorCategoria(String categoria) async {
    return await (_database.select(_database.produtoTable)
          ..where((tbl) => tbl.categoria.equals(categoria)))
        .get();
  }

  // Buscar produtos com estoque baixo
  Future<List<ProdutoTableData>> buscarEstoqueBaixo() async {
    return await (_database.select(_database.produtoTable)
          ) // Removido filtro de quantidade pois não existe mais na tabela
        .get();
  }

  // Criar produto
  Future<int> criar(ProdutoTableCompanion produto) async {
    print('Repository: Tentando inserir produto no banco: ${produto.nome.value}');
    try {
      final id = await _database.into(_database.produtoTable).insert(produto);
      print('Repository: Produto inserido com sucesso, ID: $id');
      return id;
    } catch (e) {
      print('Repository: Erro ao inserir produto: $e');
      rethrow;
    }
  }

  // Atualizar produto
  Future<bool> atualizar(int id, ProdutoTableCompanion produto) async {
    return await (_database.update(_database.produtoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(produto.copyWith(updatedAt: Value(DateTime.now()))) > 0;
  }

  // Deletar produto (soft delete)
  Future<bool> deletar(int id) async {
    return await (_database.update(_database.produtoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(ProdutoTableCompanion(
          ativo: const Value(false),
          updatedAt: Value(DateTime.now()),
        )) > 0;
  }

  // Deletar produto permanentemente
  Future<bool> deletarPermanente(int id) async {
    return await (_database.delete(_database.produtoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go() > 0;
  }

  // Atualizar quantidade do produto
  Future<bool> atualizarQuantidade(int id, int novaQuantidade) async {
    return await (_database.update(_database.produtoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(ProdutoTableCompanion(
          quantidade: Value(novaQuantidade),
          updatedAt: Value(DateTime.now()),
        )) > 0;
  }

  // Reduzir quantidade do produto (para vendas)
  Future<bool> reduzirQuantidade(int id, int quantidadeVendida) async {
    final produto = await buscarPorId(id);
    if (produto == null) return false;
    
    final novaQuantidade = produto.quantidade - quantidadeVendida;
    if (novaQuantidade < 0) return false; // Não permite estoque negativo
    
    return await atualizarQuantidade(id, novaQuantidade);
  }

  // Adicionar quantidade do produto (para reposição)
  Future<bool> adicionarQuantidade(int id, int quantidadeAdicionada) async {
    final produto = await buscarPorId(id);
    if (produto == null) return false;
    
    final novaQuantidade = produto.quantidade + quantidadeAdicionada;
    return await atualizarQuantidade(id, novaQuantidade);
  }

  // Buscar todas as categorias únicas
  Future<List<String>> buscarCategorias() async {
    final query = _database.selectOnly(_database.produtoTable)
      ..addColumns([_database.produtoTable.categoria])
      ..where(_database.produtoTable.categoria.isNotNull())
      ..groupBy([_database.produtoTable.categoria]);
    
    final result = await query.get();
    return result
        .map((row) => row.read(_database.produtoTable.categoria))
        .where((categoria) => categoria != null)
        .cast<String>()
        .toList();
  }

  // Contar total de produtos
  Future<int> contarTotal() async {
    final query = _database.selectOnly(_database.produtoTable)
      ..addColumns([_database.produtoTable.id.count()]);
    
    final result = await query.getSingle();
    return result.read(_database.produtoTable.id.count()) ?? 0;
  }

  // Contar produtos ativos
  Future<int> contarAtivos() async {
    final query = _database.selectOnly(_database.produtoTable)
      ..addColumns([_database.produtoTable.id.count()])
      ..where(_database.produtoTable.ativo.equals(true));
    
    final result = await query.getSingle();
    return result.read(_database.produtoTable.id.count()) ?? 0;
  }

  // Buscar produtos com estoque atual
  Future<List<Produto>> buscarProdutosComEstoque() async {
    final produtosData = await buscarTodos();
    
    return produtosData.map((data) {
      return _mapToEntity(data, data.quantidade);
    }).toList();
  }

  // Buscar produtos ativos com estoque atual
  Future<List<Produto>> buscarProdutosAtivosComEstoque() async {
    final produtosData = await buscarAtivos();
    
    return produtosData.map((data) {
      return _mapToEntity(data, data.quantidade);
    }).toList();
  }

  // Buscar produto por ID com estoque atual
  Future<Produto?> buscarPorIdComEstoque(int id) async {
    final produtoData = await buscarPorId(id);
    if (produtoData == null) return null;
    
    return _mapToEntity(produtoData, produtoData.quantidade);
  }

  // Buscar produtos com estoque baixo
  Future<List<Produto>> buscarProdutosEstoqueBaixoComEstoque() async {
    final produtosData = await buscarTodos();
    
    final produtosEstoqueBaixo = <Produto>[];
    
    for (final data in produtosData) {
      final produto = _mapToEntity(data, data.quantidade);
      
      if (produto.estoqueBaixo) {
        produtosEstoqueBaixo.add(produto);
      }
    }
    
    return produtosEstoqueBaixo;
  }

  // Mapear ProdutoTableData para Produto com estoque atual
  Produto _mapToEntity(ProdutoTableData data, int estoqueAtual) {
    return Produto(
      id: data.id,
      codigo: data.codigo ?? '',
      nome: data.nome,
      descricao: data.descricao,
      codigoBarras: data.codigoBarras,
      precoCompra: data.precoCompra ?? 0.0,
      precoVenda: data.precoVenda ?? 0.0,
      categoria: data.categoria,
      unidade: data.unidade ?? 'UN',
      estoqueMinimo: data.estoqueMinimo ?? 0,
      quantidade: data.quantidade ?? 0,
      ativo: data.ativo ?? true,
      imagemPath: data.imagemPath,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      estoqueAtual: estoqueAtual,
    );
  }
}