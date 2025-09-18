import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
// Importação condicional removida - será tratada dinamicamente
import '../entities/venda.dart';
import '../entities/item_venda.dart';
import '../../../configuracoes/data/repositories/empresa_config_repository.dart';
import '../../../../core/database/database.dart' show EmpresaConfigData;

class PdfService {
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy HH:mm');
  final EmpresaConfigRepository _empresaConfigRepository;
  
  PdfService(this._empresaConfigRepository);

  /// Gera um recibo em formato A4
  Future<File> gerarReciboA4(Venda venda, [List<ItemVenda>? itensVenda]) async {
    final itens = itensVenda ?? <ItemVenda>[];
    final empresaConfig = await _empresaConfigRepository.buscarConfiguracoes();
    
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
              _buildCabecalhoA4(empresaConfig),
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
              _buildRodapeA4(empresaConfig),
            ],
          );
        },
      ),
    );
    
    return _salvarPdf(pdf, 'recibo_venda_${venda.id}_a4.pdf');
  }

  /// Gera um recibo em formato térmico 58mm
  Future<File> gerarReciboTermico(Venda venda, [List<ItemVenda>? itensVenda]) async {
    final itens = itensVenda ?? <ItemVenda>[];
    final empresaConfig = await _empresaConfigRepository.buscarConfiguracoes();
    
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
              _buildCabecalhoTermico(empresaConfig),
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
              _buildRodapeTermico(empresaConfig),
            ],
          );
        },
      ),
    );
    
    return _salvarPdf(pdf, 'recibo_venda_${venda.id}_termico.pdf');
  }

  // Métodos para formato A4
  pw.Widget _buildCabecalhoA4(EmpresaConfigData? empresaConfig) {
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
        if (empresaConfig?.endereco.isNotEmpty == true) ...[
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

  pw.Widget _buildRodapeA4(EmpresaConfigData? empresaConfig) {
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
  pw.Widget _buildCabecalhoTermico(EmpresaConfigData? empresaConfig) {
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

  pw.Widget _buildRodapeTermico(EmpresaConfigData? empresaConfig) {
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

  Future<File> _salvarPdf(pw.Document pdf, String nomeArquivo) async {
    final bytes = await pdf.save();
    
    if (kIsWeb) {
      // Para Flutter Web - funcionalidade será implementada posteriormente
      throw UnsupportedError('Geração de PDF na web ainda não implementada');
    } else {
      // Para plataformas móveis/desktop
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$nomeArquivo');
      await file.writeAsBytes(bytes);
      return file;
    }
  }

  /// Abre o arquivo PDF gerado
  Future<void> abrirPdf(File arquivo) async {
    // TODO: Implementar abertura do PDF com o aplicativo padrão do sistema
    // Pode usar o package open_file ou url_launcher
  }

  /// Compartilha o arquivo PDF
  Future<void> compartilharPdf(File arquivo) async {
    // TODO: Implementar compartilhamento do PDF
    // Pode usar o package share_plus
  }
}