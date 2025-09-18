import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/empresa_config_controller.dart';


class FiscalTab extends ConsumerWidget {
  final bool isEditMode;
  
  const FiscalTab({
    super.key,
    this.isEditMode = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              // Seção: Certificado Digital
              _buildSectionCard(
                context,
                title: 'Certificado Digital',
                icon: Icons.verified_user,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildSwitchTile(
                          context,
                          title: 'Possui Certificado Digital',
                          subtitle: 'Necessário para emissão de NFe/NFCe',
                          value: false, // Propriedade não existe na entidade
                          onChanged: (value) {}, // Funcionalidade não implementada
                        ),
                      ),
                    ],
                  ),
                  
                  if (false) ...[  // Propriedade não existe na entidade
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: '', // Propriedade não existe na entidade
                      decoration: const InputDecoration(
                        labelText: 'Validade do Certificado',
                        hintText: 'dd/mm/aaaa',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8),
                        _DateInputFormatter(),
                      ],
                      onChanged: (value) {}, // Funcionalidade não implementada
                      validator: (value) {
                        if (false && (value == null || value.isEmpty)) { // Propriedade não existe
                          return 'Informe a validade do certificado';
                        }
                        return null;
                      },
                    ),
                  ],
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Seção: Configurações de NFe
              _buildSectionCard(
                context,
                title: 'Configurações de NFe',
                icon: Icons.receipt_long,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: 'homologacao', // Propriedade não existe na entidade
                    decoration: InputDecoration(
                      labelText: 'Ambiente NFe',
                      prefixIcon: const Icon(Icons.cloud),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    items: const [
                      DropdownMenuItem(value: 'homologacao', child: Text('Homologação (Teste)')),
                      DropdownMenuItem(value: 'producao', child: Text('Produção')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        // Funcionalidade não implementada
                      }
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: '1', // Propriedade não existe na entidade
                          decoration: const InputDecoration(
                            labelText: 'Série NFe',
                            hintText: '1',
                            prefixIcon: Icon(Icons.format_list_numbered),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          onChanged: (value) {}, // Funcionalidade não implementada
                          validator: (value) {
                            if (false && (value == null || value.isEmpty)) { // Propriedade não existe
                              return 'Informe a série da NFe';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: '1', // Propriedade não existe na entidade
                          decoration: const InputDecoration(
                            labelText: 'Próximo Número NFe',
                            hintText: '1',
                            prefixIcon: Icon(Icons.tag),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(9),
                          ],
                          onChanged: (value) {
                            // Funcionalidade não implementada
                          },

                          validator: (value) {
                            if (false && (value == null || value.isEmpty)) { // Propriedade não existe
                              return 'Informe o próximo número';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Seção: Configurações de NFCe
              _buildSectionCard(
                context,
                title: 'Configurações de NFCe',
                icon: Icons.receipt,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: '1', // Propriedade não existe na entidade
                          decoration: const InputDecoration(
                            labelText: 'Série NFCe',
                            hintText: '1',
                            prefixIcon: Icon(Icons.format_list_numbered),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          onChanged: (value) {}, // Funcionalidade não implementada
                          validator: (value) {
                            if (false && (value == null || value.isEmpty)) { // Propriedade não existe
                              return 'Informe a série da NFCe';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: '1', // Propriedade não existe na entidade
                          decoration: const InputDecoration(
                            labelText: 'Próximo Número NFCe',
                            hintText: '1',
                            prefixIcon: Icon(Icons.tag),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(9),
                          ],
                          onChanged: (value) {
                            // Funcionalidade não implementada
                          },
                          validator: (value) {
                            if (false && (value == null || value.isEmpty)) { // Propriedade não existe
                              return 'Informe o próximo número';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    initialValue: '', // Propriedade não existe na entidade
                    decoration: const InputDecoration(
                      labelText: 'Token CSC (NFCe)',
                      hintText: 'Token fornecido pela SEFAZ',
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                    obscureText: true,
                    onChanged: (value) {}, // Funcionalidade não implementada
                    validator: (value) {
                      if (false && (value == null || value.isEmpty)) { // Propriedade não existe
                        return 'Informe o token CSC';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Seção: Outras Configurações
              _buildSectionCard(
                context,
                title: 'Outras Configurações',
                icon: Icons.settings,
                children: [
                  TextFormField(
                    initialValue: '', // Propriedade não existe na entidade
                    decoration: const InputDecoration(
                      labelText: 'Observações Fiscais Padrão',
                      hintText: 'Observações que aparecerão nas notas fiscais',
                      prefixIcon: Icon(Icons.note),
                    ),
                    maxLines: 3,
                    maxLength: 500,
                    onChanged: (value) {}, // Funcionalidade não implementada
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildSwitchTile(
                          context,
                          title: 'Enviar NFe por E-mail',
                          subtitle: 'Envia automaticamente por e-mail',
                          value: false, // Propriedade não existe na entidade
                          onChanged: (value) {}, // Funcionalidade não implementada
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSwitchTile(
                          context,
                          title: 'Imprimir DANFE',
                          subtitle: 'Imprime automaticamente',
                          value: false, // Propriedade não existe na entidade
                          onChanged: (value) {}, // Funcionalidade não implementada
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Informações sobre configurações fiscais
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.red[600],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Importante - Configurações Fiscais',
                          style: TextStyle(
                            color: Colors.red[800],
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Sempre teste em ambiente de homologação primeiro\n'
                      '• Mantenha o certificado digital sempre atualizado\n'
                      '• Consulte seu contador para configurações específicas\n'
                      '• Backup regular das configurações é recomendado',
                      style: TextStyle(
                        color: Colors.red[700],
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
  
  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeThumbColor: Theme.of(context).primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// Formatador para data
class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    
    if (text.length <= 2) {
      return newValue;
    } else if (text.length <= 4) {
      return TextEditingValue(
        text: '${text.substring(0, 2)}/${text.substring(2)}',
        selection: TextSelection.collapsed(offset: text.length + 1),
      );
    } else {
      return TextEditingValue(
        text: '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4)}',
        selection: TextSelection.collapsed(offset: text.length + 2),
      );
    }
  }
}