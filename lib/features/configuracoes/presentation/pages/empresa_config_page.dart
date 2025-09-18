import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/empresa_config_controller.dart';
import '../widgets/empresa_config_form.dart';
import '../../../../core/widgets/loading_overlay.dart';

class EmpresaConfigPage extends ConsumerStatefulWidget {
  const EmpresaConfigPage({super.key});

  @override
  ConsumerState<EmpresaConfigPage> createState() => _EmpresaConfigPageState();
}

class _EmpresaConfigPageState extends ConsumerState<EmpresaConfigPage> {
  bool _isEditMode = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(empresaConfigControllerProvider.notifier).carregarConfiguracoes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(empresaConfigControllerProvider);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Configurações da Empresa',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey[200],
           ),
         ),
        actions: [
          PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                onSelected: (value) async {
                  switch (value) {
                    case 'reset':
                      _showResetDialog(context);
                      break;
                    case 'export':
                      _showExportDialog(context);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'reset',
                    child: Row(
                      children: [
                        Icon(Icons.refresh, size: 20),
                        SizedBox(width: 12),
                        Text('Resetar Configurações'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'export',
                    child: Row(
                      children: [
                        Icon(Icons.download, size: 20),
                        SizedBox(width: 12),
                        Text('Exportar Dados'),
                      ],
                    ),
                  ),
                ],
              ),
        ],
      ),
      body: controller.when(
         loading: () => const Center(child: CircularProgressIndicator()),
         error: (error, stack) => Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
               const SizedBox(height: 16),
               Text('Erro ao carregar configurações', style: Theme.of(context).textTheme.headlineSmall),
               const SizedBox(height: 8),
               Text(error.toString(), textAlign: TextAlign.center),
               const SizedBox(height: 16),
               ElevatedButton(
                 onPressed: () => ref.read(empresaConfigControllerProvider.notifier).carregarConfiguracoes(),
                 child: const Text('Tentar Novamente'),
               ),
             ],
           ),
         ),
         data: (config) => Column(
           children: [
                // Header com informações
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.business,
                              color: Theme.of(context).primaryColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  config != null 
                                      ? 'Empresa Configurada' 
                                      : 'Configure sua Empresa',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  config != null
                                      ? 'Dados da empresa salvos e prontos para uso'
                                      : 'Preencha os dados da sua empresa para personalizar recibos e documentos',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (config != null) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green[600],
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      config.nomeEmpresa,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'CPF/CNPJ: ${config.documento}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                // Formulário
                Expanded(
                  child: EmpresaConfigForm(isEditMode: config == null || _isEditMode),
                ),
                
                // Botões de ação
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      if (controller.error != null) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red[600],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  controller.error.toString(),
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      
                      Row(
                        children: [
                          // Botão Resetar (sempre visível quando há configuração)
                          if (config != null) ...[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _isSaving ? null : () => _mostrarDialogoResetar(context),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: _isSaving ? Colors.grey : Colors.orange[600],
                                  side: BorderSide(color: _isSaving ? Colors.grey : Colors.orange[600]!),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.refresh, size: 18),
                                    SizedBox(width: 8),
                                    Text(
                                      'Resetar',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          
                          // Botão Editar/Cancelar (quando há configuração)
                          if (config != null) ...[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _isSaving ? null : () {
                                  setState(() {
                                    _isEditMode = !_isEditMode;
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  side: BorderSide(
                                    color: _isEditMode ? Colors.orange[300]! : Theme.of(context).primaryColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _isEditMode ? Icons.close : Icons.edit,
                                      size: 18,
                                      color: _isEditMode ? Colors.orange[600] : Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      _isEditMode ? 'Cancelar' : 'Editar',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: _isEditMode ? Colors.orange[600] : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          
                          // Botão Salvar/Atualizar
                          Expanded(
                            flex: config != null ? 1 : 1,
                            child: ElevatedButton(
                              onPressed: (config == null || _isEditMode) && !_isSaving
                                  ? () => _salvarConfiguracao(context)
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isSaving ? Theme.of(context).primaryColor.withOpacity(0.7) : Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: _isSaving ? 0 : 2,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _isSaving 
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : const Icon(Icons.save, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    _isSaving ? 'Salvando...' : (config != null ? 'Atualizar' : 'Salvar'),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _mostrarDialogoResetar(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.orange[600]),
              const SizedBox(width: 8),
              const Text('Confirmar Reset'),
            ],
          ),
          content: const Text(
            'Tem certeza que deseja resetar todas as configurações? Esta ação não pode ser desfeita.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[600],
                foregroundColor: Colors.white,
              ),
              child: const Text('Resetar'),
            ),
          ],
        );
      },
    );

    if (result == true && context.mounted) {
      ref.read(empresaConfigControllerProvider.notifier).resetarConfiguracoes();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.refresh, color: Colors.white),
              SizedBox(width: 8),
              Text('Configurações resetadas com sucesso!'),
            ],
          ),
          backgroundColor: Colors.orange[600],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      
      // Sair do modo de edição após resetar
      setState(() {
        _isEditMode = false;
      });
    }
  }

  Future<void> _salvarConfiguracao(
    BuildContext context,
  ) async {
    setState(() {
      _isSaving = true;
    });
    
    try {
      // Validar se há dados suficientes antes de salvar
      final currentConfig = ref.read(empresaConfigControllerProvider).value;
      
      if (currentConfig == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.error, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Preencha os dados básicos antes de salvar!'),
                ],
              ),
              backgroundColor: Colors.red[600],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
        return;
      }
      
      // Validar campos obrigatórios
      if (currentConfig.nomeEmpresa.isEmpty || 
          currentConfig.documento.isEmpty ||
          currentConfig.endereco.isEmpty ||
          currentConfig.numero.isEmpty ||
          currentConfig.bairro.isEmpty ||
          currentConfig.cidade.isEmpty ||
          currentConfig.estado.isEmpty ||
          currentConfig.cep.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.error, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Preencha todos os campos obrigatórios!'),
                ],
              ),
              backgroundColor: Colors.red[600],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
        return;
      }
      
      // Salvar as configurações atuais
      final success = await ref.read(empresaConfigControllerProvider.notifier).salvarConfiguracaoAtual();
      
      if (context.mounted) {
         // Mostrar confirmação visual animada
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content: Row(
               children: [
                 Container(
                   padding: const EdgeInsets.all(4),
                   decoration: BoxDecoration(
                     color: Colors.white.withOpacity(0.2),
                     shape: BoxShape.circle,
                   ),
                   child: const Icon(
                     Icons.check_circle,
                     color: Colors.white,
                     size: 20,
                   ),
                 ),
                 const SizedBox(width: 12),
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       const Text(
                         'Configuração salva!',
                         style: TextStyle(
                           fontWeight: FontWeight.w600,
                           fontSize: 16,
                         ),
                       ),
                       Text(
                         'Todas as alterações foram aplicadas com sucesso.',
                         style: TextStyle(
                           fontSize: 12,
                           color: Colors.white.withOpacity(0.9),
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
             backgroundColor: Colors.green[600],
             behavior: SnackBarBehavior.floating,
             margin: const EdgeInsets.all(16),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(12),
             ),
             elevation: 6,
             duration: const Duration(seconds: 4),
             action: SnackBarAction(
               label: 'OK',
               textColor: Colors.white,
               onPressed: () {
                 ScaffoldMessenger.of(context).hideCurrentSnackBar();
               },
             ),
           ),
         );
         
         // Sair do modo de edição após salvar
         setState(() {
           _isEditMode = false;
         });
       }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _showResetDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.orange),
            SizedBox(width: 8),
            Text('Resetar Configurações'),
          ],
        ),
        content: const Text(
          'Tem certeza que deseja resetar todas as configurações da empresa? '
          'Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(empresaConfigControllerProvider.notifier).resetarConfiguracoes();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Configurações resetadas com sucesso!'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Resetar'),
          ),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.info, color: Colors.blue),
            SizedBox(width: 8),
            Text('Exportar Dados'),
          ],
        ),
        content: const Text(
          'Funcionalidade de exportação será implementada em breve.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}