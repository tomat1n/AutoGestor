import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../servicos/domain/entities/servico.dart';
import '../../../servicos/domain/repositories/servicos_repository.dart';
import '../../../../core/widgets/loading_widget.dart';

class SelecionarServicosPage extends StatefulWidget {
  final List<Servico> servicosJaSelecionados;

  const SelecionarServicosPage({
    super.key,
    required this.servicosJaSelecionados,
  });

  @override
  State<SelecionarServicosPage> createState() => _SelecionarServicosPageState();
}

class _SelecionarServicosPageState extends State<SelecionarServicosPage> {
  final _servicosRepository = GetIt.instance<ServicosRepository>();
  List<Servico> _servicos = [];
  List<Servico> _servicosSelecionados = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _servicosSelecionados = List.from(widget.servicosJaSelecionados);
    _carregarServicos();
  }

  Future<void> _carregarServicos() async {
    try {
      final servicos = await _servicosRepository.buscarTodos();
      setState(() {
        _servicos = servicos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar serviços: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  List<Servico> get _servicosFiltrados {
    if (_searchQuery.isEmpty) {
      return _servicos;
    }
    return _servicos.where((servico) {
      return servico.nome.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (servico.descricao?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
    }).toList();
  }

  bool _isServicoSelecionado(Servico servico) {
    return _servicosSelecionados.any((s) => s.id == servico.id);
  }

  void _toggleServico(Servico servico) {
    setState(() {
      if (_isServicoSelecionado(servico)) {
        _servicosSelecionados.removeWhere((s) => s.id == servico.id);
      } else {
        _servicosSelecionados.add(servico);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Serviços'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(_servicosSelecionados);
            },
            child: Text(
              'Confirmar (${_servicosSelecionados.length})',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Buscar serviços',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: _servicosFiltrados.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum serviço encontrado',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _servicosFiltrados.length,
                          itemBuilder: (context, index) {
                            final servico = _servicosFiltrados[index];
                            final isSelected = _isServicoSelecionado(servico);
                            
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: CheckboxListTile(
                                title: Text(servico.nome),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (servico.descricao != null)
                                      Text(servico.descricao!),
                                    const SizedBox(height: 4),
                                    Text(
                                      'R\$ ${servico.valor.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                value: isSelected,
                                onChanged: (bool? value) {
                                  _toggleServico(servico);
                                },
                                activeColor: Theme.of(context).primaryColor,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}