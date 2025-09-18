import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' as provider;

import '../../features/admin/presentation/middleware/admin_middleware.dart';
import '../../features/admin/presentation/pages/admin_panel_page.dart';
import '../../features/estoque/presentation/pages/estoque_page.dart';
import '../../features/estoque/presentation/pages/produto_form_page.dart';
import '../../features/clientes/presentation/pages/clientes_page.dart';
import '../../features/clientes/presentation/pages/cliente_form_page.dart';
import '../../features/servicos/presentation/pages/servicos_page.dart';
import '../../features/servicos/presentation/pages/servico_form_page.dart';
import '../../features/servicos/presentation/pages/orcamento_servicos_page.dart';
import '../../features/orcamentos/presentation/pages/orcamentos_page.dart';
import '../../features/orcamentos/presentation/pages/orcamento_form_page.dart';
import '../../features/orcamentos/presentation/pages/orcamento_detalhes_page.dart';
import '../../features/orcamentos/domain/entities/orcamento.dart';
import '../../features/orcamentos/domain/repositories/orcamentos_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import '../../features/ordens_servico/presentation/pages/ordens_servico_page.dart';
import '../../features/ordens_servico/presentation/pages/ordem_servico_form_page.dart';
import '../../features/whatsapp/presentation/pages/whatsapp_demo_page.dart';
import '../../features/vendas/presentation/pages/vendas_page.dart';
import '../../features/pdv/presentation/pages/pdv_page.dart';
import '../../features/pdv/presentation/pages/carrinho_page.dart';
import '../../features/pdv/presentation/pages/historico_page.dart';
import '../../features/configuracoes/presentation/pages/empresa_config_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/cadastro_page.dart';
import '../../features/auth/presentation/pages/configuracoes_page.dart';
import '../../features/auth/presentation/middleware/auth_middleware.dart';
import '../../features/auth/presentation/middleware/expired_subscription_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../pages/splash_page.dart';
import '../widgets/main_layout.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final authProvider = provider.Provider.of<AuthProvider>(context, listen: false);
      final isLoggedIn = authProvider.isLoggedIn;
      final hasValidSubscription = authProvider.acessoPermitido;
      
      // Rotas que não precisam de autenticação
      final publicRoutes = ['/splash', '/login', '/cadastro'];
      final isPublicRoute = publicRoutes.contains(state.matchedLocation);
      
      // Se não está logado e não está em rota pública, vai para login
      if (!isLoggedIn && !isPublicRoute) {
        return '/login';
      }
      
      // Se está logado mas não tem assinatura válida e não está na página de assinatura expirada
      if (isLoggedIn && !hasValidSubscription && state.matchedLocation != '/assinatura-expirada') {
        return '/assinatura-expirada';
      }
      
      // Se está logado, tem assinatura válida e está em rota pública, vai para dashboard
      if (isLoggedIn && hasValidSubscription && isPublicRoute) {
        return '/dashboard';
      }
      
      return null;
    },
    routes: [
      // Rotas de autenticação (sem layout)
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/cadastro',
        builder: (context, state) => const CadastroPage(),
      ),
      GoRoute(
        path: '/assinatura-expirada',
        builder: (context, state) => const ExpiredSubscriptionPage(),
      ),
      GoRoute(
        path: '/auth-configuracoes',
        builder: (context, state) => const AuthMiddleware(
          child: ConfiguracoesPage(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          // Nova rota do dashboard
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: '/estoque',
            name: 'estoque',
            builder: (context, state) => const EstoquePage(),
            routes: [
              GoRoute(
                path: 'novo',
                name: 'produto-novo',
                builder: (context, state) => const ProdutoFormPage(),
              ),
              GoRoute(
                path: 'editar/:id',
                name: 'produto-editar',
                builder: (context, state) {
                  // Para edição, o produto será carregado dentro da página
                  return const ProdutoFormPage();
                },
              ),
            ],
          ),
          GoRoute(
            path: '/clientes',
            name: 'clientes',
            builder: (context, state) => const ClientesPage(),
            routes: [
              GoRoute(
                path: 'novo',
                name: 'cliente-novo',
                builder: (context, state) => const ClienteFormPage(),
              ),
              GoRoute(
                path: 'editar/:id',
                name: 'cliente-editar',
                builder: (context, state) {
                  // Para edição, o cliente será carregado dentro da página
                  return const ClienteFormPage();
                },
              ),
            ],
          ),
          GoRoute(
            path: '/servicos',
            name: 'servicos',
            builder: (context, state) => const ServicosPage(),
            routes: [
              GoRoute(
                path: 'novo',
                name: 'servico-novo',
                builder: (context, state) => const ServicoFormPage(),
              ),
              GoRoute(
                path: 'editar/:id',
                name: 'servico-editar',
                builder: (context, state) {
                  // Para edição, o serviço será carregado dentro da página
                  return const ServicoFormPage();
                },
              ),
              GoRoute(
                path: 'orcamento',
                name: 'orcamento-servicos',
                builder: (context, state) => const OrcamentoServicosPage(),
              ),
            ],
          ),
          GoRoute(
            path: '/orcamentos',
            name: 'orcamentos',
            builder: (context, state) => const OrcamentosPage(),
            routes: [
              GoRoute(
                path: 'novo',
                name: 'orcamento-novo',
                builder: (context, state) => const OrcamentoFormPage(),
              ),
              GoRoute(
                path: 'editar/:id',
                name: 'orcamento-editar',
                builder: (context, state) {
                  final id = int.tryParse(state.pathParameters['id'] ?? '');
                  return OrcamentoFormPage(orcamentoId: id);
                },
              ),
              GoRoute(
                path: 'detalhes/:id',
                name: 'orcamento-detalhes',
                builder: (context, state) {
                  final id = int.tryParse(state.pathParameters['id'] ?? '');
                  if (id == null) {
                    return const OrcamentosPage();
                  }
                  // Buscar o orçamento pelo ID e navegar para a página de detalhes
                  return FutureBuilder<Orcamento?>(
                    future: GetIt.instance<OrcamentosRepository>().buscarPorId(id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Scaffold(
                          body: Center(child: CircularProgressIndicator()),
                        );
                      }
                      
                      if (snapshot.hasError || !snapshot.hasData) {
                        return const Scaffold(
                          body: Center(
                            child: Text('Orçamento não encontrado'),
                          ),
                        );
                      }
                      
                      final orcamento = snapshot.data!;
                      return OrcamentoDetalhesPage(
                        orcamento: orcamento,
                        servicos: const [], // TODO: Buscar serviços do orçamento
                        produtos: const [], // TODO: Buscar produtos do orçamento
                      );
                    },
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/ordens-servico',
            name: 'ordens-servico',
            builder: (context, state) => const OrdensServicoPage(),
            routes: [
              GoRoute(
                path: 'nova',
                name: 'ordem-servico-nova',
                builder: (context, state) => const OrdemServicoFormPage(),
              ),
              GoRoute(
                path: 'editar/:id',
                name: 'ordem-servico-editar',
                builder: (context, state) {
                  final id = int.tryParse(state.pathParameters['id'] ?? '');
                  return OrdemServicoFormPage(ordemId: id);
                },
              ),
              GoRoute(
                path: 'detalhes/:id',
                name: 'ordem-servico-detalhes',
                builder: (context, state) {
                  // TODO: Implementar página de detalhes da ordem de serviço
                  final id = int.tryParse(state.pathParameters['id'] ?? '');
                  return const OrdensServicoPage(); // Temporário
                },
              ),
            ],
          ),
          GoRoute(
            path: '/vendas',
            name: 'vendas',
            builder: (context, state) => const VendasPage(),
          ),
          GoRoute(
            path: '/whatsapp-demo',
            name: 'whatsapp-demo',
            builder: (context, state) => const WhatsAppDemoPage(),
          ),
          GoRoute(
            path: '/pdv',
            name: 'pdv',
            builder: (context, state) => const PdvPage(),
            routes: [
              GoRoute(
                path: 'carrinho',
                name: 'pdv-carrinho',
                builder: (context, state) => const CarrinhoPage(),
              ),
              GoRoute(
                path: 'historico',
                name: 'pdv-historico',
                builder: (context, state) => const HistoricoPage(),
              ),
            ],
          ),
          GoRoute(
            path: '/configuracoes',
            name: 'configuracoes',
            builder: (context, state) => const EmpresaConfigPage(),
          ),
          GoRoute(
            path: '/admin',
            name: 'admin',
            builder: (context, state) => const AdminMiddleware(
              child: AdminPanelPage(),
            ),
          ),
        ],
      ),
    ],
  );
});