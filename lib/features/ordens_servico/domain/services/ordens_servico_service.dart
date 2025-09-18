import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/ordem_servico.dart';
import '../repositories/ordens_servico_repository.dart';
import '../../data/repositories/ordens_servico_repository_impl.dart';
import '../../../servicos/domain/entities/servico.dart';
import '../../../clientes/domain/entities/cliente.dart';
import 'ordens_servico_whatsapp_service.dart';
import '../../../../core/providers/database_provider.dart';

class OrdensServicoService {
  final OrdensServicoRepository _repository;
  final OrdensServicoWhatsAppService? _whatsappService;

  OrdensServicoService(this._repository, [this._whatsappService]);

  // Buscar ordens de serviço
  Future<List<OrdemServico>> buscarTodas() async {
    return await _repository.buscarTodas();
  }

  Future<List<OrdemServico>> buscarAtivas() async {
    return await _repository.buscarAtivas();
  }

  Future<OrdemServico?> buscarPorId(int id) async {
    return await _repository.buscarPorId(id);
  }

  Future<List<OrdemServico>> buscarPorCliente(int clienteId) async {
    return await _repository.buscarPorCliente(clienteId);
  }

  Future<List<OrdemServico>> buscarPorStatus(StatusOrdemServico status) async {
    return await _repository.buscarPorStatus(status);
  }

  Future<List<OrdemServico>> buscarPorTecnico(String tecnico) async {
    return await _repository.buscarPorTecnico(tecnico);
  }

  Future<List<OrdemServico>> buscarAgendadasPara(DateTime data) async {
    return await _repository.buscarAgendadasPara(data);
  }

  Future<List<OrdemServico>> buscarAtrasadas() async {
    return await _repository.buscarAtrasadas();
  }

  Future<List<OrdemServico>> buscarEmAndamento() async {
    return await _repository.buscarEmAndamento();
  }

  // Criar ordem de serviço
  Future<OrdemServico> criarOrdemServico({
    required Cliente cliente,
    required List<ItemOrdemServico> itens,
    required DateTime dataAgendamento,
    PrioridadeOrdemServico prioridade = PrioridadeOrdemServico.media,
    DateTime? dataPrevista,
    double desconto = 0.0,
    String? observacoes,
    String? observacoesInternas,
    String? tecnicoResponsavel,
    String? equipamento,
    String? problemaRelatado,
  }) async {
    if (itens.isEmpty) {
      throw Exception('Ordem de serviço deve conter pelo menos um item');
    }

    if (dataAgendamento.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      throw Exception('Data de agendamento não pode ser no passado');
    }

    final numero = await _repository.gerarProximoNumero();
    final subtotal = _calcularSubtotal(itens);
    final total = subtotal - desconto;

    if (total < 0) {
      throw Exception('Desconto não pode ser maior que o subtotal');
    }

    final ordemServico = OrdemServico(
      numero: numero,
      clienteId: cliente.id!,
      nomeCliente: cliente.nome,
      emailCliente: cliente.email,
      telefoneCliente: cliente.telefone,
      itens: itens,
      subtotal: subtotal,
      desconto: desconto,
      total: total,
      status: StatusOrdemServico.agendada,
      prioridade: prioridade,
      dataAgendamento: dataAgendamento,
      dataPrevista: dataPrevista,
      observacoes: observacoes,
      observacoesInternas: observacoesInternas,
      tecnicoResponsavel: tecnicoResponsavel,
      equipamento: equipamento,
      problemaRelatado: problemaRelatado,
    );

    final id = await _repository.criar(ordemServico);
    return ordemServico.copyWith(id: id);
  }

