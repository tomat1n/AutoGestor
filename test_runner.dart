import 'dart:io';

/// Script para executar diferentes tipos de testes
/// 
/// Uso:
/// dart test_runner.dart [tipo]
/// 
/// Tipos disponíveis:
/// - unit: Executa apenas testes unitários
/// - integration: Executa apenas testes de integração  
/// - widget: Executa apenas testes de widget
/// - all: Executa todos os testes (padrão)

void main(List<String> args) async {
  final testType = args.isNotEmpty ? args[0] : 'all';
  
  print('🧪 Executando testes: $testType');
  print('=' * 50);
  
  switch (testType) {
    case 'unit':
      await runUnitTests();
      break;
    case 'integration':
      await runIntegrationTests();
      break;
    case 'widget':
      await runWidgetTests();
      break;
    case 'all':
    default:
      await runAllTests();
      break;
  }
}

Future<void> runUnitTests() async {
  print('📋 Executando testes unitários...');
  await runTests('test/unit/');
}

Future<void> runIntegrationTests() async {
  print('🔗 Executando testes de integração...');
  await runTests('test/integration/');
}

Future<void> runWidgetTests() async {
  print('🎨 Executando testes de widget...');
  await runTests('test/widget/');
}

Future<void> runAllTests() async {
  print('🚀 Executando todos os testes...');
  await runTests('test/');
}

Future<void> runTests(String path) async {
  final result = await Process.run(
    'flutter',
    ['test', path, '--coverage'],
    runInShell: true,
  );
  
  print(result.stdout);
  if (result.stderr.isNotEmpty) {
    print('❌ Erros:');
    print(result.stderr);
  }
  
  if (result.exitCode == 0) {
    print('✅ Testes executados com sucesso!');
  } else {
    print('❌ Alguns testes falharam.');
    exit(result.exitCode);
  }
}