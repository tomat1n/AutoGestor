class WhatsAppTemplates {
  // Templates para agendamento
  static String agendamentoConfirmacao({
    required String nomeCliente,
    required String servico,
    required String dataHora,
    required String nomeEmpresa,
  }) {
    return '''🔧 *${nomeEmpresa.toUpperCase()}* 🔧

Olá *$nomeCliente*! 👋

Seu agendamento foi confirmado com sucesso! ✅

📋 *Detalhes do Serviço:*
• Serviço: $servico
• Data e Hora: $dataHora

📍 Chegue com 10 minutos de antecedência
🚗 Traga a documentação do veículo

Em caso de dúvidas, entre em contato conosco!

Obrigado pela preferência! 🙏''';
  }

  static String agendamentoLembrete({
    required String nomeCliente,
    required String servico,
    required String dataHora,
    required String endereco,
    String? telefone,
  }) {
    return '''⏰ *LEMBRETE DE AGENDAMENTO* ⏰

Olá *$nomeCliente*!

Lembramos que você tem um agendamento marcado:

📋 *Serviço:* $servico
📅 *Data e Hora:* $dataHora
📍 *Local:* $endereco
${telefone != null ? '📞 *Contato:* $telefone' : ''}

⚠️ *IMPORTANTE:*
• Chegue 10 minutos antes
• Traga a documentação do veículo
• Em caso de atraso, entre em contato

Aguardamos você! 🚗✨''';
  }

  static String agendamentoCancelamento({
    required String nomeCliente,
    required String servico,
    required String dataHora,
    String? motivo,
  }) {
    return '''❌ *AGENDAMENTO CANCELADO* ❌

Olá *$nomeCliente*,

Informamos que seu agendamento foi cancelado:

📋 *Serviço:* $servico
📅 *Data e Hora:* $dataHora
${motivo != null ? '📝 *Motivo:* $motivo' : ''}

Para reagendar, entre em contato conosco.

Pedimos desculpas pelo inconveniente! 🙏''';
  }

  // Templates para serviços em andamento
  static String servicoIniciado({
    required String nomeCliente,
    required String servico,
    String? previsaoTermino,
  }) {
    return '''🔧 *SERVIÇO INICIADO* 🔧

Olá *$nomeCliente*!

Informamos que iniciamos o serviço em seu veículo:

📋 *Serviço:* $servico
⏰ *Iniciado em:* ${DateTime.now().toString().substring(0, 16)}
${previsaoTermino != null ? '🕐 *Previsão de término:* $previsaoTermino' : ''}

Manteremos você informado sobre o andamento! 📱

Obrigado pela confiança! 🙏''';
  }

  static String servicoConcluido({
    required String nomeCliente,
    required String servico,
    String? observacoes,
    String? valorTotal,
  }) {
    return '''✅ *SERVIÇO CONCLUÍDO* ✅

Olá *$nomeCliente*!

Temos o prazer de informar que seu serviço foi concluído:

📋 *Serviço:* $servico
✅ *Concluído em:* ${DateTime.now().toString().substring(0, 16)}
${valorTotal != null ? '💰 *Valor Total:* R\$ $valorTotal' : ''}
${observacoes != null ? '📝 *Observações:* $observacoes' : ''}

Seu veículo está pronto para retirada! 🚗✨

Obrigado pela preferência! 🙏''';
  }

  // Templates para manutenção preventiva
  static String manutencaoPreventiva({
    required String nomeCliente,
    required String tipoManutencao,
    required String quilometragem,
    String? proximaRevisao,
  }) {
    return '''🔔 *LEMBRETE DE MANUTENÇÃO* 🔔

Olá *$nomeCliente*!

É hora de cuidar do seu veículo! 🚗

🔧 *Manutenção recomendada:* $tipoManutencao
📊 *Quilometragem atual:* $quilometragem km
${proximaRevisao != null ? '📅 *Próxima revisão:* $proximaRevisao' : ''}

⚠️ *Por que é importante?*
• Previne problemas maiores
• Economiza dinheiro a longo prazo
• Mantém a garantia do veículo
• Garante sua segurança

Agende já sua manutenção! 📞

Cuidamos do seu veículo com carinho! ❤️''';
  }

  static String lembreteRevisao({
    required String nomeCliente,
    required String quilometragem,
    required String tempoUltimaRevisao,
  }) {
    return '''🔍 *HORA DA REVISÃO* 🔍

Olá *$nomeCliente*!

Seu veículo precisa de uma revisão:

📊 *Quilometragem:* $quilometragem km
📅 *Última revisão:* $tempoUltimaRevisao

🔧 *Itens a verificar:*
• Óleo do motor e filtros
• Freios e suspensão
• Pneus e alinhamento
• Sistema elétrico
• Fluidos em geral

💡 *Benefícios da revisão:*
✅ Maior durabilidade do veículo
✅ Economia de combustível
✅ Segurança na direção
✅ Valor de revenda preservado

Agende sua revisão hoje mesmo! 📞''';
  }

  // Templates promocionais
  static String promocaoDesconto({
    required String nomeCliente,
    required String desconto,
    required String servicos,
    required String validadePromocao,
  }) {
    return '''🎉 *PROMOÇÃO ESPECIAL* 🎉

Olá *$nomeCliente*!

Temos uma oferta imperdível para você:

💰 *$desconto% DE DESCONTO*

🔧 *Serviços inclusos:*
$servicos

⏰ *Válido até:* $validadePromocao

📞 *Como aproveitar:*
• Ligue e agende seu horário
• Mencione esta promoção
• Apresente esta mensagem

⚡ *Vagas limitadas!*
Não perca esta oportunidade!

Aproveite e cuide do seu veículo! 🚗✨''';
  }

  static String promocaoTrocaOleo({
    required String nomeCliente,
    required String preco,
    String? validadePromocao,
  }) {
    return '''🛢️ *PROMOÇÃO TROCA DE ÓLEO* 🛢️

Olá *$nomeCliente*!

Cuide do coração do seu carro:

💰 *TROCA DE ÓLEO COMPLETA*
• Óleo de qualidade premium
• Filtro de óleo novo
• Verificação de níveis
• Inspeção visual gratuita

🏷️ *Por apenas R\$ $preco*
${validadePromocao != null ? '⏰ *Válido até:* $validadePromocao' : ''}

✅ *Benefícios inclusos:*
• Proteção do motor
• Melhor performance
• Economia de combustível
• Maior vida útil do veículo

Agende já! Seu carro agradece! 🚗❤️''';
  }

  // Templates de confirmação de chegada
  static String confirmacaoChegada({
    required String nomeCliente,
    required String dataHora,
    required String servico,
    required String codigoConfirmacao,
  }) {
    return '''📍 *CONFIRMAÇÃO DE CHEGADA* 📍

Olá *$nomeCliente*!

Confirme sua chegada para o agendamento:

📋 *Serviço:* $servico
📅 *Data e Hora:* $dataHora
🔢 *Código:* $codigoConfirmacao

👆 *Para confirmar sua chegada:*
Responda com o código: *$codigoConfirmacao*

⚠️ *Importante:*
• Confirme apenas quando chegar ao local
• Nosso atendente será notificado
• Em caso de atraso, entre em contato

Aguardamos você! 📱''';
  }

  static String lembreteConfirmacaoChegada({
    required String nomeCliente,
    required String dataHora,
    required String codigoConfirmacao,
    required String nomeEmpresa,
  }) {
    return '''🔔 *LEMBRETE - ${nomeEmpresa.toUpperCase()}* 🔔

Olá *$nomeCliente*! 👋

Este é um lembrete sobre seu agendamento:

📅 *Data e Hora:* $dataHora
🔑 *Código de Confirmação:* $codigoConfirmacao

⏰ Por favor, confirme sua chegada quando estiver no local.

📱 Responda com "CHEGUEI $codigoConfirmacao" quando chegar.

Aguardamos você! 🚗✨''';
  }

  // Templates para recibos e orçamentos
  static String reciboVenda({
    required String nomeCliente,
    required String numeroVenda,
    required double valorTotal,
    required String formaPagamento,
    required String nomeEmpresa,
  }) {
    return '''🧾 *RECIBO DE VENDA - ${nomeEmpresa.toUpperCase()}* 🧾

Olá *$nomeCliente*! 👋

Sua compra foi finalizada com sucesso! ✅

📋 *Detalhes da Venda:*
• Número da Venda: #$numeroVenda
• Valor Total: R\$ ${valorTotal.toStringAsFixed(2)}
• Forma de Pagamento: $formaPagamento
• Data: ${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}

📄 Segue em anexo o recibo detalhado da sua compra.

🙏 Obrigado pela preferência!
💬 Em caso de dúvidas, entre em contato conosco.''';
  }

  static String orcamentoServicos({
    required String nomeCliente,
    required double valorTotal,
    required DateTime validadeOrcamento,
    required String nomeEmpresa,
  }) {
    return '''💰 *ORÇAMENTO - ${nomeEmpresa.toUpperCase()}* 💰

Olá *$nomeCliente*! 👋

Seu orçamento está pronto! 📋✨

💵 *Valor Total:* R\$ ${valorTotal.toStringAsFixed(2)}
📅 *Válido até:* ${validadeOrcamento.day.toString().padLeft(2, '0')}/${validadeOrcamento.month.toString().padLeft(2, '0')}/${validadeOrcamento.year}

📄 Segue em anexo o orçamento detalhado com todos os serviços.

✅ Para confirmar o agendamento, entre em contato conosco!
🔧 Garantimos qualidade e preço justo em todos os nossos serviços.

🙏 Aguardamos seu retorno!''';
  }

  static String confirmacaoOrcamento({
    required String nomeCliente,
    required String nomeEmpresa,
    required DateTime dataAgendamento,
  }) {
    return '''✅ *ORÇAMENTO APROVADO - ${nomeEmpresa.toUpperCase()}* ✅

Olá *$nomeCliente*! 👋

Seu orçamento foi aprovado e o serviço foi agendado! 🎉

📅 *Data do Agendamento:* ${dataAgendamento.day.toString().padLeft(2, '0')}/${dataAgendamento.month.toString().padLeft(2, '0')}/${dataAgendamento.year} às ${dataAgendamento.hour.toString().padLeft(2, '0')}:${dataAgendamento.minute.toString().padLeft(2, '0')}

📍 Chegue com 10 minutos de antecedência
🚗 Traga a documentação do veículo

Em breve enviaremos mais detalhes sobre o agendamento.

🔧 Obrigado pela confiança! 🙏''';
  }

  static String boasVindas({
    required String nomeCliente,
    required String nomeEmpresa,
  }) {
    return '''👋 *BEM-VINDO À ${nomeEmpresa.toUpperCase()}!* 👋

Olá *$nomeCliente*!

É um prazer tê-lo como nosso cliente! 🙏

🔧 *Nossos serviços:*
• Manutenção preventiva
• Reparos em geral
• Troca de óleo e filtros
• Alinhamento e balanceamento
• Diagnóstico eletrônico
• E muito mais!

📱 *Facilidades:*
• Agendamento pelo WhatsApp
• Lembretes automáticos
• Acompanhamento do serviço
• Promoções exclusivas

Estamos aqui para cuidar do seu veículo! 🚗✨''';
  }

  static String pesquisaSatisfacao({
    required String nomeCliente,
    required String servico,
  }) {
    return '''⭐ *PESQUISA DE SATISFAÇÃO* ⭐

Olá *$nomeCliente*!

Como foi sua experiência com nosso serviço?

📋 *Serviço realizado:* $servico

👆 *Avalie de 1 a 5:*
⭐ 1 - Muito insatisfeito
⭐⭐ 2 - Insatisfeito
⭐⭐⭐ 3 - Regular
⭐⭐⭐⭐ 4 - Satisfeito
⭐⭐⭐⭐⭐ 5 - Muito satisfeito

💬 *Deixe seu comentário:*
Sua opinião é muito importante para nós!

Obrigado pela confiança! 🙏''';
  }

  // Método para personalizar templates
  static String personalizarTemplate(String template, Map<String, String> variaveis) {
    String resultado = template;
    variaveis.forEach((chave, valor) {
      resultado = resultado.replaceAll('{$chave}', valor);
    });
    return resultado;
  }

  // Validar se template tem todas as variáveis necessárias
  static bool validarTemplate(String template, List<String> variaveisObrigatorias) {
    for (String variavel in variaveisObrigatorias) {
      if (!template.contains('{$variavel}')) {
        return false;
      }
    }
    return true;
  }
}