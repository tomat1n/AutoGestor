import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import '../../domain/entities/orcamento.dart';
import '../../../servicos/domain/entities/servico.dart';
import '../../../../core/utils/platform_utils.dart';

class OrcamentoDetalhesPage extends StatefulWidget {
  final Orcamento orcamento;
  final List<Servico> servicos;
  final List<Map<String, dynamic>> produtos;

  const OrcamentoDetalhesPage({
    super.key,
    required this.orcamento,
    this.servicos = const [],
    this.produtos = const [],
  });

  @override
  State<OrcamentoDetalhesPage> createState() => _OrcamentoDetalhesPageState();
}

class _OrcamentoDetalhesPageState extends State<OrcamentoDetalhesPage> {
  bool _isGeneratingPdf = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orçamento ${widget.orcamento.numero}'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _gerarPDF(),
            tooltip: 'Gerar PDF',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _compartilhar(),
            tooltip: 'Compartilhar',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildResumoCard(context),
            const SizedBox(height: 16),
            _buildClienteCard(context),
            const SizedBox(height: 16),
            if (widget.servicos.isNotEmpty) ...[
              _buildServicosCard(context),
              const SizedBox(height: 16),
            ],
            if (widget.produtos.isNotEmpty) ...[
              _buildProdutosCard(context),
              const SizedBox(height: 16),
            ],
            _buildTotaisCard(context),
            const SizedBox(height: 16),
            if (widget.orcamento.fotosDefeitoUrls != null && widget.orcamento.fotosDefeitoUrls!.isNotEmpty) ...[
              _buildFotosDefeitoCard(context),
              const SizedBox(height: 16),
            ],
            if (widget.orcamento.fotosReposicaoUrls != null && widget.orcamento.fotosReposicaoUrls!.isNotEmpty) ...[
              _buildFotosReposicaoCard(context),
              const SizedBox(height: 16),
            ],
            if (widget.orcamento.observacoes != null) ...[
              _buildObservacoesCard(context),
              const SizedBox(height: 16),
            ],
            if (widget.orcamento.condicoesPagamento != null) ...[
              _buildCondicoesPagamentoCard(context),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _gerarPDF,
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text('Gerar PDF'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _enviarWhatsApp,
                icon: const Icon(Icons.message),
                label: const Text('WhatsApp'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _enviarWhatsAppComPDF,
                icon: const Icon(Icons.attach_file),
                label: const Text('WhatsApp + PDF'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumo do Orçamento',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Número:', style: Theme.of(context).textTheme.bodyMedium),
                Text(widget.orcamento.numero, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Data de Emissão:', style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  '${widget.orcamento.dataEmissao.day.toString().padLeft(2, '0')}/${widget.orcamento.dataEmissao.month.toString().padLeft(2, '0')}/${widget.orcamento.dataEmissao.year}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (widget.orcamento.dataValidade != null) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Validade:', style: Theme.of(context).textTheme.bodyMedium),
                  Text(
                    '${widget.orcamento.dataValidade!.day.toString().padLeft(2, '0')}/${widget.orcamento.dataValidade!.month.toString().padLeft(2, '0')}/${widget.orcamento.dataValidade!.year}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildClienteCard(BuildContext context) {
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
            Text(
              widget.orcamento.nomeCliente,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (widget.orcamento.telefoneCliente != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.phone, size: 16),
                  const SizedBox(width: 8),
                  Text(widget.orcamento.telefoneCliente!),
                ],
              ),
            ],
            if (widget.orcamento.emailCliente != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.email, size: 16),
                  const SizedBox(width: 8),
                  Text(widget.orcamento.emailCliente!),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildServicosCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Serviços',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.servicos.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final servico = widget.servicos[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(servico.nome),
                  subtitle: servico.descricao != null ? Text(servico.descricao!) : null,
                  trailing: Text(
                    'R\$ ${servico.valor.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProdutosCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Produtos/Peças',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.produtos.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final item = widget.produtos[index];
                final produto = item['produto'];
                final quantidade = item['quantidade'];
                final valor = item['valor'];
                final subtotal = quantidade * valor;
                
                return ListTile(
                  contentPadding: EdgeInsets.zero,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotaisCard(BuildContext context) {
    double totalServicos = widget.servicos.fold(0.0, (sum, servico) => sum + servico.valor);
    double totalProdutos = widget.produtos.fold(0.0, (sum, item) => sum + (item['quantidade'] * item['valor']));
    double total = totalServicos + totalProdutos;

    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Totais',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (totalServicos > 0) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal Serviços:', style: Theme.of(context).textTheme.bodyMedium),
                  Text(
                    'R\$ ${totalServicos.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            if (totalProdutos > 0) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal Produtos:', style: Theme.of(context).textTheme.bodyMedium),
                  Text(
                    'R\$ ${totalProdutos.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL GERAL:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'R\$ ${total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFotosDefeitoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fotos de Peças com Defeito',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.orcamento.fotosDefeitoUrls!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? (widget.orcamento.fotosDefeitoUrls![index].startsWith('data:image')
                              ? Image.memory(
                                  base64Decode(widget.orcamento.fotosDefeitoUrls![index].split(',')[1]),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                ))
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
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

  Widget _buildFotosReposicaoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fotos de Peças de Reposição',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.orcamento.fotosReposicaoUrls!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? (widget.orcamento.fotosReposicaoUrls![index].startsWith('data:image')
                              ? Image.memory(
                                  base64Decode(widget.orcamento.fotosReposicaoUrls![index].split(',')[1]),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                ))
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
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

  Widget _buildObservacoesCard(BuildContext context) {
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
            Text(widget.orcamento.observacoes!),
          ],
        ),
      ),
    );
  }

  Widget _buildCondicoesPagamentoCard(BuildContext context) {
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
            Text(widget.orcamento.condicoesPagamento!),
          ],
        ),
      ),
    );
  }

  Future<void> _gerarPDF() async {
    if (!mounted || _isGeneratingPdf) return;
    
    setState(() {
      _isGeneratingPdf = true;
    });
    
    try {
      final pdf = pw.Document();
      
      // Calcular totais
      double totalServicos = widget.servicos.fold(0.0, (sum, servico) => sum + servico.valor);
      double totalProdutos = widget.produtos.fold(0.0, (sum, item) => sum + (item['quantidade'] * item['valor']));
      double total = totalServicos + totalProdutos;

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              // Cabeçalho
              pw.Header(
                level: 0,
                child: pw.Text(
                  'ORÇAMENTO ${widget.orcamento.numero}',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              
              // Informações do orçamento
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Informações do Orçamento',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Número:'),
                        pw.Text(widget.orcamento.numero, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Data de Emissão:'),
                        pw.Text(
                          '${widget.orcamento.dataEmissao.day.toString().padLeft(2, '0')}/${widget.orcamento.dataEmissao.month.toString().padLeft(2, '0')}/${widget.orcamento.dataEmissao.year}',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                    if (widget.orcamento.dataValidade != null) ...[
                      pw.SizedBox(height: 5),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Validade:'),
                          pw.Text(
                            '${widget.orcamento.dataValidade!.day.toString().padLeft(2, '0')}/${widget.orcamento.dataValidade!.month.toString().padLeft(2, '0')}/${widget.orcamento.dataValidade!.year}',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              
              // Dados do cliente
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Dados do Cliente',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      widget.orcamento.nomeCliente,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    if (widget.orcamento.telefoneCliente != null) ...[
                      pw.SizedBox(height: 5),
                      pw.Text('Telefone: ${widget.orcamento.telefoneCliente!}'),
                    ],
                    if (widget.orcamento.emailCliente != null) ...[
                      pw.SizedBox(height: 5),
                      pw.Text('E-mail: ${widget.orcamento.emailCliente!}'),
                    ],
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              
              // Serviços
              if (widget.servicos.isNotEmpty) ...[
                pw.Text(
                  'Serviços',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey300),
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(color: PdfColors.grey100),
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
                    ...widget.servicos.map((servico) => pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(servico.nome),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(servico.descricao ?? ''),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('R\$ ${servico.valor.toStringAsFixed(2)}'),
                        ),
                      ],
                    )),
                  ],
                ),
                pw.SizedBox(height: 20),
              ],
              
              // Produtos
              if (widget.produtos.isNotEmpty) ...[
                pw.Text(
                  'Produtos/Peças',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey300),
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(color: PdfColors.grey100),
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
                          child: pw.Text('Valor Unit.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('Subtotal', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                      ],
                    ),
                    ...widget.produtos.map((item) {
                      final produto = item['produto'];
                      final quantidade = item['quantidade'];
                      final valor = item['valor'];
                      final subtotal = quantidade * valor;
                      
                      return pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(produto.nome),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(quantidade.toString()),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text('R\$ ${valor.toStringAsFixed(2)}'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text('R\$ ${subtotal.toStringAsFixed(2)}'),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
                pw.SizedBox(height: 20),
              ],
              
              // Totais
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  children: [
                    if (totalServicos > 0) ...[
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Subtotal Serviços:'),
                          pw.Text('R\$ ${totalServicos.toStringAsFixed(2)}'),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                    ],
                    if (totalProdutos > 0) ...[
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Subtotal Produtos:'),
                          pw.Text('R\$ ${totalProdutos.toStringAsFixed(2)}'),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                    ],
                    pw.Divider(),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'TOTAL GERAL:',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'R\$ ${total.toStringAsFixed(2)}',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Observações
              if (widget.orcamento.observacoes != null) ...[
                pw.SizedBox(height: 20),
                pw.Text(
                  'Observações',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.Text(widget.orcamento.observacoes!),
                ),
              ],
              
              // Condições de pagamento
              if (widget.orcamento.condicoesPagamento != null) ...[
                pw.SizedBox(height: 20),
                pw.Text(
                  'Condições de Pagamento',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.Text(widget.orcamento.condicoesPagamento!),
                ),
              ],
            ];
          },
        ),
      );

      if (!mounted) return;
      
      if (kIsWeb) {
        // Para web, usar Printing.sharePdf
        await Printing.sharePdf(
          bytes: await pdf.save(),
          filename: 'Orcamento_${widget.orcamento.numero}_${widget.orcamento.nomeCliente.replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(' ', '_')}.pdf',
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('PDF gerado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // Para plataformas nativas, usar Printing.sharePdf
        await Printing.sharePdf(
          bytes: await pdf.save(),
          filename: 'Orcamento_${widget.orcamento.numero}_${widget.orcamento.nomeCliente.replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(' ', '_')}.pdf',
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('PDF gerado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao gerar PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGeneratingPdf = false;
        });
      }
    }
  }

  Future<void> _compartilhar() async {
    try {
      // Criar mensagem simples para compartilhar
      double totalServicos = widget.servicos.fold(0.0, (sum, servico) => sum + servico.valor);
      double totalProdutos = widget.produtos.fold(0.0, (sum, item) => sum + (item['quantidade'] * item['valor']));
      double total = totalServicos + totalProdutos;

      String mensagem = '''🔧 *ORÇAMENTO ${widget.orcamento.numero}*

Olá ${widget.orcamento.nomeCliente}!

Segue o orçamento solicitado:

📋 *Resumo:*
• Número: ${widget.orcamento.numero}
• Data: ${widget.orcamento.dataEmissao.day.toString().padLeft(2, '0')}/${widget.orcamento.dataEmissao.month.toString().padLeft(2, '0')}/${widget.orcamento.dataEmissao.year}''';

      if (widget.orcamento.dataValidade != null) {
        mensagem += '''
• Validade: ${widget.orcamento.dataValidade!.day.toString().padLeft(2, '0')}/${widget.orcamento.dataValidade!.month.toString().padLeft(2, '0')}/${widget.orcamento.dataValidade!.year}''';
      }

      mensagem += '''

💰 *Total: R\$ ${total.toStringAsFixed(2)}*

Qualquer dúvida, estou à disposição!''';

      await Share.share(
        mensagem,
        subject: 'Orçamento ${widget.orcamento.numero}',
      );

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao compartilhar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _enviarWhatsApp() async {
    try {
      // Criar mensagem para WhatsApp
      double totalServicos = widget.servicos.fold(0.0, (sum, servico) => sum + servico.valor);
      double totalProdutos = widget.produtos.fold(0.0, (sum, item) => sum + (item['quantidade'] * item['valor']));
      double total = totalServicos + totalProdutos;

      String mensagem = '''🔧 *ORÇAMENTO ${widget.orcamento.numero}*

Olá ${widget.orcamento.nomeCliente}!

Segue o orçamento solicitado:

📋 *Resumo:*
• Número: ${widget.orcamento.numero}
• Data: ${widget.orcamento.dataEmissao.day.toString().padLeft(2, '0')}/${widget.orcamento.dataEmissao.month.toString().padLeft(2, '0')}/${widget.orcamento.dataEmissao.year}''';

      if (widget.orcamento.dataValidade != null) {
        mensagem += '''
• Validade: ${widget.orcamento.dataValidade!.day.toString().padLeft(2, '0')}/${widget.orcamento.dataValidade!.month.toString().padLeft(2, '0')}/${widget.orcamento.dataValidade!.year}''';
      }

      mensagem += '''

💰 *Total: R\$ ${total.toStringAsFixed(2)}*

Qualquer dúvida, estou à disposição!''';

      // Criar URL do WhatsApp
      String telefone = widget.orcamento.telefoneCliente ?? '';
      // Remover caracteres não numéricos
      telefone = telefone.replaceAll(RegExp(r'[^0-9]'), '');
      
      final url = Uri.parse('https://wa.me/$telefone?text=${Uri.encodeComponent(mensagem)}');
      
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Não foi possível abrir o WhatsApp';
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar WhatsApp: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _enviarWhatsAppComPDF() async {
    try {
      if (kIsWeb) {
        // Para web, apenas enviar mensagem sem PDF
        await _enviarWhatsApp();
        return;
      }
      
      // Gerar PDF primeiro
      final pdf = pw.Document();
      
      // Calcular totais
      double totalServicos = widget.servicos.fold(0.0, (sum, servico) => sum + servico.valor);
      double totalProdutos = widget.produtos.fold(0.0, (sum, item) => sum + (item['quantidade'] * item['valor']));
      double total = totalServicos + totalProdutos;

      // Adicionar conteúdo do PDF (reutilizando a lógica do _gerarPDF)
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              pw.Header(
                level: 0,
                child: pw.Text(
                  'ORÇAMENTO ${widget.orcamento.numero}',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Cliente: ${widget.orcamento.nomeCliente}'),
              pw.Text('Data: ${widget.orcamento.dataEmissao.day.toString().padLeft(2, '0')}/${widget.orcamento.dataEmissao.month.toString().padLeft(2, '0')}/${widget.orcamento.dataEmissao.year}'),
              if (widget.orcamento.dataValidade != null)
                pw.Text('Validade: ${widget.orcamento.dataValidade!.day.toString().padLeft(2, '0')}/${widget.orcamento.dataValidade!.month.toString().padLeft(2, '0')}/${widget.orcamento.dataValidade!.year}'),
              pw.SizedBox(height: 20),
              pw.Text(
                'TOTAL: R\$ ${total.toStringAsFixed(2)}',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ];
          },
        ),
      );

      final bytes = await pdf.save();
       
      // Para plataformas nativas, compartilhar o PDF
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'Orcamento_${widget.orcamento.numero}.pdf',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF compartilhado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar PDF via WhatsApp: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}