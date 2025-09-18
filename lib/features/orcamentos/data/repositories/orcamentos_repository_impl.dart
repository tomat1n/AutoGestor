import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../../orcamentos/domain/entities/orcamento.dart';
import '../../../orcamentos/domain/repositories/orcamentos_repository.dart';
import '../models/orcamento_table.dart' as table;

class OrcamentosRepositoryImpl implements OrcamentosRepository {
  final AppDatabase _database;

  OrcamentosRepositoryImpl(this._database);
  @override
  Future<List<Orcamento>> buscarTodos() async {
    final query = _database.select(_database.orcamentoTable)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    final orcamentosData = await query.get();
    
    final orcamentos = <Orcamento>[];
    for (final data in orcamentosData) {
      final itens = await _buscarItensOrcamento(data.id);
      orcamentos.add(_mapToEntity(data, itens));
    }
    return orcamentos;
  }

  @override
  Future<List<Orcamento>> buscarAtivos() async {
    final query = _database.select(_database.orcamentoTable)
      ..where((tbl) => tbl.ativo.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    final orcamentosData = await query.get();
    
    final orcamentos = <Orcamento>[];
    for (final data in orcamentosData) {
      final itens = await _buscarItensOrcamento(data.id);
      orcamentos.add(_mapToEntity(data, itens));
    }
    return orcamentos;
  }

  @override
  Future<Orcamento?> buscarPorId(int id) async {
    final query = _database.select(_database.orcamentoTable)
      ..where((tbl) => tbl.id.equals(id));
    final orcamentoData = await query.getSingleOrNull();
    
    if (orcamentoData == null) return null;
    
    final itens = await _buscarItensOrcamento(id);
    return _mapToEntity(orcamentoData, itens);
  }

  @override
  Future<Orcamento?> buscarPorNumero(String numero) async {
    return null;
  }

  @override
  Future<List<Orcamento>> buscarPorCliente(int clienteId) async {
    return [];
  }

  @override
  Future<List<Orcamento>> buscarPorStatus(StatusOrcamento status) async {
    return [];
  }

  @override
  Future<List<Orcamento>> buscarVencendoEm(int dias) async {
    return [];
  }

  @override
  Future<List<Orcamento>> buscarPorPeriodo(DateTime inicio, DateTime fim) async {
    return [];
  }

  @override
  Future<int> criar(Orcamento orcamento) async {
    return await _database.transaction(() async {
      // Inserir orçamento
      final orcamentoId = await _database.into(_database.orcamentoTable).insert(
        OrcamentoTableCompanion.insert(
          numero: orcamento.numero,
          valorTotal: orcamento.subtotal,
          valorFinal: orcamento.total,
          clienteId: Value(orcamento.clienteId),
          descricao: Value(orcamento.observacoes),
          desconto: Value(orcamento.desconto),
          status: Value(table.StatusOrcamento.values.firstWhere((e) => e.name == orcamento.status.name)),
          dataVencimento: Value(orcamento.dataValidade),
          observacoes: Value(orcamento.observacoes),
          fotosDefeitoUrls: Value(orcamento.fotosDefeitoUrls?.join(',') ?? ''),
          fotosReposicaoUrls: Value(orcamento.fotosReposicaoUrls?.join(',') ?? ''),
          ativo: Value(orcamento.ativo),
        ),
      );

      // Inserir itens do orçamento
      for (final item in orcamento.itens) {
        await _database.into(_database.itemOrcamentoTable).insert(
          ItemOrcamentoTableCompanion.insert(
            orcamentoId: orcamentoId,
            descricao: item.nomeServico,
            quantidade: item.quantidade,
            valorUnitario: item.valorUnitario,
            valorTotal: item.subtotal,
            produtoId: Value(null),
            servicoId: Value(item.servicoId),
          ),
        );
      }

      return orcamentoId;
    });
  }

  @override
  Future<void> atualizar(Orcamento orcamento) async {
    // Implementação temporária
  }

  @override
  Future<void> excluir(int id) async {
    // Implementação temporária
  }

  @override
  Future<void> alterarStatus(int id, StatusOrcamento status) async {
    // Implementação temporária
  }

  @override
  Future<void> aprovar(int id, DateTime dataAprovacao) async {
    // Implementação temporária
  }

  @override
  Future<void> rejeitar(int id) async {
    // Implementação temporária
  }

  @override
  Future<void> ativarDesativar(int id, bool ativo) async {
    // Implementação temporária
  }

  @override
  Future<String> gerarProximoNumero() async {
    final query = _database.selectOnly(_database.orcamentoTable)
      ..addColumns([_database.orcamentoTable.numero.max()]);
    final result = await query.getSingleOrNull();
    final maxNumero = result?.read(_database.orcamentoTable.numero.max()) ?? '000';
    final numeroInt = int.tryParse(maxNumero) ?? 0;
    return (numeroInt + 1).toString().padLeft(3, '0');
  }

  Future<List<ItemOrcamento>> _buscarItensOrcamento(int orcamentoId) async {
    final query = _database.select(_database.itemOrcamentoTable)
      ..where((tbl) => tbl.orcamentoId.equals(orcamentoId));
    final itensData = await query.get();
    
    return itensData.map((data) => ItemOrcamento(
      id: data.id,
      servicoId: data.servicoId,
      nomeServico: data.descricao,
      quantidade: data.quantidade,
      valorUnitario: data.valorUnitario,
      subtotal: data.valorTotal,
    )).toList();
  }

  StatusOrcamento _mapStatusFromDatabase(table.StatusOrcamento dbStatus) {
    switch (dbStatus) {
      case table.StatusOrcamento.rascunho:
        return StatusOrcamento.rascunho;
      case table.StatusOrcamento.pendente:
        return StatusOrcamento.enviado;
      case table.StatusOrcamento.aprovado:
        return StatusOrcamento.aprovado;
      case table.StatusOrcamento.rejeitado:
        return StatusOrcamento.rejeitado;
      case table.StatusOrcamento.expirado:
        return StatusOrcamento.expirado;
    }
  }

  Orcamento _mapToEntity(OrcamentoData data, List<ItemOrcamento> itens) {
    return Orcamento(
      id: data.id,
      numero: data.numero,
      clienteId: data.clienteId ?? 0,
      nomeCliente: '', // Será preenchido via join com tabela de clientes
      itens: itens,
      subtotal: data.valorTotal,
      desconto: data.desconto,
      total: data.valorFinal,
      status: _mapStatusFromDatabase(data.status),
      dataEmissao: data.createdAt,
      dataValidade: data.dataVencimento,
      observacoes: data.observacoes ?? '',
      fotosDefeitoUrls: data.fotosDefeitoUrls?.isNotEmpty == true ? data.fotosDefeitoUrls!.split(',') : null,
      fotosReposicaoUrls: data.fotosReposicaoUrls?.isNotEmpty == true ? data.fotosReposicaoUrls!.split(',') : null,
      ativo: data.ativo,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}