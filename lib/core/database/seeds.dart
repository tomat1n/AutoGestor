import 'package:drift/drift.dart';
import 'database.dart';

class DatabaseSeeds {
  final AppDatabase _database;

  DatabaseSeeds(this._database);

  /// Executa todos os seeds do banco de dados
  Future<void> executarSeeds() async {
    await _criarProdutosECategorias();
    await _criarClientes();
  }

  /// Cria produtos e categorias para testes do PDV
  Future<void> _criarProdutosECategorias() async {
    // Verificar se já existem produtos
    final produtosExistentes = await _database.select(_database.produtoTable).get();
    if (produtosExistentes.isNotEmpty) {
      print('Seeds já executados - produtos já existem no banco');
      return;
    }

    print('Executando seeds - criando produtos e categorias...');

    final agora = DateTime.now();

    // Lista de produtos para inserir
    final produtos = [
      // Categoria: Eletrônicos
      ProdutoTableCompanion(
        codigo: const Value('ELE001'),
        nome: const Value('Smartphone Samsung Galaxy A54'),
        descricao: const Value('Smartphone Android com 128GB de armazenamento'),
        precoCompra: const Value(800.00),
        precoVenda: const Value(1200.00),
        categoria: const Value('Eletrônicos'),
        unidade: const Value('UN'),
        estoqueMinimo: const Value(5),
        codigoBarras: const Value('7891234567890'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ProdutoTableCompanion(
        codigo: const Value('ELE002'),
        nome: const Value('Fone de Ouvido Bluetooth JBL'),
        descricao: const Value('Fone sem fio com cancelamento de ruído'),
        precoCompra: const Value(150.00),
        precoVenda: const Value(250.00),
        categoria: const Value('Eletrônicos'),
        unidade: const Value('UN'),
        estoqueMinimo: const Value(10),
        codigoBarras: const Value('7891234567891'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ProdutoTableCompanion(
        codigo: const Value('ELE003'),
        nome: const Value('Carregador USB-C 65W'),
        descricao: const Value('Carregador rápido universal USB-C'),
        precoCompra: const Value(45.00),
        precoVenda: const Value(80.00),
        categoria: const Value('Eletrônicos'),
        unidade: const Value('UN'),
        estoqueMinimo: const Value(15),
        codigoBarras: const Value('7891234567892'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),

      // Categoria: Casa e Jardim
      ProdutoTableCompanion(
        codigo: const Value('CAS001'),
        nome: const Value('Aspirador de Pó Vertical'),
        descricao: const Value('Aspirador sem fio com bateria recarregável'),
        precoCompra: const Value(200.00),
        precoVenda: const Value(350.00),
        categoria: const Value('Casa e Jardim'),
        unidade: const Value('UN'),
        estoqueMinimo: const Value(3),
        codigoBarras: const Value('7891234567893'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ProdutoTableCompanion(
        codigo: const Value('CAS002'),
        nome: const Value('Jogo de Panelas Antiaderente'),
        descricao: const Value('Kit com 5 panelas antiaderentes'),
        precoCompra: const Value(120.00),
        precoVenda: const Value(220.00),
        categoria: const Value('Casa e Jardim'),
        unidade: const Value('KIT'),
        estoqueMinimo: const Value(5),
        codigoBarras: const Value('7891234567894'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ProdutoTableCompanion(
        codigo: const Value('CAS003'),
        nome: const Value('Luminária LED de Mesa'),
        descricao: const Value('Luminária ajustável com controle de intensidade'),
        precoCompra: const Value(60.00),
        precoVenda: const Value(120.00),
        categoria: const Value('Casa e Jardim'),
        unidade: const Value('UN'),
        estoqueMinimo: const Value(8),
        codigoBarras: const Value('7891234567895'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ProdutoTableCompanion(
        codigo: const Value('CAS004'),
        nome: const Value('Vaso Decorativo Cerâmica'),
        descricao: const Value('Vaso decorativo para plantas médio'),
        precoCompra: const Value(25.00),
        precoVenda: const Value(50.00),
        categoria: const Value('Casa e Jardim'),
        unidade: const Value('UN'),
        estoqueMinimo: const Value(12),
        codigoBarras: const Value('7891234567896'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),

      // Categoria: Esporte e Lazer
      ProdutoTableCompanion(
        codigo: const Value('ESP001'),
        nome: const Value('Tênis de Corrida Nike'),
        descricao: const Value('Tênis esportivo para corrida - Tamanho 42'),
        precoCompra: const Value(180.00),
        precoVenda: const Value(320.00),
        categoria: const Value('Esporte e Lazer'),
        unidade: const Value('PAR'),
        estoqueMinimo: const Value(6),
        codigoBarras: const Value('7891234567897'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ProdutoTableCompanion(
        codigo: const Value('ESP002'),
        nome: const Value('Garrafa Térmica 500ml'),
        descricao: const Value('Garrafa térmica de aço inoxidável'),
        precoCompra: const Value(35.00),
        precoVenda: const Value(70.00),
        categoria: const Value('Esporte e Lazer'),
        unidade: const Value('UN'),
        estoqueMinimo: const Value(20),
        codigoBarras: const Value('7891234567898'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ProdutoTableCompanion(
        codigo: const Value('ESP003'),
        nome: const Value('Bola de Futebol Oficial'),
        descricao: const Value('Bola de futebol campo tamanho oficial'),
        precoCompra: const Value(40.00),
        precoVenda: const Value(80.00),
        categoria: const Value('Esporte e Lazer'),
        unidade: const Value('UN'),
        estoqueMinimo: const Value(10),
        codigoBarras: const Value('7891234567899'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
    ];

    // Inserir produtos no banco
    for (final produto in produtos) {
      await _database.into(_database.produtoTable).insert(produto);
    }

    // Criar movimentações de entrada para dar estoque inicial aos produtos
    await _criarEstoqueInicial();
    
    // Criar vendas de teste
    await _criarVendasTeste();

    print('Seeds executados com sucesso!');
    print('- 10 produtos criados em 3 categorias');
    print('- Estoque inicial adicionado para todos os produtos');
    print('- Vendas de teste criadas para demonstração');
  }

  /// Cria movimentações de entrada para dar estoque inicial aos produtos
  Future<void> _criarEstoqueInicial() async {
    final produtos = await _database.select(_database.produtoTable).get();
    final agora = DateTime.now();

    for (final produto in produtos) {
      // Definir quantidade inicial diretamente no produto
      final quantidadeInicial = produto.estoqueMinimo * 3; // 3x o estoque mínimo
      
      await (_database.update(_database.produtoTable)
            ..where((p) => p.id.equals(produto.id)))
          .write(ProdutoTableCompanion(
            quantidade: Value(quantidadeInicial),
            updatedAt: Value(agora),
          ));
    }
  }

  /// Cria vendas de teste para demonstração do histórico
  Future<void> _criarVendasTeste() async {
    final produtos = await _database.select(_database.produtoTable).get();
    final agora = DateTime.now();
    
    // Criar vendas dos últimos 30 dias
    for (int i = 0; i < 15; i++) {
      final dataVenda = agora.subtract(Duration(days: i * 2));
      
      // Inserir venda
      final vendaId = await _database.into(_database.vendaTable).insert(
        VendaTableCompanion(
          dataVenda: Value(dataVenda),
          subtotal: const Value(0.0),
          total: const Value(0.0), // Será calculado depois
          formaPagamento: const Value('Dinheiro'),
          criadoEm: Value(dataVenda),
          atualizadoEm: Value(dataVenda),
        ),
      );
      
      double valorTotalVenda = 0.0;
      
      // Adicionar 1-3 itens por venda
      final numItens = 1 + (i % 3);
      for (int j = 0; j < numItens; j++) {
        final produto = produtos[j % produtos.length];
        final quantidade = 1 + (i % 3);
        final valorUnitario = produto.precoVenda;
        final valorTotal = valorUnitario * quantidade;
        
        // Inserir item da venda
        await _database.into(_database.itemVendaTable).insert(
          ItemVendaTableCompanion(
            vendaId: Value(vendaId),
            produtoId: Value(produto.id),
            quantidade: Value(quantidade),
            precoUnitario: Value(valorUnitario),
            subtotal: Value(valorTotal),
            criadoEm: Value(dataVenda),
          ),
        );
        
        valorTotalVenda += valorTotal;
        
        // Atualizar estoque do produto
        final novaQuantidade = produto.quantidade - quantidade;
        await (_database.update(_database.produtoTable)
              ..where((p) => p.id.equals(produto.id)))
            .write(ProdutoTableCompanion(
              quantidade: Value(novaQuantidade),
              updatedAt: Value(dataVenda),
            ));
      }
      
      // Atualizar valor total da venda
      await (_database.update(_database.vendaTable)
            ..where((v) => v.id.equals(vendaId)))
          .write(VendaTableCompanion(
            subtotal: Value(valorTotalVenda),
            total: Value(valorTotalVenda),
            atualizadoEm: Value(dataVenda),
          ));
    }
  }

  /// Limpa todos os dados de teste (útil para desenvolvimento)
  Future<void> limparDadosTeste() async {
    print('Limpando dados de teste...');
    
    // Limpar na ordem correta devido às foreign keys
    await _database.delete(_database.itemVendaTable).go();
    await _database.delete(_database.vendaTable).go();
    await _database.delete(_database.produtoTable).go();
    await _database.delete(_database.clienteTable).go();
    
    print('Dados de teste removidos com sucesso!');
  }

  /// Cria clientes para testes
  Future<void> _criarClientes() async {
    // Verificar se já existem clientes
    final clientesExistentes = await _database.select(_database.clienteTable).get();
    if (clientesExistentes.isNotEmpty) {
      print('Seeds de clientes já executados - clientes já existem no banco');
      return;
    }

    print('Executando seeds - criando clientes...');

    final agora = DateTime.now();

    // Lista de clientes para inserir
    final clientes = [
      ClienteTableCompanion(
        nome: const Value('João Silva Santos'),
        email: const Value('joao.silva@email.com'),
        telefone: const Value('(11) 99999-1234'),
        cpfCnpj: const Value('123.456.789-01'),
        endereco: const Value('Rua das Flores, 123'),
        cidade: const Value('São Paulo'),
        estado: const Value('SP'),
        cep: const Value('01234-567'),
        observacoes: const Value('Cliente preferencial'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ClienteTableCompanion(
        nome: const Value('Maria Oliveira Costa'),
        email: const Value('maria.oliveira@email.com'),
        telefone: const Value('(11) 98888-5678'),
        cpfCnpj: const Value('987.654.321-09'),
        endereco: const Value('Av. Paulista, 1000'),
        cidade: const Value('São Paulo'),
        estado: const Value('SP'),
        cep: const Value('01310-100'),
        observacoes: const Value('Compra sempre eletrônicos'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ClienteTableCompanion(
        nome: const Value('Pedro Almeida Ltda'),
        email: const Value('contato@pedroalmeida.com.br'),
        telefone: const Value('(11) 3333-4444'),
        cpfCnpj: const Value('12.345.678/0001-90'),
        endereco: const Value('Rua do Comércio, 456'),
        cidade: const Value('São Paulo'),
        estado: const Value('SP'),
        cep: const Value('04567-890'),
        observacoes: const Value('Empresa - compras em grande volume'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ClienteTableCompanion(
        nome: const Value('Ana Carolina Ferreira'),
        email: const Value('ana.ferreira@gmail.com'),
        telefone: const Value('(21) 97777-8888'),
        cpfCnpj: const Value('456.789.123-45'),
        endereco: const Value('Rua Copacabana, 789'),
        cidade: const Value('Rio de Janeiro'),
        estado: const Value('RJ'),
        cep: const Value('22070-011'),
        observacoes: const Value('Prefere pagamento à vista'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ClienteTableCompanion(
        nome: const Value('Carlos Eduardo Souza'),
        email: const Value('carlos.souza@hotmail.com'),
        telefone: const Value('(31) 96666-7777'),
        cpfCnpj: const Value('789.123.456-78'),
        endereco: const Value('Rua Minas Gerais, 321'),
        cidade: const Value('Belo Horizonte'),
        estado: const Value('MG'),
        cep: const Value('30112-000'),
        observacoes: const Value('Cliente desde 2020'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
      ClienteTableCompanion(
        nome: const Value('Fernanda Lima'),
        email: const Value('fernanda.lima@yahoo.com'),
        telefone: const Value('(85) 95555-6666'),
        cpfCnpj: const Value('321.654.987-12'),
        endereco: const Value('Av. Beira Mar, 654'),
        cidade: const Value('Fortaleza'),
        estado: const Value('CE'),
        cep: const Value('60165-121'),
        observacoes: const Value('Gosta de produtos de casa'),
        ativo: const Value(true),
        createdAt: Value(agora),
        updatedAt: Value(agora),
      ),
    ];

    // Inserir clientes
    for (final cliente in clientes) {
      await _database.into(_database.clienteTable).insert(cliente);
    }

    print('${clientes.length} clientes criados com sucesso!');
  }
}