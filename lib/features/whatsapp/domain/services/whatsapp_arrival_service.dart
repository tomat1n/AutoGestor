import '../entities/whatsapp_config.dart';
import '../repositories/whatsapp_repository.dart';
import 'whatsapp_manager_service.dart';
import 'whatsapp_templates.dart';
import '../../../clientes/domain/entities/cliente.dart';

// Entidade para representar um agendamento (pode ser movida para um módulo específico)
class Agendamento {
  final int? id;
  final String clienteId;
  final DateTime dataHora;
  final String servico;
  final String? observacoes;
  final String status; // 'agendado', 'confirmado', 'em_andamento', 'concluido', 'cancelado'
  final bool? clienteChegou;
  final DateTime? horaChegada;
  final String? codigoConfirmacao;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Agendamento({
    this.id,
    required this.clienteId,
    required this.dataHora,
    required this.servico,
    this.observacoes,
    required this.status,
    this.clienteChegou,
    this.horaChegada,
    this.codigoConfirmacao,
    required this.createdAt,
    required this.updatedAt,
  });

  Agendamento copyWith({
    int? id,
    String? clienteId,
    DateTime? dataHora,
    String? servico,
    String? observacoes,
    String? status,
    bool? clienteChegou,
    DateTime? horaChegada,
    String? codigoConfirmacao,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Agendamento(
      id: id ?? this.id,
      clienteId: clienteId ?? this.clienteId,
      dataHora: dataHora ?? this.dataHora,
      servico: servico ?? this.servico,
      observacoes: observacoes ?? this.observacoes,
      status: status ?? this.status,
      clienteChegou: clienteChegou ?? this.clienteChegou,
      horaChegada: horaChegada ?? this.horaChegada,
      codigoConfirmacao: codigoConfirmacao ?? this.codigoConfirmacao,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// Entidade para confirmação de chegada
class ConfirmacaoChegada {
  final String agendamentoId;
  final String clienteId;
  final String codigoConfirmacao;
  final DateTime dataHoraEnvio;
  final DateTime? dataHoraConfirmacao;
  final bool confirmado;
  final String? observacoes;
  final String? telefoneResposta;

  const ConfirmacaoChegada({
    required this.agendamentoId,
    required this.clienteId,
    required this.codigoConfirmacao,
    required this.dataHoraEnvio,
    this.dataHoraConfirmacao,
    required this.confirmado,
    this.observacoes,
    this.telefoneResposta,
  });
}

class WhatsAppArrivalService {
  final WhatsAppRepository _repository;
  final WhatsAppManagerService _managerService;

  WhatsAppArrivalService(this._repository, this._managerService);

  /// Solicita confirmação de chegada para um agendamento
  Future<String?> solicitarConfirmacaoChegada({
    required Cliente cliente,
    required Agendamento agendamento,
  }) async {
    final config = await _repository.obterConfiguracao();
    if (config == null || !config.ativo || !config.enviarConfirmacoes) {
      return null;
    }

    if (cliente.telefone == null || cliente.telefone!.isEmpty) {
      return null;
    }

    // Gerar código de confirmação único
    final codigoConfirmacao = _gerarCodigoConfirmacao();
    
    final dataFormatada = _formatarDataHora(agendamento.dataHora);
    
    final mensagem = WhatsAppTemplates.confirmacaoChegada(
      nomeCliente: cliente.nome,
      dataHora: dataFormatada,
      servico: agendamento.servico,
      codigoConfirmacao: codigoConfirmacao,
    );

    await _managerService.enviarMensagem(
      clienteId: cliente.id.toString(),
      telefone: cliente.telefone!,
      mensagem: mensagem,
      tipo: 'confirmacao_chegada',
      metadata: {
        'agendamentoId': agendamento.id.toString(),
        'codigoConfirmacao': codigoConfirmacao,
        'dataAgendamento': agendamento.dataHora.toIso8601String(),
        'evento': 'solicitacao_confirmacao_chegada',
      },
    );

    // Salvar a solicitação de confirmação
    await _salvarSolicitacaoConfirmacao(
      agendamento: agendamento,
      cliente: cliente,
      codigoConfirmacao: codigoConfirmacao,
    );

    return codigoConfirmacao;
  }

  /// Processa confirmação de chegada recebida via WhatsApp
  Future<bool> processarConfirmacaoChegada({
    required String telefone,
    required String mensagem,
  }) async {
    // Extrair código de confirmação da mensagem
    final codigoConfirmacao = _extrairCodigoConfirmacao(mensagem);
    if (codigoConfirmacao == null) {
      return false;
    }

    // Buscar agendamento pelo código de confirmação
    final agendamento = await _buscarAgendamentoPorCodigo(codigoConfirmacao);
    if (agendamento == null) {
      await _enviarMensagemCodigoInvalido(telefone);
      return false;
    }

    // Verificar se o telefone corresponde ao cliente do agendamento
    final cliente = await _buscarClientePorId(agendamento.clienteId);
    if (cliente == null || !_telefoneCorresponde(cliente.telefone, telefone)) {
      await _enviarMensagemCodigoInvalido(telefone);
      return false;
    }

    // Confirmar chegada
    await _confirmarChegada(
      agendamento: agendamento,
      cliente: cliente,
      codigoConfirmacao: codigoConfirmacao,
      telefoneResposta: telefone,
    );

    // Enviar confirmação de recebimento
    await _enviarConfirmacaoRecebida(
      cliente: cliente,
      agendamento: agendamento,
    );

    return true;
  }

  /// Envia lembrete de confirmação de chegada
  Future<void> enviarLembreteConfirmacao({
    required Cliente cliente,
    required Agendamento agendamento,
    required String codigoConfirmacao,
  }) async {
    final config = await _repository.obterConfiguracao();
    if (config == null || !config.ativo || !config.enviarLembretes) {
      return;
    }

    if (cliente.telefone == null || cliente.telefone!.isEmpty) {
      return;
    }

    final dataFormatada = _formatarDataHora(agendamento.dataHora);
    
    final mensagem = WhatsAppTemplates.lembreteConfirmacaoChegada(
      nomeCliente: cliente.nome,
      dataHora: dataFormatada,
      servico: agendamento.servico,
      codigoConfirmacao: codigoConfirmacao,
    );

    await _managerService.enviarMensagem(
      clienteId: cliente.id.toString(),
      telefone: cliente.telefone!,
      mensagem: mensagem,
      tipo: 'lembrete_confirmacao',
      metadata: {
        'agendamentoId': agendamento.id.toString(),
        'codigoConfirmacao': codigoConfirmacao,
        'evento': 'lembrete_confirmacao_chegada',
      },
    );
  }

  /// Processa lembretes automáticos de confirmação
  Future<void> processarLembretesConfirmacao() async {
    final config = await _repository.obterConfiguracao();
    if (config == null || !config.ativo || !config.enviarLembretes) {
      return;
    }

    final agora = DateTime.now();
    
    // Buscar agendamentos que precisam de lembrete de confirmação
    // (agendamentos para hoje que ainda não foram confirmados)
    final agendamentosPendentes = await _buscarAgendamentosPendentesConfirmacao(agora);
    
    for (final agendamento in agendamentosPendentes) {
      final cliente = await _buscarClientePorId(agendamento.clienteId);
      if (cliente != null && cliente.telefone != null) {
        final codigoConfirmacao = agendamento.codigoConfirmacao;
        if (codigoConfirmacao != null) {
          await enviarLembreteConfirmacao(
            cliente: cliente,
            agendamento: agendamento,
            codigoConfirmacao: codigoConfirmacao,
          );
        }
      }
    }
  }

  /// Verifica status de confirmações pendentes
  Future<List<Map<String, dynamic>>> obterConfirmacoesPendentes() async {
    final agora = DateTime.now();
    final agendamentos = await _buscarAgendamentosPendentesConfirmacao(agora);
    
    final confirmacoesPendentes = <Map<String, dynamic>>[];
    
    for (final agendamento in agendamentos) {
      final cliente = await _buscarClientePorId(agendamento.clienteId);
      if (cliente != null) {
        confirmacoesPendentes.add({
          'agendamentoId': agendamento.id,
          'clienteNome': cliente.nome,
          'clienteTelefone': cliente.telefone,
          'dataHora': agendamento.dataHora,
          'servico': agendamento.servico,
          'codigoConfirmacao': agendamento.codigoConfirmacao,
          'status': agendamento.status,
        });
      }
    }
    
    return confirmacoesPendentes;
  }

  /// Cancela solicitação de confirmação
  Future<void> cancelarConfirmacao({
    required String agendamentoId,
    required String motivo,
  }) async {
    // Implementar cancelamento da confirmação
    // Atualizar status do agendamento
    // Registrar motivo do cancelamento
  }

  String _gerarCodigoConfirmacao() {
    final agora = DateTime.now();
    final timestamp = agora.millisecondsSinceEpoch.toString();
    return timestamp.substring(timestamp.length - 6); // Últimos 6 dígitos
  }

  String? _extrairCodigoConfirmacao(String mensagem) {
    // Procurar por padrões de código de confirmação na mensagem
    final regexCodigo = RegExp(r'\b\d{6}\b');
    final match = regexCodigo.firstMatch(mensagem.toLowerCase());
    return match?.group(0);
  }

  String _formatarDataHora(DateTime dataHora) {
    final dia = dataHora.day.toString().padLeft(2, '0');
    final mes = dataHora.month.toString().padLeft(2, '0');
    final ano = dataHora.year;
    final hora = dataHora.hour.toString().padLeft(2, '0');
    final minuto = dataHora.minute.toString().padLeft(2, '0');
    
    return '$dia/$mes/$ano às $hora:$minuto';
  }

  bool _telefoneCorresponde(String? telefoneCliente, String telefoneResposta) {
    if (telefoneCliente == null) return false;
    
    // Remover caracteres especiais e comparar apenas números
    final telefone1 = telefoneCliente.replaceAll(RegExp(r'[^0-9]'), '');
    final telefone2 = telefoneResposta.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Comparar os últimos 9 dígitos (número sem DDD)
    if (telefone1.length >= 9 && telefone2.length >= 9) {
      final sufixo1 = telefone1.substring(telefone1.length - 9);
      final sufixo2 = telefone2.substring(telefone2.length - 9);
      return sufixo1 == sufixo2;
    }
    
    return telefone1 == telefone2;
  }

  Future<void> _salvarSolicitacaoConfirmacao({
    required Agendamento agendamento,
    required Cliente cliente,
    required String codigoConfirmacao,
  }) async {
    // Implementar salvamento da solicitação de confirmação
    // Isso poderia ser salvo em uma tabela específica ou como metadata do agendamento
    
    // Exemplo de implementação:
    // await _confirmacaoRepository.salvar(ConfirmacaoChegada(
    //   agendamentoId: agendamento.id.toString(),
    //   clienteId: cliente.id.toString(),
    //   codigoConfirmacao: codigoConfirmacao,
    //   dataHoraEnvio: DateTime.now(),
    //   confirmado: false,
    // ));
  }

  Future<Agendamento?> _buscarAgendamentoPorCodigo(String codigoConfirmacao) async {
    // Implementar busca de agendamento por código de confirmação
    // return await _agendamentoRepository.buscarPorCodigoConfirmacao(codigoConfirmacao);
    return null; // Placeholder
  }

  Future<Cliente?> _buscarClientePorId(String clienteId) async {
    // Implementar busca de cliente por ID
    // return await _clienteRepository.buscarPorId(clienteId);
    return null; // Placeholder
  }

  Future<List<Agendamento>> _buscarAgendamentosPendentesConfirmacao(DateTime data) async {
    // Implementar busca de agendamentos pendentes de confirmação
    // Critérios:
    // - Agendamentos para hoje
    // - Status 'agendado' ou 'confirmado'
    // - Ainda não confirmaram chegada (clienteChegou = false ou null)
    // - Horário do agendamento é em até 2 horas
    
    // return await _agendamentoRepository.buscarPendentesConfirmacao(
    //   dataInicio: DateTime(data.year, data.month, data.day),
    //   dataFim: DateTime(data.year, data.month, data.day, 23, 59, 59),
    //   horaLimite: data.add(Duration(hours: 2)),
    // );
    
    return []; // Placeholder
  }

  Future<void> _confirmarChegada({
    required Agendamento agendamento,
    required Cliente cliente,
    required String codigoConfirmacao,
    required String telefoneResposta,
  }) async {
    // Implementar confirmação de chegada
    // Atualizar agendamento com clienteChegou = true e horaChegada = agora
    
    // final agendamentoAtualizado = agendamento.copyWith(
    //   clienteChegou: true,
    //   horaChegada: DateTime.now(),
    //   status: 'cliente_chegou',
    // );
    // 
    // await _agendamentoRepository.atualizar(agendamentoAtualizado);
    
    // Atualizar confirmação
    // await _confirmacaoRepository.confirmar(
    //   codigoConfirmacao: codigoConfirmacao,
    //   dataHoraConfirmacao: DateTime.now(),
    //   telefoneResposta: telefoneResposta,
    // );
  }

  Future<void> _enviarMensagemCodigoInvalido(String telefone) async {
    const mensagem = '''❌ *Código inválido*

O código de confirmação informado não foi encontrado ou já foi utilizado.

Se você tem um agendamento conosco, verifique o código enviado anteriormente ou entre em contato conosco.''';

    await _managerService.enviarMensagem(
      clienteId: 'sistema',
      telefone: telefone,
      mensagem: mensagem,
      tipo: 'erro_confirmacao',
      metadata: {
        'evento': 'codigo_confirmacao_invalido',
      },
    );
  }

  Future<void> _enviarConfirmacaoRecebida({
    required Cliente cliente,
    required Agendamento agendamento,
  }) async {
    final dataFormatada = _formatarDataHora(agendamento.dataHora);
    
    final mensagem = '''✅ *Chegada confirmada!*

Olá ${cliente.nome}!

Sua chegada foi confirmada com sucesso para o agendamento de *${agendamento.servico}* em $dataFormatada.

Nosso atendente já foi notificado. Aguarde ser chamado.

Obrigado por escolher nossos serviços! 🚗''';

    await _managerService.enviarMensagem(
      clienteId: cliente.id.toString(),
      telefone: cliente.telefone!,
      mensagem: mensagem,
      tipo: 'confirmacao_recebida',
      metadata: {
        'agendamentoId': agendamento.id.toString(),
        'evento': 'confirmacao_chegada_recebida',
      },
    );
  }
}