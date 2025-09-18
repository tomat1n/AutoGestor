import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../pages/login_page.dart';
import 'expired_subscription_page.dart';

class AuthMiddleware extends StatelessWidget {
  final Widget child;
  final bool requireAuth;
  final bool allowExpired;

  const AuthMiddleware({
    Key? key,
    required this.child,
    this.requireAuth = true,
    this.allowExpired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // Se não requer autenticação, mostra o child diretamente
        if (!requireAuth) {
          return child;
        }

        // Se está carregando, mostra loading
        if (authProvider.state == AuthState.initial || authProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Se não está autenticado, redireciona para login
        if (!authProvider.isAuthenticated && !authProvider.isExpired) {
          return const LoginPage();
        }

        // Se assinatura expirou e não permite acesso expirado
        if (authProvider.isExpired && !allowExpired) {
          return const ExpiredSubscriptionPage();
        }

        // Se chegou até aqui, pode mostrar o conteúdo
        return child;
      },
    );
  }
}

// Widget para verificação de acesso em rotas específicas
class RouteGuard extends StatefulWidget {
  final Widget child;
  final List<String> requiredPermissions;
  final bool allowTrial;

  const RouteGuard({
    Key? key,
    required this.child,
    this.requiredPermissions = const [],
    this.allowTrial = true,
  }) : super(key: key);

  @override
  State<RouteGuard> createState() => _RouteGuardState();
}

class _RouteGuardState extends State<RouteGuard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAccess();
    });
  }

  Future<void> _checkAccess() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    // Verificar status da assinatura
    await authProvider.verificarStatusAssinatura();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // Se não está autenticado
        if (!authProvider.isAuthenticated && !authProvider.isExpired) {
          return const LoginPage();
        }

        // Se assinatura expirou
        if (authProvider.isExpired) {
          return const ExpiredSubscriptionPage();
        }

        // Se está em período de teste e a rota não permite teste
        if (authProvider.isTeste && !widget.allowTrial) {
          return _buildTrialRestrictionPage();
        }

        // Verificar permissões específicas (se necessário)
        if (widget.requiredPermissions.isNotEmpty) {
          // TODO: Implementar sistema de permissões mais granular se necessário
        }

        return widget.child;
      },
    );
  }

  Widget _buildTrialRestrictionPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acesso Restrito'),
        backgroundColor: Colors.orange.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 80,
                color: Colors.orange.shade600,
              ),
              const SizedBox(height: 24),
              Text(
                'Funcionalidade Premium',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Esta funcionalidade está disponível apenas para usuários com assinatura ativa.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/renovar-assinatura');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'Assinar Agora',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget para mostrar informações da assinatura
class SubscriptionInfo extends StatelessWidget {
  final bool showDetails;

  const SubscriptionInfo({
    Key? key,
    this.showDetails = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (!authProvider.isAuthenticated) {
          return const SizedBox.shrink();
        }

        final assinatura = authProvider.assinatura;
        if (assinatura == null) {
          return const SizedBox.shrink();
        }

        final diasRestantes = authProvider.diasRestantes;
        final isTeste = authProvider.isTeste;
        
        Color cor;
        IconData icone;
        String texto;

        if (isTeste) {
          cor = Colors.blue;
          icone = Icons.schedule;
          texto = 'Teste: $diasRestantes dias restantes';
        } else if (diasRestantes <= 7) {
          cor = Colors.red;
          icone = Icons.warning;
          texto = 'Expira em $diasRestantes dias';
        } else if (diasRestantes <= 30) {
          cor = Colors.orange;
          icone = Icons.schedule;
          texto = '$diasRestantes dias restantes';
        } else {
          cor = Colors.green;
          icone = Icons.check_circle;
          texto = 'Ativa ($diasRestantes dias)';
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: cor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icone,
                size: 16,
                color: cor,
              ),
              const SizedBox(width: 6),
              Text(
                texto,
                style: TextStyle(
                  color: cor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}