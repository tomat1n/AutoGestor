import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/orcamento.dart';
import '../providers/orcamentos_provider.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';

class OrcamentosPage extends StatefulWidget {
  const OrcamentosPage({super.key});

  @override
  State<OrcamentosPage> createState() => _OrcamentosPageState();
}

class _OrcamentosPageState extends State<OrcamentosPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrcamentosProvider>().carregarOrcamentos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orçamentos'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/orcamentos/novo'),
            tooltip: 'Novo Orçamento',
          ),
        ],
      ),
      body: Consumer<OrcamentosProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingWidget();
          }

          if (provider.error != null) {
            return CustomErrorWidget(
              message: provider.error!,
              onRetry: () => provider.carregarOrcamentos(),
            );
          }

          final orcamentos = provider.orcamentos;

          if (orcamentos.isEmpty) {
            return _buildEmptyState();
          }

          return _buildOrcamentosList(orcamentos);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum orçamento encontrado',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Crie seu primeiro orçamento clicando no botão +',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.go('/orcamentos/novo'),
            icon: const Icon(Icons.add),
            label: const Text('Criar Orçamento'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrcamentosList(List<Orcamento> orcamentos) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<OrcamentosProvider>().carregarOrcamentos();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orcamentos.length,
        itemBuilder: (context, index) {
          final orcamento = orcamentos[index];
          return _buildOrcamentoCard(orcamento);
        },
      ),
    );
  }

  Widget _buildOrcamentoCard(Orcamento orcamento) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => context.go('/orcamentos/detalhes/${orcamento.id}'),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Orçamento #${orcamento.numero}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          orcamento.nomeCliente,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(orcamento.status.toString().split('.').last),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data: ${_formatDate(orcamento.dataEmissao)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (orcamento.dataValidade != null)
                        Text(
                          'Válido até: ${_formatDate(orcamento.dataValidade!)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                  Text(
                    'R\$ ${orcamento.valorTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => _enviarWhatsApp(orcamento),
                    icon: const Icon(Icons.message, size: 16),
                    label: const Text('WhatsApp'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () => context.go('/orcamentos/editar/${orcamento.id}'),
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Editar'),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) => _handleMenuAction(value, orcamento),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'duplicar',
                        child: Row(
                          children: [
                            Icon(Icons.copy, size: 16),
                            SizedBox(width: 8),
                            Text('Duplicar'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'pdf',
                        child: Row(
                          children: [
                            Icon(Icons.picture_as_pdf, size: 16),
                            SizedBox(width: 8),
                            Text('Gerar PDF'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'whatsapp_pdf',
                        child: Row(
                          children: [
                            Icon(Icons.attach_file, size: 16, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('WhatsApp + PDF', style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'excluir',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 16, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Excluir', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status.toLowerCase()) {
      case 'pendente':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        label = 'Pendente';
        break;
      case 'aprovado':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        label = 'Aprovado';
        break;
      case 'rejeitado':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        label = 'Rejeitado';
        break;
      case 'expirado':
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
        label = 'Expirado';
        break;
      default:
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  void _enviarWhatsApp(Orcamento orcamento) async {
    try {
      // Verificar se o cliente tem telefone
      if (orcamento.telefoneCliente == null || orcamento.telefoneCliente!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cliente não possui telefone cadastrado'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Criar mensagem para WhatsApp
      String mensagem = '''🔧 *ORÇAMENTO ${orcamento.numero}*

📋 *Dados do Cliente:*
Nome: ${orcamento.nomeCliente}
Telefone: ${orcamento.telefoneCliente!}''';

      if (orcamento.emailCliente != null && orcamento.emailCliente!.isNotEmpty) {
        mensagem += '\nE-mail: ${orcamento.emailCliente!}';
      }
      
      mensagem += '\n\n📅 *Data de Emissão:* ${orcamento.dataEmissao.day.toString().padLeft(2, '0')}/${orcamento.dataEmissao.month.toString().padLeft(2, '0')}/${orcamento.dataEmissao.year}';
      
      if (orcamento.dataValidade != null) {
        mensagem += '\n⏰ *Validade:* ${orcamento.dataValidade!.day.toString().padLeft(2, '0')}/${orcamento.dataValidade!.month.toString().padLeft(2, '0')}/${orcamento.dataValidade!.year}';
      }
      
      mensagem += '\n\n💰 *Valor Total: R\$ ${orcamento.valorTotal.toStringAsFixed(2)}*';
      
      if (orcamento.observacoes != null && orcamento.observacoes!.isNotEmpty) {
        mensagem += '\n\n📝 *Observações:*\n${orcamento.observacoes!}';
      }
      
      if (orcamento.condicoesPagamento != null && orcamento.condicoesPagamento!.isNotEmpty) {
        mensagem += '\n\n💳 *Condições de Pagamento:*\n${orcamento.condicoesPagamento!}';
      }

      mensagem += '\n\n✅ Para mais detalhes ou dúvidas, entre em contato conosco!';
      mensagem += '\n🙏 Aguardamos seu retorno!';
      
      // Codificar a mensagem para URL
      final mensagemCodificada = Uri.encodeComponent(mensagem);
      
      // Remover caracteres especiais do telefone
      final telefone = orcamento.telefoneCliente!.replaceAll(RegExp(r'[^0-9]'), '');
      
      // Criar URL do WhatsApp
      final whatsappUrl = 'https://wa.me/55$telefone?text=$mensagemCodificada';
      
      // Abrir WhatsApp
      final uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Abrindo WhatsApp...'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw 'Não foi possível abrir o WhatsApp';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar via WhatsApp: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleMenuAction(String action, Orcamento orcamento) {
    switch (action) {
      case 'duplicar':
        _duplicarOrcamento(orcamento);
        break;
      case 'pdf':
        _gerarPDF(orcamento);
        break;
      case 'whatsapp_pdf':
        _enviarWhatsAppComPDF(orcamento);
        break;
      case 'excluir':
        _confirmarExclusao(orcamento);
        break;
    }
  }

  void _duplicarOrcamento(Orcamento orcamento) {
    // Implementar duplicação
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Duplicando orçamento...'),
      ),
    );
  }

  void _gerarPDF(Orcamento orcamento) {
    // Implementar geração de PDF
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gerando PDF...'),
      ),
    );
  }

  void _confirmarExclusao(Orcamento orcamento) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Deseja realmente excluir o orçamento #${orcamento.numero}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _excluirOrcamento(orcamento);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _excluirOrcamento(Orcamento orcamento) async {
    try {
      await context.read<OrcamentosProvider>().excluirOrcamento(orcamento.id!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Orçamento excluído com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao excluir orçamento: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _enviarWhatsAppComPDF(Orcamento orcamento) {
    // Verificar se o cliente tem telefone
    if (orcamento.telefoneCliente == null || orcamento.telefoneCliente!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cliente não possui telefone cadastrado'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Criar mensagem simples para WhatsApp
    String mensagem = '''🔧 *ORÇAMENTO ${orcamento.numero}*

Olá ${orcamento.nomeCliente}!

Segue em anexo o orçamento solicitado.

📋 *Resumo:*
• Número: ${orcamento.numero}
• Data: ${orcamento.dataEmissao.day.toString().padLeft(2, '0')}/${orcamento.dataEmissao.month.toString().padLeft(2, '0')}/${orcamento.dataEmissao.year}''';

    if (orcamento.dataValidade != null) {
      mensagem += '''
• Validade: ${orcamento.dataValidade!.day.toString().padLeft(2, '0')}/${orcamento.dataValidade!.month.toString().padLeft(2, '0')}/${orcamento.dataValidade!.year}''';
    }

    mensagem += '''

💰 *Total: R\$ ${orcamento.valorTotal.toStringAsFixed(2)}*

📎 *PDF será gerado e compartilhado*

Qualquer dúvida, estou à disposição!''';

    // Codificar a mensagem para URL
    final mensagemCodificada = Uri.encodeComponent(mensagem);
    
    // Remover caracteres especiais do telefone
    final telefone = orcamento.telefoneCliente!.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Criar URL do WhatsApp
    final whatsappUrl = 'https://wa.me/55$telefone?text=$mensagemCodificada';
    
    try {
      // Abrir WhatsApp
      final uri = Uri.parse(whatsappUrl);
      launchUrl(uri, mode: LaunchMode.externalApplication);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Abrindo WhatsApp... Gere o PDF separadamente e compartilhe.'),
          backgroundColor: Colors.blue,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao abrir WhatsApp: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}