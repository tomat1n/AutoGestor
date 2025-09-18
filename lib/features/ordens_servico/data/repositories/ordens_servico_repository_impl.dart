import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../domain/entities/ordem_servico.dart';
import '../../domain/repositories/ordens_servico_repository.dart';
import '../models/ordens_servico_table.dart';

class OrdensServicoRepositoryImpl implements OrdensServicoRepository {
  final AppDatabase _database;

  OrdensServicoRepositoryImpl(this._database);

  @override
  Future<List<OrdemServico>> buscarTodas() async {
    final query = _database.select(_database.ordensServicoTable)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    final ordensData = await query.get();
    
    final ordens = <OrdemServico>[];
    for (final data in ordensData) {
      final itens = await _buscarItensOrdemServico(data.id);
      ordens.add(_mapToEntity(data, itens));
    }
    return ordens;
  }

  @override
  Future<List<OrdemServico>> buscarAtivas() async {
    final query = _database.select(_database.ordensServicoTable)
      ..where((tbl) => tbl.ativo.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    final ordensData = await query.get();
    
    final ordens = <OrdemServico>[];
    for (final data in ordensData) {
      final itens = await _buscarItensOrdemServico(data.id);
      ordens.add(_mapToEntity(data, itens));
    }
    return ordens;
  }

  @override
  Future<OrdemServico?> buscarPorId(int id) async {
    final query = _database.select(_database.ordensServicoTable)
      ..where((tbl) => tbl.id.equals(id));
    final ordemData = await query.getSingleOrNull();
    
    if (ordemData == null) return null;
    
    final itens = await _buscarItensOrdemServico(id);
    return _mapToEntity(ordemData, itens);
  }

  @override
  Future<List<OrdemServico>> buscarPorCliente(int clienteId) async {
    final query = _database.select(_database.ordensServicoTable)
      ..where((tbl) => tbl.clienteId.equals(clienteId) & tbl.ativo.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    final ordensData = await query.get();
    
    final ordens = <OrdemServico>[];
    for (final data in ordensData) {
      final itens = await _buscarItensOrdemServico(data.id);
      ordens.add(_mapToEntity(data, itens));
    }
    return ordens;
  }

  @override
  Future<List<OrdemServico>> buscarPorStatus(StatusOrdemServico status) async {
    final query = _database.select(_database.ordensServicoTable)
      ..where((tbl) => tbl.status.equals(status.name) & tbl.ativo.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    final ordensData = await query.get();
    
    final ordens = <OrdemServico>[];
    for (final data in ordensData) {
      final itens = await _buscarItensOrdemServico(data.id);
      ordens.add(_mapToEntity(data, itens));
    }
    return ordens;
  }

  @override
  Future<List<OrdemServico>> buscarPorTecnico(String tecnico) async {
    final query = _database.select(_database.ordensServicoTable)
      ..where((tbl) => tbl.tecnicoResponsavel.equals(tecnico) & tbl.ativo.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    final ordensData = await query.get();
    
    final ordens = <OrdemServico>[];
    for (final data in ordensData) {
      final itens = await _buscarItensOrdemServico(data.id);
      ordens.add(_mapToEntity(data, itens));
    }
    return ordens;
  }

  @override
  Future<List<OrdemServico>> buscarAgendadasPara(DateTime data) async {
    final inicioDia = DateTime(data.year, data.month, data.day);
    final fimDia = inicioDia.add(const Duration(days: 1));
    
    final query = _database.select(_database.ordensServicoTable)
      ..where((tbl) => 
          tbl.dataAgendamento.isBetweenValues(inicioDia, fimDia) &
          tbl.ativo.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.dataAgendamento)]);
    final ordensData = await query.get();
    
    final ordens = <OrdemServico>[];
    for (final data in ordensData) {
      final itens = await _buscarItensOrdemServico(data.id);
      ordens.add(_mapToEntity(data, itens));
    }
    return ordens;
  }

  @override
  Future<List<OrdemServico>> buscarAtrasadas() async {
    final agora = DateTime.now();
    final query = _database.select(_database.ordensServicoTable)
      ..where((tbl) => 
          tbl.dataAgendamento.isSmallerThanValue(agora) &
          tbl.status.isIn([StatusOrdemServico.agendada.name, StatusOrdemServico.emAndamento.name]) &
          tbl.ativo.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.dataAgendamento)]);
    final ordensData = await query.get();
    
    final ordens = <OrdemServico>[];
    for (final data in ordensData) {
      final itens = await _buscarItensOrdemServico(data.id);
      ordens.add(_mapToEntity(data, itens));
    }
    return ordens;
  }

