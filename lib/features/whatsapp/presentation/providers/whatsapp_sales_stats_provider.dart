import 'package:flutter_riverpod/flutter_riverpod.dart';

class WhatsAppSalesStats {
  final int recibosSucesso;
  final int orcamentosSucesso;
  final int confirmacoesSucesso;
  final int erros;

  const WhatsAppSalesStats({
    this.recibosSucesso = 0,
    this.orcamentosSucesso = 0,
    this.confirmacoesSucesso = 0,
    this.erros = 0,
  });

  WhatsAppSalesStats copyWith({
    int? recibosSucesso,
    int? orcamentosSucesso,
    int? confirmacoesSucesso,
    int? erros,
  }) {
    return WhatsAppSalesStats(
      recibosSucesso: recibosSucesso ?? this.recibosSucesso,
      orcamentosSucesso: orcamentosSucesso ?? this.orcamentosSucesso,
      confirmacoesSucesso: confirmacoesSucesso ?? this.confirmacoesSucesso,
      erros: erros ?? this.erros,
    );
  }
}

class WhatsAppSalesStatsNotifier extends StateNotifier<WhatsAppSalesStats> {
  WhatsAppSalesStatsNotifier() : super(const WhatsAppSalesStats());

  void incrementarRecibosSucesso() {
    state = state.copyWith(recibosSucesso: state.recibosSucesso + 1);
  }

  void incrementarOrcamentosSucesso() {
    state = state.copyWith(orcamentosSucesso: state.orcamentosSucesso + 1);
  }

  void incrementarConfirmacoesSucesso() {
    state = state.copyWith(confirmacoesSucesso: state.confirmacoesSucesso + 1);
  }

  void incrementarErros() {
    state = state.copyWith(erros: state.erros + 1);
  }

  void reset() {
    state = const WhatsAppSalesStats();
  }
}

final whatsappSalesStatsProvider = StateNotifierProvider<WhatsAppSalesStatsNotifier, WhatsAppSalesStats>(
  (ref) => WhatsAppSalesStatsNotifier(),
);