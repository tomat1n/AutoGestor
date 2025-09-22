import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import '../../domain/entities/venda.dart';
import '../../domain/entities/item_venda.dart';
import '../../../configuracoes/domain/entities/empresa_config.dart';
import '../../../../core/utils/platform_utils.dart';

class PdfService {
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy HH:mm');
  
  PdfService();

  /// Gera um recibo em PDF com dados básicos
  Future<Uint8List> gerarReciboPdf(Venda venda, List<ItemVenda> itens, EmpresaConfig? config) async {
    if (!PlatformUtils.canUsePdfGeneration) {
      throw UnsupportedError('Geração de PDF na web ainda não implementada');
    }
    
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Cabeçalho da empresa
              if (config != null) ...[
                pw.Text(
                  config.nomeEmpresa,
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
                if (config.documento.isNotEmpty)
                  pw.Text('CNPJ: ${config.documento}'),
                if (config.endereco.isNotEmpty)
                  pw.Text('Endereço: ${config.endereco}'),
                if (config.telefone?.isNotEmpty == true)
                  pw.Text('Telefone: ${config.telefone}'),
                pw.SizedBox(height: 20),
              ],
              
              // Título
              pw.Text(
                'RECIBO DE VENDA',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              
              // Informações da venda
              pw.Text('Venda #${venda.id}'),
              pw.Text('Data: ${_dateFormat.format(venda.dataVenda)}'),
              pw.Text('Cliente: ${venda.nomeCliente ?? 'Cliente não informado'}'),
              pw.SizedBox(height: 20),
              
              // Tabela de itens
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Cabeçalho
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Produto', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Qtd', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Preço Unit.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  // Itens
                  ...itens.map((item) => pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(_buildDescricaoProduto(item)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(item.quantidade.toString()),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(_currencyFormat.format(item.precoUnitario)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(_currencyFormat.format(item.subtotal)),
                      ),
                    ],
                  )),
                ],
              ),
              
              pw.SizedBox(height: 20),
              
