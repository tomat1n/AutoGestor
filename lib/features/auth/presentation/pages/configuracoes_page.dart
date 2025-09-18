import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/auth_provider.dart';
import '../widgets/company_branding_widget.dart';
import '../../domain/entities/usuario_entity.dart';
import '../../domain/entities/assinatura_entity.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  
  // Controladores dos campos
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _empresaController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _cepController = TextEditingController();
  final _nomeFantasiaController = TextEditingController();
  
  Color _corPrimaria = Colors.blue.shade800;
  Color _corSecundaria = Colors.blue.shade600;
  String? _logoPath;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserData();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _nomeController.dispose();
    _emailController.dispose();
    _empresaController.dispose();
    _cnpjController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _cidadeController.dispose();
    _estadoController.dispose();
    _cepController.dispose();
    _nomeFantasiaController.dispose();
    super.dispose();
  }
  
  void _loadUserData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final usuario = authProvider.usuario;
    
    if (usuario != null) {
      _nomeController.text = usuario.nome ?? '';
      _emailController.text = usuario.email ?? '';
      _empresaController.text = usuario.empresa ?? '';
      _cnpjController.text = usuario.cnpj ?? '';
      _telefoneController.text = usuario.telefone ?? '';
      _enderecoController.text = usuario.endereco ?? '';
      _cidadeController.text = usuario.cidade ?? '';
      _estadoController.text = usuario.estado ?? '';
      _cepController.text = usuario.cep ?? '';
      _nomeFantasiaController.text = usuario.nomeFantasia ?? '';
      _logoPath = usuario.logoPath;
      
      // Carregar cores
      if (usuario.corPrimaria != null) {
        _corPrimaria = _parseColor(usuario.corPrimaria!);
      }
      if (usuario.corSecundaria != null) {
        _corSecundaria = _parseColor(usuario.corSecundaria!);
      }
    }
  }
  
  Color _parseColor(String colorString) {
    try {
      String cleanColor = colorString.replaceAll('#', '');
      if (cleanColor.length == 6) {
        cleanColor = 'FF$cleanColor';
      }
      return Color(int.parse(cleanColor, radix: 16));
    } catch (e) {
      return Colors.blue.shade800;
    }
  }
  
  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
  
  Future<void> _pickLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );
    
    if (image != null) {
      setState(() {
        _logoPath = image.path;
      });
    }
  }
  
  Future<void> _salvarDados() async {
    if (!_formKey.currentState!.validate()) return;
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final usuarioAtual = authProvider.usuario;
    
    if (usuarioAtual == null) return;
    
    final usuarioAtualizado = usuarioAtual.copyWith(
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      empresa: _empresaController.text.trim(),
      cnpj: _cnpjController.text.trim(),
      telefone: _telefoneController.text.trim(),
      endereco: _enderecoController.text.trim(),
      cidade: _cidadeController.text.trim(),
      estado: _estadoController.text.trim(),
      cep: _cepController.text.trim(),
      nomeFantasia: _nomeFantasiaController.text.trim(),
      logoPath: _logoPath,
      corPrimaria: _colorToHex(_corPrimaria),
      corSecundaria: _colorToHex(_corSecundaria),
      atualizadoEm: DateTime.now(),
    );
    
    final sucesso = await authProvider.atualizarUsuario(usuarioAtualizado);
    
    if (mounted) {
      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dados atualizados com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.erro ?? 'Erro ao atualizar dados'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: _corPrimaria,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Perfil'),
            Tab(icon: Icon(Icons.palette), text: 'Visual'),
            Tab(icon: Icon(Icons.card_membership), text: 'Assinatura'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _salvarDados,
            icon: const Icon(Icons.save),
            tooltip: 'Salvar alterações',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildPerfilTab(),
            _buildVisualTab(),
            _buildAssinaturaTab(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPerfilTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dados Pessoais
          Text(
            'Dados Pessoais',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome Completo',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(value)) {
                return 'Por favor, insira um email válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          
          // Dados da Empresa
          Text(
            'Dados da Empresa',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _empresaController,
            decoration: const InputDecoration(
              labelText: 'Razão Social',
              prefixIcon: Icon(Icons.business),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira a razão social';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _nomeFantasiaController,
            decoration: const InputDecoration(
              labelText: 'Nome Fantasia',
              prefixIcon: Icon(Icons.store),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _cnpjController,
            decoration: const InputDecoration(
              labelText: 'CNPJ',
              prefixIcon: Icon(Icons.assignment),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o CNPJ';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _telefoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Telefone',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _enderecoController,
            decoration: const InputDecoration(
              labelText: 'Endereço',
              prefixIcon: Icon(Icons.location_on),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _cidadeController,
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _estadoController,
                  decoration: const InputDecoration(
                    labelText: 'Estado',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _cepController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'CEP',
              prefixIcon: Icon(Icons.mail),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildVisualTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Preview
          Text(
            'Preview',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_corPrimaria, _corSecundaria],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Logo preview
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: _logoPath != null && _logoPath!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(_logoPath!),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.business,
                                size: 40,
                                color: _corPrimaria,
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.business,
                          size: 40,
                          color: _corPrimaria,
                        ),
                ),
                const SizedBox(height: 16),
                Text(
                  _nomeFantasiaController.text.isNotEmpty
                      ? _nomeFantasiaController.text
                      : _empresaController.text.isNotEmpty
                          ? _empresaController.text
                          : 'Nome da Empresa',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          // Logo
          Text(
            'Logo da Empresa',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                if (_logoPath != null && _logoPath!.isNotEmpty)
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(_logoPath!),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Icon(
                      Icons.add_photo_alternate,
                      size: 40,
                      color: Colors.grey.shade600,
                    ),
                  ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickLogo,
                  icon: const Icon(Icons.upload),
                  label: Text(_logoPath != null ? 'Alterar Logo' : 'Adicionar Logo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _corPrimaria,
                    foregroundColor: Colors.white,
                  ),
                ),
                if (_logoPath != null)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _logoPath = null;
                      });
                    },
                    child: const Text('Remover Logo'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          // Cores
          Text(
            'Cores do Sistema',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cor Primária'),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showColorPicker(true),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _corPrimaria,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Center(
                          child: Text(
                            _colorToHex(_corPrimaria),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cor Secundária'),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showColorPicker(false),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _corSecundaria,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Center(
                          child: Text(
                            _colorToHex(_corSecundaria),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Cores predefinidas
          Text(
            'Cores Predefinidas',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildColorOption(Colors.blue.shade800, Colors.blue.shade600),
              _buildColorOption(Colors.green.shade800, Colors.green.shade600),
              _buildColorOption(Colors.purple.shade800, Colors.purple.shade600),
              _buildColorOption(Colors.orange.shade800, Colors.orange.shade600),
              _buildColorOption(Colors.red.shade800, Colors.red.shade600),
              _buildColorOption(Colors.teal.shade800, Colors.teal.shade600),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildColorOption(Color primary, Color secondary) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _corPrimaria = primary;
          _corSecundaria = secondary;
        });
      },
      child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primary, secondary],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _corPrimaria == primary ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
  
  void _showColorPicker(bool isPrimary) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Escolher ${isPrimary ? 'Cor Primária' : 'Cor Secundária'}'),
        content: SingleChildScrollView(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: Colors.primaries.map((color) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isPrimary) {
                      _corPrimaria = color.shade800;
                    } else {
                      _corSecundaria = color.shade600;
                    }
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isPrimary ? color.shade800 : color.shade600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAssinaturaTab() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final assinatura = authProvider.assinatura;
        final diasRestantes = authProvider.diasRestantes;
        final isTeste = authProvider.isTeste;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status atual
              Text(
                'Status da Assinatura',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              if (assinatura != null) ...
                [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isTeste ? Colors.blue.shade50 : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isTeste ? Colors.blue.shade200 : Colors.green.shade200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isTeste ? Icons.schedule : Icons.check_circle,
                              color: isTeste ? Colors.blue.shade700 : Colors.green.shade700,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isTeste ? 'Período de Teste' : 'Assinatura Ativa',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isTeste ? Colors.blue.shade700 : Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow('Tipo', assinatura.tipo.nome),
                        _buildInfoRow('Status', assinatura.status.nome),
                        _buildInfoRow('Início', _formatDate(assinatura.dataInicio)),
                        _buildInfoRow('Fim', _formatDate(assinatura.dataFim)),
                        _buildInfoRow('Dias Restantes', '$diasRestantes dias'),
                        if (assinatura.valor != null && assinatura.valor! > 0)
                          _buildInfoRow('Valor', 'R\$ ${assinatura.valor!.toStringAsFixed(2)}'),
                        if (assinatura.pago)
                          _buildInfoRow('Pagamento', 'Confirmado'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ]
              else ...
                [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.red.shade700,
                          size: 48,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Nenhuma assinatura ativa',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              
              // Ações
              Text(
                'Ações',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              if (isTeste) ...
                [
                  CompanyThemedButton(
                    text: 'Assinar Agora',
                    icon: Icons.upgrade,
                    width: double.infinity,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/renovar-assinatura');
                    },
                  ),
                  const SizedBox(height: 12),
                ]
              else if (diasRestantes <= 30) ...
                [
                  CompanyThemedButton(
                    text: 'Renovar Assinatura',
                    icon: Icons.refresh,
                    width: double.infinity,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/renovar-assinatura');
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              
              CompanyThemedButton(
                text: 'Verificar Status',
                icon: Icons.refresh,
                width: double.infinity,
                isOutlined: true,
                onPressed: () async {
                  await authProvider.verificarStatusAssinatura();
                  
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Status atualizado!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 32),
              
              // Histórico (placeholder)
              Text(
                'Histórico de Assinaturas',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Text(
                  'Funcionalidade em desenvolvimento',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}