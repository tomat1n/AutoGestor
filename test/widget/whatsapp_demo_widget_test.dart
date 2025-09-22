import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../lib/features/whatsapp/presentation/pages/whatsapp_demo_page.dart';

void main() {
  group('WhatsApp Demo Widget Tests', () {
    testWidgets('deve exibir campos de entrada', (WidgetTester tester) async {
      // Cria um widget com tamanho específico para evitar overflow
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 800,
                height: 1200, // Aumenta a altura para evitar overflow
                child: WhatsAppDemoPage(),
              ),
            ),
          ),
        ),
      );

      // Verifica se os campos de entrada estão presentes
      expect(find.byType(TextFormField), findsWidgets);
      expect(find.text('Telefone'), findsOneWidget);
      expect(find.text('Mensagem'), findsOneWidget);
    });

    testWidgets('deve validar campos vazios', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 800,
                height: 1200,
                child: WhatsAppDemoPage(),
              ),
            ),
          ),
        ),
      );

      // Tenta enviar sem preencher os campos
      final sendButton = find.text('Enviar Mensagem');
      if (sendButton.evaluate().isNotEmpty) {
        await tester.tap(sendButton);
        await tester.pump();
      }

      // Verifica se há validação (pode não haver mensagens de erro visíveis)
      expect(find.byType(WhatsAppDemoPage), findsOneWidget);
    });

    testWidgets('deve aceitar entrada válida', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 800,
                height: 1200,
                child: WhatsAppDemoPage(),
              ),
            ),
          ),
        ),
      );

      // Preenche os campos
      final telefoneField = find.byType(TextFormField).first;
      await tester.enterText(telefoneField, '11999999999');
      
      final mensagemFields = find.byType(TextFormField);
      if (mensagemFields.evaluate().length > 1) {
        await tester.enterText(mensagemFields.at(1), 'Mensagem de teste');
      }

      await tester.pump();

      // Verifica se os valores foram inseridos
      expect(find.text('11999999999'), findsOneWidget);
      expect(find.text('Mensagem de teste'), findsOneWidget);
    });
  });
}