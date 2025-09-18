import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    
    return Scaffold(
      appBar: _buildAppBar(context),
      body: isDesktop ? _buildDesktopLayout(context) : _buildMobileLayout(context),
      bottomNavigationBar: isDesktop ? null : _buildBottomNavigation(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('AutoGestor'),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      actions: [
        Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Nome do usuário
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: Text(
                      'Olá, ${authProvider.usuario?.nome ?? "Usuário"}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Botão de logout
                PopupMenuButton<String>(
                  icon: const Icon(Icons.account_circle, color: Colors.white),
                  onSelected: (value) {
                    if (value == 'logout') {
                      _showLogoutDialog(context, authProvider);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Sair do Sistema'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Saída'),
          content: const Text('Tem certeza que deseja sair do sistema?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await authProvider.logout();
                if (context.mounted) {
                  context.go('/login');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Row(
          children: [
            NavigationRail(
              selectedIndex: _getSelectedIndex(context),
              onDestinationSelected: (index) => _onDestinationSelected(context, index),
              labelType: NavigationRailLabelType.all,
              destinations: _getNavigationDestinations(authProvider.isAdmin),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: child),
          ],
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return child;
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final items = [
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Estoque',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Clientes',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.room_service),
            label: 'Serviços',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Orçamentos',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Ordens',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.point_of_sale),
            label: 'PDV',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Vendas',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Config',
          ),
        ];
        
        if (authProvider.isAdmin) {
          items.add(
            const BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings),
              label: 'Admin',
            ),
          );
        }
        
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _getSelectedIndex(context),
          onTap: (index) => _onDestinationSelected(context, index, authProvider.isAdmin),
          items: items,
        );
      },
    );
  }

  List<NavigationRailDestination> _getNavigationDestinations(bool isAdmin) {
    final destinations = [
      const NavigationRailDestination(
        icon: Icon(Icons.dashboard),
        label: Text('Dashboard'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.inventory),
        label: Text('Estoque'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.people),
        label: Text('Clientes'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.room_service),
        label: Text('Serviços'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.description),
        label: Text('Orçamentos'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.build),
        label: Text('Ordens de Serviço'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.point_of_sale),
        label: Text('PDV'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.receipt_long),
        label: Text('Vendas'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.settings),
        label: Text('Config'),
      ),
    ];
    
    if (isAdmin) {
      destinations.add(
        const NavigationRailDestination(
          icon: Icon(Icons.admin_panel_settings),
          label: Text('Admin'),
        ),
      );
    }
    
    return destinations;
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/estoque')) return 1;
    if (location.startsWith('/clientes')) return 2;
    if (location.startsWith('/servicos')) return 3;
    if (location.startsWith('/orcamentos')) return 4;
    if (location.startsWith('/ordens-servico')) return 5;
    if (location.startsWith('/pdv')) return 6;
    if (location.startsWith('/vendas')) return 7;
    if (location.startsWith('/configuracoes')) return 8;
    if (location.startsWith('/admin')) return 9;
    return 0;
  }

  void _onDestinationSelected(BuildContext context, int index, [bool isAdmin = false]) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/estoque');
        break;
      case 2:
        context.go('/clientes');
        break;
      case 3:
        context.go('/servicos');
        break;
      case 4:
        context.go('/orcamentos');
        break;
      case 5:
        context.go('/ordens-servico');
        break;
      case 6:
        context.go('/pdv');
        break;
      case 7:
        context.go('/vendas');
        break;
      case 8:
        context.go('/configuracoes');
        break;
      case 9:
        if (isAdmin) {
          context.go('/admin');
        }
        break;
    }
  }
}