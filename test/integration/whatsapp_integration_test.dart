import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import '../../lib/core/database/database.dart';
import '../../lib/features/whatsapp/data/repositories/whatsapp_repository_impl.dart';
import '../../lib/features/whatsapp/domain/entities/whatsapp_config.dart';
import '../../lib/features/whatsapp/domain/entities/whatsapp_message.dart';

void main() {
  group('WhatsApp Integration Tests', () {
    late AppDatabase database;
    late WhatsAppRepositoryImpl repository;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      repository = WhatsAppRepositoryImpl(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('deve salvar e recuperar configuração WhatsApp', () async {
      // Cria uma configuração de teste
      final config = WhatsAppConfig(
        id: 1,
        apiKey: 'test_api_key',
        phoneNumber: '5511999999999',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Salva a configuração
      await repository.saveConfig(config);

      // Recupera a configuração
      final savedConfig = await repository.getConfig();
      expect(savedConfig, isNotNull);
      expect(savedConfig!.apiKey, equals('test_api_key'));
      expect(savedConfig.phoneNumber, equals('5511999999999'));
      expect(savedConfig.isActive, isTrue);
    });

    test('deve salvar e recuperar mensagens WhatsApp', () async {
      // Cria uma mensagem de teste
      final message = WhatsAppMessage(
        id: 1,
        phoneNumber: '5511888888888',
        message: 'Mensagem de teste',
        type: 'text',
        status: 'sent',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Salva a mensagem
      await repository.saveMessage(message);

      // Recupera as mensagens
      final messages = await repository.getMessages();
      expect(messages.length, equals(1));
      expect(messages.first.message, equals('Mensagem de teste'));
      expect(messages.first.phoneNumber, equals('5511888888888'));
    });

    test('deve filtrar mensagens por número de telefone', () async {
      // Cria múltiplas mensagens
      final message1 = WhatsAppMessage(
        id: 1,
        phoneNumber: '5511111111111',
        message: 'Mensagem 1',
        type: 'text',
        status: 'sent',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final message2 = WhatsAppMessage(
        id: 2,
        phoneNumber: '5511222222222',
        message: 'Mensagem 2',
        type: 'text',
        status: 'sent',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await repository.saveMessage(message1);
      await repository.saveMessage(message2);

      // Filtra mensagens por número
      final filteredMessages = await repository.getMessagesByPhone('5511111111111');
      expect(filteredMessages.length, equals(1));
      expect(filteredMessages.first.message, equals('Mensagem 1'));
    });
  });
}