  @override
  Future<List<OrdemServico>> buscarEmAndamento() async {
    final query = _database.select(_database.ordensServicoTable)
      ..where((tbl) => 
          tbl.status.equals(StatusOrdemServico.emAndamento.name) &
          tbl.ativo.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.dataInicio)]);
    final ordensData = await query.get();
    
    final ordens = <OrdemServico>[];
    for (final data in ordensData) {
      final itens = await _buscarItensOrdemServico(data.id);
      ordens.add(_mapToEntity(data, itens));
    }
    return ordens;
  }

  @override
  Future<OrdemServico?> buscarPorNumero(String numero) async {
    final query = _database.select(_database.ordensServicoTable)
      ..where((tbl) => tbl.numero.equals(numero));
    final ordemData = await query.getSingleOrNull();
    
    if (ordemData == null) return null;
    
    final itens = await _buscarItensOrdemServico(ordemData.id);
    return _mapToEntity(ordemData, itens);
  }

  @override
  Future<List<OrdemServico>> buscarPorPrioridade(PrioridadeOrdemServico prioridade) async {
    final query = _database.select(_database.ordensServicoTable)
      ..where((tbl) => tbl.prioridade.equals(prioridade.name) & tbl.ativo.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    final ordensData = await query.get();
    
    final ordens = <OrdemServico>[];
    for (final data in ordensData) {
      final itens = await _buscarItensOrdemServico(data.id);
      ordens.add(_mapToEntity(data, itens));
    }
    return ordens;
  }

  @override
  Future<List<OrdemServico>> buscarPorPeriodo(DateTime inicio, DateTime fim) async {
    final query = _database.select(_database.ordensServicoTable)
      ..where((tbl) => 
          tbl.dataAgendamento.isBetweenValues(inicio, fim) &
          tbl.ativo.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.dataAgendamento)]);
    final ordensData = await query.get();
    
    final ordens = <OrdemServico>[];
    for (final data in ordensData) {
      final itens = await _buscarItensOrdemServico(data.id);
      ordens.add(_mapToEntity(data, itens));
    }
    return ordens;
  }

  @override
  Future<void> ativarDesativar(int id, bool ativo) async {
    await (_database.update(_database.ordensServicoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(OrdensServicoTableCompanion(
          ativo: Value(ativo),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<String> gerarProximoNumero() async {
    final query = _database.selectOnly(_database.ordensServicoTable)
      ..addColumns([_database.ordensServicoTable.id.max()])
      ..where(_database.ordensServicoTable.ativo.equals(true));
    
    final result = await query.getSingleOrNull();
    final ultimoId = result?.read(_database.ordensServicoTable.id.max()) ?? 0;
    final proximoNumero = ultimoId + 1;
    return 'OS${proximoNumero.toString().padLeft(6, '0')}';
  }

  @override
  Future<int> criar(OrdemServico ordemServico) async {
    return await _database.transaction(() async {
      // Inserir ordem de serviço
      final ordemCompanion = OrdensServicoTableCompanion(
        numero: Value(ordemServico.numero),
        clienteId: Value(ordemServico.clienteId),
        nomeCliente: Value(ordemServico.nomeCliente),
        emailCliente: Value(ordemServico.emailCliente),
        telefoneCliente: Value(ordemServico.telefoneCliente),
        subtotal: Value(ordemServico.subtotal),
        desconto: Value(ordemServico.desconto),
        total: Value(ordemServico.total),
        status: Value(ordemServico.status.name),
        prioridade: Value(ordemServico.prioridade.name),
        dataAgendamento: Value(ordemServico.dataAgendamento),
        dataPrevista: Value(ordemServico.dataPrevista),
        observacoes: Value(ordemServico.observacoes),
        observacoesInternas: Value(ordemServico.observacoesInternas),
        tecnicoResponsavel: Value(ordemServico.tecnicoResponsavel),
        equipamento: Value(ordemServico.equipamento),
        problemaRelatado: Value(ordemServico.problemaRelatado),
        updatedAt: Value(DateTime.now()),
      );
      
      final ordemId = await _database.into(_database.ordensServicoTable).insert(ordemCompanion);
      
      // Inserir itens
      for (final item in ordemServico.itens) {
        final itemCompanion = ItensOrdemServicoTableCompanion(
          ordemServicoId: Value(ordemId),
          servicoId: Value(item.servicoId),
          nomeServico: Value(item.nomeServico),
          descricaoServico: Value(item.descricaoServico),
          quantidade: Value(item.quantidade),
          valorUnitario: Value(item.valorUnitario),
          subtotal: Value(item.subtotal),
          duracaoMinutos: Value(item.duracaoMinutos),
        );
        await _database.into(_database.itensOrdemServicoTable).insert(itemCompanion);
      }
      
      return ordemId;
    });
  }

  @override
  Future<void> atualizar(OrdemServico ordemServico) async {
    await _database.transaction(() async {
      // Atualizar ordem de serviço
      final ordemCompanion = OrdensServicoTableCompanion(
        id: Value(ordemServico.id!),
        numero: Value(ordemServico.numero),
        clienteId: Value(ordemServico.clienteId),
        nomeCliente: Value(ordemServico.nomeCliente),
        emailCliente: Value(ordemServico.emailCliente),
        telefoneCliente: Value(ordemServico.telefoneCliente),
        subtotal: Value(ordemServico.subtotal),
        desconto: Value(ordemServico.desconto),
        total: Value(ordemServico.total),
        status: Value(ordemServico.status.name),
        prioridade: Value(ordemServico.prioridade.name),
        dataAgendamento: Value(ordemServico.dataAgendamento),
        dataPrevista: Value(ordemServico.dataPrevista),
        dataInicio: Value(ordemServico.dataInicio),
        dataConclusao: Value(ordemServico.dataConclusao),
        observacoes: Value(ordemServico.observacoes),
        observacoesInternas: Value(ordemServico.observacoesInternas),
        tecnicoResponsavel: Value(ordemServico.tecnicoResponsavel),
        equipamento: Value(ordemServico.equipamento),
        problemaRelatado: Value(ordemServico.problemaRelatado),
        solucaoAplicada: Value(ordemServico.solucaoAplicada),
        updatedAt: Value(DateTime.now()),
      );
      
      await (_database.update(_database.ordensServicoTable)
            ..where((tbl) => tbl.id.equals(ordemServico.id!)))
          .write(ordemCompanion);
      
      // Remover itens existentes
      await (_database.delete(_database.itensOrdemServicoTable)
            ..where((tbl) => tbl.ordemServicoId.equals(ordemServico.id!)))
          .go();
      
      // Inserir novos itens
      for (final item in ordemServico.itens) {
        final itemCompanion = ItensOrdemServicoTableCompanion(
          ordemServicoId: Value(ordemServico.id!),
          servicoId: Value(item.servicoId),
          nomeServico: Value(item.nomeServico),
          descricaoServico: Value(item.descricaoServico),
          quantidade: Value(item.quantidade),
          valorUnitario: Value(item.valorUnitario),
          subtotal: Value(item.subtotal),
          duracaoMinutos: Value(item.duracaoMinutos),
        );
        await _database.into(_database.itensOrdemServicoTable).insert(itemCompanion);
      }
    });
  }

  @override
  Future<void> iniciarExecucao(int id, DateTime dataInicio) async {
    await (_database.update(_database.ordensServicoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(OrdensServicoTableCompanion(
          status: Value(StatusOrdemServico.emAndamento.name),
          dataInicio: Value(dataInicio),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<void> pausarExecucao(int id) async {
    await (_database.update(_database.ordensServicoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(OrdensServicoTableCompanion(
          status: Value(StatusOrdemServico.pausada.name),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<void> concluirExecucao(int id, DateTime dataConclusao, String? solucaoAplicada) async {
    await (_database.update(_database.ordensServicoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(OrdensServicoTableCompanion(
          status: Value(StatusOrdemServico.concluida.name),
          dataConclusao: Value(dataConclusao),
          solucaoAplicada: Value(solucaoAplicada),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<void> cancelar(int id) async {
    await (_database.update(_database.ordensServicoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(OrdensServicoTableCompanion(
          status: Value(StatusOrdemServico.cancelada.name),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<void> reagendar(int id, DateTime novaData) async {
    await (_database.update(_database.ordensServicoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(OrdensServicoTableCompanion(
          dataAgendamento: Value(novaData),
          status: Value(StatusOrdemServico.agendada.name),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<void> alterarStatus(int id, StatusOrdemServico novoStatus) async {
    await (_database.update(_database.ordensServicoTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(OrdensServicoTableCompanion(
          status: Value(novoStatus.name),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<void> excluir(int id) async {
    await _database.transaction(() async {
      // Excluir itens
      await (_database.delete(_database.itensOrdemServicoTable)
            ..where((tbl) => tbl.ordemServicoId.equals(id)))
          .go();
      
      // Excluir ordem de serviço
      await (_database.delete(_database.ordensServicoTable)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
    });
  }

  Future<List<ItemOrdemServico>> _buscarItensOrdemServico(int ordemServicoId) async {
    final query = _database.select(_database.itensOrdemServicoTable)
      ..where((tbl) => tbl.ordemServicoId.equals(ordemServicoId));
    final itensData = await query.get();
    
    return itensData.map((data) => ItemOrdemServico(
      servicoId: data.servicoId,
      nomeServico: data.nomeServico,
      descricaoServico: data.descricaoServico,
      quantidade: data.quantidade,
      valorUnitario: data.valorUnitario,
      subtotal: data.subtotal,
      duracaoMinutos: data.duracaoMinutos,
    )).toList();
  }

  OrdemServico _mapToEntity(OrdensServicoTableData data, List<ItemOrdemServico> itens) {
    return OrdemServico(
      id: data.id,
      numero: data.numero,
      clienteId: data.clienteId,
      nomeCliente: data.nomeCliente,
      emailCliente: data.emailCliente,
      telefoneCliente: data.telefoneCliente,
      itens: itens,
      subtotal: data.subtotal,
      desconto: data.desconto,
      total: data.total,
      status: StatusOrdemServico.values.firstWhere((s) => s.name == data.status),
      prioridade: PrioridadeOrdemServico.values.firstWhere((p) => p.name == data.prioridade),
      dataAgendamento: data.dataAgendamento,
      dataPrevista: data.dataPrevista,
      dataInicio: data.dataInicio,
      dataConclusao: data.dataConclusao,
      observacoes: data.observacoes,
      observacoesInternas: data.observacoesInternas,
      tecnicoResponsavel: data.tecnicoResponsavel,
      equipamento: data.equipamento,
      problemaRelatado: data.problemaRelatado,
      solucaoAplicada: data.solucaoAplicada,
      ativo: data.ativo,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}