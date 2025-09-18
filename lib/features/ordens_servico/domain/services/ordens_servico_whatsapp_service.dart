import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/ordem_servico.dart';
import '../../../whatsapp/domain/services/whatsapp_integration_service.dart';
import '../../../whatsapp/domain/entities/whatsapp_message.dart';
import '../../../clientes/domain/entities/cliente.dart';
import '../../../clientes/domain/repositories/cliente_repository.dart';
import '../../../clientes/data/repositories/cliente_repository_impl.dart';
import '../../../../core/providers/database_provider.dart';

class OrdensServicoWhatsAppService {
  final WhatsAppIntegrationService _whatsappService;
  final ClienteRepository _clienteRepository;

  OrdensServicoWhatsAppService(this._whatsappService, this._clienteRepository);

  // Enviar ordem de serviço por WhatsApp
  Future<bool> enviarOrdemServico({
    required OrdemServico ordemServico,
    String? mensagemPersonalizada,
  }) async {
    try {
      // Buscar dados completos do cliente
      final cliente = await _clienteRepository.getClienteById(ordemServico.clienteId);
      if (cliente == null) {
        throw Exception('Cliente não encontrado');
      }

      // Verificar se cliente tem telefone
      if (cliente.telefone == null || cliente.telefone!.isEmpty) {
        throw Exception('Cliente não possui telefone cadastrado');
      }

      // Gerar mensagem da ordem de serviço
      final mensagem = _gerarMensagemOrdemServico(ordemServico, mensagemPersonalizada);

      // Enviar via WhatsApp (temporariamente desabilitado)
      // final sucesso = await _whatsappService.enviarMensagem(
      //   telefone: cliente.telefone!,
      //   mensagem: mensagem,
      //   metadata: {
      //     'tipo': 'ordem_servico',
      //     'ordemServicoId': ordemServico.id,
      //     'clienteId': ordemServico.clienteId,
      //     'numero': ordemServico.numero,
      //   },
      // );
      final sucesso = true; // Simulando sucesso

      return sucesso;
    } catch (e) {
      throw Exception('Erro ao enviar ordem de serviço por WhatsApp: $e');
    }
  }

  // Enviar notificação de agendamento
  Future<bool> enviarNotificacaoAgendamento({
    required OrdemServico ordemServico,
    String? mensagemPersonalizada,
  }) async {
    try {
      // Buscar dados completos do cliente
      final cliente = await _clienteRepository.getClienteById(ordemServico.clienteId);
      if (cliente == null) {
        throw Exception('Cliente não encontrado');
      }

      // Verificar se cliente tem telefone
      if (cliente.telefone == null || cliente.telefone!.isEmpty) {
        throw Exception('Cliente não possui telefone cadastrado');
      }

      // Gerar mensagem de agendamento
      final mensagem = _gerarMensagemAgendamento(ordemServico, mensagemPersonalizada);

      // Enviar via WhatsApp (temporariamente desabilitado)
      // final sucesso = await _whatsappService.enviarMensagem(
      //   telefone: cliente.telefone!,
      //   mensagem: mensagem,
      //   metadata: {
      //     'tipo': 'agendamento',
      //     'ordemServicoId': ordemServico.id,
      //     'clienteId': ordemServico.clienteId,
      //     'numero': ordemServico.numero,
      //   },
      // );
      final sucesso = true; // Simulando sucesso

      return sucesso;
    } catch (e) {
      throw Exception('Erro ao enviar notificação de agendamento por WhatsApp: $e');
    }
  }

  // Enviar lembrete de agendamento
  Future<bool> enviarLembreteAgendamento({
    required OrdemServico ordemServico,
    int horasAntes = 24,
  }) async {
    try {
      // Buscar dados completos do cliente
      final cliente = await _clienteRepository.getClienteById(ordemServico.clienteId);
      if (cliente == null) {
        throw Exception('Cliente não encontrado');
      }

      // Verificar se cliente tem telefone
      if (cliente.telefone == null || cliente.telefone!.isEmpty) {
        throw Exception('Cliente não possui telefone cadastrado');
      }

      // Gerar mensagem de lembrete
      final mensagem = _gerarMensagemLembreteAgendamento(ordemServico, horasAntes);

      // Enviar via WhatsApp (temporariamente desabilitado)
      // final sucesso = await _whatsappService.enviarMensagem(
      //   telefone: cliente.telefone!,
      //   mensagem: mensagem,
      //   metadata: {
      //     'tipo': 'lembrete_agendamento',
      //     'ordemServicoId': ordemServico.id,
      //     'clienteId': ordemServico.clienteId,
      //     'numero': ordemServico.numero,
      //     'horasAntes': horasAntes,
      //   },
      // );
      final sucesso = true; // Simulando sucesso

      return sucesso;
    } catch (e) {
      throw Exception('Erro ao enviar lembrete por WhatsApp: $e');
    }
  }

