import '../entities/whatsapp_message.dart';
import '../entities/whatsapp_config.dart';

abstract class WhatsAppRepository {
  // Configurações
  Future<WhatsAppConfig?> obterConfiguracao();
  Future<void> salvarConfiguracao(WhatsAppConfig config);
  
  // Mensagens
  Future<List<WhatsAppMessage>> listarMensagens({
    String? clienteId,
    String? tipo,
    String? status,
    DateTime? dataInicio,
    DateTime? dataFim,
    int? limite,
  });
  
  Future<WhatsAppMessage> salvarMensagem(WhatsAppMessage mensagem);
  Future<WhatsAppMessage> atualizarMensagem(WhatsAppMessage mensagem);
  Future<void> excluirMensagem(int id);
  Future<WhatsAppMessage?> obterMensagemPorId(int id);
  
  // Mensagens pendentes
  Future<List<WhatsAppMessage>> obterMensagensPendentes();
  Future<void> marcarComoEnviada(int id, DateTime dataEnvio);
  Future<void> marcarComoEntregue(int id, DateTime dataEntrega);
  Future<void> marcarComoLida(int id, DateTime dataLeitura);
  Future<void> marcarComoErro(int id, String erro);
  
  // Estatísticas
  Future<Map<String, int>> obterEstatisticas({
    DateTime? dataInicio,
    DateTime? dataFim,
  });
}