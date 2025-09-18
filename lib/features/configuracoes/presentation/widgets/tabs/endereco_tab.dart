import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/empresa_config_controller.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/database/database.dart';

class EnderecoTab extends ConsumerStatefulWidget {
  final bool isEditMode;
  
  const EnderecoTab({
    super.key,
    this.isEditMode = true,
  });

  @override
  ConsumerState<EnderecoTab> createState() => _EnderecoTabState();
}

class _EnderecoTabState extends ConsumerState<EnderecoTab> {
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final config = ref.read(empresaConfigControllerProvider).value;
      _carregarDados(config);
    });
  }

  void _carregarDados(EmpresaConfigData? config) {
    if (config != null) {
      _cepController.text = config.cep ?? '';
      _logradouroController.text = config.endereco;
      _numeroController.text = config.numero ?? '';
      _complementoController.text = config.complemento ?? '';
      _bairroController.text = config.bairro ?? '';
      _cidadeController.text = config.cidade ?? '';
      _estadoController.text = config.estado ?? '';
    }
  }

  @override
  void dispose() {
    _cepController.dispose();
    _logradouroController.dispose();
    _numeroController.dispose();
    _complementoController.dispose();
    _bairroController.dispose();
    _cidadeController.dispose();
    _estadoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final configState = ref.watch(empresaConfigControllerProvider);
    
    return configState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Erro ao carregar configurações: $error'),
      ),
      data: (config) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seção: Endereço Principal
              _buildSectionCard(
                context,
                title: 'Endereço Principal',
                icon: Icons.home,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomTextField(
                          controller: _cepController,
                          label: 'CEP',
                          hint: '00000-000',
                          prefixIcon: Icons.location_on,
                          keyboardType: TextInputType.number,
                          isRequired: true,
                          hasSavedData: _cepController.text.isNotEmpty,
                          enabled: widget.isEditMode,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter(),
                          ],
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'CEP é obrigatório';
                            }
                            final digits = value.replaceAll(RegExp(r'\D'), '');
                            if (digits.length != 8) {
                              return 'CEP deve ter 8 dígitos';
                            }
                            return null;
                          },
                          onSubmitted: (value) => _buscarCep(context, value),
                          onChanged: (value) {
                            ref.read(empresaConfigControllerProvider.notifier)
                                .updateCep(value);
                            setState(() {}); // Atualiza o indicador visual
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => _buscarCep(
                          context, 
                          _cepController.text,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Buscar'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    controller: _logradouroController,
                    label: 'Logradouro',
                    hint: 'Rua, Avenida, Travessa, etc.',
                    prefixIcon: Icons.streetview,
                    textCapitalization: TextCapitalization.words,
                    isRequired: true,
                    hasSavedData: _logradouroController.text.isNotEmpty,
                    enabled: widget.isEditMode,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Logradouro é obrigatório';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      ref.read(empresaConfigControllerProvider.notifier)
                          .updateEndereco(value);
                      setState(() {}); // Atualiza o indicador visual
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          controller: _numeroController,
                          label: 'Número',
                          hint: '123',
                          prefixIcon: Icons.numbers,
                          isRequired: true,
                          hasSavedData: _numeroController.text.isNotEmpty,
                          enabled: widget.isEditMode,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Número é obrigatório';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            ref.read(empresaConfigControllerProvider.notifier)
                                .updateNumero(value);
                            setState(() {}); // Atualiza o indicador visual
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: CustomTextField(
                          controller: _complementoController,
                          label: 'Complemento',
                          hint: 'Apto, Sala, Bloco, etc.',
                          prefixIcon: Icons.add_location,
                          textCapitalization: TextCapitalization.words,
                          hasSavedData: _complementoController.text.isNotEmpty,
                          enabled: widget.isEditMode,
                          onChanged: (value) {
                            ref.read(empresaConfigControllerProvider.notifier)
                                .updateComplemento(value);
                            setState(() {}); // Atualiza o indicador visual
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    controller: _bairroController,
                    label: 'Bairro',
                    hint: 'Digite o bairro',
                    prefixIcon: Icons.location_city,
                    textCapitalization: TextCapitalization.words,
                    isRequired: true,
                    hasSavedData: _bairroController.text.isNotEmpty,
                    enabled: widget.isEditMode,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Bairro é obrigatório';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      ref.read(empresaConfigControllerProvider.notifier)
                          .updateBairro(value);
                      setState(() {}); // Atualiza o indicador visual
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomTextField(
                          controller: _cidadeController,
                          label: 'Cidade',
                          hint: 'Digite a cidade',
                          prefixIcon: Icons.location_city,
                          textCapitalization: TextCapitalization.words,
                          isRequired: true,
                          hasSavedData: _cidadeController.text.isNotEmpty,
                          enabled: widget.isEditMode,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Cidade é obrigatória';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            ref.read(empresaConfigControllerProvider.notifier)
                                .updateCidade(value);
                            setState(() {}); // Atualiza o indicador visual
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          controller: _estadoController,
                          label: 'UF',
                          hint: 'SP',
                          prefixIcon: Icons.map,
                          textCapitalization: TextCapitalization.characters,
                          maxLength: 2,
                          isRequired: true,
                          hasSavedData: _estadoController.text.isNotEmpty,
                          enabled: widget.isEditMode,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'UF é obrigatória';
                            }
                            if (value.length != 2) {
                              return 'UF deve ter 2 letras';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            ref.read(empresaConfigControllerProvider.notifier)
                                .updateEstado(value);
                            setState(() {}); // Atualiza o indicador visual
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Informações sobre CEP
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber[200]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Colors.amber[700],
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Dica: Digite o CEP e clique em "Buscar" para preencher automaticamente '
                        'o endereço. Você pode editar os campos após o preenchimento.',
                        style: TextStyle(
                          color: Colors.amber[800],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
  
  Future<void> _buscarCep(
    BuildContext context,
    String cep,
  ) async {
    final cepDigits = cep.replaceAll(RegExp(r'\D'), '');
    
    if (cepDigits.length != 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CEP deve ter 8 dígitos'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    // Aqui você pode implementar a busca do CEP usando uma API como ViaCEP
    // Por enquanto, vamos mostrar uma mensagem informativa
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.info, color: Colors.white),
            SizedBox(width: 8),
            Text('Funcionalidade de busca de CEP será implementada em breve'),
          ],
        ),
        backgroundColor: Colors.blue[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    
    // Exemplo de como seria o preenchimento automático:
    // _logradouroController.text = 'Rua Exemplo';
    // _bairroController.text = 'Centro';
    // _cidadeController.text = 'São Paulo';
    // _estadoController.text = 'SP';
  }
}