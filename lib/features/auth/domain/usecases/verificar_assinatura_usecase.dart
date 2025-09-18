import '../entities/assinatura_entity.dart';
import '../repositories/auth_repository.dart';

class StatusAssinaturaResult {
  final bool ativa;
  final bool expirada;
  final bool isTeste;
  final int diasRestantes;
  final AssinaturaEntity? assinatura;
  final String mensagem;

  const StatusAssinaturaResult({
    required this.ativa,
    required this.expirada,
    required this.isTeste,
    required this.diasRestantes,
    this.assinatura,
    required this.mensagem,
  });
}

class VerificarAssinaturaUseCase {
  final AuthRepository _repository;

  VerificarAssinaturaUseCase(this._repository);

  Future<StatusAssinaturaResult> execute(int usuarioId) async {
    try {
      final assinatura = await _repository.getAssinaturaAtiva(usuarioId);
      
      if (assinatura == null) {
        return const StatusAssinaturaResult(
          ativa: false,
          expirada: true,
          isTeste: false,
          diasRestantes: 0,
          mensagem: 'Nenhuma assinatura encontrada',
        );
      }

      final diasRestantes = assinatura.diasRestantes;
      final isExpirada = assinatura.isExpirada;
      final isTeste = assinatura.isTeste;
      final ativa = assinatura.permiteAcesso;

      String mensagem;
      if (isExpirada) {
        mensagem = isTeste 
            ? 'Seu período de teste expirou'
            : 'Sua assinatura expirou';
      } else if (isTeste) {
        mensagem = diasRestantes == 1 
            ? 'Último dia do período de teste'
            : 'Restam $diasRestantes dias do período de teste';
      } else {
        if (diasRestantes <= 7) {
          mensagem = diasRestantes == 1 
              ? 'Sua assinatura expira amanhã'
              : 'Sua assinatura expira em $diasRestantes dias';
        } else {
          mensagem = 'Assinatura ativa - $diasRestantes dias restantes';
        }
      }

      return StatusAssinaturaResult(
        ativa: ativa,
        expirada: isExpirada,
        isTeste: isTeste,
        diasRestantes: diasRestantes,
        assinatura: assinatura,
        mensagem: mensagem,
      );
    } catch (e) {
      return StatusAssinaturaResult(
        ativa: false,
        expirada: true,
        isTeste: false,
        diasRestantes: 0,
        mensagem: 'Erro ao verificar assinatura: ${e.toString()}',
      );
    }
  }
}