import 'dart:io';

import '../../../../core/utils/platform_utils.dart';
import '../entities/whatsapp_config.dart';
import '../repositories/whatsapp_repository.dart';
import 'whatsapp_manager_service.dart';
import 'whatsapp_templates.dart';
import '../../../pdv/domain/services/pdf_service.dart';
import '../../../pdv/domain/entities/venda.dart';
import '../../../pdv/domain/entities/item_venda.dart';
import '../../../clientes/domain/entities/cliente.dart';
import '../../../clientes/domain/repositories/cliente_repository.dart';
import '../../../configuracoes/domain/entities/empresa_config.dart';
import '../../../configuracoes/data/repositories/empresa_config_repository.dart';

/// Serviço responsável por integrar o envio de PDFs via WhatsApp
class WhatsAppPdfService {
  final WhatsAppManagerService _whatsappManager;
  final WhatsAppRepository _whatsappRepository;
  final PdfService _pdfService;
  final ClienteRepository _clienteRepository;
  final EmpresaConfigRepository _empresaConfigRepository;

  WhatsAppPdfService(
    this._whatsappManager,
    this._whatsappRepository,
    this._pdfService,
    this._clienteRepository,
    this._empresaConfigRepository,
  );

  /// Envia recibo de venda via WhatsApp
  Future<bool> enviarReciboVenda({
    required Venda venda,
    required String telefoneCliente,
    List<ItemVenda>? itensVenda,
    bool formatoTermico = false,
    String? nomeCliente,
  }) async {
    try {
      // Verificar se o WhatsApp está configurado
      final config = await _whatsappRepository.buscarConfiguracoes();
      if (config == null || !config.ativo) {
        throw Exception('WhatsApp não está configurado ou ativo');
      }

      // Gerar PDF do recibo
      final File pdfFile;
      if (formatoTermico) {
        pdfFile = await _pdfService.gerarReciboTermico(venda, itensVenda);
      } else {
        pdfFile = await _pdfService.gerarReciboA4(venda, itensVenda);
      }

      // Buscar configurações da empresa
      final empresaConfig = await _empresaConfigRepository.buscarConfiguracoes();
      final nomeEmpresa = empresaConfig?.nomeFantasia ?? 'AutoGestor';

      // Preparar mensagem de acompanhamento
      final mensagem = WhatsAppTemplates.reciboVenda(
        nomeCliente: nomeCliente ?? 'Cliente',
        numeroVenda: venda.id?.toString() ?? 'N/A',
        valorTotal: venda.total,
        formaPagamento: venda.formaPagamento,
        nomeEmpresa: nomeEmpresa,
      );

      // Enviar PDF via WhatsApp
      final sucesso = await _whatsappManager.enviarArquivo(
        telefone: telefoneCliente,
        arquivo: pdfFile,
        mensagem: mensagem,
      );

      // Limpar arquivo temporário
      try {
        await pdfFile.delete();
      } catch (e) {
        // Ignorar erro de limpeza
      }

      return sucesso;
    } catch (e) {
      print('Erro ao enviar recibo via WhatsApp: $e');
      return false;
    }
  }

  /// Envia orçamento de serviços via WhatsApp
  Future<bool> enviarOrcamentoServicos({
    required String telefoneCliente,
    required List<OrcamentoItem> itens,
    required double valorTotal,
    String? nomeCliente,
    String? observacoes,
    DateTime? validadeOrcamento,
  }) async {
    try {
      // Verificar se o WhatsApp está configurado
      final config = await _whatsappRepository.buscarConfiguracoes();
      if (config == null || !config.ativo) {
        throw Exception('WhatsApp não está configurado ou ativo');
      }

      // Buscar configurações da empresa
      final empresaConfig = await _empresaConfigRepository.buscarConfiguracoes();
      final nomeEmpresa = empresaConfig?.nomeFantasia ?? 'AutoGestor';

      // Gerar PDF do orçamento
      final pdfFile = await _gerarPdfOrcamento(
        itens: itens,
        valorTotal: valorTotal,
        nomeCliente: nomeCliente,
        observacoes: observacoes,
        validadeOrcamento: validadeOrcamento,
        empresaConfig: empresaConfig,
      );

      // Preparar mensagem de acompanhamento
      final mensagem = WhatsAppTemplates.orcamentoServicos(
        nomeCliente: nomeCliente ?? 'Cliente',
        valorTotal: valorTotal,
        validadeOrcamento: validadeOrcamento ?? DateTime.now().add(const Duration(days: 15)),
        nomeEmpresa: nomeEmpresa,
      );

      // Enviar PDF via WhatsApp
      final sucesso = await _whatsappManager.enviarArquivo(
        telefone: telefoneCliente,
        arquivo: pdfFile,
        mensagem: mensagem,
      );

      // Limpar arquivo temporário
      try {
        await pdfFile.delete();
      } catch (e) {
        // Ignorar erro de limpeza
      }

      return sucesso;
    } catch (e) {
      print('Erro ao enviar orçamento via WhatsApp: $e');
      return false;
    }
  }

