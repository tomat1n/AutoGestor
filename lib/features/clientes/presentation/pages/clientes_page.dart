import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/cliente.dart';
import '../providers/clientes_provider.dart';
import 'cliente_form_page.dart';

class ClientesPage extends ConsumerStatefulWidget {
  const ClientesPage({super.key});

  @override
  ConsumerState<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends ConsumerState<ClientesPage> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _abrirFormularioCliente([Cliente? cliente]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClienteFormPage(cliente: cliente),
      ),
    );
  }

  void _buscarClientes(String termo) {
    if (termo.isEmpty) {
      ref.read(buscaClientesProvider.notifier).limparBusca();
    } else {
      ref.read(buscaClientesProvider.notifier).buscarPorNome(termo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Todos', icon: Icon(Icons.people)),
            Tab(text: 'Ativos', icon: Icon(Icons.person)),
            Tab(text: 'Buscar', icon: Icon(Icons.search)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodosClientes(),
          _buildClientesAtivos(),
          _buildBuscarClientes(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormularioCliente(),
        tooltip: 'Adicionar Cliente',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodosClientes() {
    final clientesAsync = ref.watch(clientesProvider);
    
    return clientesAsync.when(
      data: (clientes) {
        if (clientes.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_outline, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Nenhum cliente cadastrado',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Toque no botão + para adicionar o primeiro cliente',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        
        return RefreshIndicator(
          onRefresh: () => ref.read(clientesProvider.notifier).carregarClientes(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              final cliente = clientes[index];
              return _buildClienteCard(cliente);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Erro ao carregar clientes: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(clientesProvider.notifier).carregarClientes(),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientesAtivos() {
    final clientesAtivosAsync = ref.watch(clientesAtivosProvider);
    
    return clientesAtivosAsync.when(
      data: (clientes) {
        if (clientes.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_off_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Nenhum cliente ativo',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }
        
        return RefreshIndicator(
          onRefresh: () => ref.refresh(clientesAtivosProvider.future),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              final cliente = clientes[index];
              return _buildClienteCard(cliente);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Erro ao carregar clientes ativos: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.refresh(clientesAtivosProvider.future),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuscarClientes() {
    final buscaClientesAsync = ref.watch(buscaClientesProvider);
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Buscar cliente',
              hintText: 'Digite o nome ou email do cliente',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: _buscarClientes,
          ),
        ),
        Expanded(
          child: buscaClientesAsync.when(
            data: (clientes) {
              if (_searchController.text.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Digite algo para buscar clientes',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              
              if (clientes.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Nenhum cliente encontrado',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: clientes.length,
                itemBuilder: (context, index) {
                  final cliente = clientes[index];
                  return _buildClienteCard(cliente);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Erro na busca: $error'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClienteCard(Cliente cliente) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cliente.ativo ? Colors.green : Colors.grey,
          child: Text(
            cliente.nome.isNotEmpty ? cliente.nome[0].toUpperCase() : 'C',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          cliente.nome,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: cliente.ativo ? null : Colors.grey,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (cliente.email?.isNotEmpty == true)
              Text(
                cliente.email!,
                style: TextStyle(color: cliente.ativo ? null : Colors.grey),
              ),
            if (cliente.telefone?.isNotEmpty == true)
              Text(
                cliente.telefone!,
                style: TextStyle(color: cliente.ativo ? null : Colors.grey),
              ),
            if (cliente.cpfCnpj?.isNotEmpty == true)
              Text(
                'CPF/CNPJ: ${cliente.cpfCnpj!}',
                style: TextStyle(
                  fontSize: 12,
                  color: cliente.ativo ? Colors.grey[600] : Colors.grey,
                ),
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _onMenuSelected(value, cliente),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'editar',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Editar'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            PopupMenuItem(
              value: cliente.ativo ? 'desativar' : 'ativar',
              child: ListTile(
                leading: Icon(cliente.ativo ? Icons.visibility_off : Icons.visibility),
                title: Text(cliente.ativo ? 'Desativar' : 'Ativar'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'excluir',
              child: ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Excluir', style: TextStyle(color: Colors.red)),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
        onTap: () => _abrirFormularioCliente(cliente),
      ),
    );
  }

  void _onMenuSelected(String value, Cliente cliente) {
    switch (value) {
      case 'editar':
        _abrirFormularioCliente(cliente);
        break;
      case 'ativar':
      case 'desativar':
        _alternarStatusCliente(cliente);
        break;
      case 'excluir':
        _confirmarExclusao(cliente);
        break;
    }
  }

  void _alternarStatusCliente(Cliente cliente) {
    ref.read(clientesProvider.notifier).alternarStatusCliente(
      cliente.id!,
      !cliente.ativo,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          cliente.ativo 
            ? 'Cliente ${cliente.nome} foi desativado'
            : 'Cliente ${cliente.nome} foi ativado',
        ),
      ),
    );
  }

  void _confirmarExclusao(Cliente cliente) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Deseja realmente excluir o cliente "${cliente.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _excluirCliente(cliente);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _excluirCliente(Cliente cliente) {
    ref.read(clientesProvider.notifier).deletarCliente(cliente.id!);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cliente "${cliente.nome}" foi excluído'),
      ),
    );
  }
}