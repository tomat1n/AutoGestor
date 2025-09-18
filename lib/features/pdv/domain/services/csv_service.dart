import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import '../entities/venda.dart';
import '../entities/item_venda.dart';

/// Serviço para exportação de dados em formato CSV
class CsvService {
  static const String _separator = ';';
  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy HH:mm');
  static final DateFormat _fileNameFormat = DateFormat('yyyyMMdd_HHmmss');

  /// Exporta vendas para arquivo CSV
  Future<String> exportarVendas({
    required List<Venda> vendas,
    required Map<int, List<ItemVenda>> itensVendas,
    String? nomeArquivo,
  }) async {
    try {
      // Gerar nome do arquivo se não fornecido
      nomeArquivo ??= 'vendas_${_fileNameFormat.format(DateTime.now())}.csv';
      
      // Obter diretório de documentos
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$nomeArquivo';
      
      // Criar conteúdo CSV
      final csvContent = _gerarCsvVendas(vendas, itensVendas);
      
      // Escrever arquivo
      final file = File(filePath);
      await file.writeAsString(csvContent, encoding: utf8);
      
      return filePath;
    } catch (e) {
      throw Exception('Erro ao exportar vendas para CSV: $e');
    }
  }

  /// Exporta vendas detalhadas (com itens) para arquivo CSV
  Future<String> exportarVendasDetalhadas({
    required List<Venda> vendas,
    required Map<int, List<ItemVenda>> itensVendas,
    String? nomeArquivo,
  }) async {
    try {
      // Gerar nome do arquivo se não fornecido
      nomeArquivo ??= 'vendas_detalhadas_${_fileNameFormat.format(DateTime.now())}.csv';
      
      // Obter diretório de documentos
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$nomeArquivo';
      
      // Criar conteúdo CSV
      final csvContent = _gerarCsvVendasDetalhadas(vendas, itensVendas);
      
      // Escrever arquivo
      final file = File(filePath);
      await file.writeAsString(csvContent, encoding: utf8);
      
      return filePath;
    } catch (e) {
      throw Exception('Erro ao exportar vendas detalhadas para CSV: $e');
    }
  }

  /// Gera conteúdo CSV para vendas (resumo)
  String _gerarCsvVendas(List<Venda> vendas, Map<int, List<ItemVenda>> itensVendas) {
    final buffer = StringBuffer();
    
    // Cabeçalho
    buffer.writeln([
      'ID Venda',
      'Data/Hora',
      'Subtotal',
      'Desconto',
      'Total',
      'Forma Pagamento',
      'Qtd Itens',
      'Observações',
    ].join(_separator));
    
    // Dados das vendas
    for (final venda in vendas) {
      final itens = itensVendas[venda.id] ?? [];
      final qtdItens = itens.fold<int>(0, (sum, item) => sum + item.quantidade);
      
      buffer.writeln([
        venda.id?.toString() ?? '',
        _dateFormat.format(venda.dataVenda),
        _formatarValor(venda.subtotal),
        _formatarValor(venda.desconto),
        _formatarValor(venda.total),
        venda.formaPagamento,
        qtdItens.toString(),
        _escaparCsv(venda.observacoes ?? ''),
      ].join(_separator));
    }
    
    return buffer.toString();
  }

  /// Gera conteúdo CSV para vendas detalhadas (com itens)
  String _gerarCsvVendasDetalhadas(List<Venda> vendas, Map<int, List<ItemVenda>> itensVendas) {
    final buffer = StringBuffer();
    
    // Cabeçalho
    buffer.writeln([
      'ID Venda',
      'Data/Hora',
      'Forma Pagamento',
      'Subtotal Venda',
      'Desconto Venda',
      'Total Venda',
      'Observações Venda',
      'Produto ID',
      'Produto Nome',
      'Quantidade',
      'Preço Unitário',
      'Subtotal Item',
    ].join(_separator));
    
    // Dados das vendas com itens
    for (final venda in vendas) {
      final itens = itensVendas[venda.id] ?? [];
      
      if (itens.isEmpty) {
        // Venda sem itens
        buffer.writeln([
          venda.id?.toString() ?? '',
          _dateFormat.format(venda.dataVenda),
          venda.formaPagamento,
          _formatarValor(venda.subtotal),
          _formatarValor(venda.desconto),
          _formatarValor(venda.total),
          _escaparCsv(venda.observacoes ?? ''),
          '', // Produto ID
          '', // Produto Nome
          '', // Quantidade
          '', // Preço Unitário
          '', // Subtotal Item
        ].join(_separator));
      } else {
        // Venda com itens
        for (final item in itens) {
          buffer.writeln([
            venda.id?.toString() ?? '',
            _dateFormat.format(venda.dataVenda),
            venda.formaPagamento,
            _formatarValor(venda.subtotal),
            _formatarValor(venda.desconto),
            _formatarValor(venda.total),
            _escaparCsv(venda.observacoes ?? ''),
            item.produtoId.toString(),
            _escaparCsv(item.produto?.nome ?? 'Produto não encontrado'),
            item.quantidade.toString(),
            _formatarValor(item.precoUnitario),
            _formatarValor(item.subtotal),
          ].join(_separator));
        }
      }
    }
    
    return buffer.toString();
  }

