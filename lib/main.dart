import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:get_it/get_it.dart';

import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/domain/services/admin_service.dart';
import 'features/orcamentos/presentation/providers/orcamentos_provider.dart';
import 'features/ordens_servico/presentation/providers/ordens_servico_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configurar injeção de dependência
  setupServiceLocator();
  
  // Criar usuário administrador padrão se não existir
  try {
    final adminService = GetIt.instance<AdminService>();
    await adminService.criarAdminPadrao();
  } catch (e) {
    print('Erro ao criar admin padrão: $e');
  }
  
  // Verificar status de autenticação na inicialização
  try {
    final authProvider = GetIt.instance<AuthProvider>();
    await authProvider.checkAuthStatus();
  } catch (e) {
    print('Erro ao verificar status de autenticação: $e');
  }
  
  runApp(
    ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(
            create: (context) => GetIt.instance<AuthProvider>(),
          ),
          provider.ChangeNotifierProvider(
            create: (context) => GetIt.instance<OrcamentosProvider>(),
          ),
          provider.ChangeNotifierProvider(
            create: (context) => GetIt.instance<OrdensServicoProvider>(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    
    return MaterialApp.router(
      title: 'AutoGestor',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}