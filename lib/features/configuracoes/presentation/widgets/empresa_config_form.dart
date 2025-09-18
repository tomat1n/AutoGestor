import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/empresa_config_controller.dart';
import 'tabs/dados_basicos_tab.dart';
import 'tabs/endereco_tab.dart';
import 'tabs/contatos_tab.dart';
import 'tabs/impressao_tab.dart';
import 'tabs/financeiro_tab.dart';
import 'tabs/fiscal_tab.dart';

class EmpresaConfigForm extends ConsumerStatefulWidget {
  final bool isEditMode;
  
  const EmpresaConfigForm({
    super.key,
    this.isEditMode = true,
  });

  @override
  ConsumerState<EmpresaConfigForm> createState() => _EmpresaConfigFormState();
}

class _EmpresaConfigFormState extends ConsumerState<EmpresaConfigForm>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(empresaConfigControllerProvider);
    
    return Form(
          key: _formKey,
          child: Column(
            children: [
              // Tab Bar
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey[600],
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.business, size: 20),
                      text: 'Dados Básicos',
                    ),
                    Tab(
                      icon: Icon(Icons.location_on, size: 20),
                      text: 'Endereço',
                    ),
                    Tab(
                      icon: Icon(Icons.contact_phone, size: 20),
                      text: 'Contatos',
                    ),
                    Tab(
                      icon: Icon(Icons.print, size: 20),
                      text: 'Impressão',
                    ),
                    Tab(
                      icon: Icon(Icons.account_balance, size: 20),
                      text: 'Financeiro',
                    ),
                    Tab(
                      icon: Icon(Icons.receipt_long, size: 20),
                      text: 'Fiscal',
                    ),
                  ],
                ),
              ),
              
              // Tab Views
              Expanded(
                child: Container(
                  color: Colors.grey[50],
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      DadosBasicosTab(isEditMode: widget.isEditMode),
                      EnderecoTab(isEditMode: widget.isEditMode),
                      ContatosTab(isEditMode: widget.isEditMode),
                      ImpressaoTab(isEditMode: widget.isEditMode),
                      FinanceiroTab(isEditMode: widget.isEditMode),
                      FiscalTab(isEditMode: widget.isEditMode),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }
}