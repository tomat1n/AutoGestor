import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/entities/whatsapp_config.dart';
import '../../domain/repositories/whatsapp_repository.dart';
import '../../domain/services/whatsapp_service.dart';

class WhatsAppConfigPage extends StatefulWidget {
  final WhatsAppRepository repository;
  final WhatsAppService service;

  const WhatsAppConfigPage({
    super.key,
    required this.repository,
    required this.service,
  });

  @override
  State<WhatsAppConfigPage> createState() => _WhatsAppConfigPageState();
}

class _WhatsAppConfigPageState extends State<WhatsAppConfigPage> {
  final _formKey = GlobalKey<FormState>();
  final _apiUrlController = TextEditingController();
  final _apiTokenController = TextEditingController();
  final _instanceIdController = TextEditingController();
  final _horaInicioController = TextEditingController();
  final _horaFimController = TextEditingController();
  final _intervaloPadrao = TextEditingController();

  bool _ativo = false;
  bool _enviarAgendamentos = true;
  bool _enviarLembretes = true;
  bool _enviarConfirmacoes = true;
  bool _enviarPromocoes = false;
  bool _respeitarHorarioComercial = true;
  bool _isLoading = false;
  bool _isTestingConnection = false;
  String? _connectionStatus;

  @override
  void initState() {
    super.initState();
    _loadConfiguration();
  }

  @override
  void dispose() {
    _apiUrlController.dispose();
    _apiTokenController.dispose();
    _instanceIdController.dispose();
    _horaInicioController.dispose();
    _horaFimController.dispose();
    _intervaloPadrao.dispose();
    super.dispose();
  }

