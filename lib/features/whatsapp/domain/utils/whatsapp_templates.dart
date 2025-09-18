class WhatsAppTemplates {
  static String orcamento({
    required String nomeCliente,
    required String nomeEmpresa,
    required List<Map<String, dynamic>> servicos,
    required double valorTotal,
    String? observacoes,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('🔧 *ORÇAMENTO - $nomeEmpresa*');
    buffer.writeln('');
    buffer.writeln('👤 *Cliente:* $nomeCliente');
    buffer.writeln('📅 *Data:* ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');
    buffer.writeln('');
    buffer.writeln('📋 *SERVIÇOS:*');
    
    for (int i = 0; i < servicos.length; i++) {
      final servico = servicos[i];
      buffer.writeln('${i + 1}. *${servico['nome']}*');
      if (servico['descricao'] != null && servico['descricao'].toString().isNotEmpty) {
        buffer.writeln('   ${servico['descricao']}');
      }
      buffer.writeln('   💰 R\$ ${servico['valor'].toStringAsFixed(2)}');
      buffer.writeln('');
    }
    
    buffer.writeln('💵 *VALOR TOTAL: R\$ ${valorTotal.toStringAsFixed(2)}*');
    
    if (observacoes != null && observacoes.isNotEmpty) {
      buffer.writeln('');
      buffer.writeln('📝 *Observações:*');
      buffer.writeln(observacoes);
    }
    
    buffer.writeln('');
    buffer.writeln('✅ Para confirmar este orçamento, responda esta mensagem.');
    buffer.writeln('📞 Dúvidas? Entre em contato conosco!');
    
    return buffer.toString();
  }

  static String confirmarOrcamento({
    required String orcamentoId,
    required String nomeCliente,
    required String nomeEmpresa,
    String? observacoes,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('✅ *ORÇAMENTO CONFIRMADO - $nomeEmpresa*');
    buffer.writeln('');
    buffer.writeln('👤 *Cliente:* $nomeCliente');
    buffer.writeln('🆔 *Orçamento:* $orcamentoId');
    buffer.writeln('📅 *Confirmado em:* ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');
    buffer.writeln('');
    buffer.writeln('🎉 Seu orçamento foi confirmado com sucesso!');
    buffer.writeln('📋 Em breve entraremos em contato para agendar o serviço.');
    
    if (observacoes != null && observacoes.isNotEmpty) {
      buffer.writeln('');
      buffer.writeln('📝 *Observações:*');
      buffer.writeln(observacoes);
    }
    
    buffer.writeln('');
    buffer.writeln('📞 Dúvidas? Entre em contato conosco!');
    buffer.writeln('🙏 Obrigado pela preferência!');
    
    return buffer.toString();
  }

  static String reciboVenda({
    required String nomeCliente,
    required String nomeEmpresa,
    required List<Map<String, dynamic>> itens,
    required double valorTotal,
    required DateTime dataVenda,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('🧾 *RECIBO DE VENDA - $nomeEmpresa*');
    buffer.writeln('');
    buffer.writeln('👤 *Cliente:* $nomeCliente');
    buffer.writeln('📅 *Data:* ${dataVenda.day}/${dataVenda.month}/${dataVenda.year}');
    buffer.writeln('');
    buffer.writeln('🛒 *ITENS VENDIDOS:*');
    
    for (int i = 0; i < itens.length; i++) {
      final item = itens[i];
      buffer.writeln('${i + 1}. *${item['nome']}*');
      buffer.writeln('   Qtd: ${item['quantidade']} x R\$ ${item['valor'].toStringAsFixed(2)}');
      buffer.writeln('   Total: R\$ ${(item['quantidade'] * item['valor']).toStringAsFixed(2)}');
      buffer.writeln('');
    }
    
    buffer.writeln('💵 *VALOR TOTAL: R\$ ${valorTotal.toStringAsFixed(2)}*');
    buffer.writeln('');
    buffer.writeln('✅ Pagamento realizado com sucesso!');
    buffer.writeln('🙏 Obrigado pela preferência!');
    
    return buffer.toString();
  }
}