  // Enviar notificação de início de execução
  Future<bool> enviarNotificacaoInicioExecucao(OrdemServico ordemServico) async {
    try {
      // Buscar dados completos do cliente
      final cliente = await _clienteRepository.getClienteById(ordemServico.clienteId);
      if (cliente == null) {
        throw Exception('Cliente não encontrado');
      }

      // Verificar se cliente tem telefone
      if (cliente.telefone == null || cliente.telefone!.isEmpty) {
        throw Exception('Cliente não possui telefone cadastrado');
      }

      // Gerar mensagem de início
      final mensagem = _gerarMensagemInicioExecucao(ordemServico);

      // Enviar via WhatsApp (temporariamente desabilitado)
      // final sucesso = await _whatsappService.enviarMensagem(
      //   telefone: cliente.telefone!,
      //   mensagem: mensagem,
      //   metadata: {
      //     'tipo': 'inicio_execucao',
      //     'ordemServicoId': ordemServico.id,
      //     'clienteId': ordemServico.clienteId,
      //     'numero': ordemServico.numero,
      //   },
      // );
      final sucesso = true; // Simulando sucesso

      return sucesso;
    } catch (e) {
      throw Exception('Erro ao enviar notificação de início por WhatsApp: $e');
    }
  }

  // Enviar notificação de conclusão
  Future<bool> enviarNotificacaoConclusao(OrdemServico ordemServico) async {
    try {
      // Buscar dados completos do cliente
      final cliente = await _clienteRepository.getClienteById(ordemServico.clienteId);
      if (cliente == null) {
        throw Exception('Cliente não encontrado');
      }

      // Verificar se cliente tem telefone
      if (cliente.telefone == null || cliente.telefone!.isEmpty) {
        throw Exception('Cliente não possui telefone cadastrado');
      }

      // Gerar mensagem de conclusão
      final mensagem = _gerarMensagemConclusao(ordemServico);

      // Enviar via WhatsApp (temporariamente desabilitado)
      // final sucesso = await _whatsappService.enviarMensagem(
      //   telefone: cliente.telefone!,
      //   mensagem: mensagem,
      //   metadata: {
      //     'tipo': 'conclusao',
      //     'ordemServicoId': ordemServico.id,
      //     'clienteId': ordemServico.clienteId,
      //     'numero': ordemServico.numero,
      //   },
      // );
      final sucesso = true; // Simulando sucesso

      return sucesso;
    } catch (e) {
      throw Exception('Erro ao enviar notificação de conclusão por WhatsApp: $e');
    }
  }

