import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/empresa_config_controller.dart';


class ImpressaoTab extends ConsumerWidget {
  final bool isEditMode;
  
  const ImpressaoTab({
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
              // Seção: Configurações Gerais
              _buildSectionCard(
                context,
                title: 'Configurações Gerais',
                icon: Icons.settings,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildSwitchTile(
                          context,
                          title: 'Mostrar Logo nos Recibos',
                          subtitle: 'Exibe o logo da empresa nos documentos',
                          value: false, // Propriedade não existe na entidade
                          onChanged: (value) {}, // Funcionalidade não implementada
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildSwitchTile(
                          context,
                          title: 'Imprimir Observações',
                          subtitle: 'Inclui campo de observações nos recibos',
                          value: false, // Propriedade não existe na entidade
                          onChanged: (value) {}, // Funcionalidade não implementada
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Seção: Impressão Térmica
              _buildSectionCard(
                context,
                title: 'Impressão Térmica',
                icon: Icons.receipt,
                children: [
                  DropdownButtonFormField<int>(
                    initialValue: null, // Propriedade não existe na entidade
                    decoration: InputDecoration(
                      labelText: 'Largura do Papel',
                      prefixIcon: const Icon(Icons.straighten),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    items: const [
                      DropdownMenuItem(value: null, child: Text('Selecione a largura')),
                      DropdownMenuItem(value: 58, child: Text('58mm')),
                      DropdownMenuItem(value: 80, child: Text('80mm')),
                    ],
                    onChanged: (value) {
                      // Funcionalidade não implementada
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  TextFormField(
                     initialValue: '10', // Valor padrão
                    onChanged: (value) {
                      // Funcionalidade não implementada
                    },
                    decoration: InputDecoration(
                      labelText: 'Margem (pixels)',
                      hintText: '10',
                      prefixIcon: const Icon(Icons.border_outer),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final margin = int.tryParse(value);
                        if (margin == null || margin < 0 || margin > 50) {
                          return 'Margem deve ser entre 0 e 50 pixels';
                        }
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  DropdownButtonFormField<String>(
                     initialValue: 'pequena', // Valor padrão
                    decoration: InputDecoration(
                      labelText: 'Tamanho da Fonte',
                      prefixIcon: const Icon(Icons.text_fields),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    items: const [
                      DropdownMenuItem(value: 'pequena', child: Text('Pequena')),
                      DropdownMenuItem(value: 'media', child: Text('Média')),
                      DropdownMenuItem(value: 'grande', child: Text('Grande')),
                    ],
                    onChanged: (value) {
                      // Funcionalidade não implementada
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Seção: Impressão A4
              _buildSectionCard(
                context,
                title: 'Impressão A4',
                icon: Icons.description,
                children: [
                  DropdownButtonFormField<String>(
                     initialValue: 'retrato', // Valor padrão
                    decoration: InputDecoration(
                      labelText: 'Orientação',
                      prefixIcon: const Icon(Icons.rotate_90_degrees_ccw),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    items: const [
                      DropdownMenuItem(value: 'retrato', child: Text('Retrato')),
                      DropdownMenuItem(value: 'paisagem', child: Text('Paisagem')),
                    ],
                    onChanged: (value) {
                      // Funcionalidade não implementada
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  TextFormField(
                     initialValue: '20', // Valor padrão
                    onChanged: (value) {
                      // Funcionalidade não implementada
                    },
                    decoration: InputDecoration(
                      labelText: 'Margem (mm)',
                      hintText: '20',
                      prefixIcon: const Icon(Icons.border_all),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final margin = double.tryParse(value);
                        if (margin == null || margin < 0 || margin > 50) {
                          return 'Margem deve ser entre 0 e 50 mm';
                        }
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  DropdownButtonFormField<String>(
                     initialValue: 'media', // Valor padrão
                    decoration: InputDecoration(
                      labelText: 'Tamanho da Fonte',
                      prefixIcon: const Icon(Icons.format_size),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    items: const [
                      DropdownMenuItem(value: 'pequena', child: Text('Pequena (10pt)')),
                      DropdownMenuItem(value: 'media', child: Text('Média (12pt)')),
                      DropdownMenuItem(value: 'grande', child: Text('Grande (14pt)')),
                    ],
                    onChanged: (value) {
                      // Funcionalidade não implementada
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Informações sobre impressão
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.print,
                          color: Colors.blue[600],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Configurações de Impressão',
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Impressão térmica: ideal para recibos rápidos\n'
                      '• Impressão A4: ideal para documentos formais\n'
                      '• As configurações afetam todos os recibos gerados',
                      style: TextStyle(
                        color: Colors.blue[700],
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}