              // Total
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'TOTAL: ${_currencyFormat.format(venda.total)}',
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ),
    );
    
    return pdf.save();
  }

  /// Gera um recibo em formato A4
  Future<Uint8List> gerarReciboA4(Venda venda, [List<ItemVenda>? itensVenda]) async {
    if (!PlatformUtils.canUsePdfGeneration) {
      throw UnsupportedError('Geração de PDF na web ainda não implementada');
    }
    
    final itens = itensVenda ?? <ItemVenda>[];
    
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
              _buildCabecalhoA4(null),
              pw.SizedBox(height: 30),
              
              // Informações da venda
              _buildInfoVendaA4(venda),
              pw.SizedBox(height: 20),
              
              // Tabela de itens
              _buildTabelaItensA4(itens),
              pw.SizedBox(height: 20),
              
              // Totais
              _buildTotaisA4(venda),
              pw.SizedBox(height: 30),
              
              // Observações
              if (venda.observacoes?.isNotEmpty == true)
                _buildObservacoesA4(venda.observacoes!),
              
              pw.Spacer(),
              
              // Rodapé
              _buildRodapeA4(null),
            ],
          );
        },
      ),
    );
    
    return pdf.save();
  }

  /// Gera um recibo em formato térmico 58mm
  Future<Uint8List> gerarReciboTermico(Venda venda, [List<ItemVenda>? itensVenda]) async {
    if (!PlatformUtils.canUsePdfGeneration) {
      throw UnsupportedError('Geração de PDF na web ainda não implementada');
    }
    
    final itens = itensVenda ?? <ItemVenda>[];
    
    const double mmToPt = 72.0 / 25.4;
    const double width = 58 * mmToPt; // 58mm de largura
    
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(width, double.infinity),
        margin: const pw.EdgeInsets.all(8),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Cabeçalho da empresa
              _buildCabecalhoTermico(null),
              pw.SizedBox(height: 10),
              
              // Linha separadora
              _buildLinhaSeparadora(),
              pw.SizedBox(height: 8),
              
              // Informações da venda
              _buildInfoVendaTermico(venda),
              pw.SizedBox(height: 8),
              
              // Linha separadora
              _buildLinhaSeparadora(),
              pw.SizedBox(height: 8),
              
              // Lista de itens
              _buildItensTermico(itens),
              pw.SizedBox(height: 8),
              
              // Linha separadora
              _buildLinhaSeparadora(),
              pw.SizedBox(height: 8),
              
              // Totais
              _buildTotaisTermico(venda),
              pw.SizedBox(height: 8),
              
              // Observações
              if (venda.observacoes?.isNotEmpty == true) ...[
                _buildLinhaSeparadora(),
                pw.SizedBox(height: 8),
                _buildObservacoesTermico(venda.observacoes!),
                pw.SizedBox(height: 8),
              ],
              
              // Linha separadora
              _buildLinhaSeparadora(),
              pw.SizedBox(height: 8),
              
              // Rodapé
              _buildRodapeTermico(null),
            ],
          );
        },
      ),
    );
    
    return pdf.save();
  }

  // Métodos para formato A4
  pw.Widget _buildCabecalhoA4(EmpresaConfig? empresaConfig) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          empresaConfig?.nomeEmpresa ?? 'AUTOGESTOR',
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          'Sistema de Gestão Empresarial',
          style: const pw.TextStyle(fontSize: 14),
        ),
        pw.SizedBox(height: 4),
        if (empresaConfig?.documento.isNotEmpty == true || empresaConfig?.telefone?.isNotEmpty == true)
          pw.Text(
            '${empresaConfig?.documento.isNotEmpty == true ? "CNPJ: ${empresaConfig!.documento}" : ""}'
            '${empresaConfig?.documento.isNotEmpty == true && empresaConfig?.telefone?.isNotEmpty == true ? " | " : ""}'  
            '${empresaConfig?.telefone?.isNotEmpty == true ? "Telefone: ${empresaConfig!.telefone}" : ""}',
            style: const pw.TextStyle(fontSize: 12),
          ),
        if (empresaConfig?.endereco?.isNotEmpty == true) ...[
          pw.SizedBox(height: 4),
          pw.Text(
            'Endereço: ${empresaConfig!.endereco}',
            style: const pw.TextStyle(fontSize: 12),
          ),
        ],
      ],
    );
  }

  pw.Widget _buildInfoVendaA4(Venda venda) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'RECIBO DE VENDA',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text('Venda Nº: ${venda.id}'),
              pw.Text('Data: ${_dateFormat.format(venda.dataVenda)}'),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'Forma de Pagamento:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(venda.formaPagamento),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildTabelaItensA4(List<ItemVenda> itens) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400),
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(1),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(2),
      },
      children: [
        // Cabeçalho
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _buildCelulaTabelaA4('Produto', true),
            _buildCelulaTabelaA4('Qtd', true),
            _buildCelulaTabelaA4('Preço Unit.', true),
            _buildCelulaTabelaA4('Subtotal', true),
          ],
        ),
        // Itens
        ...itens.map((ItemVenda item) => pw.TableRow(
          children: [
            _buildCelulaTabelaA4(_buildDescricaoProduto(item), false),
            _buildCelulaTabelaA4(item.quantidade.toStringAsFixed(0), false),
            _buildCelulaTabelaA4(_currencyFormat.format(item.precoUnitario), false),
            _buildCelulaTabelaA4(_currencyFormat.format(item.subtotal), false),
          ],
        )),
      ],
    );
  }

  pw.Widget _buildCelulaTabelaA4(String texto, bool isCabecalho) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        texto,
        style: pw.TextStyle(
          fontWeight: isCabecalho ? pw.FontWeight.bold : pw.FontWeight.normal,
          fontSize: isCabecalho ? 12 : 10,
        ),
      ),
    );
  }

  pw.Widget _buildTotaisA4(Venda venda) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Subtotal:'),
              pw.Text(_currencyFormat.format(venda.subtotal)),
            ],
          ),
          if (venda.desconto > 0) ...[
            pw.SizedBox(height: 4),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Desconto:'),
                pw.Text('- ${_currencyFormat.format(venda.desconto)}'),
              ],
            ),
          ],
          pw.SizedBox(height: 8),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 8),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(color: PdfColors.grey400, width: 2),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'TOTAL:',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  _currencyFormat.format(venda.total),
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildObservacoesA4(String observacoes) {
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

  pw.Widget _buildRodapeA4(EmpresaConfig? empresaConfig) {
    return pw.Column(
      children: [
        pw.Container(
          height: 1,
          color: PdfColors.grey400,
        ),
        pw.SizedBox(height: 16),
        pw.Text(
          empresaConfig?.mensagemRodape ?? 'Obrigado pela preferência!',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
          textAlign: pw.TextAlign.center,
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          'Este documento foi gerado automaticamente pelo ${empresaConfig?.nomeEmpresa ?? "AutoGestor"}',
          style: const pw.TextStyle(fontSize: 10),
          textAlign: pw.TextAlign.center,
        ),
        pw.Text(
          'Gerado em: ${_dateFormat.format(DateTime.now())}',
          style: const pw.TextStyle(fontSize: 10),
          textAlign: pw.TextAlign.center,
        ),
      ],
    );
  }

  // Métodos para formato térmico
  pw.Widget _buildCabecalhoTermico(EmpresaConfig? empresaConfig) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          empresaConfig?.nomeEmpresa ?? 'AUTOGESTOR',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
          textAlign: pw.TextAlign.center,
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Sistema de Gestão',
          style: const pw.TextStyle(fontSize: 10),
          textAlign: pw.TextAlign.center,
        ),
        if (empresaConfig?.documento.isNotEmpty == true)
          pw.Text(
            'CNPJ: ${empresaConfig!.documento}',
            style: const pw.TextStyle(fontSize: 8),
            textAlign: pw.TextAlign.center,
          ),
        if (empresaConfig?.telefone?.isNotEmpty == true)
          pw.Text(
            'Tel: ${empresaConfig!.telefone}',
            style: const pw.TextStyle(fontSize: 8),
            textAlign: pw.TextAlign.center,
          ),
        if (empresaConfig?.endereco.isNotEmpty == true)
          pw.Text(
            empresaConfig!.endereco,
            style: const pw.TextStyle(fontSize: 8),
            textAlign: pw.TextAlign.center,
          ),
      ],
    );
  }

  pw.Widget _buildLinhaSeparadora() {
    return pw.Container(
      height: 1,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.black,
            style: pw.BorderStyle.dashed,
          ),
        ),
      ),
    );
  }

  pw.Widget _buildInfoVendaTermico(Venda venda) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'RECIBO DE VENDA',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
          textAlign: pw.TextAlign.center,
        ),
        pw.SizedBox(height: 6),
        pw.Text('Venda: ${venda.id}', style: const pw.TextStyle(fontSize: 10)),
        pw.Text('Data: ${_dateFormat.format(venda.dataVenda)}', style: const pw.TextStyle(fontSize: 10)),
        pw.Text('Pagto: ${venda.formaPagamento}', style: const pw.TextStyle(fontSize: 10)),
      ],
    );
  }

  pw.Widget _buildItensTermico(List<ItemVenda> itens) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: itens.map((ItemVenda item) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              _buildDescricaoProduto(item),
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  '${item.quantidade.toStringAsFixed(0)} x ${_currencyFormat.format(item.precoUnitario)}',
                  style: const pw.TextStyle(fontSize: 9),
                ),
                pw.Text(
                  _currencyFormat.format(item.subtotal),
                  style: const pw.TextStyle(fontSize: 9),
                ),
              ],
            ),
            pw.SizedBox(height: 4),
          ],
        );
      }).toList().cast<pw.Widget>(),
    );
  }

  pw.Widget _buildTotaisTermico(Venda venda) {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Subtotal:', style: const pw.TextStyle(fontSize: 10)),
            pw.Text(_currencyFormat.format(venda.subtotal), style: const pw.TextStyle(fontSize: 10)),
          ],
        ),
        if (venda.desconto > 0) ...[
          pw.SizedBox(height: 2),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Desconto:', style: const pw.TextStyle(fontSize: 10)),
              pw.Text('- ${_currencyFormat.format(venda.desconto)}', style: const pw.TextStyle(fontSize: 10)),
            ],
          ),
        ],
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'TOTAL:',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              _currencyFormat.format(venda.total),
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildObservacoesTermico(String observacoes) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Obs:',
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          observacoes,
          style: const pw.TextStyle(fontSize: 9),
        ),
      ],
    );
  }

  pw.Widget _buildRodapeTermico(EmpresaConfig? empresaConfig) {
    return pw.Column(
      children: [
        pw.Text(
          empresaConfig?.mensagemRodape ?? 'Obrigado pela preferencia!',
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
          textAlign: pw.TextAlign.center,
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          '${empresaConfig?.nomeEmpresa ?? "AutoGestor"} - ${_dateFormat.format(DateTime.now())}',
          style: const pw.TextStyle(fontSize: 8),
          textAlign: pw.TextAlign.center,
        ),
      ],
    );
  }

  /// Constrói uma descrição detalhada do produto
  String _buildDescricaoProduto(ItemVenda item) {
    final produto = item.produto;
    if (produto == null) {
      return 'Produto não encontrado';
    }
    
    String descricao = produto.nome;
    
    // Adiciona código do produto se disponível
    if (produto.codigo.isNotEmpty == true) {
      descricao = 'Cód: ${produto.codigo} - $descricao';
    }
    
    // Adiciona descrição adicional se disponível
    if (produto.descricao?.isNotEmpty == true && produto.descricao != produto.nome) {
      descricao += '\n${produto.descricao}';
    }
    
    return descricao;
  }

  Future<Uint8List> _salvarPdf(pw.Document pdf, String nomeArquivo) async {
    return pdf.save();
  }

  /// Abre o arquivo PDF gerado
  Future<void> abrirPdf(Uint8List pdfBytes) async {
    // TODO: Implementar abertura do PDF com o aplicativo padrão do sistema
    // Pode usar o package open_file ou url_launcher
  }

  /// Compartilha o arquivo PDF
  Future<void> compartilharPdf(Uint8List pdfBytes) async {
    // TODO: Implementar compartilhamento do PDF
    // Pode usar o package share_plus
  }
}