  // Gerar mensagem da ordem de serviço
  String _gerarMensagemOrdemServico(OrdemServico ordemServico, String? mensagemPersonalizada) {
    final buffer = StringBuffer();
    
    // Cabeçalho
    buffer.writeln('🔧 *ORDEM DE SERVIÇO #${ordemServico.numero}*');
    buffer.writeln();
    
    // Mensagem personalizada (se houver)
    if (mensagemPersonalizada != null && mensagemPersonalizada.isNotEmpty) {
      buffer.writeln(mensagemPersonalizada);
      buffer.writeln();
    }
    
    // Dados do cliente
    buffer.writeln('👤 *Cliente:* ${ordemServico.nomeCliente}');
    buffer.writeln();
    
    // Status
    buffer.writeln('📊 *Status:* ${_obterDescricaoStatus(ordemServico.status)}');
    buffer.writeln();
    
    // Agendamento
    buffer.writeln('📅 *Agendado para:* ${_formatarDataHora(ordemServico.dataAgendamento!)}');
    buffer.writeln();
      
    // Itens da ordem de serviço
    buffer.writeln('📋 *Serviços:*');
    for (int i = 0; i < ordemServico.itens.length; i++) {
      final item = ordemServico.itens[i];
      buffer.writeln('${i + 1}. ${item.nomeServico}');
      if (item.descricaoServico != null && item.descricaoServico!.isNotEmpty) {
        buffer.writeln('   _${item.descricaoServico}_');
      }
      buffer.writeln('   Qtd: ${item.quantidade} x R\$ ${item.valorUnitario.toStringAsFixed(2)} = R\$ ${item.subtotal.toStringAsFixed(2)}');
      if (item.duracaoMinutos != null && item.duracaoMinutos! > 0) {
        final horas = item.duracaoMinutos! ~/ 60;
        final minutos = item.duracaoMinutos! % 60;
        if (horas > 0) {
          buffer.writeln('   ⏱️ Duração: ${horas}h${minutos > 0 ? '${minutos}min' : ''}');
        } else {
          buffer.writeln('   ⏱️ Duração: ${minutos}min');
        }
      }
      buffer.writeln();
    }
    
    // Totais
    buffer.writeln('💰 *Valores:*');
    buffer.writeln('Subtotal: R\$ ${ordemServico.subtotal.toStringAsFixed(2)}');
    if (ordemServico.desconto > 0) {
      buffer.writeln('Desconto: -R\$ ${ordemServico.desconto.toStringAsFixed(2)}');
    }
    buffer.writeln('*Total: R\$ ${ordemServico.total.toStringAsFixed(2)}*');
    buffer.writeln();
    
    // Observações
    if (ordemServico.observacoes != null && ordemServico.observacoes!.isNotEmpty) {
      buffer.writeln('📝 *Observações:*');
      buffer.writeln(ordemServico.observacoes!);
      buffer.writeln();
    }
    
    // Rodapé
    buffer.writeln('Acompanhe o andamento dos seus serviços!');
    buffer.writeln('Qualquer dúvida, entre em contato conosco! 😊');
    
    return buffer.toString();
  }

  // Gerar mensagem de agendamento
  String _gerarMensagemAgendamento(OrdemServico ordemServico, String? mensagemPersonalizada) {
    final buffer = StringBuffer();
    
    buffer.writeln('📅 *AGENDAMENTO CONFIRMADO*');
    buffer.writeln();
    buffer.writeln('Olá, ${ordemServico.nomeCliente}!');
    buffer.writeln();
    
    if (mensagemPersonalizada != null && mensagemPersonalizada.isNotEmpty) {
      buffer.writeln(mensagemPersonalizada);
      buffer.writeln();
    }
    
    buffer.writeln('Seu serviço foi agendado:');
    buffer.writeln();
    buffer.writeln('🔧 *Ordem de Serviço:* #${ordemServico.numero}');
    buffer.writeln('📅 *Data e Hora:* ${_formatarDataHora(ordemServico.dataAgendamento)}');
    buffer.writeln('💰 *Valor:* R\$ ${ordemServico.total.toStringAsFixed(2)}');
    buffer.writeln();
    
    // Duração estimada
    final duracaoTotal = ordemServico.itens
        .where((item) => item.duracaoMinutos != null)
        .fold<int>(0, (total, item) => total + (item.duracaoMinutos! * item.quantidade));
    
    if (duracaoTotal > 0) {
      final horas = duracaoTotal ~/ 60;
      final minutos = duracaoTotal % 60;
      buffer.writeln('⏱️ *Duração estimada:* ');
      if (horas > 0) {
        buffer.writeln('${horas}h${minutos > 0 ? ' ${minutos}min' : ''}');
      } else {
        buffer.writeln('${minutos}min');
      }
      buffer.writeln();
    }
    
    buffer.writeln('Estaremos no local no horário agendado.');
    buffer.writeln('Obrigado pela confiança! 😊');
    
    return buffer.toString();
  }

  // Gerar mensagem de lembrete de agendamento
  String _gerarMensagemLembreteAgendamento(OrdemServico ordemServico, int horasAntes) {
    final buffer = StringBuffer();
    
    buffer.writeln('⏰ *LEMBRETE DE AGENDAMENTO*');
    buffer.writeln();
    buffer.writeln('Olá, ${ordemServico.nomeCliente}!');
    buffer.writeln();
    
    if (horasAntes == 24) {
      buffer.writeln('Lembramos que seu serviço está agendado para *amanhã*!');
    } else if (horasAntes < 24) {
      buffer.writeln('Lembramos que seu serviço está agendado para *hoje*!');
    } else {
      final dias = horasAntes ~/ 24;
      buffer.writeln('Lembramos que seu serviço está agendado para *$dias dia${dias > 1 ? 's' : ''}*!');
    }
    
    buffer.writeln();
    buffer.writeln('🔧 *Ordem de Serviço:* #${ordemServico.numero}');
    buffer.writeln('📅 *Data e Hora:* ${_formatarDataHora(ordemServico.dataAgendamento)}');
    buffer.writeln('💰 *Valor:* R\$ ${ordemServico.total.toStringAsFixed(2)}');
    buffer.writeln();
    buffer.writeln('Estaremos no local no horário combinado.');
    buffer.writeln('Até breve! 😊');
    
    return buffer.toString();
  }