  // Editar ordem de serviço
  Future<OrdemServico> editarOrdemServico({
    required int id,
    List<ItemOrdemServico>? itens,
    DateTime? dataAgendamento,
    PrioridadeOrdemServico? prioridade,
    DateTime? dataPrevista,
    double? desconto,
    String? observacoes,
    String? observacoesInternas,
    String? tecnicoResponsavel,
    String? equipamento,
    String? problemaRelatado,
  }) async {
    final ordemExistente = await _repository.buscarPorId(id);
    if (ordemExistente == null) {
      throw Exception('Ordem de serviço não encontrada');
    }

    if (ordemExistente.status == StatusOrdemServico.concluida) {
      throw Exception('Não é possível editar ordem de serviço concluída');
    }

    final itensAtualizados = itens ?? ordemExistente.itens;
    final descontoAtualizado = desconto ?? ordemExistente.desconto;
    
    if (itensAtualizados.isEmpty) {
      throw Exception('Ordem de serviço deve conter pelo menos um item');
    }

    if (dataAgendamento != null && dataAgendamento.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      throw Exception('Data de agendamento não pode ser no passado');
    }

    final subtotal = _calcularSubtotal(itensAtualizados);
    final total = subtotal - descontoAtualizado;

    if (total < 0) {
      throw Exception('Desconto não pode ser maior que o subtotal');
    }

    final ordemAtualizada = ordemExistente.copyWith(
      itens: itensAtualizados,
      subtotal: subtotal,
      desconto: descontoAtualizado,
      total: total,
      dataAgendamento: dataAgendamento,
      prioridade: prioridade,
      dataPrevista: dataPrevista,
      observacoes: observacoes,
      observacoesInternas: observacoesInternas,
      tecnicoResponsavel: tecnicoResponsavel,
      equipamento: equipamento,
      problemaRelatado: problemaRelatado,
      updatedAt: DateTime.now(),
    );

    await _repository.atualizar(ordemAtualizada);
    return ordemAtualizada;
  }

  // Iniciar execução
  Future<void> iniciarExecucao(int id, {bool notificarWhatsApp = true}) async {
    final ordem = await _repository.buscarPorId(id);
    if (ordem == null) {
      throw Exception('Ordem de serviço não encontrada');
    }

    if (ordem.status != StatusOrdemServico.agendada) {
      throw Exception('Apenas ordens agendadas podem ser iniciadas');
    }

    await _repository.iniciarExecucao(id, DateTime.now());
    
    // Notificar início via WhatsApp se habilitado e serviço disponível
    if (notificarWhatsApp && _whatsappService != null) {
      try {
        final ordemAtualizada = ordem.copyWith(
          status: StatusOrdemServico.emAndamento,
          dataInicio: DateTime.now(),
        );
        await _whatsappService!.enviarNotificacaoInicioExecucao(ordemAtualizada);
      } catch (e) {
        print('Erro ao notificar início via WhatsApp: $e');
      }
    }
  }

  // Pausar execução
  Future<void> pausarExecucao(int id) async {
    final ordem = await _repository.buscarPorId(id);
    if (ordem == null) {
      throw Exception('Ordem de serviço não encontrada');
    }

    if (ordem.status != StatusOrdemServico.emAndamento) {
      throw Exception('Apenas ordens em andamento podem ser pausadas');
    }

    await _repository.pausarExecucao(id);
  }

  // Retomar execução
  Future<void> retomarExecucao(int id) async {
    final ordem = await _repository.buscarPorId(id);
    if (ordem == null) {
      throw Exception('Ordem de serviço não encontrada');
    }

    if (ordem.status != StatusOrdemServico.pausada) {
      throw Exception('Apenas ordens pausadas podem ser retomadas');
    }

    await _repository.alterarStatus(id, StatusOrdemServico.emAndamento);
  }

  // Concluir execução
  Future<void> concluirExecucao(int id, String? solucaoAplicada, {bool notificarWhatsApp = true}) async {
    final ordem = await _repository.buscarPorId(id);
    if (ordem == null) {
      throw Exception('Ordem de serviço não encontrada');
    }

    if (ordem.status != StatusOrdemServico.emAndamento && ordem.status != StatusOrdemServico.pausada) {
      throw Exception('Apenas ordens em andamento ou pausadas podem ser concluídas');
    }

    await _repository.concluirExecucao(id, DateTime.now(), solucaoAplicada);
    
    // Notificar conclusão via WhatsApp se habilitado e serviço disponível
    if (notificarWhatsApp && _whatsappService != null) {
      try {
        final ordemConcluida = ordem.copyWith(
          status: StatusOrdemServico.concluida,
          dataConclusao: DateTime.now(),
          observacoes: solucaoAplicada,
        );
        await _whatsappService!.enviarNotificacaoConclusao(ordemConcluida);
      } catch (e) {
        print('Erro ao notificar conclusão via WhatsApp: $e');
      }
    }
  }

