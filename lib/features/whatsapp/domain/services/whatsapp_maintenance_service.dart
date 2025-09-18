import '../entities/whatsapp_config.dart';
import '../repositories/whatsapp_repository.dart';
import 'whatsapp_manager_service.dart';
import 'whatsapp_templates.dart';
import '../../../clientes/domain/entities/cliente.dart';

// Entidade para representar um veículo (pode ser movida para um módulo específico)
class Veiculo {
  final int? id;
  final String clienteId;
  final String marca;
  final String modelo;
  final String ano;
  final String placa;
  final int? quilometragemAtual;
  final DateTime? ultimaRevisao;
  final DateTime? ultimaTrocaOleo;
  final Map<String, dynamic>? historicoManutencao;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Veiculo({
    this.id,
    required this.clienteId,
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.placa,
    this.quilometragemAtual,
    this.ultimaRevisao,
    this.ultimaTrocaOleo,
    this.historicoManutencao,
    required this.createdAt,
    required this.updatedAt,
  });
}

// Entidade para regras de manutenção
class RegraManutencao {
  final String tipo; // 'troca_oleo', 'revisao', 'filtro_ar', etc.
  final int? intervaloQuilometragem;
  final int? intervaloDias;
  final String descricao;
  final bool ativo;

  const RegraManutencao({
    required this.tipo,
    this.intervaloQuilometragem,
    this.intervaloDias,
    required this.descricao,
    this.ativo = true,
  });
}

class WhatsAppMaintenanceService {
  final WhatsAppRepository _repository;
  final WhatsAppManagerService _managerService;

  WhatsAppMaintenanceService(this._repository, this._managerService);

  // Regras padrão de manutenção para auto center
  static const List<RegraManutencao> regrasManutencao = [
    RegraManutencao(
      tipo: 'troca_oleo',
      intervaloQuilometragem: 10000,
      intervaloDias: 180, // 6 meses
      descricao: 'Troca de óleo e filtro',
    ),
    RegraManutencao(
      tipo: 'revisao_geral',
      intervaloQuilometragem: 20000,
      intervaloDias: 365, // 1 ano
      descricao: 'Revisão geral do veículo',
    ),
    RegraManutencao(
      tipo: 'filtro_ar',
      intervaloQuilometragem: 15000,
      intervaloDias: 365,
      descricao: 'Troca do filtro de ar',
    ),
    RegraManutencao(
      tipo: 'filtro_combustivel',
      intervaloQuilometragem: 30000,
      intervaloDias: 730, // 2 anos
      descricao: 'Troca do filtro de combustível',
    ),
    RegraManutencao(
      tipo: 'velas_ignicao',
      intervaloQuilometragem: 30000,
      intervaloDias: 730,
      descricao: 'Troca das velas de ignição',
    ),
    RegraManutencao(
      tipo: 'correia_dentada',
      intervaloQuilometragem: 60000,
      intervaloDias: 1460, // 4 anos
      descricao: 'Troca da correia dentada',
    ),
    RegraManutencao(
      tipo: 'pastilhas_freio',
      intervaloQuilometragem: 25000,
      descricao: 'Verificação/troca das pastilhas de freio',
    ),
    RegraManutencao(
      tipo: 'alinhamento_balanceamento',
      intervaloQuilometragem: 10000,
      intervaloDias: 180,
      descricao: 'Alinhamento e balanceamento',
    ),
  ];

  /// Verifica e envia lembretes de manutenção para todos os veículos
  Future<void> processarLembretesManutencao() async {
    final config = await _repository.obterConfiguracao();
    if (config == null || !config.ativo || !config.enviarLembretes) {
      return;
    }

    if (!config.podeEnviarAgora()) {
      return;
    }

    // Aqui você integraria com o repositório de veículos
    // final veiculos = await _veiculoRepository.listarTodos();
    
    // for (final veiculo in veiculos) {
    //   await _verificarManutencaoVeiculo(veiculo);
    // }
  }

  /// Verifica manutenções pendentes para um veículo específico
  Future<void> verificarManutencaoVeiculo(Veiculo veiculo, Cliente cliente) async {
    final config = await _repository.obterConfiguracao();
    if (config == null || !config.ativo || !config.enviarLembretes) {
      return;
    }

    for (final regra in regrasManutencao) {
      if (!regra.ativo) continue;

      final precisaManutencao = await _verificarSePrecsaManutencao(veiculo, regra);
      if (precisaManutencao) {
        await _enviarLembreteManutencao(cliente, veiculo, regra);
      }
    }
  }