  // Gerar mensagem de início de execução
  String _gerarMensagemInicioExecucao(OrdemServico ordemServico) {
    final buffer = StringBuffer();
    
    buffer.writeln('🚀 *SERVIÇO INICIADO*');
    buffer.writeln();
    buffer.writeln('Olá, ${ordemServico.nomeCliente}!');
    buffer.writeln();
    buffer.writeln('Iniciamos a execução do seu serviço:');
    buffer.writeln();
    buffer.writeln('🔧 *Ordem de Serviço:* #${ordemServico.numero}');
    buffer.writeln('⏰ *Início:* ${_formatarDataHora(ordemServico.dataInicio!)}');
    buffer.writeln();
    buffer.writeln('Acompanhe o andamento e entre em contato se precisar!');
    buffer.writeln('Estamos trabalhando para você! 💪');
    
    return buffer.toString();
  }

  // Gerar mensagem de conclusão
  String _gerarMensagemConclusao(OrdemServico ordemServico) {
    final buffer = StringBuffer();
    
    buffer.writeln('✅ *SERVIÇO CONCLUÍDO*');
    buffer.writeln();
    buffer.writeln('Parabéns, ${ordemServico.nomeCliente}!');
    buffer.writeln();
    buffer.writeln('Seu serviço foi concluído com sucesso!');
    buffer.writeln();
    buffer.writeln('🔧 *Ordem de Serviço:* #${ordemServico.numero}');
    buffer.writeln('✅ *Concluído em:* ${_formatarDataHora(ordemServico.dataConclusao!)}');
    buffer.writeln('💰 *Valor total:* R\$ ${ordemServico.total.toStringAsFixed(2)}');
    buffer.writeln();
    
    if (ordemServico.observacoes != null && ordemServico.observacoes!.isNotEmpty) {
      buffer.writeln('📝 *Observações finais:*');
      buffer.writeln(ordemServico.observacoes!);
      buffer.writeln();
    }
    
    buffer.writeln('Esperamos que esteja satisfeito com nosso trabalho!');
    buffer.writeln('Obrigado pela confiança! 🎉');
    
    return buffer.toString();
  }

  // Obter descrição do status
  String _obterDescricaoStatus(StatusOrdemServico status) {
    switch (status) {
      case StatusOrdemServico.agendada:
        return '📅 Agendada';
      case StatusOrdemServico.emAndamento:
        return '🔧 Em Andamento';
      case StatusOrdemServico.pausada:
        return '⏸️ Pausada';
      case StatusOrdemServico.concluida:
        return '✅ Concluída';
      case StatusOrdemServico.cancelada:
        return '❌ Cancelada';
    }
  }

  // Formatar data e hora para exibição
  String _formatarDataHora(DateTime dataHora) {
    return '${dataHora.day.toString().padLeft(2, '0')}/${dataHora.month.toString().padLeft(2, '0')}/${dataHora.year} às ${dataHora.hour.toString().padLeft(2, '0')}:${dataHora.minute.toString().padLeft(2, '0')}';
  }

  // Verificar se cliente tem WhatsApp
  Future<bool> clienteTemWhatsApp(int clienteId) async {
    try {
      final cliente = await _clienteRepository.getClienteById(clienteId);
      return cliente?.telefone != null && cliente!.telefone!.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Obter histórico de mensagens da ordem de serviço
  Future<List<dynamic>> obterHistoricoMensagens(int ordemServicoId) async {
    try {
      // Método temporariamente desabilitado até implementação completa do WhatsApp
      return [];
    } catch (e) {
      return [];
    }
  }
}

// Provider - Temporariamente comentado até implementar o WhatsApp service
// final ordensServicoWhatsAppServiceProvider = Provider<OrdensServicoWhatsAppService>((ref) {
//   final whatsappService = ref.read(whatsAppIntegrationServiceProvider);
//   final clienteRepository = ClienteRepositoryImpl(ref.read(databaseProvider));
//   return OrdensServicoWhatsAppService(whatsappService, clienteRepository);
// });