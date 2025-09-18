import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/empresa_config_controller.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class DadosBasicosTab extends ConsumerStatefulWidget {
  final bool isEditMode;
  
  const DadosBasicosTab({
    super.key,
    this.isEditMode = true,
  });

  @override
  ConsumerState<DadosBasicosTab> createState() => _DadosBasicosTabState();
}

class _DadosBasicosTabState extends ConsumerState<DadosBasicosTab> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _documentoController = TextEditingController();
  final TextEditingController _inscricaoEstadualController = TextEditingController();
  final TextEditingController _inscricaoMunicipalController = TextEditingController();
  String _tipoEmpresa = 'PF';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarDados();
    });
  }

  void _carregarDados() {
    final controller = ref.read(empresaConfigControllerProvider);
    controller.whenData((config) {
      if (config != null) {
        _nomeController.text = config.nomeEmpresa ?? '';
        _documentoController.text = config.documento ?? '';
        _inscricaoEstadualController.text = config.inscricaoEstadual ?? '';
        _inscricaoMunicipalController.text = config.inscricaoMunicipal ?? '';
        setState(() {
          _tipoEmpresa = config.tipoEmpresa ?? 'PF';
        });
      }
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _documentoController.dispose();
    _inscricaoEstadualController.dispose();
    _inscricaoMunicipalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(empresaConfigControllerProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seção: Tipo de Empresa
          _buildSectionCard(
            context,
            title: 'Tipo de Empresa',
            icon: Icons.business_center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Pessoa Física'),
                      subtitle: const Text('CPF'),
                      value: 'PF',
                      groupValue: _tipoEmpresa,
                      onChanged: (value) {
                        setState(() {
                          _tipoEmpresa = value!;
                        });
                        ref.read(empresaConfigControllerProvider.notifier)
                            .updateTipoEmpresa(value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Pessoa Jurídica'),
                      subtitle: const Text('CNPJ'),
                      value: 'PJ',
                      groupValue: _tipoEmpresa,
                      onChanged: (value) {
                        setState(() {
                          _tipoEmpresa = value!;
                        });
                        ref.read(empresaConfigControllerProvider.notifier)
                            .updateTipoEmpresa(value!);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Seção: Dados Básicos
          _buildSectionCard(
            context,
            title: 'Dados Básicos',
            icon: Icons.person,
            children: [
              CustomTextField(
                controller: _nomeController,
                label: _tipoEmpresa == 'PF' ? 'Nome Completo' : 'Razão Social',
                hint: _tipoEmpresa == 'PF'
                    ? 'Digite o nome completo'
                    : 'Digite a razão social da empresa',
                prefixIcon: Icons.person,
                isRequired: true,
                hasSavedData: _nomeController.text.isNotEmpty,
                enabled: widget.isEditMode,
                onChanged: (value) {
                  ref.read(empresaConfigControllerProvider.notifier)
                      .updateNomeEmpresa(value);
                  setState(() {}); // Atualiza o indicador visual
                },
              ),
              
              const SizedBox(height: 16),
              
              CustomTextField(
                controller: _documentoController,
                label: _tipoEmpresa == 'PF' ? 'CPF' : 'CNPJ',
                hint: _tipoEmpresa == 'PF'
                    ? 'Digite o CPF'
                    : 'Digite o CNPJ',
                prefixIcon: Icons.badge,
                isRequired: true,
                hasSavedData: _documentoController.text.isNotEmpty,
                enabled: widget.isEditMode,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _tipoEmpresa == 'PF'
                      ? CpfInputFormatter()
                      : CnpjInputFormatter(),
                ],
                onChanged: (value) {
                  ref.read(empresaConfigControllerProvider.notifier)
                      .updateDocumento(value);
                  setState(() {}); // Atualiza o indicador visual
                },
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Seção: Inscrições (apenas para PJ)
          if (_tipoEmpresa == 'PJ') ...[
            _buildSectionCard(
              context,
              title: 'Inscrições',
              icon: Icons.assignment,
              children: [
                CustomTextField(
                      controller: _inscricaoEstadualController,
                      label: 'Inscrição Estadual',
                      hint: 'Digite a inscrição estadual',
                      prefixIcon: Icons.location_city,
                      hasSavedData: _inscricaoEstadualController.text.isNotEmpty,
                      enabled: widget.isEditMode,
                      onChanged: (value) {
                        ref.read(empresaConfigControllerProvider.notifier)
                            .updateInscricaoEstadual(value);
                        setState(() {}); // Atualiza o indicador visual
                      },
                    ),
                
                const SizedBox(height: 16),
                
                CustomTextField(
                      controller: _inscricaoMunicipalController,
                      label: 'Inscrição Municipal',
                      hint: 'Digite a inscrição municipal',
                      prefixIcon: Icons.account_balance,
                      hasSavedData: _inscricaoMunicipalController.text.isNotEmpty,
                      enabled: widget.isEditMode,
                      onChanged: (value) {
                        ref.read(empresaConfigControllerProvider.notifier)
                            .updateInscricaoMunicipal(value);
                        setState(() {}); // Atualiza o indicador visual
                      },
                    ),
              ],
            ),
            const SizedBox(height: 20),
          ],
          
          // Informações importantes
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: Colors.blue[600],
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Os campos marcados com * são obrigatórios. '
                    'Essas informações aparecerão nos recibos e documentos gerados.',
                    style: TextStyle(
                      color: Colors.blue[700],
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
            color: Colors.black.withValues(alpha: 0.05),
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
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
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