  // Cancelar ordem de serviço
  Future<void> cancelarOrdemServico(int id) async {
    final ordem = await _repository.buscarPorId(id);
    if (ordem == null) {
      throw Exception('Ordem de serviço não encontrada');
    }

    if (ordem.status == StatusOrdemServico.concluida) {
      throw Exception('Não é possível cancelar ordem de serviço concluída');
    }

    await _repository.cancelar(id);
  }

  // Reagendar ordem de serviço
  Future<void> reagendarOrdemServico(int id, DateTime novaData) async {
    final ordem = await _repository.buscarPorId(id);
    if (ordem == null) {
      throw Exception('Ordem de serviço não encontrada');
    }

    if (ordem.status == StatusOrdemServico.concluida || ordem.status == StatusOrdemServico.cancelada) {
      throw Exception('Não é possível reagendar ordem concluída ou cancelada');
    }

    if (novaData.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      throw Exception('Nova data não pode ser no passado');
    }

    await _repository.reagendar(id, novaData);
  }

  // Excluir ordem de serviço
  Future<void> excluirOrdemServico(int id) async {
    final ordem = await _repository.buscarPorId(id);
    if (ordem == null) {
      throw Exception('Ordem de serviço não encontrada');
    }

    if (ordem.status == StatusOrdemServico.emAndamento) {
      throw Exception('Não é possível excluir ordem de serviço em andamento');
    }

    await _repository.excluir(id);
  }

  // Criar item de ordem de serviço
  ItemOrdemServico criarItemOrdemServico({
    required Servico servico,
    required int quantidade,
    double? valorCustomizado,
  }) {
    if (quantidade <= 0) {
      throw Exception('Quantidade deve ser maior que zero');
    }

    final valorUnitario = valorCustomizado ?? servico.valor;
    final subtotal = valorUnitario * quantidade;

    return ItemOrdemServico(
      servicoId: servico.id,
      nomeServico: servico.nome,
      descricaoServico: servico.descricao,
      quantidade: quantidade,
      valorUnitario: valorUnitario,
      subtotal: subtotal,
      duracaoMinutos: servico.duracaoMinutos,
    );
  }

  // Calcular subtotal dos itens
  double _calcularSubtotal(List<ItemOrdemServico> itens) {
    return itens.fold(0.0, (total, item) => total + item.subtotal);
  }

  // Calcular duração total estimada
  int calcularDuracaoTotal(List<ItemOrdemServico> itens) {
    return itens.fold(0, (total, item) {
      final duracao = item.duracaoMinutos ?? 0;
      return total + (duracao * item.quantidade);
    });
  }

  // Obter estatísticas
  Future<Map<String, dynamic>> obterEstatisticas() async {
    final todasOrdens = await _repository.buscarTodas();
    final agendadas = todasOrdens.where((o) => o.isAgendada).length;
    final emAndamento = todasOrdens.where((o) => o.isEmAndamento).length;
    final concluidas = todasOrdens.where((o) => o.isConcluida).length;
    final atrasadas = todasOrdens.where((o) => o.isAtrasada).length;

    return {
      'total': todasOrdens.length,
      'agendadas': agendadas,
      'emAndamento': emAndamento,
      'concluidas': concluidas,
      'atrasadas': atrasadas,
    };
  }
}

// Provider
final ordensServicoServiceProvider = Provider<OrdensServicoService>((ref) {
  final database = ref.read(databaseProvider);
  final repository = OrdensServicoRepositoryImpl(database);
  // final whatsappService = ref.read(ordensServicoWhatsAppServiceProvider);
  return OrdensServicoService(repository);
});

