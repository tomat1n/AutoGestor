import 'dart:typed_data';
import '../../../../core/utils/platform_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:drift/drift.dart' as drift;
import '../../../../core/database/database.dart';
import '../providers/estoque_provider.dart';
import '../../domain/enums/categoria_produto.dart';

class ProdutoFormPage extends ConsumerStatefulWidget {
  final ProdutoTableData? produto;

  const ProdutoFormPage({super.key, this.produto});

  @override
  ConsumerState<ProdutoFormPage> createState() => _ProdutoFormPageState();
}

class _ProdutoFormPageState extends ConsumerState<ProdutoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _codigoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoCompraController = TextEditingController();
  final _precoVendaController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _estoqueMinimoController = TextEditingController();
  final _unidadeController = TextEditingController();
  CategoriaProduto? _categoriaSelecionada;
  final _codigoBarrasController = TextEditingController();
  final _qrCodeController = TextEditingController();

  Uint8List? _imagemBytes;
  String? _imagemPath;
  bool _ativo = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.produto != null) {
      _preencherFormulario();
    }
  }

  void _preencherFormulario() {
    final produto = widget.produto!;
    _codigoController.text = produto.codigo;
    _nomeController.text = produto.nome;
    _descricaoController.text = produto.descricao ?? '';
    _precoCompraController.text = produto.precoCompra.toString();
    _precoVendaController.text = produto.precoVenda.toString();
    _quantidadeController.text = produto.quantidade.toString();
    _estoqueMinimoController.text = produto.estoqueMinimo.toString();
    _unidadeController.text = produto.unidade;
    _categoriaSelecionada = produto.categoria != null 
        ? CategoriaProduto.fromNome(produto.categoria!) ?? CategoriaProduto.outros
        : null;
    _codigoBarrasController.text = produto.codigoBarras ?? '';
    _qrCodeController.text = produto.qrCode ?? '';
    _imagemPath = produto.imagemPath;
    _ativo = produto.ativo;
  }

  @override
  void dispose() {
    _codigoController.dispose();
    _nomeController.dispose();
    _descricaoController.dispose();
    _precoCompraController.dispose();
    _precoVendaController.dispose();
    _quantidadeController.dispose();
    _estoqueMinimoController.dispose();
    _unidadeController.dispose();

    _codigoBarrasController.dispose();
    _qrCodeController.dispose();
    super.dispose();
  }

  Future<void> _selecionarImagem() async {
    // Verificar se está rodando na web
    if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      try {
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 800,
          maxHeight: 600,
          imageQuality: 80,
        );
        if (image != null) {
          await _processarImagem(image);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao selecionar imagem: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
      return;
    }
    
    final ImagePicker picker = ImagePicker();
    
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Câmera'),
                onTap: () async {
                  Navigator.pop(context);
                  try {
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 800,
                      maxHeight: 600,
                      imageQuality: 80,
                    );
                    if (image != null) {
                      await _processarImagem(image);
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao acessar câmera: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria'),
                onTap: () async {
                  Navigator.pop(context);
                  try {
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 800,
                      maxHeight: 600,
                      imageQuality: 80,
                    );
                    if (image != null) {
                      await _processarImagem(image);
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao acessar galeria: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _processarImagem(XFile image) async {
    try {
      final bytes = await image.readAsBytes();
      setState(() {
        _imagemBytes = bytes;
        _imagemPath = image.name; // Para web, usamos o nome do arquivo
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao processar imagem: $e')),
        );
      }
    }
  }



  void _abrirScanner(bool isQrCode) {
    // Verificar se está rodando na web
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Scanner não disponível na versão web'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScannerPage(
          isQrCode: isQrCode,
          onCodeScanned: (code) {
            setState(() {
              if (isQrCode) {
                _qrCodeController.text = code;
              } else {
                _codigoBarrasController.text = code;
              }
            });
          },
        ),
      ),
    );
  }

  Future<void> _salvarProduto() async {
    if (!_formKey.currentState!.validate()) return;

    print('Form: Iniciando salvamento do produto');
    setState(() {
      _isLoading = true;
    });

    try {
      final produto = ProdutoTableCompanion(
        id: widget.produto != null ? drift.Value(widget.produto!.id) : const drift.Value.absent(),
        codigo: drift.Value(_codigoController.text),
        nome: drift.Value(_nomeController.text),
        descricao: drift.Value(_descricaoController.text.isEmpty ? null : _descricaoController.text),
        precoCompra: drift.Value(double.tryParse(_precoCompraController.text) ?? 0.0),
        precoVenda: drift.Value(double.tryParse(_precoVendaController.text) ?? 0.0),
        quantidade: drift.Value(int.tryParse(_quantidadeController.text) ?? 0),
        estoqueMinimo: drift.Value(int.parse(_estoqueMinimoController.text)),
        unidade: drift.Value(_unidadeController.text),
        categoria: drift.Value(_categoriaSelecionada?.nome),
        codigoBarras: drift.Value(_codigoBarrasController.text.isEmpty ? null : _codigoBarrasController.text),
        qrCode: drift.Value(_qrCodeController.text.isEmpty ? null : _qrCodeController.text),
        imagemPath: drift.Value(_imagemPath),
        ativo: drift.Value(_ativo),
      );

      print('Form: Produto criado - Nome: ${produto.nome.value}, Código: ${produto.codigo.value}');

      if (widget.produto != null) {
        print('Form: Atualizando produto existente ID: ${widget.produto!.id}');
        await ref.read(produtosProvider.notifier).atualizarProduto(widget.produto!.id, produto);
      } else {
        print('Form: Adicionando novo produto');
        final produtoId = await ref.read(produtosProvider.notifier).adicionarProduto(produto);
        
        // Quantidade inicial será definida diretamente no produto
      }

      // Invalidar todos os providers relacionados para atualizar as listas
      ref.invalidate(produtosAtivosProvider);
      ref.invalidate(produtosEstoqueBaixoProvider);
      ref.invalidate(buscaProdutosProvider);
      ref.invalidate(categoriasProvider);
      // Invalidar providers com estoque para atualizar o PDV
      ref.invalidate(produtosComEstoqueProvider);
      ref.invalidate(produtosAtivosComEstoqueProvider);
      ref.invalidate(produtosEstoqueBaixoComEstoqueProvider);

      print('Form: Produto salvo com sucesso!');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.produto != null ? 'Produto atualizado com sucesso!' : 'Produto criado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      print('Form: Erro ao salvar produto: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar produto: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produto != null ? 'Editar Produto' : 'Novo Produto'),
        actions: [
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            TextButton(
              onPressed: _salvarProduto,
              child: const Text('Salvar'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Imagem do produto
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Imagem do Produto', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Center(
                      child: GestureDetector(
                        onTap: _selecionarImagem,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _imagemBytes != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    _imagemBytes!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : _imagemPath != null && !kIsWeb
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: const Icon(
                                        Icons.image,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                                        Text('Adicionar Foto', style: TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Informações básicas
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Informações Básicas', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _codigoController,
                      decoration: const InputDecoration(
                        labelText: 'Código *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descricaoController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<CategoriaProduto>(
                      initialValue: _categoriaSelecionada,
                      decoration: const InputDecoration(
                        labelText: 'Categoria',
                        border: OutlineInputBorder(),
                      ),
                      items: CategoriaProduto.values.map((categoria) {
                        return DropdownMenuItem<CategoriaProduto>(
                          value: categoria,
                          child: Row(
                            children: [
                              Icon(categoria.icone, size: 20),
                              const SizedBox(width: 8),
                              Text(categoria.nome),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (CategoriaProduto? value) {
                        setState(() {
                          _categoriaSelecionada = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Preço e estoque
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Preço e Estoque', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _precoCompraController,
                            decoration: const InputDecoration(
                              labelText: 'Preço de Compra',
                              border: OutlineInputBorder(),
                              prefixText: 'R\$ ',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                                return 'Valor inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _precoVendaController,
                            decoration: const InputDecoration(
                              labelText: 'Preço de Venda *',
                              border: OutlineInputBorder(),
                              prefixText: 'R\$ ',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Valor inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _unidadeController,
                            decoration: const InputDecoration(
                              labelText: 'Unidade',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(child: SizedBox()), // Espaço vazio para manter alinhamento
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _quantidadeController,
                            decoration: const InputDecoration(
                              labelText: 'Quantidade *',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Valor inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _estoqueMinimoController,
                            decoration: const InputDecoration(
                              labelText: 'Estoque Mínimo *',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Valor inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Códigos de barras e QR
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Códigos de Identificação', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _codigoBarrasController,
                      decoration: InputDecoration(
                        labelText: 'Código de Barras',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.qr_code_scanner),
                          onPressed: () => _abrirScanner(false),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _qrCodeController,
                      decoration: InputDecoration(
                        labelText: 'QR Code',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.qr_code_2),
                          onPressed: () => _abrirScanner(true),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                    SwitchListTile(
                      title: const Text('Produto Ativo'),
                      value: _ativo,
                      onChanged: (value) {
                        setState(() {
                          _ativo = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannerPage extends StatefulWidget {
  final bool isQrCode;
  final Function(String) onCodeScanned;

  const ScannerPage({
    super.key,
    required this.isQrCode,
    required this.onCodeScanned,
  });

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isQrCode ? 'Escanear QR Code' : 'Escanear Código de Barras'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: _foundBarcode,
      ),
    );
  }

  void _foundBarcode(BarcodeCapture capture) {
    if (!_screenOpened && capture.barcodes.isNotEmpty) {
      final String code = capture.barcodes.first.rawValue ?? "";
      _screenOpened = true;
      widget.onCodeScanned(code);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}