  /// Envia lembrete específico de manutenção preventiva
  Future<void> enviarLembreteManutencaoPreventiva({
    required Cliente cliente,
    required String tipoManutencao,
    required String quilometragem,
    String? proximaRevisao,
  }) async {
    final config = await _repository.obterConfiguracao();
    if (config == null || !config.ativo || !config.enviarLembretes) {
      return;
    }

    if (cliente.telefone == null || cliente.telefone!.isEmpty) {
      return;
    }

    final mensagem = WhatsAppTemplates.manutencaoPreventiva(
      nomeCliente: cliente.nome,
      tipoManutencao: tipoManutencao,
      quilometragem: quilometragem,
      proximaRevisao: proximaRevisao,
    );

    await _managerService.enviarMensagem(
      clienteId: cliente.id.toString(),
      telefone: cliente.telefone!,
      mensagem: mensagem,
      tipo: 'manutencao_preventiva',
      metadata: {
        'tipoManutencao': tipoManutencao,
        'quilometragemAtual': quilometragem,
        'evento': 'lembrete_manutencao_preventiva',
      },
    );
  }

  /// Envia lembrete de revisão geral
  Future<void> enviarLembreteRevisao({
    required Cliente cliente,
    required String quilometragem,
    required String tempoUltimaRevisao,
  }) async {
    final config = await _repository.obterConfiguracao();
    if (config == null || !config.ativo || !config.enviarLembretes) {
      return;
    }

    if (cliente.telefone == null || cliente.telefone!.isEmpty) {
      return;
    }

    final mensagem = WhatsAppTemplates.lembreteRevisao(
      nomeCliente: cliente.nome,
      quilometragem: quilometragem,
      tempoUltimaRevisao: tempoUltimaRevisao,
    );

    await _managerService.enviarMensagem(
      clienteId: cliente.id.toString(),
      telefone: cliente.telefone!,
      mensagem: mensagem,
      tipo: 'lembrete_revisao',
      metadata: {
        'quilometragemAtual': quilometragem,
        'ultimaRevisao': tempoUltimaRevisao,
        'evento': 'lembrete_revisao_geral',
      },
    );
  }

  /// Envia promoção de desconto
  Future<void> enviarPromocaoDesconto({
    required Cliente cliente,
    required String desconto,
    required String servicos,
    required String validadePromocao,
  }) async {
    final config = await _repository.obterConfiguracao();
    if (config == null || !config.ativo || !config.enviarPromocoes) {
      return;
    }

    if (cliente.telefone == null || cliente.telefone!.isEmpty) {
      return;
    }

    final mensagem = WhatsAppTemplates.promocaoDesconto(
      nomeCliente: cliente.nome,
      desconto: desconto,
      servicos: servicos,
      validadePromocao: validadePromocao,
    );

    await _managerService.enviarMensagem(
      clienteId: cliente.id.toString(),
      telefone: cliente.telefone!,
      mensagem: mensagem,
      tipo: 'promocional',
      metadata: {
        'desconto': desconto,
        'validadePromocao': validadePromocao,
        'evento': 'promocao_desconto',
      },
    );
  }

  /// Envia promoção específica de troca de óleo
  Future<void> enviarPromocaoTrocaOleo({
    required Cliente cliente,
    required String preco,
    String? validadePromocao,
  }) async {
    final config = await _repository.obterConfiguracao();
    if (config == null || !config.ativo || !config.enviarPromocoes) {
      return;
    }

    if (cliente.telefone == null || cliente.telefone!.isEmpty) {
      return;
    }

    final mensagem = WhatsAppTemplates.promocaoTrocaOleo(
      nomeCliente: cliente.nome,
      preco: preco,
      validadePromocao: validadePromocao,
    );

    await _managerService.enviarMensagem(
      clienteId: cliente.id.toString(),
      telefone: cliente.telefone!,
      mensagem: mensagem,
      tipo: 'promocional',
      metadata: {
        'preco': preco,
        'validadePromocao': validadePromocao,
        'evento': 'promocao_troca_oleo',
        'servico': 'troca_oleo',
      },
    );
  }

  /// Programa lembretes automáticos baseados no histórico do cliente
  Future<void> programarLembretesAutomaticos({
    required Cliente cliente,
    required Veiculo veiculo,
  }) async {
    // Calcular próximas manutenções baseadas no histórico
    final proximasManutencoes = _calcularProximasManutencoes(veiculo);
    
    for (final manutencao in proximasManutencoes) {
      // Agendar lembrete para ser enviado na data apropriada
      // Isso poderia ser implementado com um sistema de jobs/cron
      await _agendarLembrete(
        cliente: cliente,
        veiculo: veiculo,
        tipoManutencao: manutencao['tipo'],
        dataLembrete: manutencao['dataLembrete'],
      );
    }
  }

