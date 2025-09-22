import '../../../../core/utils/platform_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../entities/orcamento.dart';
import '../../../clientes/domain/repositories/cliente_repository.dart';
import '../../../configuracoes/data/repositories/empresa_config_repository.dart';
import '../../../whatsapp/domain/services/whatsapp_templates.dart';

class OrcamentosWhatsAppService {
  final ClienteRepository? _clienteRepository;
  final EmpresaConfigRepository? _empresaConfigRepository;

  OrcamentosWhatsAppService({
    ClienteRepository? clienteRepository,
    EmpresaConfigRepository? empresaConfigRepository,
  }) : _clienteRepository = clienteRepository,
        _empresaConfigRepository = empresaConfigRepository;

  /// Envia orçamento via WhatsApp Web (abre no navegador)
  Future<bool> enviarOrcamento({
    required Orcamento orcamento,
    String? mensagemPersonalizada,
    bool incluirDetalhes = true,
  }) async {
    try {
      // Verificar se o cliente tem telefone
      if (orcamento.telefoneCliente == null || orcamento.telefoneCliente!.isEmpty) {
        throw Exception('Cliente não possui telefone cadastrado');
      }

      // Buscar configurações da empresa se disponível
      String nomeEmpresa = 'AutoGestor';
      if (_empresaConfigRepository != null) {
        try {
          final empresaConfig = await _empresaConfigRepository!.buscarConfiguracoes();
          nomeEmpresa = empresaConfig?.nomeFantasia ?? 'AutoGestor';
        } catch (e) {
          // Usar nome padrão se não conseguir buscar
        }
      }

      // Gerar mensagem
      String mensagem;
      if (mensagemPersonalizada != null) {
        mensagem = mensagemPersonalizada;
      } else {
        mensagem = _gerarMensagemOrcamento(orcamento, nomeEmpresa, incluirDetalhes);
      }

      // Preparar telefone (remover caracteres especiais)
      final telefone = orcamento.telefoneCliente!.replaceAll(RegExp(r'[^0-9]'), '');
      
      // Codificar mensagem para URL
      final mensagemCodificada = Uri.encodeComponent(mensagem);
      
      // Criar URL do WhatsApp
      final whatsappUrl = 'https://wa.me/55$telefone?text=$mensagemCodificada';
      
      // Abrir WhatsApp
      final uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return true;
      } else {
        throw Exception('Não foi possível abrir o WhatsApp');
      }
    } catch (e) {
      throw Exception('Erro ao enviar orçamento via WhatsApp: $e');
    }
  }

  /// Envia confirmação de aprovação do orçamento
  Future<bool> enviarConfirmacaoAprovacao(Orcamento orcamento) async {
    try {
      if (orcamento.telefoneCliente == null || orcamento.telefoneCliente!.isEmpty) {
        throw Exception('Cliente não possui telefone cadastrado');
      }

      final mensagem = '''✅ *ORÇAMENTO APROVADO!*

Olá *${orcamento.nomeCliente}*! 👋

Seu orçamento #${orcamento.numero} foi aprovado com sucesso! 🎉

💰 *Valor:* R\$ ${orcamento.valorTotal.toStringAsFixed(2)}

📅 Entraremos em contato para agendar o serviço.

🙏 Obrigado pela confiança!''';

      return await _enviarMensagemSimples(orcamento.telefoneCliente!, mensagem);
    } catch (e) {
      throw Exception('Erro ao enviar confirmação de aprovação: $e');
    }
  }

  /// Envia lembrete de vencimento do orçamento
  Future<bool> enviarLembreteVencimento({
    required Orcamento orcamento,
    required int diasParaVencimento,
  }) async {
    try {
      if (orcamento.telefoneCliente == null || orcamento.telefoneCliente!.isEmpty) {
        throw Exception('Cliente não possui telefone cadastrado');
      }

      String mensagem;
      if (diasParaVencimento == 0) {
        mensagem = '''⏰ *ORÇAMENTO VENCE HOJE!*

Olá *${orcamento.nomeCliente}*! 👋

Seu orçamento #${orcamento.numero} vence hoje!

💰 *Valor:* R\$ ${orcamento.valorTotal.toStringAsFixed(2)}

📞 Entre em contato conosco para aprovação ou dúvidas.

🙏 Aguardamos seu retorno!''';
      } else {
        mensagem = '''⏰ *LEMBRETE DE ORÇAMENTO*

Olá *${orcamento.nomeCliente}*! 👋

Seu orçamento #${orcamento.numero} vence em $diasParaVencimento ${diasParaVencimento == 1 ? 'dia' : 'dias'}!

💰 *Valor:* R\$ ${orcamento.valorTotal.toStringAsFixed(2)}

📞 Entre em contato conosco para aprovação ou dúvidas.

🙏 Aguardamos seu retorno!''';
      }

      return await _enviarMensagemSimples(orcamento.telefoneCliente!, mensagem);
    } catch (e) {
      throw Exception('Erro ao enviar lembrete de vencimento: $e');
    }
  }

  /// Verifica se o cliente tem WhatsApp (simulado)
  Future<bool> clienteTemWhatsApp(int clienteId) async {
    try {
      if (_clienteRepository != null) {
        final cliente = await _clienteRepository!.getClienteById(clienteId);
        return cliente?.telefone != null && cliente!.telefone!.isNotEmpty;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Gera mensagem formatada do orçamento
  String _gerarMensagemOrcamento(Orcamento orcamento, String nomeEmpresa, bool incluirDetalhes) {
    String mensagem = '''🔧 *ORÇAMENTO ${orcamento.numero}* - $nomeEmpresa

📋 *Dados do Cliente:*
Nome: ${orcamento.nomeCliente}
Telefone: ${orcamento.telefoneCliente!}''';

    if (orcamento.emailCliente != null && orcamento.emailCliente!.isNotEmpty) {
      mensagem += '\nE-mail: ${orcamento.emailCliente!}';
    }
    
    mensagem += '\n\n📅 *Data de Emissão:* ${orcamento.dataEmissao.day.toString().padLeft(2, '0')}/${orcamento.dataEmissao.month.toString().padLeft(2, '0')}/${orcamento.dataEmissao.year}';
    
    if (orcamento.dataValidade != null) {
      mensagem += '\n⏰ *Validade:* ${orcamento.dataValidade!.day.toString().padLeft(2, '0')}/${orcamento.dataValidade!.month.toString().padLeft(2, '0')}/${orcamento.dataValidade!.year}';
    }
    
    mensagem += '\n\n💰 *Valor Total: R\$ ${orcamento.valorTotal.toStringAsFixed(2)}*';
    
    if (incluirDetalhes) {
      if (orcamento.observacoes != null && orcamento.observacoes!.isNotEmpty) {
        mensagem += '\n\n📝 *Observações:*\n${orcamento.observacoes!}';
      }
      
      if (orcamento.condicoesPagamento != null && orcamento.condicoesPagamento!.isNotEmpty) {
        mensagem += '\n\n💳 *Condições de Pagamento:*\n${orcamento.condicoesPagamento!}';
      }
    }

    mensagem += '\n\n✅ Para mais detalhes ou dúvidas, entre em contato conosco!';
    mensagem += '\n🙏 Aguardamos seu retorno!';

    return mensagem;
  }

  /// Envia mensagem simples via WhatsApp Web
  Future<bool> _enviarMensagemSimples(String telefone, String mensagem) async {
    try {
      final telefoneFormatado = telefone.replaceAll(RegExp(r'[^0-9]'), '');
      final mensagemCodificada = Uri.encodeComponent(mensagem);
      final whatsappUrl = 'https://wa.me/55$telefoneFormatado?text=$mensagemCodificada';
      
      final uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return true;
      } else {
        throw Exception('Não foi possível abrir o WhatsApp');
      }
    } catch (e) {
      throw Exception('Erro ao enviar mensagem: $e');
    }
  }
}