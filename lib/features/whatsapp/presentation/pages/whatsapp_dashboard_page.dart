import 'package:flutter/material.dart';
import '../../domain/repositories/whatsapp_repository.dart';
import '../../domain/services/whatsapp_manager_service.dart';
import '../../domain/services/whatsapp_arrival_service.dart';

class WhatsAppDashboardPage extends StatefulWidget {
  final WhatsAppRepository repository;
  final WhatsAppManagerService managerService;
  final WhatsAppArrivalService arrivalService;

  const WhatsAppDashboardPage({
    Key? key,
    required this.repository,
    required this.managerService,
    required this.arrivalService,
  }) : super(key: key);

  @override
  State<WhatsAppDashboardPage> createState() => _WhatsAppDashboardPageState();
}

class _WhatsAppDashboardPageState extends State<WhatsAppDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  Map<String, dynamic> _statistics = {};
  List<Map<String, dynamic>> _recentMessages = [];
  List<Map<String, dynamic>> _pendingConfirmations = [];
  List<Map<String, dynamic>> _queuedMessages = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadDashboardData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    
    try {
      // Carregar estatísticas
      _statistics = await widget.repository.obterEstatisticas();
      
      // Carregar mensagens recentes
      _recentMessages = await widget.repository.listarMensagens(
        limite: 20,
        ordenacao: 'data_envio DESC',
      );
      
      // Carregar confirmações pendentes
      _pendingConfirmations = await widget.arrivalService.obterConfirmacoesPendentes();
      
      // Carregar mensagens na fila
      _queuedMessages = await widget.repository.listarMensagensPendentes();
      
      setState(() {});
    } catch (e) {
      _showErrorSnackBar('Erro ao carregar dados: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard WhatsApp'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navegar para configurações
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Visão Geral'),
            Tab(icon: Icon(Icons.message), text: 'Mensagens'),
            Tab(icon: Icon(Icons.check_circle), text: 'Confirmações'),
            Tab(icon: Icon(Icons.queue), text: 'Fila'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildMessagesTab(),
                _buildConfirmationsTab(),
                _buildQueueTab(),
              ],
            ),
    );
  }

  Widget _buildOverviewTab() {
    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatisticsCards(),
            const SizedBox(height: 24),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Estatísticas do Dia',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildStatCard(
              'Mensagens Enviadas',
              _statistics['mensagensEnviadas']?.toString() ?? '0',
              Icons.send,
              Colors.blue,
            ),
            _buildStatCard(
              'Mensagens Entregues',
              _statistics['mensagensEntregues']?.toString() ?? '0',
              Icons.done_all,
              Colors.green,
            ),
            _buildStatCard(
              'Mensagens Lidas',
              _statistics['mensagensLidas']?.toString() ?? '0',
              Icons.visibility,
              Colors.orange,
            ),
            _buildStatCard(
              'Mensagens com Erro',
              _statistics['mensagensComErro']?.toString() ?? '0',
              Icons.error,
              Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ações Rápidas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _processQueue(),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Processar Fila'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _sendTestMessage(),
                icon: const Icon(Icons.send),
                label: const Text('Teste de Envio'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Atividade Recente',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _recentMessages.take(5).length,
            itemBuilder: (context, index) {
              final message = _recentMessages[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getStatusColor(message['status']),
                  child: Icon(
                    _getStatusIcon(message['status']),
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                title: Text(
                  message['telefone'] ?? 'N/A',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  message['mensagem']?.toString().substring(0, 50) ?? 'N/A',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  _formatDateTime(message['dataEnvio']),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMessagesTab() {
    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _recentMessages.length,
        itemBuilder: (context, index) {
          final message = _recentMessages[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: _getStatusColor(message['status']),
                child: Icon(
                  _getStatusIcon(message['status']),
                  color: Colors.white,
                  size: 16,
                ),
              ),
              title: Text(
                message['telefone'] ?? 'N/A',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['tipo'] ?? 'N/A',
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  Text(
                    _formatDateTime(message['dataEnvio']),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mensagem:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(message['mensagem'] ?? 'N/A'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Chip(
                            label: Text(message['status'] ?? 'N/A'),
                            backgroundColor: _getStatusColor(message['status']),
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          if (message['erro'] != null)
                            Expanded(
                              child: Chip(
                                label: Text('Erro: ${message['erro']}'),
                                backgroundColor: Colors.red,
                                labelStyle: const TextStyle(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildConfirmationsTab() {
    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      child: _pendingConfirmations.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhuma confirmação pendente',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _pendingConfirmations.length,
              itemBuilder: (context, index) {
                final confirmation = _pendingConfirmations[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.schedule, color: Colors.white),
                    ),
                    title: Text(
                      confirmation['clienteNome'] ?? 'N/A',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(confirmation['servico'] ?? 'N/A'),
                        Text(
                          _formatDateTime(confirmation['dataHora']),
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Código:',
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        Text(
                          confirmation['codigoConfirmacao'] ?? 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _showConfirmationDetails(confirmation),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildQueueTab() {
    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      child: _queuedMessages.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.queue, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhuma mensagem na fila',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _processQueue(),
                          icon: const Icon(Icons.play_arrow),
                          label: Text('Processar ${_queuedMessages.length} mensagens'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _queuedMessages.length,
                    itemBuilder: (context, index) {
                      final message = _queuedMessages[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.schedule, color: Colors.white),
                          ),
                          title: Text(
                            message['telefone'] ?? 'N/A',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['tipo'] ?? 'N/A',
                                style: const TextStyle(fontSize: 12, color: Colors.blue),
                              ),
                              Text(
                                message['mensagem']?.toString().substring(0, 50) ?? 'N/A',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeFromQueue(message['id']),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'enviada':
        return Colors.blue;
      case 'entregue':
        return Colors.green;
      case 'lida':
        return Colors.orange;
      case 'erro':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'enviada':
        return Icons.send;
      case 'entregue':
        return Icons.done_all;
      case 'lida':
        return Icons.visibility;
      case 'erro':
        return Icons.error;
      default:
        return Icons.schedule;
    }
  }

  String _formatDateTime(dynamic dateTime) {
    if (dateTime == null) return 'N/A';
    
    DateTime dt;
    if (dateTime is String) {
      dt = DateTime.tryParse(dateTime) ?? DateTime.now();
    } else if (dateTime is DateTime) {
      dt = dateTime;
    } else {
      return 'N/A';
    }
    
    final now = DateTime.now();
    final difference = now.difference(dt);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m atrás';
    } else {
      return 'Agora';
    }
  }

  Future<void> _processQueue() async {
    try {
      await widget.managerService.processarFilaMensagens();
      _showSuccessSnackBar('Fila processada com sucesso!');
      await _loadDashboardData();
    } catch (e) {
      _showErrorSnackBar('Erro ao processar fila: $e');
    }
  }

  Future<void> _sendTestMessage() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => _TestMessageDialog(),
    );
    
    if (result != null) {
      try {
        await widget.managerService.enviarMensagem(
          clienteId: 'teste',
          telefone: result['telefone']!,
          mensagem: result['mensagem']!,
          tipo: 'teste',
        );
        _showSuccessSnackBar('Mensagem de teste enviada!');
        await _loadDashboardData();
      } catch (e) {
        _showErrorSnackBar('Erro ao enviar mensagem: $e');
      }
    }
  }

  Future<void> _removeFromQueue(String messageId) async {
    try {
      await widget.repository.removerMensagem(messageId);
      _showSuccessSnackBar('Mensagem removida da fila');
      await _loadDashboardData();
    } catch (e) {
      _showErrorSnackBar('Erro ao remover mensagem: $e');
    }
  }

  void _showConfirmationDetails(Map<String, dynamic> confirmation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detalhes da Confirmação'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cliente: ${confirmation['clienteNome']}'),
            Text('Telefone: ${confirmation['clienteTelefone']}'),
            Text('Serviço: ${confirmation['servico']}'),
            Text('Data/Hora: ${_formatDateTime(confirmation['dataHora'])}'),
            Text('Código: ${confirmation['codigoConfirmacao']}'),
            Text('Status: ${confirmation['status']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}

class _TestMessageDialog extends StatefulWidget {
  @override
  State<_TestMessageDialog> createState() => _TestMessageDialogState();
}

class _TestMessageDialogState extends State<_TestMessageDialog> {
  final _telefoneController = TextEditingController();
  final _mensagemController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _telefoneController.dispose();
    _mensagemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enviar Mensagem de Teste'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _telefoneController,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                hintText: '(11) 99999-9999',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Telefone é obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _mensagemController,
              decoration: const InputDecoration(
                labelText: 'Mensagem',
                hintText: 'Digite sua mensagem de teste',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mensagem é obrigatória';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop({
                'telefone': _telefoneController.text,
                'mensagem': _mensagemController.text,
              });
            }
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}