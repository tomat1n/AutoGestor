import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../orcamentos/domain/entities/orcamento.dart';
import '../../../orcamentos/domain/services/orcamentos_service.dart';
import '../../../orcamentos/data/repositories/orcamentos_repository_impl.dart';
import '../../../../core/providers/database_provider.dart';

class OrcamentosProvider extends ChangeNotifier {
  final OrcamentosService _orcamentosService;
  
  List<Orcamento> _orcamentos = [];
  bool _isLoading = false;
  String? _error;

  OrcamentosProvider(this._orcamentosService);

  List<Orcamento> get orcamentos => _orcamentos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> carregarOrcamentos() async {
    _setLoading(true);
    try {
      _orcamentos = await _orcamentosService.listarOrcamentos();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> criarOrcamento(Orcamento orcamento) async {
    _setLoading(true);
    try {
      final novoId = await _orcamentosService.criarOrcamento(orcamento);
      // Criar uma cópia do orçamento com o novo ID
      final novoOrcamento = orcamento.copyWith(id: novoId);
      _orcamentos.add(novoOrcamento);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> atualizarOrcamento(Orcamento orcamento) async {
    _setLoading(true);
    try {
      final orcamentoAtualizado = await _orcamentosService.atualizarOrcamento(orcamento);
      final index = _orcamentos.indexWhere((o) => o.id == orcamento.id);
      if (index != -1) {
        _orcamentos[index] = orcamentoAtualizado;
        notifyListeners();
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> excluirOrcamento(int id) async {
    _setLoading(true);
    try {
      await _orcamentosService.excluirOrcamento(id);
      _orcamentos.removeWhere((o) => o.id == id);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<Orcamento?> buscarOrcamentoPorId(int id) async {
    try {
      return await _orcamentosService.buscarOrcamentoPorId(id);
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  // Métodos de estatísticas simplificados
  int get totalOrcamentos => _orcamentos.length;
  
  int get orcamentosPendentes {
    return _orcamentos.where((o) => o.status == StatusOrcamento.rascunho).length;
  }

  int get orcamentosAprovados {
    return _orcamentos.where((o) => o.status == StatusOrcamento.aprovado).length;
  }

  double get valorTotalAprovados {
    return _orcamentos
        .where((o) => o.status == StatusOrcamento.aprovado)
        .fold(0.0, (total, orcamento) => total + orcamento.total);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}

// Provider
final orcamentosProvider = ChangeNotifierProvider<OrcamentosProvider>((ref) {
  final database = ref.watch(databaseProvider);
  final repository = OrcamentosRepositoryImpl(database);
  final service = OrcamentosService(repository);
  return OrcamentosProvider(service);
});