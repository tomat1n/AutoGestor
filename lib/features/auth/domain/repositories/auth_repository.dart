import '../entities/usuario_entity.dart';
import '../entities/assinatura_entity.dart';

abstract class AuthRepository {
  // Autenticação
  Future<UsuarioEntity?> login(String email, String senha);
  Future<void> logout();
  Future<UsuarioEntity?> getUsuarioLogado();
  Future<bool> isLogado();
  
  // Gestão de usuários
  Future<UsuarioEntity> criarUsuario(UsuarioEntity usuario, String senha);
  Future<UsuarioEntity> atualizarUsuario(UsuarioEntity usuario);
  Future<void> atualizarSenha(int usuarioId, String novaSenha);
  Future<void> atualizarUltimoLogin(int usuarioId);
  
  // Gestão de assinaturas
  Future<AssinaturaEntity?> getAssinaturaAtiva(int usuarioId);
  Future<AssinaturaEntity> criarAssinatura(AssinaturaEntity assinatura);
  Future<AssinaturaEntity> atualizarAssinatura(AssinaturaEntity assinatura);
  Future<List<AssinaturaEntity>> getHistoricoAssinaturas(int usuarioId);
  
  // Verificações de acesso
  Future<bool> verificarAcessoPermitido(int usuarioId);
  Future<int> getDiasRestantes(int usuarioId);
  Future<bool> isAssinaturaExpirada(int usuarioId);
  
  // Período de teste
  Future<AssinaturaEntity> criarPeriodoTeste(int usuarioId);
  Future<bool> jaUsouPeriodoTeste(String email);
}