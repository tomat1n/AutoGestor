import 'package:drift/drift.dart';

// Conditional imports for different platforms


import '../../features/estoque/data/models/produto_table.dart';
import '../../features/estoque/data/models/fornecedor_table.dart';
import '../../features/estoque/data/models/pedido_compra_table.dart';
import '../../features/estoque/data/models/item_compra_table.dart';

import '../../features/pdv/data/models/venda_table.dart';
import '../../features/pdv/data/models/item_venda_table.dart';
import '../../features/clientes/data/models/cliente_table.dart';
import '../../features/servicos/data/models/servicos_table.dart';
import '../../features/orcamentos/data/models/orcamento_table.dart';
import '../../features/ordens_servico/data/models/ordens_servico_table.dart';
import 'models/auditoria_table.dart';
import 'models/empresa_config_table.dart';
import 'models/usuario_table.dart';
import 'models/assinatura_table.dart';
import 'tables/whatsapp_messages_table.dart';
import 'tables/whatsapp_config_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  ProdutoTable,
  FornecedorTable,
  PedidoCompraTable,
  ItemCompraTable,
  VendaTable,
  ItemVendaTable,
  ClienteTable,
  ServicosTable,
  OrcamentoTable,
  ItemOrcamentoTable,
  OrdensServicoTable,
  ItensOrdemServicoTable,
  AuditoriaTable,
  EmpresaConfigs,
  UsuarioTable,
  AssinaturaTable,
  WhatsAppMessagesTable,
  WhatsAppConfigTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(DatabaseConnection super.connection);

  @override
  int get schemaVersion => 15;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Migração da versão 1 para 2
          // Adicionar tabela fornecedores
          await m.createTable(fornecedorTable);
          
          // Adicionar novos campos na tabela produtos
          await m.addColumn(produtoTable, produtoTable.precoCompra);
          await m.addColumn(produtoTable, produtoTable.precoVenda);
          await m.addColumn(produtoTable, produtoTable.codigoBarras);
          await m.addColumn(produtoTable, produtoTable.qrCode);
          await m.addColumn(produtoTable, produtoTable.imagemPath);
        }
        if (from < 3) {
          // Migração da versão 2 para 3
          // Adicionar tabela auditoria
          await m.createTable(auditoriaTable);
        }
        if (from < 4) {
          // Migração da versão 3 para 4
          // Adicionar tabelas de vendas
          await m.createTable(vendaTable);
          await m.createTable(itemVendaTable);
        }
        if (from < 5) {
          // Migração da versão 4 para 5
          // Adicionar campo quantidade na tabela produtos
          await m.addColumn(produtoTable, produtoTable.quantidade);
        }
        if (from < 6) {
          // Migração da versão 5 para 6
          // Adicionar tabela de configurações da empresa
          await m.createTable(empresaConfigs);
        }
        if (from < 7) {
          // Migração da versão 6 para 7
          // Adicionar tabela de clientes
          await m.createTable(clienteTable);
        }
        if (from < 8) {
          // Migração da versão 7 para 8
          // Adicionar tabela de usuários
          await m.createTable(usuarioTable);
        }
        if (from < 9) {
          // Migração da versão 8 para 9
          // Adicionar tabela de assinaturas
          await m.createTable(assinaturaTable);
        }
        if (from < 10) {
          // Migração da versão 9 para 10
          // Adicionar campo role na tabela de usuários
          await m.addColumn(usuarioTable, usuarioTable.role);
        }
        if (from < 11) {
          // Migração da versão 10 para 11
          // Adicionar tabela de serviços
          await m.createTable(servicosTable);
        }
        if (from < 12) {
          // Migração da versão 11 para 12
          // Adicionar tabelas do WhatsApp
          await m.createTable(whatsAppMessagesTable);
          await m.createTable(whatsAppConfigTable);
        }
        if (from < 13) {
          // Migração da versão 12 para 13
          // Adicionar tabelas de orçamentos
          await m.createTable(orcamentoTable);
          await m.createTable(itemOrcamentoTable);
        }
        if (from < 14) {
          // Migração da versão 13 para 14
          // Adicionar tabelas de ordens de serviço
          await m.createTable(ordensServicoTable);
          await m.createTable(itensOrdemServicoTable);
        }
        if (from < 15) {
          // Migração da versão 14 para 15
          // Adicionar campos de fotos na tabela de orçamentos
          await m.addColumn(orcamentoTable, orcamentoTable.fotosDefeitoUrls);
          await m.addColumn(orcamentoTable, orcamentoTable.fotosReposicaoUrls);
        }
      },
    );
  }
}