  /// Formata valor monetário para CSV
  String _formatarValor(double valor) {
    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  /// Escapa caracteres especiais para CSV
  String _escaparCsv(String texto) {
    if (texto.isEmpty) return texto;
    
    // Se contém separador, quebra de linha ou aspas, envolver em aspas
    if (texto.contains(_separator) || texto.contains('\n') || texto.contains('"')) {
      // Duplicar aspas internas
      final textoEscapado = texto.replaceAll('"', '""');
      return '"$textoEscapado"';
    }
    
    return texto;
  }

  /// Exporta relatório de vendas por período
  Future<String> exportarRelatorioVendas({
    required List<Venda> vendas,
    required Map<int, List<ItemVenda>> itensVendas,
    required DateTime dataInicio,
    required DateTime dataFim,
    String? nomeArquivo,
  }) async {
    try {
      // Gerar nome do arquivo se não fornecido
      final periodoStr = '${DateFormat('ddMMyyyy').format(dataInicio)}_${DateFormat('ddMMyyyy').format(dataFim)}';
      nomeArquivo ??= 'relatorio_vendas_${periodoStr}_${_fileNameFormat.format(DateTime.now())}.csv';
      
      // Obter diretório de documentos
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$nomeArquivo';
      
      // Criar conteúdo CSV do relatório
      final csvContent = _gerarCsvRelatorioVendas(vendas, itensVendas, dataInicio, dataFim);
      
      // Escrever arquivo
      final file = File(filePath);
      await file.writeAsString(csvContent, encoding: utf8);
      
      return filePath;
    } catch (e) {
      throw Exception('Erro ao exportar relatório de vendas para CSV: $e');
    }
  }

  /// Gera conteúdo CSV para relatório de vendas
  String _gerarCsvRelatorioVendas(
    List<Venda> vendas,
    Map<int, List<ItemVenda>> itensVendas,
    DateTime dataInicio,
    DateTime dataFim,
  ) {
    final buffer = StringBuffer();
    
    // Cabeçalho do relatório
    buffer.writeln('RELATÓRIO DE VENDAS');
    buffer.writeln('Período: ${_dateFormat.format(dataInicio)} até ${_dateFormat.format(dataFim)}');
    buffer.writeln('Gerado em: ${_dateFormat.format(DateTime.now())}');
    buffer.writeln('');
    
    // Resumo geral
    final totalVendas = vendas.length;
    final valorTotalVendas = vendas.fold<double>(0, (sum, venda) => sum + venda.total);
    final descontoTotal = vendas.fold<double>(0, (sum, venda) => sum + venda.desconto);
    final subtotalGeral = vendas.fold<double>(0, (sum, venda) => sum + venda.subtotal);
    
    buffer.writeln('RESUMO GERAL');
    buffer.writeln('Total de Vendas$_separator$totalVendas');
    buffer.writeln('Subtotal Geral$_separator${_formatarValor(subtotalGeral)}');
    buffer.writeln('Desconto Total$_separator${_formatarValor(descontoTotal)}');
    buffer.writeln('Valor Total$_separator${_formatarValor(valorTotalVendas)}');
    buffer.writeln('');
    
    // Vendas por forma de pagamento
    final vendasPorFormaPagamento = <String, List<Venda>>{};
    for (final venda in vendas) {
      vendasPorFormaPagamento.putIfAbsent(venda.formaPagamento, () => []).add(venda);
    }
    
    buffer.writeln('VENDAS POR FORMA DE PAGAMENTO');
    buffer.writeln('Forma Pagamento${_separator}Quantidade${_separator}Valor Total');
    
    for (final entry in vendasPorFormaPagamento.entries) {
      final quantidade = entry.value.length;
      final valorTotal = entry.value.fold<double>(0, (sum, venda) => sum + venda.total);
      buffer.writeln('${entry.key}$_separator$quantidade$_separator${_formatarValor(valorTotal)}');
    }
    
    buffer.writeln('');
    
    // Detalhes das vendas
    buffer.writeln('DETALHES DAS VENDAS');
    buffer.writeln([
      'ID Venda',
      'Data/Hora',
      'Subtotal',
      'Desconto',
      'Total',
      'Forma Pagamento',
      'Qtd Itens',
      'Observações',
    ].join(_separator));
    
    for (final venda in vendas) {
      final itens = itensVendas[venda.id] ?? [];
      final qtdItens = itens.fold<int>(0, (sum, item) => sum + item.quantidade);
      
      buffer.writeln([
        venda.id?.toString() ?? '',
        _dateFormat.format(venda.dataVenda),
        _formatarValor(venda.subtotal),
        _formatarValor(venda.desconto),
        _formatarValor(venda.total),
        venda.formaPagamento,
        qtdItens.toString(),
        _escaparCsv(venda.observacoes ?? ''),
      ].join(_separator));
    }
    
    return buffer.toString();
  }
}