// Métodos auxiliares para integração WhatsApp
extension OrdensServicoServiceWhatsApp on OrdensServicoService {
  // Enviar ordem de serviço por WhatsApp
  Future<void> enviarOrdemServicoWhatsApp(int id, {String? mensagemPersonalizada}) async {
    if (_whatsappService == null) return;
    
    final ordem = await _repository.buscarPorId(id);
    if (ordem == null) {
      throw Exception('Ordem de serviço não encontrada');
    }

    try {
      await _whatsappService!.enviarOrdemServico(
        ordemServico: ordem,
        mensagemPersonalizada: mensagemPersonalizada,
      );
    } catch (e) {
      throw Exception('Erro ao enviar ordem de serviço via WhatsApp: $e');
    }
  }

  // Enviar notificação de agendamento
  Future<void> enviarNotificacaoAgendamento(int id, {String? mensagemPersonalizada}) async {
    if (_whatsappService == null) return;
    
    final ordem = await _repository.buscarPorId(id);
    if (ordem == null) {
      throw Exception('Ordem de serviço não encontrada');
    }

    try {
      await _whatsappService!.enviarNotificacaoAgendamento(
        ordemServico: ordem,
        mensagemPersonalizada: mensagemPersonalizada,
      );
    } catch (e) {
      throw Exception('Erro ao enviar notificação de agendamento via WhatsApp: $e');
    }
  }

  // Enviar lembrete de agendamento
  Future<void> enviarLembreteAgendamento(int id, {int horasAntes = 24}) async {
    if (_whatsappService == null) return;
    
    final ordem = await _repository.buscarPorId(id);
    if (ordem == null) {
      throw Exception('Ordem de serviço não encontrada');
    }

    try {
      await _whatsappService!.enviarLembreteAgendamento(
        ordemServico: ordem,
        horasAntes: horasAntes,
      );
    } catch (e) {
      throw Exception('Erro ao enviar lembrete via WhatsApp: $e');
    }
  }

  // Verificar se cliente tem WhatsApp
  Future<bool> clienteTemWhatsApp(int clienteId) async {
    if (_whatsappService == null) return false;
    return await _whatsappService!.clienteTemWhatsApp(clienteId);
  }

  // Processar lembretes automáticos de agendamento
  Future<void> processarLembretesAgendamento() async {
    if (_whatsappService == null) return;
    
    final agora = DateTime.now();
    final amanha = agora.add(const Duration(days: 1));
    
    // Buscar ordens agendadas para amanhã
    final ordensAmanha = await buscarAgendadasPara(amanha);
    
    for (final ordem in ordensAmanha) {
      try {
        final horasRestantes = ordem.dataAgendamento!.difference(agora).inHours;
        if (horasRestantes > 0 && horasRestantes <= 24) {
          await _whatsappService!.enviarLembreteAgendamento(
            ordemServico: ordem,
            horasAntes: horasRestantes,
          );
        }
            } catch (e) {
        print('Erro ao enviar lembrete automático para ordem ${ordem.numero}: $e');
      }
    }
  }

  // Reagendar com notificação WhatsApp
  Future<void> reagendarComNotificacao(int id, DateTime novaData, {String? mensagemPersonalizada}) async {
    // Reagendar usando método original
    await reagendarOrdemServico(id, novaData);
    
    // Enviar notificação se WhatsApp disponível
    if (_whatsappService != null) {
      try {
        final ordem = await _repository.buscarPorId(id);
        if (ordem != null) {
          final ordemAtualizada = ordem.copyWith(dataAgendamento: novaData);
          await _whatsappService!.enviarNotificacaoAgendamento(
            ordemServico: ordemAtualizada,
            mensagemPersonalizada: mensagemPersonalizada ?? 'Seu serviço foi reagendado.',
          );
        }
      } catch (e) {
        print('Erro ao notificar reagendamento via WhatsApp: $e');
      }
    }
  }
}