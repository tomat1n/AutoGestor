import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/servico.dart';
import '../providers/servicos_provider.dart';

class ServicoFormPage extends ConsumerStatefulWidget {
  final Servico? servico;

  const ServicoFormPage({super.key, this.servico});

  @override
  ConsumerState<ServicoFormPage> createState() => _ServicoFormPageState();
}

class _ServicoFormPageState extends ConsumerState<ServicoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _duracaoController = TextEditingController();
  
  String _categoriaSelecionada = 'Outros';
  bool _ativo = true;
  bool _salvando = false;

  bool get _isEdicao => widget.servico != null;

  @override
  void initState() {
    super.initState();
    _preencherFormulario();
  }

  void _preencherFormulario() {
    if (widget.servico != null) {
      final servico = widget.servico!;
      _nomeController.text = servico.nome;
      _descricaoController.text = servico.descricao ?? '';
      _valorController.text = servico.valor.toStringAsFixed(2);
      _duracaoController.text = servico.duracaoMinutos?.toString() ?? '';
      _categoriaSelecionada = servico.categoria ?? 'Outros';
      _ativo = servico.ativo;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _valorController.dispose();
    _duracaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdicao ? 'Editar Serviço' : 'Novo Serviço'),
        actions: [
          if (_isEdicao)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _confirmarExclusao,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCampoNome(),
              const SizedBox(height: 16),
              _buildCampoDescricao(),
              const SizedBox(height: 16),
              _buildCampoValor(),
              const SizedBox(height: 16),
              _buildCampoCategoria(),
              const SizedBox(height: 16),
              _buildCampoDuracao(),
              const SizedBox(height: 16),
              _buildSwitchAtivo(),
              const SizedBox(height: 32),
              _buildBotaoSalvar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampoNome() {
    return TextFormField(
      controller: _nomeController,
      decoration: const InputDecoration(
        labelText: 'Nome do Serviço *',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.room_service),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Nome é obrigatório';
        }
        if (value.trim().length < 2) {
          return 'Nome deve ter pelo menos 2 caracteres';
        }
        return null;
      },
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildCampoDescricao() {
    return TextFormField(
      controller: _descricaoController,
      decoration: const InputDecoration(
        labelText: 'Descrição',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.description),
      ),
      maxLines: 3,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget _buildCampoValor() {
    return TextFormField(
      controller: _valorController,
      decoration: const InputDecoration(
        labelText: 'Valor (R\$) *',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.attach_money),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Valor é obrigatório';
        }
        final valor = double.tryParse(value.replaceAll(',', '.'));
        if (valor == null || valor <= 0) {
          return 'Valor deve ser maior que zero';
        }
        return null;
      },
    );
  }

  Widget _buildCampoCategoria() {
    return DropdownButtonFormField<String>(
      value: _categoriaSelecionada,
      decoration: const InputDecoration(
        labelText: 'Categoria',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.category),
      ),
      items: const [
        DropdownMenuItem(value: 'Beleza', child: Text('Beleza')),
        DropdownMenuItem(value: 'Saúde', child: Text('Saúde')),
        DropdownMenuItem(value: 'Educação', child: Text('Educação')),
        DropdownMenuItem(value: 'Tecnologia', child: Text('Tecnologia')),
        DropdownMenuItem(value: 'Consultoria', child: Text('Consultoria')),
        DropdownMenuItem(value: 'Outros', child: Text('Outros')),
      ],
      onChanged: (value) {
        setState(() {
          _categoriaSelecionada = value ?? 'Outros';
        });
      },
    );
  }

  Widget _buildCampoDuracao() {
    return TextFormField(
      controller: _duracaoController,
      decoration: const InputDecoration(
        labelText: 'Duração (minutos)',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.timer),
        helperText: 'Tempo estimado para execução do serviço',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          final duracao = int.tryParse(value);
          if (duracao == null || duracao <= 0) {
            return 'Duração deve ser um número positivo';
          }
        }
        return null;
      },
    );
  }

  Widget _buildSwitchAtivo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.visibility),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status do Serviço',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _ativo ? 'Ativo - Disponível para venda' : 'Inativo - Não disponível',
                    style: TextStyle(
                      color: _ativo ? Colors.green : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _ativo,
              onChanged: (value) {
                setState(() {
                  _ativo = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBotaoSalvar() {
    return ElevatedButton(
      onPressed: _salvando ? null : _salvarServico,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: _salvando
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 8),
                Text('Salvando...'),
              ],
            )
          : Text(
              _isEdicao ? 'Atualizar Serviço' : 'Criar Serviço',
              style: const TextStyle(fontSize: 16),
            ),
    );
  }

  void _salvarServico() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _salvando = true;
    });

    try {
      final valor = double.parse(_valorController.text.replaceAll(',', '.'));
      final duracao = _duracaoController.text.isNotEmpty 
          ? int.parse(_duracaoController.text) 
          : null;

      final servico = Servico(
        id: widget.servico?.id,
        nome: _nomeController.text.trim(),
        descricao: _descricaoController.text.trim().isEmpty 
            ? null 
            : _descricaoController.text.trim(),
        valor: valor,
        categoria: _categoriaSelecionada,
        duracaoMinutos: duracao,
        ativo: _ativo,
        createdAt: widget.servico?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (_isEdicao) {
        await ref.read(servicosProvider.notifier).atualizarServico(servico);
      } else {
        await ref.read(servicosProvider.notifier).adicionarServico(servico);
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEdicao 
                  ? 'Serviço atualizado com sucesso'
                  : 'Serviço criado com sucesso',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar serviço: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _salvando = false;
        });
      }
    }
  }

  void _confirmarExclusao() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Deseja realmente excluir o serviço "${widget.servico!.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _excluirServico();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _excluirServico() async {
    setState(() {
      _salvando = true;
    });

    try {
      await ref.read(servicosProvider.notifier).excluirServico(widget.servico!.id!);
      
      if (mounted) {
        Navigator.of(context).pop();
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
    } finally {
      if (mounted) {
        setState(() {
          _salvando = false;
        });
      }
    }
  }
}