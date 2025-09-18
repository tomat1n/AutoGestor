import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/models/assinatura_table.dart' as db;
import '../../domain/entities/usuario_entity.dart';
import '../../domain/entities/assinatura_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/usuario_mapper.dart';
import '../models/assinatura_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AppDatabase _database;
  UsuarioEntity? _usuarioLogado;
  static const String _keyUsuarioLogado = 'usuario_logado';

  AuthRepositoryImpl(this._database);

  // Função para hash da senha
  String _hashSenha(String senha) {
    final bytes = utf8.encode(senha);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<UsuarioEntity?> login(String email, String senha) async {
    try {
      final senhaHash = _hashSenha(senha);
      
      final query = _database.select(_database.usuarioTable)
        ..where((u) => u.email.equals(email) & u.senha.equals(senhaHash) & u.ativo.equals(true));
      
      final usuario = await query.getSingleOrNull();
      
      if (usuario != null) {
        _usuarioLogado = UsuarioMapper.fromDatabase(usuario);
        
        // Salvar usuário no SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final usuarioJson = jsonEncode({
          'id': _usuarioLogado!.id,
          'nome': _usuarioLogado!.nome,
          'email': _usuarioLogado!.email,
          'empresa': _usuarioLogado!.empresa,
          'cnpj': _usuarioLogado!.cnpj,
          'telefone': _usuarioLogado!.telefone,
          'endereco': _usuarioLogado!.endereco,
          'cidade': _usuarioLogado!.cidade,
          'estado': _usuarioLogado!.estado,
          'cep': _usuarioLogado!.cep,
          'logoPath': _usuarioLogado!.logoPath,
          'corPrimaria': _usuarioLogado!.corPrimaria,
          'corSecundaria': _usuarioLogado!.corSecundaria,
          'nomeFantasia': _usuarioLogado!.nomeFantasia,
          'role': _usuarioLogado!.role.value,
          'ativo': _usuarioLogado!.ativo,
          'criadoEm': _usuarioLogado!.criadoEm?.toIso8601String(),
          'atualizadoEm': _usuarioLogado!.atualizadoEm?.toIso8601String(),
        });
        await prefs.setString(_keyUsuarioLogado, usuarioJson);
        
        return _usuarioLogado;
      }
      
      return null;
    } catch (e) {
      throw Exception('Erro ao fazer login: $e');
    }
  }

  @override
  Future<void> logout() async {
    _usuarioLogado = null;
    
    // Remover usuário do SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsuarioLogado);
  }

  @override
  Future<UsuarioEntity?> getUsuarioLogado() async {
    if (_usuarioLogado != null) {
      return _usuarioLogado;
    }
    
    // Tentar recuperar do SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final usuarioJson = prefs.getString(_keyUsuarioLogado);
    
    if (usuarioJson != null) {
      try {
        final usuarioMap = jsonDecode(usuarioJson) as Map<String, dynamic>;
        _usuarioLogado = UsuarioEntity.fromJson(usuarioMap);
        return _usuarioLogado;
      } catch (e) {
        // Se houver erro ao decodificar, remover dados corrompidos
        await prefs.remove(_keyUsuarioLogado);
      }
    }
    
    return null;
  }

  @override
  Future<bool> isLogado() async {
    final usuario = await getUsuarioLogado();
    return usuario != null;
  }

  @override
  Future<UsuarioEntity> criarUsuario(UsuarioEntity usuario, String senha) async {
    try {
      final senhaHash = _hashSenha(senha);
      final agora = DateTime.now();
      
      final companion = UsuarioTableCompanion.insert(
        nome: usuario.nome,
        email: usuario.email,
        senha: senhaHash,
        empresa: usuario.empresa,
        cnpj: Value(usuario.cnpj),
        telefone: Value(usuario.telefone),
        endereco: Value(usuario.endereco),
        cidade: Value(usuario.cidade),
        estado: Value(usuario.estado),
        cep: Value(usuario.cep),
        logoPath: Value(usuario.logoPath),
        corPrimaria: Value(usuario.corPrimaria),
        corSecundaria: Value(usuario.corSecundaria),
        nomeFantasia: Value(usuario.nomeFantasia),
        role: Value(usuario.role.value),
        ativo: Value(usuario.ativo),
        criadoEm: Value(agora),
        atualizadoEm: Value(agora),
      );
      
      final id = await _database.into(_database.usuarioTable).insert(companion);
      
      return usuario.copyWith(id: id, criadoEm: agora, atualizadoEm: agora);
    } catch (e) {
      throw Exception('Erro ao criar usuário: $e');
    }
  }

  @override
  Future<UsuarioEntity> atualizarUsuario(UsuarioEntity usuario) async {
    try {
      final agora = DateTime.now();
      
      final companion = UsuarioTableCompanion(
        id: Value(usuario.id!),
        nome: Value(usuario.nome),
        email: Value(usuario.email),
        empresa: Value(usuario.empresa),
        cnpj: Value(usuario.cnpj),
        telefone: Value(usuario.telefone),
        endereco: Value(usuario.endereco),
        cidade: Value(usuario.cidade),
        estado: Value(usuario.estado),
        cep: Value(usuario.cep),
        logoPath: Value(usuario.logoPath),
        corPrimaria: Value(usuario.corPrimaria),
        corSecundaria: Value(usuario.corSecundaria),
        nomeFantasia: Value(usuario.nomeFantasia),
        role: Value(usuario.role.value),
        ativo: Value(usuario.ativo),
        atualizadoEm: Value(agora),
      );
      
      await _database.update(_database.usuarioTable).replace(companion);
      
      final usuarioAtualizado = usuario.copyWith(atualizadoEm: agora);
      
      // Atualizar usuário logado se for o mesmo
      if (_usuarioLogado?.id == usuario.id) {
        _usuarioLogado = usuarioAtualizado;
      }
      
      return usuarioAtualizado;
    } catch (e) {
      throw Exception('Erro ao atualizar usuário: $e');
    }
  }

  @override
  Future<void> atualizarSenha(int usuarioId, String novaSenha) async {
    try {
      final senhaHash = _hashSenha(novaSenha);
      final agora = DateTime.now();
      
      await (_database.update(_database.usuarioTable)
        ..where((u) => u.id.equals(usuarioId)))
        .write(UsuarioTableCompanion(
          senha: Value(senhaHash),
          atualizadoEm: Value(agora),
        ));
    } catch (e) {
      throw Exception('Erro ao atualizar senha: $e');
    }
  }

  @override
  Future<void> atualizarUltimoLogin(int usuarioId) async {
    try {
      final agora = DateTime.now();
      
      await (_database.update(_database.usuarioTable)
        ..where((u) => u.id.equals(usuarioId)))
        .write(UsuarioTableCompanion(
          ultimoLogin: Value(agora),
          atualizadoEm: Value(agora),
        ));
    } catch (e) {
      throw Exception('Erro ao atualizar último login: $e');
    }
  }

  @override
  Future<AssinaturaEntity?> getAssinaturaAtiva(int usuarioId) async {
    try {
      final query = _database.select(_database.assinaturaTable)
        ..where((a) => a.usuarioId.equals(usuarioId) & 
                      a.status.equals(StatusAssinatura.ativa.index))
        ..orderBy([(a) => OrderingTerm(expression: a.criadoEm, mode: OrderingMode.desc)]);
      
      final assinatura = await query.getSingleOrNull();
      
      if (assinatura != null) {
        return AssinaturaMapper.fromDatabase(assinatura);
      }
      
      return null;
    } catch (e) {
      throw Exception('Erro ao buscar assinatura ativa: $e');
    }
  }

  @override
  Future<AssinaturaEntity> criarAssinatura(AssinaturaEntity assinatura) async {
    try {
      final companion = AssinaturaTableCompanion.insert(
        usuarioId: assinatura.usuarioId,
        tipo: db.TipoAssinatura.values[assinatura.tipo.index],
        status: Value(db.StatusAssinatura.values[assinatura.status.index]),
        dataInicio: assinatura.dataInicio,
        dataFim: assinatura.dataFim,
        criadoEm: Value(assinatura.criadoEm),
        atualizadoEm: Value(assinatura.atualizadoEm),
        valor: Value(assinatura.valor),
        pago: Value(assinatura.pago),
        dataPagamento: Value(assinatura.dataPagamento),
        metodoPagamento: Value(assinatura.metodoPagamento),
        transacaoId: Value(assinatura.transacaoId),
        observacoes: Value(assinatura.observacoes),
      );
      
      final id = await _database.into(_database.assinaturaTable).insert(companion);
      
      return assinatura.copyWith(id: id);
    } catch (e) {
      throw Exception('Erro ao criar assinatura: $e');
    }
  }

  @override
  Future<AssinaturaEntity> atualizarAssinatura(AssinaturaEntity assinatura) async {
    try {
      final agora = DateTime.now();
      
      final companion = AssinaturaTableCompanion(
        id: Value(assinatura.id!),
        usuarioId: Value(assinatura.usuarioId),
        tipo: Value(db.TipoAssinatura.values[assinatura.tipo.index]),
        status: Value(db.StatusAssinatura.values[assinatura.status.index]),
        dataInicio: Value(assinatura.dataInicio),
        dataFim: Value(assinatura.dataFim),
        atualizadoEm: Value(agora),
        valor: Value(assinatura.valor),
        pago: Value(assinatura.pago),
        dataPagamento: Value(assinatura.dataPagamento),
        metodoPagamento: Value(assinatura.metodoPagamento),
        transacaoId: Value(assinatura.transacaoId),
        observacoes: Value(assinatura.observacoes),
      );
      
      await _database.update(_database.assinaturaTable).replace(companion);
      
      return assinatura.copyWith(atualizadoEm: agora);
    } catch (e) {
      throw Exception('Erro ao atualizar assinatura: $e');
    }
  }

  @override
  Future<List<AssinaturaEntity>> getHistoricoAssinaturas(int usuarioId) async {
    try {
      final query = _database.select(_database.assinaturaTable)
        ..where((a) => a.usuarioId.equals(usuarioId))
        ..orderBy([(a) => OrderingTerm(expression: a.criadoEm, mode: OrderingMode.desc)]);
      
      final assinaturas = await query.get();
      
      return assinaturas.map((a) => AssinaturaMapper.fromDatabase(a)).toList();
    } catch (e) {
      throw Exception('Erro ao buscar histórico de assinaturas: $e');
    }
  }

  @override
  Future<bool> verificarAcessoPermitido(int usuarioId) async {
    try {
      final assinatura = await getAssinaturaAtiva(usuarioId);
      return assinatura?.permiteAcesso ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int> getDiasRestantes(int usuarioId) async {
    try {
      final assinatura = await getAssinaturaAtiva(usuarioId);
      return assinatura?.diasRestantes ?? 0;
    } catch (e) {
      return 0;
    }
  }

  @override
  Future<bool> isAssinaturaExpirada(int usuarioId) async {
    try {
      final assinatura = await getAssinaturaAtiva(usuarioId);
      return assinatura?.isExpirada ?? true;
    } catch (e) {
      return true;
    }
  }

  @override
  Future<AssinaturaEntity> criarPeriodoTeste(int usuarioId) async {
    try {
      final agora = DateTime.now();
      final dataFim = agora.add(Duration(days: TipoAssinatura.teste.diasDuracao));
      
      final assinaturaTeste = AssinaturaEntity(
        usuarioId: usuarioId,
        tipo: TipoAssinatura.teste,
        status: StatusAssinatura.ativa,
        dataInicio: agora,
        dataFim: dataFim,
        criadoEm: agora,
        atualizadoEm: agora,
        valor: TipoAssinatura.teste.valor,
        pago: true,
        dataPagamento: agora,
        metodoPagamento: 'Período de Teste',
        observacoes: 'Período de teste de ${TipoAssinatura.teste.diasDuracao} dias',
      );
      
      return await criarAssinatura(assinaturaTeste);
    } catch (e) {
      throw Exception('Erro ao criar período de teste: $e');
    }
  }

  @override
  Future<bool> jaUsouPeriodoTeste(String email) async {
    try {
      // Buscar usuário pelo email
      final queryUsuario = _database.select(_database.usuarioTable)
        ..where((u) => u.email.equals(email));
      
      final usuario = await queryUsuario.getSingleOrNull();
      
      if (usuario == null) return false;
      
      // Verificar se já tem assinatura de teste
      final queryAssinatura = _database.select(_database.assinaturaTable)
        ..where((a) => a.usuarioId.equals(usuario.id!) &
                      a.tipo.equals(TipoAssinatura.teste.index));
      
      final assinaturaTeste = await queryAssinatura.getSingleOrNull();
      
      return assinaturaTeste != null;
    } catch (e) {
      return false;
    }
  }
}