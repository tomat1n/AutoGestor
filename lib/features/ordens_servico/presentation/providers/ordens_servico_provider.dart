import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../ordens_servico/domain/entities/ordem_servico.dart';
import '../../../ordens_servico/domain/services/ordens_servico_service.dart';
import '../../../ordens_servico/data/repositories/ordens_servico_repository_impl.dart';
import '../../../clientes/domain/entities/cliente.dart';
import '../../../../core/providers/database_provider.dart';

class OrdensServicoProvider extends ChangeNotifier {
  final OrdensServicoService _ordensServicoService;
  
  List<OrdemServico> _ordens = [];
  bool _isLoading = false;
  String? _error;

  OrdensServicoProvider(this._ordensServicoService);

  List<OrdemServico> get ordens => _ordens;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> carregarOrdens() async {
    _setLoading(true);
    try {
      _ordens = await _ordensServicoService.buscarTodas();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> carregarOrdensAtivas() async {
    _setLoading(true);
    try {
      _ordens = await _ordensServicoService.buscarAtivas();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> criarOrdem(OrdemServico ordem) async {
    _setLoading(true);
    try {
      final novaOrdem = await _ordensServicoService.criarOrdemServico(
        cliente: Cliente(id: ordem.clienteId, nome: ordem.nomeCliente ?? '', email: ordem.emailCliente, telefone: ordem.telefoneCliente),
        itens: ordem.itens,
        dataAgendamento: ordem.dataAgendamento ?? DateTime.now(),
        prioridade: ordem.prioridade,
        dataPrevista: ordem.dataPrevista,
        desconto: ordem.desconto,
        observacoes: ordem.observacoes,
        observacoesInternas: ordem.observacoesInternas,
        tecnicoResponsavel: ordem.tecnicoResponsavel,
        equipamento: ordem.equipamento,
        problemaRelatado: ordem.problemaRelatado,
      );
      _ordens.add(novaOrdem);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> atualizarOrdem(OrdemServico ordem) async {
    _setLoading(true);
    try {
      await _ordensServicoService.editarOrdemServico(
        id: ordem.id!,
        itens: ordem.itens,
        dataAgendamento: ordem.dataAgendamento,
        prioridade: ordem.prioridade,
        dataPrevista: ordem.dataPrevista,
        desconto: ordem.desconto,
        observacoes: ordem.observacoes,
        observacoesInternas: ordem.observacoesInternas,
        tecnicoResponsavel: ordem.tecnicoResponsavel,
        equipamento: ordem.equipamento,
        problemaRelatado: ordem.problemaRelatado,
      );
      final index = _ordens.indexWhere((o) => o.id == ordem.id);
      if (index != -1) {
        _ordens[index] = ordem;
      }
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> excluirOrdem(int id) async {
    _setLoading(true);
    try {
      await _ordensServicoService.excluirOrdemServico(id);
      _ordens.removeWhere((ordem) => ordem.id == id);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<OrdemServico?> buscarOrdemPorId(int id) async {
    try {
      return await _ordensServicoService.buscarPorId(id);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}

// Provider para injeção de dependência
final ordensServicoProvider = ChangeNotifierProvider<OrdensServicoProvider>((ref) {
  final database = ref.watch(databaseProvider);
  final repository = OrdensServicoRepositoryImpl(database);
  final service = OrdensServicoService(repository);
  return OrdensServicoProvider(service);
});