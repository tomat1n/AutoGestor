import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/cliente.dart';
import '../providers/clientes_provider.dart';

class ClienteFormPage extends ConsumerStatefulWidget {
  final Cliente? cliente;

  const ClienteFormPage({super.key, this.cliente});

  @override
  ConsumerState<ClienteFormPage> createState() => _ClienteFormPageState();
}

class _ClienteFormPageState extends ConsumerState<ClienteFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cpfCnpjController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _cepController = TextEditingController();
  final _observacoesController = TextEditingController();

  bool _ativo = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.cliente != null) {
      _preencherFormulario();
    }
  }

  void _preencherFormulario() {
    final cliente = widget.cliente!;
    _nomeController.text = cliente.nome;
    _emailController.text = cliente.email ?? '';
    _telefoneController.text = cliente.telefone ?? '';
    _cpfCnpjController.text = cliente.cpfCnpj ?? '';
    _enderecoController.text = cliente.endereco ?? '';
    _cidadeController.text = cliente.cidade ?? '';
    _estadoController.text = cliente.estado ?? '';
    _cepController.text = cliente.cep ?? '';
    _observacoesController.text = cliente.observacoes ?? '';
    _ativo = cliente.ativo;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _cpfCnpjController.dispose();
    _enderecoController.dispose();
    _cidadeController.dispose();
    _estadoController.dispose();
    _cepController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  String? _validarNome(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nome é obrigatório';
    }
    if (value.trim().length < 2) {
      return 'Nome deve ter pelo menos 2 caracteres';
    }
    return null;
  }

  String? _validarEmail(String? value) {
    if (value != null && value.isNotEmpty) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Email inválido';
      }
    }
    return null;
  }

  String? _validarTelefone(String? value) {
    if (value != null && value.isNotEmpty) {
      final telefoneRegex = RegExp(r'^\(?\d{2}\)?[\s-]?\d{4,5}[\s-]?\d{4}$');
      if (!telefoneRegex.hasMatch(value.replaceAll(RegExp(r'[^\d]'), ''))) {
        return 'Telefone inválido';
      }
    }
    return null;
  }

  String? _validarCpfCnpj(String? value) {
    if (value != null && value.isNotEmpty) {
      final numeros = value.replaceAll(RegExp(r'[^\d]'), '');
      if (numeros.length != 11 && numeros.length != 14) {
        return 'CPF deve ter 11 dígitos ou CNPJ deve ter 14 dígitos';
      }
    }
    return null;
  }

  String? _validarCep(String? value) {
    if (value != null && value.isNotEmpty) {
      final cepRegex = RegExp(r'^\d{5}-?\d{3}$');
      if (!cepRegex.hasMatch(value)) {
        return 'CEP inválido (formato: 12345-678)';
      }
    }
    return null;
  }

  Future<void> _salvarCliente() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final cliente = Cliente(
        id: widget.cliente?.id,
        nome: _nomeController.text.trim(),
        email: _emailController.text.trim(),
        telefone: _telefoneController.text.trim(),
        cpfCnpj: _cpfCnpjController.text.trim(),
        endereco: _enderecoController.text.trim(),
        cidade: _cidadeController.text.trim(),
        estado: _estadoController.text.trim(),
        cep: _cepController.text.trim(),
        observacoes: _observacoesController.text.trim(),
        ativo: _ativo,
        createdAt: widget.cliente?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (widget.cliente == null) {
        // Criar novo cliente
        await ref.read(clientesProvider.notifier).adicionarCliente(cliente);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cliente criado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // Atualizar cliente existente
        await ref.read(clientesProvider.notifier).atualizarCliente(cliente);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cliente atualizado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar cliente: $e'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cliente == null ? 'Novo Cliente' : 'Editar Cliente'),
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _salvarCliente,
              child: const Text('Salvar'),
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
              // Informações básicas
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informações Básicas',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nomeController,
                        decoration: const InputDecoration(
                          labelText: 'Nome *',
                          hintText: 'Digite o nome completo',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validarNome,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'exemplo@email.com',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validarEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _telefoneController,
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                          hintText: '(11) 99999-9999',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validarTelefone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _cpfCnpjController,
                        decoration: const InputDecoration(
                          labelText: 'CPF/CNPJ',
                          hintText: '000.000.000-00 ou 00.000.000/0000-00',
                          prefixIcon: Icon(Icons.badge),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validarCpfCnpj,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(14),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Endereço
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Endereço',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _enderecoController,
                        decoration: const InputDecoration(
                          labelText: 'Endereço',
                          hintText: 'Rua, número, complemento',
                          prefixIcon: Icon(Icons.home),
                          border: OutlineInputBorder(),
                        ),
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _cidadeController,
                              decoration: const InputDecoration(
                                labelText: 'Cidade',
                                prefixIcon: Icon(Icons.location_city),
                                border: OutlineInputBorder(),
                              ),
                              textCapitalization: TextCapitalization.words,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _estadoController,
                              decoration: const InputDecoration(
                                labelText: 'Estado',
                                hintText: 'SP',
                                prefixIcon: Icon(Icons.map),
                                border: OutlineInputBorder(),
                              ),
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]')),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _cepController,
                        decoration: const InputDecoration(
                          labelText: 'CEP',
                          hintText: '12345-678',
                          prefixIcon: Icon(Icons.local_post_office),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validarCep,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Observações e Status
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informações Adicionais',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _observacoesController,
                        decoration: const InputDecoration(
                          labelText: 'Observações',
                          hintText: 'Informações adicionais sobre o cliente',
                          prefixIcon: Icon(Icons.note),
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Cliente Ativo'),
                        subtitle: Text(
                          _ativo 
                            ? 'Cliente pode realizar compras' 
                            : 'Cliente desativado',
                        ),
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
              ),
              const SizedBox(height: 32),
              
              // Botões de ação
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _salvarCliente,
                      child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Salvar'),
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
}