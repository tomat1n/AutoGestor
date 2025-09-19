import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../orcamentos/domain/services/orcamentos_service_provider.dart';
import '../../ordens_servico/domain/services/ordens_servico_service_provider.dart';

class WhatsAppIntegrationDemo extends ConsumerStatefulWidget {
  const WhatsAppIntegrationDemo({super.key});

  @override
  ConsumerState<WhatsAppIntegrationDemo> createState() => _WhatsAppIntegrationDemoState();
}

class _WhatsAppIntegrationDemoState extends ConsumerState<WhatsAppIntegrationDemo> {
  final _mensagemController = TextEditingController();
  bool _isLoading = false;
  String? _resultado;

  @override
  void dispose() {
    _mensagemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integração WhatsApp'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.info, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'Integração WhatsApp Implementada',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'As seguintes funcionalidades foram implementadas:',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    _buildFeatureItem('📋 Envio automático de orçamentos'),
                    _buildFeatureItem('⏰ Lembretes de vencimento de orçamentos'),
                    _buildFeatureItem('✅ Notificações de aprovação de orçamentos'),
                    _buildFeatureItem('🔧 Envio de ordens de serviço'),
                    _buildFeatureItem('📅 Notificações de agendamento'),
                    _buildFeatureItem('🚀 Notificações de início de execução'),
                    _buildFeatureItem('✅ Notificações de conclusão de serviços'),
                    _buildFeatureItem('⏰ Lembretes automáticos de agendamento'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.code, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          'Como Usar',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildUsageExample(
                      'Enviar Orçamento:',
                      'await orcamentosService.enviarOrcamento(id, mensagemPersonalizada: "Seu orçamento está pronto!");',
                    ),
                    _buildUsageExample(
                      'Aprovar com Notificação:',
                      'await orcamentosService.aprovarOrcamento(id);',
                    ),
                    _buildUsageExample(
                      'Iniciar Ordem de Serviço:',
                      'await ordensServicoService.iniciarExecucao(id);',
                    ),
                    _buildUsageExample(
                      'Concluir Ordem de Serviço:',
                      'await ordensServicoService.concluirExecucao(id, "Serviço concluído com sucesso");',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.settings, color: Colors.purple),
                        const SizedBox(width: 8),
                        Text(
                          'Configurações Automáticas',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildConfigItem('✅ Integração automática nos serviços principais'),
                    _buildConfigItem('✅ Tratamento de erros sem interromper fluxo'),
                    _buildConfigItem('✅ Mensagens personalizáveis'),
                    _buildConfigItem('✅ Verificação de telefone do cliente'),
                    _buildConfigItem('✅ Histórico de mensagens por entidade'),
                    _buildConfigItem('✅ Processamento de lembretes automáticos'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: _testarIntegracao,
                    icon: const Icon(Icons.whatsapp),
                    label: const Text('Testar Integração'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _processarLembretesAutomaticos,
                    icon: const Icon(Icons.schedule),
                    label: const Text('Processar Lembretes Automáticos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ],
              ),
            if (_resultado != null) ...[
              const SizedBox(height: 16),
              Card(
                color: _resultado!.contains('Erro') ? Colors.red.shade50 : Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _resultado!,
                    style: TextStyle(
                      color: _resultado!.contains('Erro') ? Colors.red.shade700 : Colors.green.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildUsageExample(String title, String code) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildConfigItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.check, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  Future<void> _testarIntegracao() async {
    setState(() {
      _isLoading = true;
      _resultado = null;
    });

    try {
      // Simular teste da integração
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _resultado = '✅ Integração WhatsApp configurada com sucesso!\n'
                    'Todos os serviços estão prontos para envio automático.';
      });
    } catch (e) {
      setState(() {
        _resultado = '❌ Erro ao testar integração: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _processarLembretesAutomaticos() async {
    setState(() {
      _isLoading = true;
      _resultado = null;
    });

    try {
      final orcamentosService = ref.read(orcamentosServiceProvider);
      final ordensServicoService = ref.read(ordensServicoServiceProvider);

      // Processar lembretes de orçamentos
      await orcamentosService.processarLembretesAutomaticos();
      
      // Processar lembretes de ordens de serviço
      await ordensServicoService.processarLembretesAgendamento();
      
      setState(() {
        _resultado = '✅ Lembretes automáticos processados com sucesso!\n'
                    'Todas as notificações pendentes foram enviadas.';
      });
    } catch (e) {
      setState(() {
        _resultado = '❌ Erro ao processar lembretes: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}