import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class AdminMiddleware extends StatelessWidget {
  final Widget child;
  final Widget? fallback;

  const AdminMiddleware({
    Key? key,
    required this.child,
    this.fallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // Verificar se o usuário tem permissões de admin
        if (!authProvider.temPermissaoAdmin()) {
          return fallback ?? _buildAccessDeniedPage(context);
        }

        return child;
      },
    );
  }

  Widget _buildAccessDeniedPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acesso Negado'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.security,
                size: 100,
                color: Colors.red[300],
              ),
              const SizedBox(height: 24),
              const Text(
                'Acesso Restrito',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Você não tem permissão para acessar esta área.\nApenas administradores podem visualizar este conteúdo.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Voltar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navegar para a página de contato ou suporte
                      _showContactDialog(context);
                    },
                    icon: const Icon(Icons.contact_support),
                    label: const Text('Solicitar Acesso'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Solicitar Acesso de Administrador'),
        content: const Text(
          'Para solicitar acesso de administrador, entre em contato com o administrador do sistema ou com o suporte técnico.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

// Widget helper para verificação rápida de admin
class AdminOnly extends StatelessWidget {
  final Widget child;
  final Widget? placeholder;

  const AdminOnly({
    Key? key,
    required this.child,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.temPermissaoAdmin()) {
          return child;
        }
        
        return placeholder ?? const SizedBox.shrink();
      },
    );
  }
}

// Mixin para páginas que precisam de verificação de admin
mixin AdminRequiredMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAdminAccess();
    });
  }

  void _checkAdminAccess() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    if (!authProvider.temPermissaoAdmin()) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AdminMiddleware(
            child: Container(), // Não será mostrado
          ),
        ),
      );
    }
  }
}