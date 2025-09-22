import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' hide isNotNull;
import '../../lib/core/database/database.dart';

void main() {
  group('Database Tests', () {
    late AppDatabase database;

    setUp(() {
      // Cria um banco de dados em memória para testes
      database = AppDatabase(DatabaseConnection(NativeDatabase.memory()));
    });

    tearDown(() async {
      await database.close();
    });

    test('deve criar tabelas corretamente', () async {
      // Verifica se as tabelas foram criadas
      expect(database.produtoTable, isNotNull);
      expect(database.fornecedorTable, isNotNull);
      expect(database.whatsAppMessagesTable, isNotNull);
      expect(database.whatsAppConfigTable, isNotNull);
    });

    test('deve inserir e buscar produto', () async {
      // Insere um produto de teste
      final produto = ProdutoTableCompanion.insert(
        nome: 'Produto Teste',
        codigo: 'TEST001',
        precoVenda: 10.0,
      );

      final id = await database.into(database.produtoTable).insert(produto);
      expect(id, greaterThan(0));

      // Busca o produto inserido
      final produtos = await database.select(database.produtoTable).get();
      expect(produtos.length, equals(1));
      expect(produtos.first.nome, equals('Produto Teste'));
    });

    test('deve inserir e buscar fornecedor', () async {
      // Insere um fornecedor de teste
      final fornecedor = FornecedorTableCompanion.insert(
        nome: 'Fornecedor Teste',
        razaoSocial: const Value('Fornecedor Teste Ltda'),
      );

      final id = await database.into(database.fornecedorTable).insert(fornecedor);
      expect(id, greaterThan(0));

      // Busca o fornecedor inserido
      final fornecedores = await database.select(database.fornecedorTable).get();
      expect(fornecedores.length, equals(1));
      expect(fornecedores.first.nome, equals('Fornecedor Teste'));
    });
  });
}