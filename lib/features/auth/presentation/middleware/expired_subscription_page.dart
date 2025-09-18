import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../../domain/entities/assinatura_entity.dart';

class ExpiredSubscriptionPage extends StatelessWidget {
  const ExpiredSubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.shade800,
              Colors.red.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              final usuario = authProvider.usuario;
              final assinatura = authProvider.assinatura;
              final diasRestantes = authProvider.diasRestantes;
              
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Ícone de aviso
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Icon(
                              Icons.access_time,
                              size: 40,
                              color: Colors.red.shade800,
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Título
                          Text(
                            'Assinatura Expirada',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Informações da empresa
                          if (usuario != null) ...
                            [
                              Text(
                                usuario.nomeFantasia ?? usuario.empresa ?? 'Empresa',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          
                          // Status da assinatura
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Column(
                              children: [
                                if (assinatura != null) ...
                                  [
                                    Text(
                                      'Tipo: ${assinatura.tipo.nome}',
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Expirou em: ${_formatDate(assinatura.dataFim)}',
                                      style: TextStyle(color: Colors.red.shade700),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                Text(
                                  diasRestantes < 0 
                                      ? 'Expirada há ${-diasRestantes} dias'
                                      : 'Expira hoje',
                                  style: TextStyle(
                                    color: Colors.red.shade800,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Mensagem
                          const Text(
                            'Para continuar usando o AutoGestor, você precisa renovar sua assinatura.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 32),
                          
                          // Planos disponíveis
                          Text(
                            'Escolha um plano:',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Plano Mensal
                          _buildPlanCard(
                            context,
                            authProvider,
                            TipoAssinatura.mensal,
                            'Mensal',
                            'R\$ 99,90/mês',
                            'Ideal para começar',
                            Colors.blue,
                          ),
                          const SizedBox(height: 12),
                          
                          // Plano Trimestral
                          _buildPlanCard(
                            context,
                            authProvider,
                            TipoAssinatura.trimestral,
                            'Trimestral',
                            'R\$ 79,90/mês',
                            'Economize 20%',
                            Colors.green,
                            isPopular: true,
                          ),
                          const SizedBox(height: 12),
                          
                          // Plano Anual
                          _buildPlanCard(
                            context,
                            authProvider,
                            TipoAssinatura.anual,
                            'Anual',
                            'R\$ 59,90/mês',
                            'Economize 40%',
                            Colors.purple,
                          ),
                          const SizedBox(height: 32),
                          
                          // Botão Logout
                          TextButton(
                            onPressed: () async {
                              await authProvider.logout();
                            },
                            child: const Text(
                              'Sair da conta',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    AuthProvider authProvider,
    TipoAssinatura tipo,
    String nome,
    String preco,
    String descricao,
    Color cor, {
    bool isPopular = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isPopular ? cor : Colors.grey.shade300,
          width: isPopular ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          if (isPopular)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: cor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: const Text(
                  'POPULAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: cor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        preco,
                        style: TextStyle(
                          color: cor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        descricao,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final sucesso = await authProvider.renovarAssinatura(tipo);
                    
                    if (context.mounted) {
                      if (sucesso) {
                        // Mostrar tela de pagamento ou confirmação
                        _showPaymentDialog(context, authProvider, tipo);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(authProvider.erro ?? 'Erro ao renovar assinatura'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Escolher'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context, AuthProvider authProvider, TipoAssinatura tipo) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Pagamento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Plano: ${tipo.nome}'),
            Text('Valor: R\$ ${tipo.valor.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            const Text(
              'Simular pagamento realizado com sucesso!',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              // Simular confirmação de pagamento
              await authProvider.confirmarPagamento('Simulado', 'SIM123456');
              
              if (context.mounted) {
                Navigator.of(context).pop();
                
                // Mostrar sucesso e redirecionar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Assinatura renovada com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
                
                // Navegar para dashboard
                context.go('/dashboard');
              }
            },
            child: const Text('Confirmar Pagamento'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}