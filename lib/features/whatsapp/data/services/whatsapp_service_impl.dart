import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/whatsapp_config.dart';
import '../../domain/services/whatsapp_service.dart';

class WhatsAppServiceImpl implements WhatsAppService {
  final WhatsAppConfig config;
  late final http.Client _client;
  
  WhatsAppServiceImpl(this.config) {
    _client = http.Client();
  }

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${config.apiToken}',
  };

  @override
  Future<bool> enviarMensagem({
    required String telefone,
    required String mensagem,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final url = Uri.parse('${config.apiUrl}/message/sendText/${config.instanceId}');
      
      final body = {
        'number': _formatarTelefone(telefone),
        'textMessage': {
          'text': mensagem,
        },
        'options': {
          'delay': 1200,
          'presence': 'composing',
        },
        if (metadata != null) 'metadata': metadata,
      };

      final response = await _client.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return responseData['key'] != null;
      }
      
      throw WhatsAppServiceException(
        'Erro ao enviar mensagem: ${response.body}',
        statusCode: response.statusCode,
      );
    } catch (e) {
      if (e is WhatsAppServiceException) rethrow;
      throw WhatsAppServiceException(
        'Erro de conexão: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<bool> verificarConexao() async {
    try {
      final url = Uri.parse('${config.apiUrl}/instance/connectionState/${config.instanceId}');
      
      final response = await _client.get(url, headers: _headers);
      
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['instance']?['state'] == 'open';
      }
      
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> obterStatusInstancia() async {
    try {
      final url = Uri.parse('${config.apiUrl}/instance/connectionState/${config.instanceId}');
      
      final response = await _client.get(url, headers: _headers);
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      
      throw WhatsAppServiceException(
        'Erro ao obter status: ${response.body}',
        statusCode: response.statusCode,
      );
    } catch (e) {
      if (e is WhatsAppServiceException) rethrow;
      throw WhatsAppServiceException(
        'Erro de conexão: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<bool> enviarMensagemComImagem({
    required String telefone,
    required String mensagem,
    required String imagemUrl,
    String? legenda,
  }) async {
    try {
      final url = Uri.parse('${config.apiUrl}/message/sendMedia/${config.instanceId}');
      
      final body = {
        'number': _formatarTelefone(telefone),
        'mediaMessage': {
          'mediatype': 'image',
          'media': imagemUrl,
          'caption': legenda ?? mensagem,
        },
        'options': {
          'delay': 1200,
          'presence': 'composing',
        },
      };

      final response = await _client.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return responseData['key'] != null;
      }
      
      throw WhatsAppServiceException(
        'Erro ao enviar imagem: ${response.body}',
        statusCode: response.statusCode,
      );
    } catch (e) {
      if (e is WhatsAppServiceException) rethrow;
      throw WhatsAppServiceException(
        'Erro de conexão: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<bool> enviarMensagemComDocumento({
    required String telefone,
    required String documentoUrl,
    required String nomeArquivo,
    String? mensagem,
  }) async {
    try {
      final url = Uri.parse('${config.apiUrl}/message/sendMedia/${config.instanceId}');
      
      final body = {
        'number': _formatarTelefone(telefone),
        'mediaMessage': {
          'mediatype': 'document',
          'media': documentoUrl,
          'fileName': nomeArquivo,
          'caption': mensagem,
        },
        'options': {
          'delay': 1200,
          'presence': 'composing',
        },
      };

      final response = await _client.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return responseData['key'] != null;
      }
      
      throw WhatsAppServiceException(
        'Erro ao enviar documento: ${response.body}',
        statusCode: response.statusCode,
      );
    } catch (e) {
      if (e is WhatsAppServiceException) rethrow;
      throw WhatsAppServiceException(
        'Erro de conexão: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<List<Map<String, dynamic>>> obterMensagensRecebidas({
    DateTime? desde,
  }) async {
    try {
      final url = Uri.parse('${config.apiUrl}/chat/findMessages/${config.instanceId}');
      
      final body = {
        'where': {
          'key': {
            'fromMe': false,
          },
          if (desde != null)
            'messageTimestamp': {
              '\$gte': desde.millisecondsSinceEpoch ~/ 1000,
            },
        },
        'limit': 100,
      };

      final response = await _client.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(responseData ?? []);
      }
      
      throw WhatsAppServiceException(
        'Erro ao obter mensagens: ${response.body}',
        statusCode: response.statusCode,
      );
    } catch (e) {
      if (e is WhatsAppServiceException) rethrow;
      throw WhatsAppServiceException(
        'Erro de conexão: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<bool> marcarComoLida(String messageId) async {
    try {
      final url = Uri.parse('${config.apiUrl}/chat/markMessageAsRead/${config.instanceId}');
      
      final body = {
        'readMessages': [{
          'id': messageId,
          'fromMe': false,
        }],
      };

      final response = await _client.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  String _formatarTelefone(String telefone) {
    // Remove todos os caracteres não numéricos
    String numeroLimpo = telefone.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Se não começar com código do país, adiciona o código do Brasil
    if (!numeroLimpo.startsWith('55')) {
      numeroLimpo = '55$numeroLimpo';
    }
    
    // Adiciona @c.us no final para o formato do WhatsApp
    return '$numeroLimpo@c.us';
  }

  void dispose() {
    _client.close();
  }
}