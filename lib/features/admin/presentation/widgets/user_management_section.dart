import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/domain/entities/usuario_entity.dart';
import '../../../../core/database/enums/user_role.dart';

class UserManagementSection extends StatefulWidget {
  const UserManagementSection({Key? key}) : super(key: key);

  @override
  State<UserManagementSection> createState() => _UserManagementSectionState();
}

class _UserManagementSectionState extends State<UserManagementSection> {
  List<UsuarioEntity> _usuarios = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Por enquanto, vamos simular uma lista de usuários
      // Em uma implementação real, você buscaria do repositório
      await Future.delayed(const Duration(milliseconds: 500));
      
      _usuarios = [
        UsuarioEntity(
          id: 1,
          nome: 'Admin',
          email: 'admin@autogestor.com',
          empresa: 'AutoGestor',
          role: UserRole.admin,
          ativo: true,
          criadoEm: DateTime.now().subtract(const Duration(days: 30)),
          atualizadoEm: DateTime.now(),
        ),
        // Adicione mais usuários de exemplo aqui se necessário
      ];
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar usuários: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<UsuarioEntity> get _filteredUsers {
    if (_searchQuery.isEmpty) {
      return _usuarios;
    }
    return _usuarios.where((user) {
      return user.nome.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             user.email.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Column(
          children: [
            // Barra de pesquisa
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquisar usuários...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),

            // Lista de usuários
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _filteredUsers.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Nenhum usuário encontrado',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadUsers,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _filteredUsers.length,
                            itemBuilder: (context, index) {
                              final user = _filteredUsers[index];
                              return _buildUserCard(context, user, authProvider);
                            },
                          ),
                        ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserCard(BuildContext context, UsuarioEntity user, AuthProvider authProvider) {
    final isCurrentUser = authProvider.usuario?.id == user.id;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: user.role.isAdmin ? Colors.red : Colors.blue,
          child: Icon(
            user.role.isAdmin ? Icons.admin_panel_settings : Icons.person,
            color: Colors.white,
          ),
        ),
        title: Text(
          user.nome,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: user.ativo ? null : Colors.grey,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: user.role.isAdmin ? Colors.red : Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user.role.isAdmin ? 'Admin' : 'Usuário',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: user.ativo ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user.ativo ? 'Ativo' : 'Inativo',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: isCurrentUser
            ? const Chip(
                label: Text(
                  'Você',
                  style: TextStyle(fontSize: 12),
                ),
                backgroundColor: Colors.orange,
                labelStyle: TextStyle(color: Colors.white),
              )
            : PopupMenuButton<String>(
                onSelected: (value) => _handleUserAction(context, value, user, authProvider),
                itemBuilder: (context) => [
                  if (!user.role.isAdmin)
                    const PopupMenuItem(
                      value: 'promote',
                      child: ListTile(
                        leading: Icon(Icons.admin_panel_settings),
                        title: Text('Promover para Admin'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  if (user.role.isAdmin)
                    const PopupMenuItem(
                      value: 'demote',
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Remover Admin'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  const PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Editar'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  PopupMenuItem(
                    value: user.ativo ? 'deactivate' : 'activate',
                    child: ListTile(
                      leading: Icon(
                        user.ativo ? Icons.block : Icons.check_circle,
                      ),
                      title: Text(user.ativo ? 'Desativar' : 'Ativar'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
        isThreeLine: true,
      ),
    );
  }

  void _handleUserAction(BuildContext context, String action, UsuarioEntity user, AuthProvider authProvider) {
    switch (action) {
      case 'promote':
        _showConfirmDialog(
          context,
          'Promover Usuário',
          'Deseja promover ${user.nome} para administrador?',
          () async {
            final success = await authProvider.promoverParaAdmin(user);
            if (success && mounted) {
              _loadUsers();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Usuário promovido com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
        );
        break;
      case 'demote':
        _showConfirmDialog(
          context,
          'Remover Privilégios',
          'Deseja remover os privilégios de administrador de ${user.nome}?',
          () async {
            final success = await authProvider.removerPrivilegiosAdmin(user);
            if (success && mounted) {
              _loadUsers();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Privilégios removidos com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
        );
        break;
      case 'edit':
        _showEditUserDialog(context, user);
        break;
      case 'activate':
      case 'deactivate':
        _showConfirmDialog(
          context,
          action == 'activate' ? 'Ativar Usuário' : 'Desativar Usuário',
          'Deseja ${action == 'activate' ? 'ativar' : 'desativar'} o usuário ${user.nome}?',
          () {
            // Implementar ativação/desativação
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Usuário ${action == 'activate' ? 'ativado' : 'desativado'} com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
          },
        );
        break;
    }
  }

  void _showConfirmDialog(BuildContext context, String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _showEditUserDialog(BuildContext context, UsuarioEntity user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Usuário'),
        content: const Text('Funcionalidade de edição será implementada em breve.'),
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