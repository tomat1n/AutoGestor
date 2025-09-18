import 'package:flutter/foundation.dart';
import '../../domain/entities/usuario_entity.dart';
import '../../domain/entities/assinatura_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/verificar_assinatura_usecase.dart';
import '../../domain/usecases/criar_periodo_teste_usecase.dart';
import '../../domain/services/admin_service.dart';
import '../../../../core/database/enums/user_role.dart';

enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  expired,
  error
}

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;
  final LoginUseCase _loginUseCase;
  final VerificarAssinaturaUseCase _verificarAssinaturaUseCase;
  final CriarPeriodoTesteUseCase _criarPeriodoTesteUseCase;
  final AdminService _adminService;

  AuthProvider(
    this._repository,
    this._loginUseCase,
    this._verificarAssinaturaUseCase,
    this._criarPeriodoTesteUseCase,
    this._adminService,
  );

  AuthState _state = AuthState.initial;
  UsuarioEntity? _usuario;
  AssinaturaEntity? _assinatura;
  String? _erro;
  bool _isLoading = false;

  // Getters
  AuthState get state => _state;
  UsuarioEntity? get usuario => _usuario;
  AssinaturaEntity? get assinatura => _assinatura;
  String? get erro => _erro;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _state == AuthState.authenticated;
  bool get isExpired => _state == AuthState.expired;
  bool get isLoggedIn => _state == AuthState.authenticated;
  bool get acessoPermitido => _state == AuthState.authenticated;
  int get diasRestantes => _assinatura?.diasRestantes ?? 0;
  bool get isTeste => _assinatura?.isTeste ?? false;
  bool get isAdmin => _usuario?.role.isAdmin ?? false;
  UserRole? get userRole => _usuario?.role;

  // Informações de personalização do usuário
  String? get logoPath => _usuario?.logoPath;
  String? get corPrimaria => _usuario?.corPrimaria;
  String? get corSecundaria => _usuario?.corSecundaria;
  String? get nomeFantasia => _usuario?.nomeFantasia ?? _usuario?.empresa;
  String? get nomeEmpresa => _usuario?.empresa;
  String? get cnpj => _usuario?.cnpj;

  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _erro = error;
    notifyListeners();
  }

  // Inicializar sistema e verificar se já está logado
  Future<void> checkAuthStatus() async {
    try {
      _setLoading(true);
      
      // Criar admin padrão se não existir
      await _criarAdminPadraoSeNecessario();
      
      final isLogado = await _repository.isLogado();
      
      if (isLogado) {
        final usuario = await _repository.getUsuarioLogado();
        
        if (usuario != null) {
          _usuario = usuario;
          
          // Verificar status da assinatura
          final statusAssinatura = await _verificarAssinaturaUseCase.execute(usuario.id!);
          _assinatura = statusAssinatura.assinatura;
          
          if (statusAssinatura.ativa) {
            _setState(AuthState.authenticated);
          } else {
            _setState(AuthState.expired);
          }
        } else {
          _setState(AuthState.unauthenticated);
        }
      } else {
        _setState(AuthState.unauthenticated);
      }
    } catch (e) {
      _setError('Erro ao verificar status de autenticação: $e');
      _setState(AuthState.error);
    } finally {
      _setLoading(false);
    }
  }

  // Criar administrador padrão se necessário
  Future<void> _criarAdminPadraoSeNecessario() async {
    try {
      await _adminService.criarAdminPadrao();
    } catch (e) {
      // Log do erro, mas não interrompe o fluxo
      debugPrint('Erro ao criar admin padrão: $e');
    }
  }

  // Login
  Future<bool> login(String email, String senha) async {
    try {
      _setLoading(true);
      _setError(null);
      
      final result = await _loginUseCase.execute(email, senha);
      
      if (result.sucesso) {
        _usuario = result.usuario;
        _assinatura = result.assinatura;
        _setState(AuthState.authenticated);
        return true;
      } else {
        _setError(result.erro);
        
        if (result.assinaturaExpirada) {
          _usuario = result.usuario;
          _assinatura = result.assinatura;
          _setState(AuthState.expired);
        } else {
          _setState(AuthState.unauthenticated);
        }
        
        return false;
      }
    } catch (e) {
      _setError('Erro interno: $e');
      _setState(AuthState.error);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _repository.logout();
      _usuario = null;
      _assinatura = null;
      _erro = null;
      _setState(AuthState.unauthenticated);
    } catch (e) {
      _setError('Erro ao fazer logout: $e');
    }
  }

  // Criar usuário com período de teste
  Future<bool> criarUsuarioComTeste(UsuarioEntity usuario, String senha) async {
    try {
      _setLoading(true);
      _setError(null);
      
      // Criar usuário
      final usuarioCriado = await _repository.criarUsuario(usuario, senha);
      
      // Criar período de teste
      final resultTeste = await _criarPeriodoTesteUseCase.execute(usuarioCriado);
      
      if (resultTeste.sucesso) {
        _usuario = usuarioCriado;
        _assinatura = resultTeste.assinatura;
        _setState(AuthState.authenticated);
        return true;
      } else {
        _setError(resultTeste.erro);
        _setState(AuthState.error);
        return false;
      }
    } catch (e) {
      _setError('Erro ao criar usuário: $e');
      _setState(AuthState.error);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Atualizar dados do usuário
  Future<bool> atualizarUsuario(UsuarioEntity usuarioAtualizado) async {
    try {
      _setLoading(true);
      _setError(null);
      
      final usuario = await _repository.atualizarUsuario(usuarioAtualizado);
      _usuario = usuario;
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Erro ao atualizar usuário: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Verificar status da assinatura
  Future<void> verificarStatusAssinatura() async {
    if (_usuario == null) return;
    
    try {
      final status = await _verificarAssinaturaUseCase.execute(_usuario!.id!);
      _assinatura = status.assinatura;
      
      if (status.ativa) {
        if (_state != AuthState.authenticated) {
          _setState(AuthState.authenticated);
        }
      } else {
        _setState(AuthState.expired);
      }
      
      notifyListeners();
    } catch (e) {
      _setError('Erro ao verificar assinatura: $e');
    }
  }

  // Renovar assinatura
  Future<bool> renovarAssinatura(TipoAssinatura tipo) async {
    if (_usuario == null) return false;
    
    try {
      _setLoading(true);
      _setError(null);
      
      final agora = DateTime.now();
      final dataFim = agora.add(Duration(days: tipo.diasDuracao));
      
      final novaAssinatura = AssinaturaEntity(
        usuarioId: _usuario!.id!,
        tipo: tipo,
        status: StatusAssinatura.ativa,
        dataInicio: agora,
        dataFim: dataFim,
        criadoEm: agora,
        atualizadoEm: agora,
        valor: tipo.valor,
        pago: false, // Será marcado como pago após confirmação de pagamento
        observacoes: 'Renovação de assinatura ${tipo.nome}',
      );
      
      // Marcar assinatura atual como expirada
      if (_assinatura != null) {
        await _repository.atualizarAssinatura(
          _assinatura!.copyWith(status: StatusAssinatura.expirada)
        );
      }
      
      // Criar nova assinatura
      _assinatura = await _repository.criarAssinatura(novaAssinatura);
      _setState(AuthState.authenticated);
      
      return true;
    } catch (e) {
      _setError('Erro ao renovar assinatura: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Confirmar pagamento
  Future<bool> confirmarPagamento(String metodoPagamento, String? transacaoId) async {
    if (_assinatura == null) return false;
    
    try {
      final assinaturaAtualizada = _assinatura!.copyWith(
        pago: true,
        dataPagamento: DateTime.now(),
        metodoPagamento: metodoPagamento,
        transacaoId: transacaoId,
      );
      
      _assinatura = await _repository.atualizarAssinatura(assinaturaAtualizada);
      notifyListeners();
      
      return true;
    } catch (e) {
      _setError('Erro ao confirmar pagamento: $e');
      return false;
    }
  }

  // Verificar se o acesso é permitido
  Future<bool> verificarAcessoPermitido() async {
    try {
      // Verificar se está autenticado
      if (_state != AuthState.authenticated) {
        return false;
      }
      
      // Verificar se tem usuário logado
      if (_usuario == null) {
        return false;
      }
      
      // Verificar status da assinatura
      if (_assinatura == null) {
        await verificarStatusAssinatura();
      }
      
      // Permitir acesso se a assinatura estiver ativa
        return _assinatura != null && 
               _assinatura!.status == StatusAssinatura.ativa &&
               _assinatura!.dataFim.isAfter(DateTime.now());
    } catch (e) {
      _setError('Erro ao verificar acesso: $e');
      return false;
    }
  }

  // Tentar login automático
  Future<bool> tentarLoginAutomatico() async {
    try {
      _setLoading(true);
      
      final isLogado = await _repository.isLogado();
      
      if (isLogado) {
        final usuario = await _repository.getUsuarioLogado();
        
        if (usuario != null) {
          _usuario = usuario;
          
          // Verificar status da assinatura
          final statusAssinatura = await _verificarAssinaturaUseCase.execute(usuario.id!);
          _assinatura = statusAssinatura.assinatura;
          
          if (statusAssinatura.ativa) {
            _setState(AuthState.authenticated);
            return true;
          } else {
            _setState(AuthState.expired);
            return false;
          }
        }
      }
      
      _setState(AuthState.unauthenticated);
      return false;
    } catch (e) {
      _setError('Erro no login automático: $e');
      _setState(AuthState.error);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // === FUNCIONALIDADES DE ADMINISTRAÇÃO ===

  // Promover usuário para administrador
  Future<bool> promoverParaAdmin(UsuarioEntity usuario) async {
    try {
      if (!isAdmin) {
        _setError('Apenas administradores podem promover usuários');
        return false;
      }

      _setLoading(true);
      await _adminService.promoverParaAdmin(usuario);
      return true;
    } catch (e) {
      _setError('Erro ao promover usuário: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Remover privilégios de administrador
  Future<bool> removerPrivilegiosAdmin(UsuarioEntity usuario) async {
    try {
      if (!isAdmin) {
        _setError('Apenas administradores podem remover privilégios');
        return false;
      }

      _setLoading(true);
      await _adminService.removerPrivilegiosAdmin(usuario);
      return true;
    } catch (e) {
      _setError('Erro ao remover privilégios: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Verificar se tem permissões de admin
  bool temPermissaoAdmin() {
    return isAdmin && acessoPermitido;
  }

  // Criar novo usuário (apenas admin)
  Future<bool> criarNovoUsuario(UsuarioEntity usuario, String senha) async {
    try {
      if (!isAdmin) {
        _setError('Apenas administradores podem criar usuários');
        return false;
      }

      _setLoading(true);
      await _repository.criarUsuario(usuario, senha);
      return true;
    } catch (e) {
      _setError('Erro ao criar usuário: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }
}