  /// Envia recibo com opções personalizadas
  Future<bool> enviarReciboPersonalizado({
    required String telefoneCliente,
    required File arquivoPdf,
    required String mensagem,
  }) async {
    try {
      // Verificar se o WhatsApp está configurado
      final config = await _whatsappRepository.buscarConfiguracoes();
      if (config == null || !config.ativo) {
        throw Exception('WhatsApp não está configurado ou ativo');
      }

      // Enviar arquivo via WhatsApp
      return await _whatsappManager.enviarArquivo(
        telefone: telefoneCliente,
        arquivo: arquivoPdf,
        mensagem: mensagem,
      );
    } catch (e) {
      print('Erro ao enviar recibo personalizado via WhatsApp: $e');
      return false;
    }
  }

  /// Gera PDF do orçamento
  Future<File> _gerarPdfOrcamento({
    required List<OrcamentoItem> itens,
    required double valorTotal,
    String? nomeCliente,
    String? observacoes,
    DateTime? validadeOrcamento,
    EmpresaConfig? empresaConfig,
  }) async {
    // Implementação da geração de PDF do orçamento
    // Por enquanto, vamos usar uma implementação básica
    // que pode ser expandida posteriormente
    
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Cabeçalho da empresa
              _buildCabecalhoOrcamento(empresaConfig),
              pw.SizedBox(height: 30),
              
              // Informações do orçamento
              _buildInfoOrcamento(nomeCliente, validadeOrcamento),
              pw.SizedBox(height: 20),
              
              // Tabela de itens
              _buildTabelaItensOrcamento(itens),
              pw.SizedBox(height: 20),
              
              // Total
              _buildTotalOrcamento(valorTotal),
              pw.SizedBox(height: 20),
              
              // Observações
              if (observacoes?.isNotEmpty == true)
                _buildObservacoesOrcamento(observacoes!),
              
              pw.Spacer(),
              
              // Rodapé
              _buildRodapeOrcamento(empresaConfig),
            ],
          );
        },
      ),
    );
    
    // Salvar PDF temporário
    final directory = Directory.systemTemp;
    final file = File('${directory.path}/orcamento_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(await pdf.save());
    
    return file;
  }

  pw.Widget _buildCabecalhoOrcamento(EmpresaConfig? empresaConfig) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        border: pw.Border.all(color: PdfColors.blue200),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            empresaConfig?.nomeFantasia ?? 'AutoGestor',
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue800,
            ),
          ),
          if (empresaConfig?.endereco?.isNotEmpty == true) ...[
            pw.SizedBox(height: 8),
            pw.Text(
              empresaConfig!.endereco!,
              style: const pw.TextStyle(fontSize: 12),
            ),
          ],
          if (empresaConfig?.telefone?.isNotEmpty == true) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              'Tel: ${empresaConfig!.telefone}',
              style: const pw.TextStyle(fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  pw.Widget _buildInfoOrcamento(String? nomeCliente, DateTime? validadeOrcamento) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'ORÇAMENTO DE SERVIÇOS',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 12),
          if (nomeCliente?.isNotEmpty == true)
            pw.Text('Cliente: $nomeCliente'),
          pw.Text('Data: ${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}'),
          if (validadeOrcamento != null)
            pw.Text('Válido até: ${validadeOrcamento.day.toString().padLeft(2, '0')}/${validadeOrcamento.month.toString().padLeft(2, '0')}/${validadeOrcamento.year}'),
        ],
      ),
    );
  }

  pw.Widget _buildTabelaItensOrcamento(List<OrcamentoItem> itens) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400),
      children: [
        // Cabeçalho
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text('Serviço', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text('Descrição', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text('Valor', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
          ],
        ),
        // Itens
        ...itens.map((item) => pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(item.nome),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(item.descricao ?? ''),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text('R\$ ${item.valor.toStringAsFixed(2)}'),
            ),
          ],
        )),
      ],
    );
  }

  pw.Widget _buildTotalOrcamento(double valorTotal) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'VALOR TOTAL:',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            'R\$ ${valorTotal.toStringAsFixed(2)}',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green800,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildObservacoesOrcamento(String observacoes) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Observações:',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Text(observacoes),
        ],
      ),
    );
  }

  pw.Widget _buildRodapeOrcamento(EmpresaConfig? empresaConfig) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(16),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(color: PdfColors.grey400),
        ),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'Este orçamento tem validade de 15 dias.',
            style: const pw.TextStyle(fontSize: 10),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Obrigado pela preferência!',
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Classe para representar um item do orçamento
class OrcamentoItem {
  final String nome;
  final String? descricao;
  final double valor;
  final int? duracaoMinutos;

  const OrcamentoItem({
    required this.nome,
    this.descricao,
    required this.valor,
    this.duracaoMinutos,
  });

  factory OrcamentoItem.fromServico(dynamic servico) {
    return OrcamentoItem(
      nome: servico.nome,
      descricao: servico.descricao,
      valor: servico.valor,
      duracaoMinutos: servico.duracaoMinutos,
    );
  }
}