import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/domain/entities/usuario_entity.dart';
import '../../../../core/database/enums/user_role.dart';
import '../widgets/admin_dashboard_card.dart';
import '../widgets/user_management_section.dart';
import '../widgets/system_stats_section.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({Key? key}) : super(key: key);

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Verificar se o usuário tem permissões de admin
        if (!authProvider.temPermissaoAdmin()) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Acesso Negado'),
              backgroundColor: Colors.red,
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.security,
                    size: 80,
                    color: Colors.red,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Acesso Restrito',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Apenas administradores podem acessar este painel.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Painel de Administração'),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: const [
                Tab(
                  icon: Icon(Icons.dashboard),
                  text: 'Dashboard',
                ),
                Tab(
                  icon: Icon(Icons.people),
                  text: 'Usuários',
                ),
                Tab(
                  icon: Icon(Icons.settings),
                  text: 'Sistema',
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildDashboardTab(context, authProvider),
              _buildUsersTab(context, authProvider),
              _buildSystemTab(context, authProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDashboardTab(BuildContext context, AuthProvider authProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Boas-vindas
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.admin_panel_settings,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bem-vindo, ${authProvider.usuario?.nome ?? "Administrador"}!',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Painel de Administração do AutoGestor',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Cards de estatísticas
          const Text(
            'Visão Geral do Sistema',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const SystemStatsSection(),
          const SizedBox(height: 24),

          // Ações rápidas
          const Text(
            'Ações Rápidas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              AdminDashboardCard(
                title: 'Criar Usuário',
                icon: Icons.person_add,
                color: Colors.green,
                onTap: () => _showCreateUserDialog(context, authProvider),
              ),
              AdminDashboardCard(
                title: 'Gerenciar Usuários',
                icon: Icons.people_outline,
                color: Colors.blue,
                onTap: () => _tabController.animateTo(1),
              ),
              AdminDashboardCard(
                title: 'Configurações',
                icon: Icons.settings,
                color: Colors.orange,
                onTap: () => _tabController.animateTo(2),
              ),
              AdminDashboardCard(
                title: 'Relatórios',
                icon: Icons.analytics,
                color: Colors.purple,
                onTap: () => _showComingSoonDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUsersTab(BuildContext context, AuthProvider authProvider) {
    return const UserManagementSection();
  }

  Widget _buildSystemTab(BuildContext context, AuthProvider authProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Configurações do Sistema',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.backup),
                  title: const Text('Backup do Sistema'),
                  subtitle: const Text('Criar backup dos dados'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showComingSoonDialog(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.restore),
                  title: const Text('Restaurar Sistema'),
                  subtitle: const Text('Restaurar dados de backup'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showComingSoonDialog(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.update),
                  title: const Text('Atualizações'),
                  subtitle: const Text('Verificar atualizações disponíveis'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showComingSoonDialog(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Informações do Sistema'),
                  subtitle: const Text('Versão, logs e diagnósticos'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showSystemInfoDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateUserDialog(BuildContext context, AuthProvider authProvider) {
    final formKey = GlobalKey<FormState>();
    final nomeController = TextEditingController();
    final emailController = TextEditingController();
    final senhaController = TextEditingController();
    UserRole selectedRole = UserRole.user;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Criar Novo Usuário'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email é obrigatório';
                  }
                  if (!value.contains('@')) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: senhaController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Senha é obrigatória';
                  }
                  if (value.length < 6) {
                    return 'Senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<UserRole>(
                value: selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Usuário',
                  border: OutlineInputBorder(),
                ),
                items: UserRole.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.value == 'admin' ? 'Administrador' : 'Usuário'),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedRole = value;
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final usuario = UsuarioEntity(
                  nome: nomeController.text,
                  email: emailController.text,
                  empresa: 'AutoGestor',
                  role: selectedRole,
                  ativo: true,
                  criadoEm: DateTime.now(),
                  atualizadoEm: DateTime.now(),
                );

                final success = await authProvider.criarNovoUsuario(
                  usuario,
                  senhaController.text,
                );

                if (success && context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Usuário criado com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              }
            },
            child: const Text('Criar'),
          ),
        ],
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Em Breve'),
        content: const Text('Esta funcionalidade estará disponível em breve.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSystemInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Informações do Sistema'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AutoGestor v1.0.0'),
            SizedBox(height: 8),
            Text('Sistema de Gestão Empresarial'),
            SizedBox(height: 8),
            Text('Desenvolvido com Flutter'),
          ],
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