  Future<bool> _verificarSePrecsaManutencao(Veiculo veiculo, RegraManutencao regra) async {
    final agora = DateTime.now();
    
    // Verificar por quilometragem
    if (regra.intervaloQuilometragem != null && veiculo.quilometragemAtual != null) {
      final ultimaManutencao = _obterUltimaManutencao(veiculo, regra.tipo);
      if (ultimaManutencao != null) {
        final kmPercorridos = veiculo.quilometragemAtual! - ultimaManutencao['quilometragem'];
        if (kmPercorridos >= regra.intervaloQuilometragem!) {
          return true;
        }
      }
    }
    
    // Verificar por tempo
    if (regra.intervaloDias != null) {
      final ultimaManutencao = _obterUltimaManutencao(veiculo, regra.tipo);
      if (ultimaManutencao != null) {
        final diasPassados = agora.difference(ultimaManutencao['data']).inDays;
        if (diasPassados >= regra.intervaloDias!) {
          return true;
        }
      } else {
        // Se nunca fez a manutenção, verificar baseado na idade do cadastro
        final diasCadastro = agora.difference(veiculo.createdAt).inDays;
        if (diasCadastro >= regra.intervaloDias!) {
          return true;
        }
      }
    }
    
    return false;
  }

  Future<void> _enviarLembreteManutencao(Cliente cliente, Veiculo veiculo, RegraManutencao regra) async {
    if (cliente.telefone == null || cliente.telefone!.isEmpty) {
      return;
    }

    final quilometragem = veiculo.quilometragemAtual?.toString() ?? 'N/A';
    
    await enviarLembreteManutencaoPreventiva(
      cliente: cliente,
      tipoManutencao: regra.descricao,
      quilometragem: quilometragem,
    );
  }

  Map<String, dynamic>? _obterUltimaManutencao(Veiculo veiculo, String tipo) {
    if (veiculo.historicoManutencao == null) return null;
    
    final historico = veiculo.historicoManutencao![tipo] as List<dynamic>?;
    if (historico == null || historico.isEmpty) return null;
    
    // Retorna a manutenção mais recente
    return historico.last as Map<String, dynamic>;
  }

  List<Map<String, dynamic>> _calcularProximasManutencoes(Veiculo veiculo) {
    final proximasManutencoes = <Map<String, dynamic>>[];
    final agora = DateTime.now();
    
    for (final regra in regrasManutencao) {
      if (!regra.ativo) continue;
      
      DateTime? proximaData;
      
      // Calcular próxima data baseada no tempo
      if (regra.intervaloDias != null) {
        final ultimaManutencao = _obterUltimaManutencao(veiculo, regra.tipo);
        if (ultimaManutencao != null) {
          proximaData = (ultimaManutencao['data'] as DateTime)
              .add(Duration(days: regra.intervaloDias!));
        } else {
          proximaData = veiculo.createdAt.add(Duration(days: regra.intervaloDias!));
        }
      }
      
      if (proximaData != null && proximaData.isAfter(agora)) {
        // Agendar lembrete para 7 dias antes
        final dataLembrete = proximaData.subtract(const Duration(days: 7));
        
        if (dataLembrete.isAfter(agora)) {
          proximasManutencoes.add({
            'tipo': regra.tipo,
            'descricao': regra.descricao,
            'dataLembrete': dataLembrete,
            'dataManutencao': proximaData,
          });
        }
      }
    }
    
    return proximasManutencoes;
  }

  Future<void> _agendarLembrete({
    required Cliente cliente,
    required Veiculo veiculo,
    required String tipoManutencao,
    required DateTime dataLembrete,
  }) async {
    // Implementar sistema de agendamento de lembretes
    // Isso poderia usar um sistema de jobs, cron, ou banco de dados de tarefas agendadas
    
    // Por exemplo, salvar no banco uma tarefa agendada:
    // await _tarefaRepository.criarTarefaAgendada(
    //   tipo: 'lembrete_manutencao',
    //   dataExecucao: dataLembrete,
    //   parametros: {
    //     'clienteId': cliente.id,
    //     'veiculoId': veiculo.id,
    //     'tipoManutencao': tipoManutencao,
    //   },
    // );
  }
}