import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_it/get_it.dart';
import 'dart:io';
import '../../domain/entities/orcamento.dart';
import '../../domain/repositories/orcamentos_repository.dart';
import '../providers/orcamentos_provider.dart';
import '../../../servicos/domain/entities/servico.dart';
import '../../../servicos/presentation/providers/servicos_provider.dart';
import '../../../../core/widgets/loading_widget.dart';
import 'selecionar_servicos_page.dart';
import 'selecionar_produtos_page.dart';
import 'orcamento_detalhes_page.dart';

class OrcamentoFormPage extends StatefulWidget {
  final int? orcamentoId;
  
  const OrcamentoFormPage({super.key, this.orcamentoId});

  @override
  State<OrcamentoFormPage> createState() => _OrcamentoFormPageState();
}

class _OrcamentoFormPageState extends State<OrcamentoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeClienteController = TextEditingController();
  final _emailClienteController = TextEditingController();
  final _telefoneClienteController = TextEditingController();
  final _observacoesController = TextEditingController();
  final _condicoesPagamentoController = TextEditingController();
  
  DateTime? _dataValidade;
  String _localSalvamento = 'Local';
  bool _isLoading = false;
  Orcamento? _orcamentoExistente;
  List<Servico> _servicosSelecionados = [];
  List<Map<String, dynamic>> _produtosSelecionados = [];
  List<File> _fotosDefeito = [];
  List<File> _fotosReposicao = [];
  final ImagePicker _picker = ImagePicker();
  
  @override
  void initState() {
    super.initState();
    if (widget.orcamentoId != null) {
      _carregarOrcamento();
    }
  }
  
  Future<void> _carregarOrcamento() async {
    setState(() => _isLoading = true);
    try {
      final orcamentosRepository = GetIt.instance<OrcamentosRepository>();
      _orcamentoExistente = await orcamentosRepository.buscarPorId(widget.orcamentoId!);
      
      if (_orcamentoExistente != null) {
        _preencherFormulario();
      } else {
        throw Exception('Orçamento não encontrado');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar orçamento: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  void _preencherFormulario() {
    if (_orcamentoExistente != null) {
      _nomeClienteController.text = _orcamentoExistente!.nomeCliente;
      _emailClienteController.text = _orcamentoExistente!.emailCliente ?? '';
      _telefoneClienteController.text = _orcamentoExistente!.telefoneCliente ?? '';
      _observacoesController.text = _orcamentoExistente!.observacoes ?? '';
      _condicoesPagamentoController.text = _orcamentoExistente!.condicoesPagamento ?? '';
      _dataValidade = _orcamentoExistente!.dataValidade;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.orcamentoId == null ? 'Novo Orçamento' : 'Editar Orçamento'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _salvarOrcamento,
            child: const Text(
              'Salvar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildClienteSection(),
                    const SizedBox(height: 24),
                    _buildServicosSection(),
                    const SizedBox(height: 24),
                    _buildProdutosSection(),
                    const SizedBox(height: 24),
                    _buildFotosDefeitoSection(),
                    const SizedBox(height: 24),
                    _buildFotosReposicaoSection(),
                    const SizedBox(height: 24),
                    _buildObservacoesSection(),
                    const SizedBox(height: 24),
                    _buildCondicoesPagamentoSection(),
                    const SizedBox(height: 24),
                    _buildDataValidadeSection(),
                    const SizedBox(height: 24),
                    _buildLocalSalvamentoSection(),
                  ],
                ),
              ),
            ),
    );
  }
  
  Widget _buildClienteSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dados do Cliente',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nomeClienteController,
              decoration: const InputDecoration(
                labelText: 'Nome do Cliente *',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nome do cliente é obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailClienteController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _telefoneClienteController,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildServicosSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Serviços do Orçamento',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton.icon(
                  onPressed: _selecionarServicos,
                  icon: const Icon(Icons.add),
                  label: const Text('Selecionar Serviços'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_servicosSelecionados.isEmpty)
              Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Nenhum serviço selecionado\nClique em "Selecionar Serviços" para começar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _servicosSelecionados.length,
                itemBuilder: (context, index) {
                  final servico = _servicosSelecionados[index];
                  return Card(
                    child: ListTile(
                      title: Text(servico.nome),
                      subtitle: Text(servico.descricao ?? ''),
                      trailing: Text(
                        'R\$ ${servico.valor.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProdutosSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Produtos/Peças do Orçamento',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton.icon(
                  onPressed: _selecionarProdutos,
                  icon: const Icon(Icons.add),
                  label: const Text('Selecionar Produtos'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_produtosSelecionados.isEmpty)
              Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Nenhum produto selecionado\nClique em "Selecionar Produtos" para começar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _produtosSelecionados.length,
                itemBuilder: (context, index) {
                  final item = _produtosSelecionados[index];
                  final produto = item['produto'];
                  final quantidade = item['quantidade'];
                  final valor = item['valor'];
                  final subtotal = quantidade * valor;
                  
                  return Card(
                    child: ListTile(
                      title: Text(produto.nome),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (produto.descricao != null)
                            Text(produto.descricao!),
                          Text('Qtd: $quantidade x R\$ ${valor.toStringAsFixed(2)}'),
                        ],
                      ),
                      trailing: Text(
                        'R\$ ${subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFotosDefeitoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fotos de Peças com Defeito',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton.icon(
                  onPressed: _adicionarFotoDefeito,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Adicionar Foto'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_fotosDefeito.isEmpty)
              Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Nenhuma foto adicionada\nClique em "Adicionar Foto" para começar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _fotosDefeito.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _fotosDefeito[index],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => _removerFotoDefeito(index),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFotosReposicaoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fotos de Peças de Reposição',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton.icon(
                  onPressed: _adicionarFotoReposicao,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Adicionar Foto'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_fotosReposicao.isEmpty)
              Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Nenhuma foto adicionada\nClique em "Adicionar Foto" para começar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _fotosReposicao.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _fotosReposicao[index],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => _removerFotoReposicao(index),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildObservacoesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Observações',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _observacoesController,
              decoration: const InputDecoration(
                labelText: 'Observações adicionais',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCondicoesPagamentoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Condições de Pagamento',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _condicoesPagamentoController,
              decoration: const InputDecoration(
                labelText: 'Condições de pagamento',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDataValidadeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Validade do Orçamento',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _selecionarDataValidade,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Data de validade',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _dataValidade != null
                      ? '${_dataValidade!.day.toString().padLeft(2, '0')}/${_dataValidade!.month.toString().padLeft(2, '0')}/${_dataValidade!.year}'
                      : 'Selecionar data',
                  style: TextStyle(
                    color: _dataValidade != null ? null : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocalSalvamentoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Local de Salvamento',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _localSalvamento,
              decoration: const InputDecoration(
                labelText: 'Selecionar local',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.folder),
              ),
              items: const [
                DropdownMenuItem(value: 'Local', child: Text('Armazenamento Local')),
                DropdownMenuItem(value: 'Nuvem', child: Text('Nuvem (Google Drive)')),
                DropdownMenuItem(value: 'Servidor', child: Text('Servidor da Empresa')),
                DropdownMenuItem(value: 'Backup', child: Text('Pasta de Backup')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _localSalvamento = value;
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              _getDescricaoLocal(_localSalvamento),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDescricaoLocal(String local) {
    switch (local) {
      case 'Local':
        return 'Salvo no dispositivo local';
      case 'Nuvem':
        return 'Sincronizado com Google Drive';
      case 'Servidor':
        return 'Armazenado no servidor da empresa';
      case 'Backup':
        return 'Cópia de segurança automática';
      default:
        return '';
    }
  }
  
  void _adicionarItem() {
    // TODO: Implementar adição de itens
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade de adicionar itens será implementada em breve'),
      ),
    );
  }
  
  Future<void> _selecionarDataValidade() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataValidade ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (data != null) {
      setState(() {
        _dataValidade = data;
      });
    }
  }
  
  Future<void> _selecionarServicos() async {
    final servicosSelecionados = await Navigator.of(context).push<List<Servico>>(
      MaterialPageRoute(
        builder: (context) => SelecionarServicosPage(
          servicosJaSelecionados: _servicosSelecionados,
        ),
      ),
    );
    
    if (servicosSelecionados != null) {
      setState(() {
        _servicosSelecionados = servicosSelecionados;
      });
    }
  }

  Future<void> _selecionarProdutos() async {
    final produtosSelecionados = await Navigator.of(context).push<List<Map<String, dynamic>>>(
      MaterialPageRoute(
        builder: (context) => SelecionarProdutosPage(
          produtosSelecionados: _produtosSelecionados,
        ),
      ),
    );
    
    if (produtosSelecionados != null) {
      setState(() {
        _produtosSelecionados = produtosSelecionados;
      });
    }
  }
  
  Future<void> _adicionarFotoDefeito() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _fotosDefeito.add(File(image.path));
      });
    }
  }
  
  Future<void> _adicionarFotoReposicao() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _fotosReposicao.add(File(image.path));
      });
    }
  }
  
  void _removerFotoDefeito(int index) {
    setState(() {
      _fotosDefeito.removeAt(index);
    });
  }
  
  void _removerFotoReposicao(int index) {
    setState(() {
      _fotosReposicao.removeAt(index);
    });
  }
  
  Future<void> _salvarOrcamento() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    if (_servicosSelecionados.isEmpty && _produtosSelecionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione pelo menos um serviço ou produto'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    
    try {
      // Converter fotos para URLs (simulação - em produção seria upload para servidor)
      final fotosDefeitoUrls = _fotosDefeito.map((foto) => foto.path).toList();
      final fotosReposicaoUrls = _fotosReposicao.map((foto) => foto.path).toList();
      
      final orcamento = Orcamento(
        id: widget.orcamentoId,
        numero: 'ORC-${DateTime.now().millisecondsSinceEpoch}',
        clienteId: 1, // TODO: Implementar seleção de cliente
        nomeCliente: _nomeClienteController.text,
        telefoneCliente: _telefoneClienteController.text,
        itens: [], // Será preenchido pelo repositório
        subtotal: 0.0, // Será calculado pelo repositório
        total: 0.0, // Será calculado pelo repositório
        dataEmissao: DateTime.now(),
        dataValidade: _dataValidade,
        observacoes: _observacoesController.text.isEmpty ? null : _observacoesController.text,
        condicoesPagamento: _condicoesPagamentoController.text.isEmpty ? null : _condicoesPagamentoController.text,
        fotosDefeitoUrls: fotosDefeitoUrls.isEmpty ? null : fotosDefeitoUrls,
        fotosReposicaoUrls: fotosReposicaoUrls.isEmpty ? null : fotosReposicaoUrls,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      final orcamentosRepository = GetIt.instance<OrcamentosRepository>();
      
      if (widget.orcamentoId == null) {
        await orcamentosRepository.criar(orcamento);
      } else {
        // TODO: Implementar atualização
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Orçamento salvo com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navegar para a página de detalhes do orçamento
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OrcamentoDetalhesPage(
              orcamento: orcamento,
              servicos: _servicosSelecionados,
              produtos: _produtosSelecionados,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar orçamento: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  @override
  void dispose() {
    _nomeClienteController.dispose();
    _emailClienteController.dispose();
    _telefoneClienteController.dispose();
    _observacoesController.dispose();
    _condicoesPagamentoController.dispose();
    super.dispose();
  }
}