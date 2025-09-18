import '../entities/whatsapp_message.dart';
import '../entities/whatsapp_config.dart';

abstract class WhatsAppService {
  Future<bool> enviarMensagem({
    required String telefone,
    required String mensagem,
    Map<String, dynamic>? metadata,
  });
  
  Future<bool> verificarConexao();
  Future<Map<String, dynamic>> obterStatusInstancia();
  
  Future<bool> enviarMensagemComImagem({
    required String telefone,
    required String mensagem,
    required String imagemUrl,
    String? legenda,
  });
  
  Future<bool> enviarMensagemComDocumento({
    required String telefone,
    required String documentoUrl,
    required String nomeArquivo,
    String? mensagem,
  });
  
  Future<List<Map<String, dynamic>>> obterMensagensRecebidas({
    DateTime? desde,
  });
  
  Future<bool> marcarComoLida(String messageId);
}

class WhatsAppServiceException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;
  
  const WhatsAppServiceException(
    this.message, {
    this.statusCode,
    this.originalError,
  });
  
  @override
  String toString() {
    return 'WhatsAppServiceException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
  }
}