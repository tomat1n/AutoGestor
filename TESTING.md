# 🧪 Guia de Testes - AutoGestor

Este documento fornece informações completas sobre como executar testes no projeto AutoGestor.

## 📁 Estrutura de Testes

```
test/
├── unit/                    # Testes unitários
│   └── database_test.dart   # Testes do banco de dados
├── integration/             # Testes de integração
│   └── whatsapp_integration_test.dart  # Testes WhatsApp
├── widget/                  # Testes de widget
│   └── whatsapp_demo_widget_test.dart  # Testes de UI
└── widget_test.dart         # Teste básico do app
```

## 🚀 Como Executar os Testes

### Opção 1: Usando o Script Personalizado

```bash
# Executar todos os testes
dart test_runner.dart all

# Executar apenas testes unitários
dart test_runner.dart unit

# Executar apenas testes de integração
dart test_runner.dart integration

# Executar apenas testes de widget
dart test_runner.dart widget
```

### Opção 2: Usando Flutter Test Diretamente

```bash
# Todos os testes
flutter test

# Testes específicos por pasta
flutter test test/unit/
flutter test test/integration/
flutter test test/widget/

# Teste específico
flutter test test/unit/database_test.dart

# Com cobertura de código
flutter test --coverage
```

### Opção 3: Usando Dart Test

```bash
# Todos os testes
dart test

# Testes específicos
dart test test/unit/database_test.dart
```

## 📊 Tipos de Testes

### 1. Testes Unitários (`test/unit/`)
- **Objetivo**: Testar funções e classes isoladamente
- **Exemplo**: `database_test.dart` - testa operações do banco de dados
- **Comando**: `flutter test test/unit/`

### 2. Testes de Integração (`test/integration/`)
- **Objetivo**: Testar interação entre componentes
- **Exemplo**: `whatsapp_integration_test.dart` - testa fluxo completo WhatsApp
- **Comando**: `flutter test test/integration/`

### 3. Testes de Widget (`test/widget/`)
- **Objetivo**: Testar interface do usuário
- **Exemplo**: `whatsapp_demo_widget_test.dart` - testa formulários e validações
- **Comando**: `flutter test test/widget/`

## 🔧 Configuração de Testes

### Dependências Necessárias

Certifique-se de que o `pubspec.yaml` contém:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  test: ^1.24.0
  mockito: ^5.4.0
  build_runner: ^2.4.0
```

### Instalação das Dependências

```bash
flutter pub get
```

## 📈 Cobertura de Código

Para gerar relatório de cobertura:

```bash
# Executar testes com cobertura
flutter test --coverage

# Gerar relatório HTML (requer lcov)
genhtml coverage/lcov.info -o coverage/html

# Visualizar no navegador
open coverage/html/index.html
```

## 🐛 Debugging de Testes

### Executar Testes em Modo Debug

```bash
# Com output detalhado
flutter test --verbose

# Com informações de debug
flutter test --debug
```

### Executar Teste Específico

```bash
# Por nome do teste
flutter test --name "deve inserir e buscar produto"

# Por arquivo específico
flutter test test/unit/database_test.dart
```

## 📱 Testes em Diferentes Plataformas

### Android
```bash
flutter test --device-id android
```

### iOS
```bash
flutter test --device-id ios
```

### Web
```bash
flutter test --platform chrome
```

### Desktop
```bash
flutter test --device-id windows
flutter test --device-id macos
flutter test --device-id linux
```

## 🔍 Análise de Código

### Executar Análise Estática

```bash
# Análise completa
flutter analyze

# Análise com informações fatais
flutter analyze --fatal-infos

# Análise de arquivo específico
flutter analyze lib/features/whatsapp/
```

### Formatação de Código

```bash
# Formatar todo o código
dart format .

# Verificar formatação
dart format --set-exit-if-changed .
```

## 🚨 Solução de Problemas Comuns

### 1. Erro de Dependências
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### 2. Erro de Banco de Dados em Testes
- Certifique-se de usar `NativeDatabase.memory()` nos testes
- Feche sempre o banco no `tearDown()`

### 3. Erro de Widget Tests
- Use `ProviderScope` para testes com Riverpod
- Use `MaterialApp` como wrapper para widgets

### 4. Erro de Imports
- Verifique se todos os imports estão corretos
- Use imports relativos para arquivos do projeto

## 📋 Checklist de Testes

Antes de fazer commit, execute:

- [ ] `flutter analyze` (sem erros)
- [ ] `flutter test` (todos os testes passando)
- [ ] `dart format .` (código formatado)
- [ ] Cobertura de código > 80%

## 🔗 Links Úteis

- [Flutter Testing Guide](https://docs.flutter.dev/testing)
- [Dart Testing](https://dart.dev/guides/testing)
- [Widget Testing](https://docs.flutter.dev/testing/widget-tests)
- [Integration Testing](https://docs.flutter.dev/testing/integration-tests)

## 📞 Suporte

Se encontrar problemas com os testes:

1. Verifique este documento
2. Execute `flutter doctor` para verificar o ambiente
3. Limpe o projeto: `flutter clean && flutter pub get`
4. Regenere arquivos: `dart run build_runner build --delete-conflicting-outputs`

---

**Última atualização**: $(date)
**Versão do Flutter**: Execute `flutter --version` para verificar