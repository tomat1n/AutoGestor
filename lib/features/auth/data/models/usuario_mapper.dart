import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/models/usuario_table.dart' as db;
import '../../../../core/database/enums/user_role.dart';
import '../../domain/entities/usuario_entity.dart' as entity;

class UsuarioMapper {
  static entity.UsuarioEntity fromDatabase(Usuario usuario) {
    return entity.UsuarioEntity(
      id: usuario.id,
      nome: usuario.nome,
      email: usuario.email,
      empresa: usuario.empresa,
      cnpj: usuario.cnpj,
      telefone: usuario.telefone,
      endereco: usuario.endereco,
      cidade: usuario.cidade,
      estado: usuario.estado,
      cep: usuario.cep,
      logoPath: usuario.logoPath,
      corPrimaria: usuario.corPrimaria,
      corSecundaria: usuario.corSecundaria,
      nomeFantasia: usuario.nomeFantasia,
      role: UserRole.fromString(usuario.role),
      ativo: usuario.ativo,
      criadoEm: usuario.criadoEm,
      atualizadoEm: usuario.atualizadoEm,
      ultimoLogin: usuario.ultimoLogin,
    );
  }

  static UsuarioTableCompanion toCompanion(entity.UsuarioEntity usuario) {
    return UsuarioTableCompanion(
      id: usuario.id != null ? Value(usuario.id!) : const Value.absent(),
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
      criadoEm: Value(usuario.criadoEm),
      atualizadoEm: Value(usuario.atualizadoEm),
      ultimoLogin: Value(usuario.ultimoLogin),
    );
  }
}