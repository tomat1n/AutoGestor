import '../entities/usuario_entity.dart';
import '../entities/assinatura_entity.dart';
import '../repositories/auth_repository.dart';

class CriarPeriodoTesteResult {
  final bool sucesso;
  final AssinaturaEntity? assinatura;
  final String? erro;

  const CriarPeriodoTesteResult({
    required this.sucesso,
    this.assinatura,
    this.erro,
  });
}

class CriarPeriodoTesteUseCase {
  final AuthRepository _repository;

  CriarPeriodoTesteUseCase(this._repository);

  Future<CriarPeriodoTesteResult> execute(UsuarioEntity usuario) async {
    try {
      // Verificar se já usou período de teste
      final jaUsouTeste = await _repository.jaUsouPeriodoTeste(usuario.email);
      
      if (jaUsouTeste) {
        return const CriarPeriodoTesteResult(
          sucesso: false,
          erro: 'Este email já utilizou o período de teste',
        );
      }

      // Verificar se já tem assinatura ativa
      final assinaturaExistente = await _repository.getAssinaturaAtiva(usuario.id!);
      
      if (assinaturaExistente != null && assinaturaExistente.permiteAcesso) {
        return const CriarPeriodoTesteResult(
          sucesso: false,
          erro: 'Usuário já possui assinatura ativa',
        );
      }

      // Criar período de teste
      final agora = DateTime.now();
      final dataFim = agora.add(Duration(days: TipoAssinatura.teste.diasDuracao));
      
      final novaAssinatura = AssinaturaEntity(
        usuarioId: usuario.id!,
        tipo: TipoAssinatura.teste,
        status: StatusAssinatura.ativa,
        dataInicio: agora,
        dataFim: dataFim,
        criadoEm: agora,
        atualizadoEm: agora,
        valor: TipoAssinatura.teste.valor,
        pago: true, // Período de teste é "gratuito"
        dataPagamento: agora,
        metodoPagamento: 'Período de Teste',
        observacoes: 'Período de teste de ${TipoAssinatura.teste.diasDuracao} dias',
      );

      final assinaturaCriada = await _repository.criarAssinatura(novaAssinatura);

      return CriarPeriodoTesteResult(
        sucesso: true,
        assinatura: assinaturaCriada,
      );
    } catch (e) {
      return CriarPeriodoTesteResult(
        sucesso: false,
        erro: 'Erro ao criar período de teste: ${e.toString()}',
      );
    }
  }
}