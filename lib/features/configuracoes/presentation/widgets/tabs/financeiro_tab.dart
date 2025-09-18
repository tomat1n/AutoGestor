import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/empresa_config_controller.dart';
import '../../../domain/entities/empresa_config.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/database/database.dart';

class FinanceiroTab extends ConsumerWidget {
  final bool isEditMode;
  
  const FinanceiroTab({
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
              // Seção: Dados Bancários
              _buildSectionCard(
                context,
                title: 'Dados Bancários',
                icon: Icons.account_balance,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          initialValue: config?.banco ?? '',
                          onChanged: (value) => ref.read(empresaConfigControllerProvider.notifier).updateBanco(value ?? ''),
                          decoration: InputDecoration(
                            labelText: 'Banco',
                            hintText: 'Ex: Banco do Brasil',
                            prefixIcon: const Icon(Icons.business),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: config?.agencia ?? '',
                          onChanged: (value) => ref.read(empresaConfigControllerProvider.notifier).updateAgencia(value ?? ''),
                          decoration: InputDecoration(
                            labelText: 'Agência',
                            hintText: '1234-5',
                            prefixIcon: const Icon(Icons.location_city),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: config?.conta ?? '',
                          onChanged: (value) => ref.read(empresaConfigControllerProvider.notifier).updateConta(value ?? ''),
                          decoration: InputDecoration(
                            labelText: 'Conta',
                            hintText: '12345-6',
                            prefixIcon: const Icon(Icons.credit_card),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: null, // Propriedade não existe na entidade
                          decoration: InputDecoration(
                            labelText: 'Tipo de Conta',
                            prefixIcon: const Icon(Icons.account_balance_wallet),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          items: const [
                            DropdownMenuItem(value: null, child: Text('Selecione o tipo')),
                            DropdownMenuItem(value: 'corrente', child: Text('Corrente')),
                            DropdownMenuItem(value: 'poupanca', child: Text('Poupança')),
                            DropdownMenuItem(value: 'salario', child: Text('Salário')),
                          ],
                          onChanged: (value) {
                            // Propriedade não implementada
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    initialValue: config?.pix ?? '',
                    onChanged: (value) => ref.read(empresaConfigControllerProvider.notifier).updatePix(value ?? ''),
                    decoration: InputDecoration(
                      labelText: 'Chave PIX',
                      hintText: 'CPF, CNPJ, e-mail, telefone ou chave aleatória',
                      prefixIcon: const Icon(Icons.qr_code),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Seção: Configurações de Pagamento
              _buildSectionCard(
                context,
                title: 'Configurações de Pagamento',
                icon: Icons.payment,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildSwitchTile(
                          context,
                          title: 'Aceita Dinheiro',
                          subtitle: 'Pagamento em espécie',
                          value: false, // Propriedade não existe na entidade
                          onChanged: (value) {}, // Propriedade não implementada
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSwitchTile(
                          context,
                          title: 'Aceita Cartão',
                          subtitle: 'Débito e crédito',
                          value: false, // Propriedade não existe na entidade
                          onChanged: (value) {}, // Propriedade não implementada
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
                          title: 'Aceita PIX',
                          subtitle: 'Transferência instantânea',
                          value: false, // Propriedade não existe na entidade
                          onChanged: (value) {}, // Propriedade não implementada
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSwitchTile(
                          context,
                          title: 'Aceita Cheque',
                          subtitle: 'Pagamento em cheque',
                          value: false, // Propriedade não existe na entidade
                          onChanged: (value) {}, // Propriedade não implementada
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Seção: Configurações Fiscais Básicas
              _buildSectionCard(
                context,
                title: 'Configurações Fiscais Básicas',
                icon: Icons.receipt_long,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: config?.regimeTributario?.isEmpty == true ? null : config?.regimeTributario,
                    decoration: InputDecoration(
                      labelText: 'Regime Tributário',
                      prefixIcon: const Icon(Icons.gavel),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    items: const [
                      DropdownMenuItem(value: null, child: Text('Selecione o regime')),
                      DropdownMenuItem(value: 'simples', child: Text('Simples Nacional')),
                      DropdownMenuItem(value: 'presumido', child: Text('Lucro Presumido')),
                      DropdownMenuItem(value: 'real', child: Text('Lucro Real')),
                      DropdownMenuItem(value: 'mei', child: Text('MEI')),
                      DropdownMenuItem(value: 'isento', child: Text('Isento')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(empresaConfigControllerProvider.notifier).updateRegimeTributario(value);
                      }
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildSwitchTile(
                          context,
                          title: 'Emite NFe',
                          subtitle: 'Nota Fiscal Eletrônica',
                          value: config?.emitirNfce ?? false,
                           onChanged: (value) => ref.read(empresaConfigControllerProvider.notifier).updateEmitirNfce(value),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSwitchTile(
                          context,
                          title: 'Emite NFCe',
                          subtitle: 'NFC-e (Cupom Fiscal)',
                          value: false, // Propriedade não existe na entidade
                          onChanged: (value) {}, // Propriedade não implementada
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Informações sobre dados financeiros
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: Colors.orange[600],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Informações Financeiras',
                          style: TextStyle(
                            color: Colors.orange[800],
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Dados bancários aparecerão nos recibos quando necessário\n'
                      '• Chave PIX pode ser exibida para facilitar pagamentos\n'
                      '• Configurações fiscais são importantes para compliance',
                      style: TextStyle(
                        color: Colors.orange[700],
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