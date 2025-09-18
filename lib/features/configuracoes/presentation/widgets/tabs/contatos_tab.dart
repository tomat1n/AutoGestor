import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/empresa_config_controller.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/database/database.dart';

class ContatosTab extends ConsumerStatefulWidget {
  final bool isEditMode;
  
  const ContatosTab({
    super.key,
    this.isEditMode = true,
  });

  @override
  ConsumerState<ContatosTab> createState() => _ContatosTabState();
}

class _ContatosTabState extends ConsumerState<ContatosTab> {
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _siteController = TextEditingController();

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
      _telefoneController.text = config.telefone ?? '';
      _celularController.text = config.celular ?? '';
      _emailController.text = config.email ?? '';
      _siteController.text = config.website ?? '';
    }
  }

  @override
  void dispose() {
    _telefoneController.dispose();
    _celularController.dispose();
    _emailController.dispose();
    _siteController.dispose();
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
              // Seção: Telefones
              _buildSectionCard(
                context,
                title: 'Telefones',
                icon: Icons.phone,
                children: [
                  CustomTextField(
                    controller: _telefoneController,
                    label: 'Telefone Fixo',
                    hint: '(11) 1234-5678',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    controller: _celularController,
                    label: 'Celular/WhatsApp',
                    hint: '(11) 91234-5678',
                    prefixIcon: Icons.smartphone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Seção: Internet
              _buildSectionCard(
                context,
                title: 'Internet',
                icon: Icons.language,
                children: [
                  CustomTextField(
                    controller: _emailController,
                    label: 'E-mail',
                    hint: 'contato@empresa.com.br',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return 'E-mail inválido';
                        }
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    controller: _siteController,
                    label: 'Website',
                    hint: 'https://www.empresa.com.br',
                    prefixIcon: Icons.web,
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final urlRegex = RegExp(
                          r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
                        );
                        if (!urlRegex.hasMatch(value)) {
                          return 'URL inválida (deve começar com http:// ou https://)';
                        }
                      }
                      return null;
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Informações sobre contatos
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Colors.green[600],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Informações de Contato',
                          style: TextStyle(
                            color: Colors.green[800],
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Estes dados aparecerão nos recibos e documentos gerados\n'
                      '• O celular pode ser usado para WhatsApp\n'
                      '• Todos os campos são opcionais, mas recomendados',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 13,
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
}