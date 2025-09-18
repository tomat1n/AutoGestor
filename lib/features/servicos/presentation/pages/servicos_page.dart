import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/servico.dart';
import '../providers/servicos_provider.dart';
import 'servico_form_page.dart';

class ServicosPage extends ConsumerStatefulWidget {
  const ServicosPage({super.key});

  @override
  ConsumerState<ServicosPage> createState() => _ServicosPageState();
}

class _ServicosPageState extends ConsumerState<ServicosPage> {
  String _filtroCategoria = 'Todos';
  String _textoPesquisa = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serviços'),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            tooltip: 'Criar Orçamento',
            onPressed: () => context.go('/servicos/orcamento'),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(servicosProvider),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFiltros(),
          Expanded(
            child: _buildListaServicos(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navegarParaFormulario(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFiltros() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Pesquisar serviços',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _textoPesquisa = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Categoria: '),
              Expanded(
                child: DropdownButton<String>(
                  value: _filtroCategoria,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                    DropdownMenuItem(value: 'Beleza', child: Text('Beleza')),
                    DropdownMenuItem(value: 'Saúde', child: Text('Saúde')),
                    DropdownMenuItem(value: 'Educação', child: Text('Educação')),
                    DropdownMenuItem(value: 'Tecnologia', child: Text('Tecnologia')),
                    DropdownMenuItem(value: 'Consultoria', child: Text('Consultoria')),
                    DropdownMenuItem(value: 'Outros', child: Text('Outros')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _filtroCategoria = value ?? 'Todos';
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListaServicos() {
    final servicosAsync = ref.watch(servicosProvider);

    return servicosAsync.when(
      data: (servicos) {
        final servicosFiltrados = _filtrarServicos(servicos);
        
        if (servicosFiltrados.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.room_service, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Nenhum serviço encontrado',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: servicosFiltrados.length,
          itemBuilder: (context, index) {
            final servico = servicosFiltrados[index];
            return _buildServicoCard(servico);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Erro: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.refresh(servicosProvider),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicoCard(Servico servico) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: servico.ativo ? Colors.green : Colors.grey,
          child: const Icon(Icons.room_service, color: Colors.white),
        ),
        title: Text(
          servico.nome,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: servico.ativo ? null : TextDecoration.lineThrough,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (servico.descricao != null && servico.descricao!.isNotEmpty)
              Text(servico.descricao!),
            Text(
              'R\$ ${servico.valor.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            if (servico.categoria != null)
              Text(
                servico.categoria!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            if (servico.duracaoMinutos != null)
              Text(
                'Duração: ${servico.duracaoMinutos} min',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _onMenuSelected(value, servico),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'editar',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Editar'),
              ),
            ),
            PopupMenuItem(
              value: 'ativar_desativar',
              child: ListTile(
                leading: Icon(servico.ativo ? Icons.visibility_off : Icons.visibility),
                title: Text(servico.ativo ? 'Desativar' : 'Ativar'),
              ),
            ),
            const PopupMenuItem(
              value: 'excluir',
              child: ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Excluir', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Servico> _filtrarServicos(List<Servico> servicos) {
    return servicos.where((servico) {
      final matchCategoria = _filtroCategoria == 'Todos' || 
          servico.categoria == _filtroCategoria;
      
      final matchPesquisa = _textoPesquisa.isEmpty ||
          servico.nome.toLowerCase().contains(_textoPesquisa.toLowerCase()) ||
          (servico.descricao?.toLowerCase().contains(_textoPesquisa.toLowerCase()) ?? false);
      
      return matchCategoria && matchPesquisa;
    }).toList();
  }

  void _onMenuSelected(String value, Servico servico) {
    switch (value) {
      case 'editar':
        _navegarParaFormulario(servico: servico);
        break;
      case 'ativar_desativar':
        _ativarDesativarServico(servico);
        break;
      case 'excluir':
        _confirmarExclusao(servico);
        break;
    }
  }

  void _navegarParaFormulario({Servico? servico}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ServicoFormPage(servico: servico),
      ),
    );
  }

  void _ativarDesativarServico(Servico servico) async {
    try {
      await ref.read(servicosProvider.notifier)
          .ativarDesativarServico(servico.id!, !servico.ativo);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              servico.ativo 
                  ? 'Serviço desativado com sucesso'
                  : 'Serviço ativado com sucesso',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao ${servico.ativo ? "desativar" : "ativar"} serviço: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _confirmarExclusao(Servico servico) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Deseja realmente excluir o serviço "${servico.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _excluirServico(servico);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _excluirServico(Servico servico) async {
    try {
      await ref.read(servicosProvider.notifier).excluirServico(servico.id!);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Serviço excluído com sucesso'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao excluir serviço: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}