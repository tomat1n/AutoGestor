import '../entities/usuario_entity.dart';
import '../entities/assinatura_entity.dart';
import '../repositories/auth_repository.dart';

class LoginResult {
  final bool sucesso;
  final UsuarioEntity? usuario;
  final AssinaturaEntity? assinatura;
  final String? erro;
  final bool assinaturaExpirada;
  final int diasRestantes;

  const LoginResult({
    required this.sucesso,
    this.usuario,
    this.assinatura,
    this.erro,
    this.assinaturaExpirada = false,
    this.diasRestantes = 0,
  });
}

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<LoginResult> execute(String email, String senha) async {
    try {
      // Validar entrada
      if (email.isEmpty || senha.isEmpty) {
        return const LoginResult(
          sucesso: false,
          erro: 'Email e senha são obrigatórios',
        );
      }

      // Tentar fazer login
      final usuario = await _repository.login(email, senha);
      
      if (usuario == null) {
        return const LoginResult(
          sucesso: false,
          erro: 'Email ou senha incorretos',
        );
      }

      // Verificar se o usuário está ativo
      if (!usuario.ativo) {
        return const LoginResult(
          sucesso: false,
          erro: 'Usuário inativo. Entre em contato com o suporte.',
        );
      }

      // Verificar assinatura
      final assinatura = await _repository.getAssinaturaAtiva(usuario.id!);
      
      if (assinatura == null) {
        return LoginResult(
          sucesso: false,
          usuario: usuario,
          erro: 'Nenhuma assinatura ativa encontrada',
        );
      }

      // Verificar se a assinatura permite acesso
      if (!assinatura.permiteAcesso) {
        return LoginResult(
          sucesso: false,
          usuario: usuario,
          assinatura: assinatura,
          assinaturaExpirada: assinatura.isExpirada,
          erro: assinatura.isExpirada 
              ? 'Sua assinatura expirou. Renove para continuar usando o sistema.'
              : 'Assinatura ${assinatura.status.nome.toLowerCase()}. Entre em contato com o suporte.',
        );
      }

      // Atualizar último login
      await _repository.atualizarUltimoLogin(usuario.id!);

      return LoginResult(
        sucesso: true,
        usuario: usuario,
        assinatura: assinatura,
        diasRestantes: assinatura.diasRestantes,
      );
    } catch (e) {
      return LoginResult(
        sucesso: false,
        erro: 'Erro interno: ${e.toString()}',
      );
    }
  }
}