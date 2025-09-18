import '../entities/usuario_entity.dart';
import '../entities/assinatura_entity.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/database/enums/user_role.dart';

class AdminService {
  final AuthRepository _authRepository;

  AdminService(this._authRepository);

  /// Cria o usuário administrador padrão se não existir
  Future<UsuarioEntity?> criarAdminPadrao() async {
    try {
      // Verificar se já existe um admin
      final adminExistente = await _verificarAdminExistente();
      if (adminExistente != null) {
        return adminExistente;
      }

      // Criar usuário admin padrão
      final agora = DateTime.now();
      final adminPadrao = UsuarioEntity(
        nome: 'Administrador',
        email: 'admin@autogestor.com',
        empresa: 'AutoGestor Admin',
        role: UserRole.admin,
        ativo: true,
        criadoEm: agora,
        atualizadoEm: agora,
      );

      // Criar usuário com senha padrão
      final usuarioCriado = await _authRepository.criarUsuario(adminPadrao, 'admin123');

      // Criar assinatura permanente para o admin
      final assinatura = AssinaturaEntity(
        usuarioId: usuarioCriado.id!,
        tipo: TipoAssinatura.anual,
        status: StatusAssinatura.ativa,
        dataInicio: agora,
        dataFim: agora.add(const Duration(days: 36500)), // 100 anos
        criadoEm: agora,
        atualizadoEm: agora,
        valor: 0.0,
        pago: true,
        dataPagamento: agora,
        metodoPagamento: 'Sistema',
        observacoes: 'Assinatura permanente do administrador do sistema',
      );

      await _authRepository.criarAssinatura(assinatura);

      return usuarioCriado;
    } catch (e) {
      throw Exception('Erro ao criar administrador padrão: $e');
    }
  }

  /// Verifica se existe um usuário administrador
  Future<UsuarioEntity?> _verificarAdminExistente() async {
    try {
      // Tentar fazer login com credenciais padrão do admin
      final admin = await _authRepository.login('admin@autogestor.com', 'admin123');
      if (admin != null && admin.role.isAdmin) {
        return admin;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Verifica se um usuário é administrador
  bool isAdmin(UsuarioEntity? usuario) {
    return usuario?.role.isAdmin ?? false;
  }

  /// Lista todos os usuários administradores
  Future<List<UsuarioEntity>> listarAdministradores() async {
    // Esta funcionalidade precisaria ser implementada no repository
    // Por enquanto, retorna lista vazia
    return [];
  }

  /// Promove um usuário para administrador
  Future<UsuarioEntity> promoverParaAdmin(UsuarioEntity usuario) async {
    final usuarioAtualizado = usuario.copyWith(role: UserRole.admin);
    return await _authRepository.atualizarUsuario(usuarioAtualizado);
  }

  /// Remove privilégios de administrador de um usuário
  Future<UsuarioEntity> removerPrivilegiosAdmin(UsuarioEntity usuario) async {
    final usuarioAtualizado = usuario.copyWith(role: UserRole.user);
    return await _authRepository.atualizarUsuario(usuarioAtualizado);
  }
}