  Future<void> _loadConfiguration() async {
    setState(() => _isLoading = true);
    
    try {
      final config = await widget.repository.obterConfiguracao();
      if (config != null) {
        _apiUrlController.text = config.apiUrl;
        _apiTokenController.text = config.apiToken;
        _instanceIdController.text = config.instanceId;
        _horaInicioController.text = config.horaInicioComercial ?? '08:00';
        _horaFimController.text = config.horaFimComercial ?? '18:00';
        _intervaloPadrao.text = config.intervaloPadraoMinutos.toString();
        
        setState(() {
          _ativo = config.ativo;
          _enviarAgendamentos = config.enviarAgendamentos;
          _enviarLembretes = config.enviarLembretes;
          _enviarConfirmacoes = config.enviarConfirmacoes;
          _enviarPromocoes = config.enviarPromocoes;
          _respeitarHorarioComercial = config.respeitarHorarioComercial;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Erro ao carregar configurações: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveConfiguration() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      final config = WhatsAppConfig(
        apiUrl: _apiUrlController.text.trim(),
        apiToken: _apiTokenController.text.trim(),
        instanceId: _instanceIdController.text.trim(),
        ativo: _ativo,
        enviarAgendamentos: _enviarAgendamentos,
        enviarLembretes: _enviarLembretes,
        enviarConfirmacoes: _enviarConfirmacoes,
        enviarPromocoes: _enviarPromocoes,
        respeitarHorarioComercial: _respeitarHorarioComercial,
        horaInicioComercial: _horaInicioController.text.trim(),
        horaFimComercial: _horaFimController.text.trim(),
        intervaloPadraoMinutos: int.tryParse(_intervaloPadrao.text) ?? 30,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await widget.repository.salvarConfiguracao(config);
      _showSuccessSnackBar('Configurações salvas com sucesso!');
    } catch (e) {
      _showErrorSnackBar('Erro ao salvar configurações: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _testConnection() async {
    if (_apiUrlController.text.isEmpty || _apiTokenController.text.isEmpty) {
      _showErrorSnackBar('Preencha a URL da API e o Token antes de testar');
      return;
    }
    
    setState(() => _isTestingConnection = true);
    
    try {
      final isConnected = await widget.service.verificarConexao();
      setState(() {
        _connectionStatus = isConnected ? 'Conexão bem-sucedida!' : 'Falha na conexão';
      });
      
      if (isConnected) {
        _showSuccessSnackBar('Conexão testada com sucesso!');
      } else {
        _showErrorSnackBar('Falha ao conectar com a API do WhatsApp');
      }
    } catch (e) {
      setState(() => _connectionStatus = 'Erro: $e');
      _showErrorSnackBar('Erro ao testar conexão: $e');
    } finally {
      setState(() => _isTestingConnection = false);
    }
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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações WhatsApp'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildConnectionSection(),
                    const SizedBox(height: 24),
                    _buildGeneralSettingsSection(),
                    const SizedBox(height: 24),
                    _buildNotificationSettingsSection(),
                    const SizedBox(height: 24),
                    _buildScheduleSettingsSection(),
                    const SizedBox(height: 32),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildConnectionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.api, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Configurações da API',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _apiUrlController,
              decoration: const InputDecoration(
                labelText: 'URL da API *',
                hintText: 'https://api.whatsapp.com',
                prefixIcon: Icon(Icons.link),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'URL da API é obrigatória';
                }
                if (!Uri.tryParse(value)!.isAbsolute) {
                  return 'URL inválida';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _apiTokenController,
              decoration: const InputDecoration(
                labelText: 'Token da API *',
                hintText: 'Seu token de acesso',
                prefixIcon: Icon(Icons.key),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Token da API é obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _instanceIdController,
              decoration: const InputDecoration(
                labelText: 'ID da Instância *',
                hintText: 'ID da sua instância WhatsApp',
                prefixIcon: Icon(Icons.phone_android),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'ID da Instância é obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isTestingConnection ? null : _testConnection,
                    icon: _isTestingConnection
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.wifi_tethering),
                    label: Text(_isTestingConnection ? 'Testando...' : 'Testar Conexão'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            if (_connectionStatus != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _connectionStatus!.contains('sucesso')
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _connectionStatus!.contains('sucesso')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _connectionStatus!.contains('sucesso')
                          ? Icons.check_circle
                          : Icons.error,
                      color: _connectionStatus!.contains('sucesso')
                          ? Colors.green
                          : Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _connectionStatus!,
                        style: TextStyle(
                          color: _connectionStatus!.contains('sucesso')
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettingsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.settings, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Configurações Gerais',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Ativar WhatsApp'),
              subtitle: const Text('Habilita o envio de mensagens via WhatsApp'),
              value: _ativo,
              onChanged: (value) => setState(() => _ativo = value),
              activeThumbColor: Colors.green,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _intervaloPadrao,
              decoration: const InputDecoration(
                labelText: 'Intervalo Padrão (minutos)',
                hintText: '30',
                prefixIcon: Icon(Icons.timer),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Intervalo é obrigatório';
                }
                final interval = int.tryParse(value);
                if (interval == null || interval < 1 || interval > 1440) {
                  return 'Intervalo deve ser entre 1 e 1440 minutos';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettingsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.notifications, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'Tipos de Notificação',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Agendamentos'),
              subtitle: const Text('Confirmações e atualizações de agendamentos'),
              value: _enviarAgendamentos,
              onChanged: _ativo ? (value) => setState(() => _enviarAgendamentos = value) : null,
              activeThumbColor: Colors.green,
            ),
            SwitchListTile(
              title: const Text('Lembretes'),
              subtitle: const Text('Lembretes de agendamentos e manutenções'),
              value: _enviarLembretes,
              onChanged: _ativo ? (value) => setState(() => _enviarLembretes = value) : null,
              activeThumbColor: Colors.green,
            ),
            SwitchListTile(
              title: const Text('Confirmações'),
              subtitle: const Text('Solicitações de confirmação de chegada'),
              value: _enviarConfirmacoes,
              onChanged: _ativo ? (value) => setState(() => _enviarConfirmacoes = value) : null,
              activeThumbColor: Colors.green,
            ),
            SwitchListTile(
              title: const Text('Promoções'),
              subtitle: const Text('Ofertas e promoções especiais'),
              value: _enviarPromocoes,
              onChanged: _ativo ? (value) => setState(() => _enviarPromocoes = value) : null,
              activeThumbColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleSettingsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.schedule, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Horário Comercial',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Respeitar Horário Comercial'),
              subtitle: const Text('Enviar mensagens apenas no horário comercial'),
              value: _respeitarHorarioComercial,
              onChanged: _ativo ? (value) => setState(() => _respeitarHorarioComercial = value) : null,
              activeThumbColor: Colors.green,
            ),
            if (_respeitarHorarioComercial) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _horaInicioController,
                      decoration: const InputDecoration(
                        labelText: 'Hora Início',
                        hintText: '08:00',
                        prefixIcon: Icon(Icons.access_time),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (_respeitarHorarioComercial && (value == null || value.isEmpty)) {
                          return 'Hora de início é obrigatória';
                        }
                        return null;
                      },
                      onTap: () => _selectTime(context, _horaInicioController),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _horaFimController,
                      decoration: const InputDecoration(
                        labelText: 'Hora Fim',
                        hintText: '18:00',
                        prefixIcon: Icon(Icons.access_time),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (_respeitarHorarioComercial && (value == null || value.isEmpty)) {
                          return 'Hora de fim é obrigatória';
                        }
                        return null;
                      },
                      onTap: () => _selectTime(context, _horaFimController),
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _isLoading ? null : _saveConfiguration,
            icon: _isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
            label: Text(_isLoading ? 'Salvando...' : 'Salvar Configurações'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final formattedTime = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      controller.text = formattedTime;
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajuda - Configurações WhatsApp'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Configurações da API:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('• URL da API: Endereço do serviço WhatsApp Business API'),
              Text('• Token: Chave de autenticação fornecida pelo provedor'),
              Text('• ID da Instância: Identificador único da sua instância'),
              SizedBox(height: 16),
              Text(
                'Tipos de Notificação:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('• Agendamentos: Confirmações e atualizações'),
              Text('• Lembretes: Avisos de agendamentos próximos'),
              Text('• Confirmações: Solicitações de chegada'),
              Text('• Promoções: Ofertas e campanhas'),
              SizedBox(height: 16),
              Text(
                'Horário Comercial:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('• Define quando as mensagens podem ser enviadas'),
              Text('• Mensagens fora do horário ficam na fila'),
              Text('• Recomendado para respeitar o cliente'),
            ],
          ),
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