// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProdutoTableTable extends ProdutoTable
    with TableInfo<$ProdutoTableTable, ProdutoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProdutoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _precoCompraMeta =
      const VerificationMeta('precoCompra');
  @override
  late final GeneratedColumn<double> precoCompra = GeneratedColumn<double>(
      'preco_compra', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _precoVendaMeta =
      const VerificationMeta('precoVenda');
  @override
  late final GeneratedColumn<double> precoVenda = GeneratedColumn<double>(
      'preco_venda', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _estoqueMinimoMeta =
      const VerificationMeta('estoqueMinimo');
  @override
  late final GeneratedColumn<int> estoqueMinimo = GeneratedColumn<int>(
      'estoque_minimo', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _quantidadeMeta =
      const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _unidadeMeta =
      const VerificationMeta('unidade');
  @override
  late final GeneratedColumn<String> unidade = GeneratedColumn<String>(
      'unidade', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('UN'));
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _codigoBarrasMeta =
      const VerificationMeta('codigoBarras');
  @override
  late final GeneratedColumn<String> codigoBarras = GeneratedColumn<String>(
      'codigo_barras', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _qrCodeMeta = const VerificationMeta('qrCode');
  @override
  late final GeneratedColumn<String> qrCode = GeneratedColumn<String>(
      'qr_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imagemPathMeta =
      const VerificationMeta('imagemPath');
  @override
  late final GeneratedColumn<String> imagemPath = GeneratedColumn<String>(
      'imagem_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        codigo,
        nome,
        descricao,
        precoCompra,
        precoVenda,
        estoqueMinimo,
        quantidade,
        unidade,
        categoria,
        codigoBarras,
        qrCode,
        imagemPath,
        ativo,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'produto_table';
  @override
  VerificationContext validateIntegrity(Insertable<ProdutoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    if (data.containsKey('preco_compra')) {
      context.handle(
          _precoCompraMeta,
          precoCompra.isAcceptableOrUnknown(
              data['preco_compra']!, _precoCompraMeta));
    }
    if (data.containsKey('preco_venda')) {
      context.handle(
          _precoVendaMeta,
          precoVenda.isAcceptableOrUnknown(
              data['preco_venda']!, _precoVendaMeta));
    } else if (isInserting) {
      context.missing(_precoVendaMeta);
    }
    if (data.containsKey('estoque_minimo')) {
      context.handle(
          _estoqueMinimoMeta,
          estoqueMinimo.isAcceptableOrUnknown(
              data['estoque_minimo']!, _estoqueMinimoMeta));
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    }
    if (data.containsKey('unidade')) {
      context.handle(_unidadeMeta,
          unidade.isAcceptableOrUnknown(data['unidade']!, _unidadeMeta));
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    }
    if (data.containsKey('codigo_barras')) {
      context.handle(
          _codigoBarrasMeta,
          codigoBarras.isAcceptableOrUnknown(
              data['codigo_barras']!, _codigoBarrasMeta));
    }
    if (data.containsKey('qr_code')) {
      context.handle(_qrCodeMeta,
          qrCode.isAcceptableOrUnknown(data['qr_code']!, _qrCodeMeta));
    }
    if (data.containsKey('imagem_path')) {
      context.handle(
          _imagemPathMeta,
          imagemPath.isAcceptableOrUnknown(
              data['imagem_path']!, _imagemPathMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProdutoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProdutoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao']),
      precoCompra: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}preco_compra'])!,
      precoVenda: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}preco_venda'])!,
      estoqueMinimo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estoque_minimo'])!,
      quantidade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
      unidade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unidade'])!,
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria']),
      codigoBarras: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo_barras']),
      qrCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}qr_code']),
      imagemPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}imagem_path']),
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProdutoTableTable createAlias(String alias) {
    return $ProdutoTableTable(attachedDatabase, alias);
  }
}

class ProdutoTableData extends DataClass
    implements Insertable<ProdutoTableData> {
  final int id;
  final String codigo;
  final String nome;
  final String? descricao;
  final double precoCompra;
  final double precoVenda;
  final int estoqueMinimo;
  final int quantidade;
  final String unidade;
  final String? categoria;
  final String? codigoBarras;
  final String? qrCode;
  final String? imagemPath;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ProdutoTableData(
      {required this.id,
      required this.codigo,
      required this.nome,
      this.descricao,
      required this.precoCompra,
      required this.precoVenda,
      required this.estoqueMinimo,
      required this.quantidade,
      required this.unidade,
      this.categoria,
      this.codigoBarras,
      this.qrCode,
      this.imagemPath,
      required this.ativo,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['codigo'] = Variable<String>(codigo);
    map['nome'] = Variable<String>(nome);
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    map['preco_compra'] = Variable<double>(precoCompra);
    map['preco_venda'] = Variable<double>(precoVenda);
    map['estoque_minimo'] = Variable<int>(estoqueMinimo);
    map['quantidade'] = Variable<int>(quantidade);
    map['unidade'] = Variable<String>(unidade);
    if (!nullToAbsent || categoria != null) {
      map['categoria'] = Variable<String>(categoria);
    }
    if (!nullToAbsent || codigoBarras != null) {
      map['codigo_barras'] = Variable<String>(codigoBarras);
    }
    if (!nullToAbsent || qrCode != null) {
      map['qr_code'] = Variable<String>(qrCode);
    }
    if (!nullToAbsent || imagemPath != null) {
      map['imagem_path'] = Variable<String>(imagemPath);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProdutoTableCompanion toCompanion(bool nullToAbsent) {
    return ProdutoTableCompanion(
      id: Value(id),
      codigo: Value(codigo),
      nome: Value(nome),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
      precoCompra: Value(precoCompra),
      precoVenda: Value(precoVenda),
      estoqueMinimo: Value(estoqueMinimo),
      quantidade: Value(quantidade),
      unidade: Value(unidade),
      categoria: categoria == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria),
      codigoBarras: codigoBarras == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoBarras),
      qrCode:
          qrCode == null && nullToAbsent ? const Value.absent() : Value(qrCode),
      imagemPath: imagemPath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagemPath),
      ativo: Value(ativo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProdutoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProdutoTableData(
      id: serializer.fromJson<int>(json['id']),
      codigo: serializer.fromJson<String>(json['codigo']),
      nome: serializer.fromJson<String>(json['nome']),
      descricao: serializer.fromJson<String?>(json['descricao']),
      precoCompra: serializer.fromJson<double>(json['precoCompra']),
      precoVenda: serializer.fromJson<double>(json['precoVenda']),
      estoqueMinimo: serializer.fromJson<int>(json['estoqueMinimo']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      unidade: serializer.fromJson<String>(json['unidade']),
      categoria: serializer.fromJson<String?>(json['categoria']),
      codigoBarras: serializer.fromJson<String?>(json['codigoBarras']),
      qrCode: serializer.fromJson<String?>(json['qrCode']),
      imagemPath: serializer.fromJson<String?>(json['imagemPath']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'codigo': serializer.toJson<String>(codigo),
      'nome': serializer.toJson<String>(nome),
      'descricao': serializer.toJson<String?>(descricao),
      'precoCompra': serializer.toJson<double>(precoCompra),
      'precoVenda': serializer.toJson<double>(precoVenda),
      'estoqueMinimo': serializer.toJson<int>(estoqueMinimo),
      'quantidade': serializer.toJson<int>(quantidade),
      'unidade': serializer.toJson<String>(unidade),
      'categoria': serializer.toJson<String?>(categoria),
      'codigoBarras': serializer.toJson<String?>(codigoBarras),
      'qrCode': serializer.toJson<String?>(qrCode),
      'imagemPath': serializer.toJson<String?>(imagemPath),
      'ativo': serializer.toJson<bool>(ativo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProdutoTableData copyWith(
          {int? id,
          String? codigo,
          String? nome,
          Value<String?> descricao = const Value.absent(),
          double? precoCompra,
          double? precoVenda,
          int? estoqueMinimo,
          int? quantidade,
          String? unidade,
          Value<String?> categoria = const Value.absent(),
          Value<String?> codigoBarras = const Value.absent(),
          Value<String?> qrCode = const Value.absent(),
          Value<String?> imagemPath = const Value.absent(),
          bool? ativo,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ProdutoTableData(
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
        descricao: descricao.present ? descricao.value : this.descricao,
        precoCompra: precoCompra ?? this.precoCompra,
        precoVenda: precoVenda ?? this.precoVenda,
        estoqueMinimo: estoqueMinimo ?? this.estoqueMinimo,
        quantidade: quantidade ?? this.quantidade,
        unidade: unidade ?? this.unidade,
        categoria: categoria.present ? categoria.value : this.categoria,
        codigoBarras:
            codigoBarras.present ? codigoBarras.value : this.codigoBarras,
        qrCode: qrCode.present ? qrCode.value : this.qrCode,
        imagemPath: imagemPath.present ? imagemPath.value : this.imagemPath,
        ativo: ativo ?? this.ativo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ProdutoTableData copyWithCompanion(ProdutoTableCompanion data) {
    return ProdutoTableData(
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      nome: data.nome.present ? data.nome.value : this.nome,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      precoCompra:
          data.precoCompra.present ? data.precoCompra.value : this.precoCompra,
      precoVenda:
          data.precoVenda.present ? data.precoVenda.value : this.precoVenda,
      estoqueMinimo: data.estoqueMinimo.present
          ? data.estoqueMinimo.value
          : this.estoqueMinimo,
      quantidade:
          data.quantidade.present ? data.quantidade.value : this.quantidade,
      unidade: data.unidade.present ? data.unidade.value : this.unidade,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      codigoBarras: data.codigoBarras.present
          ? data.codigoBarras.value
          : this.codigoBarras,
      qrCode: data.qrCode.present ? data.qrCode.value : this.qrCode,
      imagemPath:
          data.imagemPath.present ? data.imagemPath.value : this.imagemPath,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProdutoTableData(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('precoCompra: $precoCompra, ')
          ..write('precoVenda: $precoVenda, ')
          ..write('estoqueMinimo: $estoqueMinimo, ')
          ..write('quantidade: $quantidade, ')
          ..write('unidade: $unidade, ')
          ..write('categoria: $categoria, ')
          ..write('codigoBarras: $codigoBarras, ')
          ..write('qrCode: $qrCode, ')
          ..write('imagemPath: $imagemPath, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      codigo,
      nome,
      descricao,
      precoCompra,
      precoVenda,
      estoqueMinimo,
      quantidade,
      unidade,
      categoria,
      codigoBarras,
      qrCode,
      imagemPath,
      ativo,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProdutoTableData &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.nome == this.nome &&
          other.descricao == this.descricao &&
          other.precoCompra == this.precoCompra &&
          other.precoVenda == this.precoVenda &&
          other.estoqueMinimo == this.estoqueMinimo &&
          other.quantidade == this.quantidade &&
          other.unidade == this.unidade &&
          other.categoria == this.categoria &&
          other.codigoBarras == this.codigoBarras &&
          other.qrCode == this.qrCode &&
          other.imagemPath == this.imagemPath &&
          other.ativo == this.ativo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProdutoTableCompanion extends UpdateCompanion<ProdutoTableData> {
  final Value<int> id;
  final Value<String> codigo;
  final Value<String> nome;
  final Value<String?> descricao;
  final Value<double> precoCompra;
  final Value<double> precoVenda;
  final Value<int> estoqueMinimo;
  final Value<int> quantidade;
  final Value<String> unidade;
  final Value<String?> categoria;
  final Value<String?> codigoBarras;
  final Value<String?> qrCode;
  final Value<String?> imagemPath;
  final Value<bool> ativo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProdutoTableCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.descricao = const Value.absent(),
    this.precoCompra = const Value.absent(),
    this.precoVenda = const Value.absent(),
    this.estoqueMinimo = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.unidade = const Value.absent(),
    this.categoria = const Value.absent(),
    this.codigoBarras = const Value.absent(),
    this.qrCode = const Value.absent(),
    this.imagemPath = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProdutoTableCompanion.insert({
    this.id = const Value.absent(),
    required String codigo,
    required String nome,
    this.descricao = const Value.absent(),
    this.precoCompra = const Value.absent(),
    required double precoVenda,
    this.estoqueMinimo = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.unidade = const Value.absent(),
    this.categoria = const Value.absent(),
    this.codigoBarras = const Value.absent(),
    this.qrCode = const Value.absent(),
    this.imagemPath = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : codigo = Value(codigo),
        nome = Value(nome),
        precoVenda = Value(precoVenda);
  static Insertable<ProdutoTableData> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? nome,
    Expression<String>? descricao,
    Expression<double>? precoCompra,
    Expression<double>? precoVenda,
    Expression<int>? estoqueMinimo,
    Expression<int>? quantidade,
    Expression<String>? unidade,
    Expression<String>? categoria,
    Expression<String>? codigoBarras,
    Expression<String>? qrCode,
    Expression<String>? imagemPath,
    Expression<bool>? ativo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
      if (descricao != null) 'descricao': descricao,
      if (precoCompra != null) 'preco_compra': precoCompra,
      if (precoVenda != null) 'preco_venda': precoVenda,
      if (estoqueMinimo != null) 'estoque_minimo': estoqueMinimo,
      if (quantidade != null) 'quantidade': quantidade,
      if (unidade != null) 'unidade': unidade,
      if (categoria != null) 'categoria': categoria,
      if (codigoBarras != null) 'codigo_barras': codigoBarras,
      if (qrCode != null) 'qr_code': qrCode,
      if (imagemPath != null) 'imagem_path': imagemPath,
      if (ativo != null) 'ativo': ativo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProdutoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? codigo,
      Value<String>? nome,
      Value<String?>? descricao,
      Value<double>? precoCompra,
      Value<double>? precoVenda,
      Value<int>? estoqueMinimo,
      Value<int>? quantidade,
      Value<String>? unidade,
      Value<String?>? categoria,
      Value<String?>? codigoBarras,
      Value<String?>? qrCode,
      Value<String?>? imagemPath,
      Value<bool>? ativo,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ProdutoTableCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      precoCompra: precoCompra ?? this.precoCompra,
      precoVenda: precoVenda ?? this.precoVenda,
      estoqueMinimo: estoqueMinimo ?? this.estoqueMinimo,
      quantidade: quantidade ?? this.quantidade,
      unidade: unidade ?? this.unidade,
      categoria: categoria ?? this.categoria,
      codigoBarras: codigoBarras ?? this.codigoBarras,
      qrCode: qrCode ?? this.qrCode,
      imagemPath: imagemPath ?? this.imagemPath,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (precoCompra.present) {
      map['preco_compra'] = Variable<double>(precoCompra.value);
    }
    if (precoVenda.present) {
      map['preco_venda'] = Variable<double>(precoVenda.value);
    }
    if (estoqueMinimo.present) {
      map['estoque_minimo'] = Variable<int>(estoqueMinimo.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    if (unidade.present) {
      map['unidade'] = Variable<String>(unidade.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (codigoBarras.present) {
      map['codigo_barras'] = Variable<String>(codigoBarras.value);
    }
    if (qrCode.present) {
      map['qr_code'] = Variable<String>(qrCode.value);
    }
    if (imagemPath.present) {
      map['imagem_path'] = Variable<String>(imagemPath.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdutoTableCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('precoCompra: $precoCompra, ')
          ..write('precoVenda: $precoVenda, ')
          ..write('estoqueMinimo: $estoqueMinimo, ')
          ..write('quantidade: $quantidade, ')
          ..write('unidade: $unidade, ')
          ..write('categoria: $categoria, ')
          ..write('codigoBarras: $codigoBarras, ')
          ..write('qrCode: $qrCode, ')
          ..write('imagemPath: $imagemPath, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FornecedorTableTable extends FornecedorTable
    with TableInfo<$FornecedorTableTable, FornecedorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FornecedorTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _razaoSocialMeta =
      const VerificationMeta('razaoSocial');
  @override
  late final GeneratedColumn<String> razaoSocial = GeneratedColumn<String>(
      'razao_social', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 150),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _cnpjMeta = const VerificationMeta('cnpj');
  @override
  late final GeneratedColumn<String> cnpj = GeneratedColumn<String>(
      'cnpj', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 18),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _cpfMeta = const VerificationMeta('cpf');
  @override
  late final GeneratedColumn<String> cpf = GeneratedColumn<String>(
      'cpf', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 14),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _enderecoMeta =
      const VerificationMeta('endereco');
  @override
  late final GeneratedColumn<String> endereco = GeneratedColumn<String>(
      'endereco', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _cidadeMeta = const VerificationMeta('cidade');
  @override
  late final GeneratedColumn<String> cidade = GeneratedColumn<String>(
      'cidade', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _cepMeta = const VerificationMeta('cep');
  @override
  late final GeneratedColumn<String> cep = GeneratedColumn<String>(
      'cep', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _atualizadoEmMeta =
      const VerificationMeta('atualizadoEm');
  @override
  late final GeneratedColumn<DateTime> atualizadoEm = GeneratedColumn<DateTime>(
      'atualizado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nome,
        razaoSocial,
        cnpj,
        cpf,
        email,
        telefone,
        endereco,
        cidade,
        estado,
        cep,
        ativo,
        criadoEm,
        atualizadoEm
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fornecedor_table';
  @override
  VerificationContext validateIntegrity(Insertable<FornecedorData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('razao_social')) {
      context.handle(
          _razaoSocialMeta,
          razaoSocial.isAcceptableOrUnknown(
              data['razao_social']!, _razaoSocialMeta));
    }
    if (data.containsKey('cnpj')) {
      context.handle(
          _cnpjMeta, cnpj.isAcceptableOrUnknown(data['cnpj']!, _cnpjMeta));
    }
    if (data.containsKey('cpf')) {
      context.handle(
          _cpfMeta, cpf.isAcceptableOrUnknown(data['cpf']!, _cpfMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    }
    if (data.containsKey('endereco')) {
      context.handle(_enderecoMeta,
          endereco.isAcceptableOrUnknown(data['endereco']!, _enderecoMeta));
    }
    if (data.containsKey('cidade')) {
      context.handle(_cidadeMeta,
          cidade.isAcceptableOrUnknown(data['cidade']!, _cidadeMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('cep')) {
      context.handle(
          _cepMeta, cep.isAcceptableOrUnknown(data['cep']!, _cepMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    }
    if (data.containsKey('atualizado_em')) {
      context.handle(
          _atualizadoEmMeta,
          atualizadoEm.isAcceptableOrUnknown(
              data['atualizado_em']!, _atualizadoEmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FornecedorData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FornecedorData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      razaoSocial: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}razao_social']),
      cnpj: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cnpj']),
      cpf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cpf']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      telefone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefone']),
      endereco: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endereco']),
      cidade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cidade']),
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado']),
      cep: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cep']),
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
      atualizadoEm: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}atualizado_em'])!,
    );
  }

  @override
  $FornecedorTableTable createAlias(String alias) {
    return $FornecedorTableTable(attachedDatabase, alias);
  }
}

class FornecedorData extends DataClass implements Insertable<FornecedorData> {
  final int id;
  final String nome;
  final String? razaoSocial;
  final String? cnpj;
  final String? cpf;
  final String? email;
  final String? telefone;
  final String? endereco;
  final String? cidade;
  final String? estado;
  final String? cep;
  final bool ativo;
  final DateTime criadoEm;
  final DateTime atualizadoEm;
  const FornecedorData(
      {required this.id,
      required this.nome,
      this.razaoSocial,
      this.cnpj,
      this.cpf,
      this.email,
      this.telefone,
      this.endereco,
      this.cidade,
      this.estado,
      this.cep,
      required this.ativo,
      required this.criadoEm,
      required this.atualizadoEm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    if (!nullToAbsent || razaoSocial != null) {
      map['razao_social'] = Variable<String>(razaoSocial);
    }
    if (!nullToAbsent || cnpj != null) {
      map['cnpj'] = Variable<String>(cnpj);
    }
    if (!nullToAbsent || cpf != null) {
      map['cpf'] = Variable<String>(cpf);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || telefone != null) {
      map['telefone'] = Variable<String>(telefone);
    }
    if (!nullToAbsent || endereco != null) {
      map['endereco'] = Variable<String>(endereco);
    }
    if (!nullToAbsent || cidade != null) {
      map['cidade'] = Variable<String>(cidade);
    }
    if (!nullToAbsent || estado != null) {
      map['estado'] = Variable<String>(estado);
    }
    if (!nullToAbsent || cep != null) {
      map['cep'] = Variable<String>(cep);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['criado_em'] = Variable<DateTime>(criadoEm);
    map['atualizado_em'] = Variable<DateTime>(atualizadoEm);
    return map;
  }

  FornecedorTableCompanion toCompanion(bool nullToAbsent) {
    return FornecedorTableCompanion(
      id: Value(id),
      nome: Value(nome),
      razaoSocial: razaoSocial == null && nullToAbsent
          ? const Value.absent()
          : Value(razaoSocial),
      cnpj: cnpj == null && nullToAbsent ? const Value.absent() : Value(cnpj),
      cpf: cpf == null && nullToAbsent ? const Value.absent() : Value(cpf),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      telefone: telefone == null && nullToAbsent
          ? const Value.absent()
          : Value(telefone),
      endereco: endereco == null && nullToAbsent
          ? const Value.absent()
          : Value(endereco),
      cidade:
          cidade == null && nullToAbsent ? const Value.absent() : Value(cidade),
      estado:
          estado == null && nullToAbsent ? const Value.absent() : Value(estado),
      cep: cep == null && nullToAbsent ? const Value.absent() : Value(cep),
      ativo: Value(ativo),
      criadoEm: Value(criadoEm),
      atualizadoEm: Value(atualizadoEm),
    );
  }

  factory FornecedorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FornecedorData(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      razaoSocial: serializer.fromJson<String?>(json['razaoSocial']),
      cnpj: serializer.fromJson<String?>(json['cnpj']),
      cpf: serializer.fromJson<String?>(json['cpf']),
      email: serializer.fromJson<String?>(json['email']),
      telefone: serializer.fromJson<String?>(json['telefone']),
      endereco: serializer.fromJson<String?>(json['endereco']),
      cidade: serializer.fromJson<String?>(json['cidade']),
      estado: serializer.fromJson<String?>(json['estado']),
      cep: serializer.fromJson<String?>(json['cep']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
      atualizadoEm: serializer.fromJson<DateTime>(json['atualizadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'razaoSocial': serializer.toJson<String?>(razaoSocial),
      'cnpj': serializer.toJson<String?>(cnpj),
      'cpf': serializer.toJson<String?>(cpf),
      'email': serializer.toJson<String?>(email),
      'telefone': serializer.toJson<String?>(telefone),
      'endereco': serializer.toJson<String?>(endereco),
      'cidade': serializer.toJson<String?>(cidade),
      'estado': serializer.toJson<String?>(estado),
      'cep': serializer.toJson<String?>(cep),
      'ativo': serializer.toJson<bool>(ativo),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
      'atualizadoEm': serializer.toJson<DateTime>(atualizadoEm),
    };
  }

  FornecedorData copyWith(
          {int? id,
          String? nome,
          Value<String?> razaoSocial = const Value.absent(),
          Value<String?> cnpj = const Value.absent(),
          Value<String?> cpf = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> telefone = const Value.absent(),
          Value<String?> endereco = const Value.absent(),
          Value<String?> cidade = const Value.absent(),
          Value<String?> estado = const Value.absent(),
          Value<String?> cep = const Value.absent(),
          bool? ativo,
          DateTime? criadoEm,
          DateTime? atualizadoEm}) =>
      FornecedorData(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        razaoSocial: razaoSocial.present ? razaoSocial.value : this.razaoSocial,
        cnpj: cnpj.present ? cnpj.value : this.cnpj,
        cpf: cpf.present ? cpf.value : this.cpf,
        email: email.present ? email.value : this.email,
        telefone: telefone.present ? telefone.value : this.telefone,
        endereco: endereco.present ? endereco.value : this.endereco,
        cidade: cidade.present ? cidade.value : this.cidade,
        estado: estado.present ? estado.value : this.estado,
        cep: cep.present ? cep.value : this.cep,
        ativo: ativo ?? this.ativo,
        criadoEm: criadoEm ?? this.criadoEm,
        atualizadoEm: atualizadoEm ?? this.atualizadoEm,
      );
  FornecedorData copyWithCompanion(FornecedorTableCompanion data) {
    return FornecedorData(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      razaoSocial:
          data.razaoSocial.present ? data.razaoSocial.value : this.razaoSocial,
      cnpj: data.cnpj.present ? data.cnpj.value : this.cnpj,
      cpf: data.cpf.present ? data.cpf.value : this.cpf,
      email: data.email.present ? data.email.value : this.email,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
      endereco: data.endereco.present ? data.endereco.value : this.endereco,
      cidade: data.cidade.present ? data.cidade.value : this.cidade,
      estado: data.estado.present ? data.estado.value : this.estado,
      cep: data.cep.present ? data.cep.value : this.cep,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
      atualizadoEm: data.atualizadoEm.present
          ? data.atualizadoEm.value
          : this.atualizadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FornecedorData(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('razaoSocial: $razaoSocial, ')
          ..write('cnpj: $cnpj, ')
          ..write('cpf: $cpf, ')
          ..write('email: $email, ')
          ..write('telefone: $telefone, ')
          ..write('endereco: $endereco, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('cep: $cep, ')
          ..write('ativo: $ativo, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, razaoSocial, cnpj, cpf, email,
      telefone, endereco, cidade, estado, cep, ativo, criadoEm, atualizadoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FornecedorData &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.razaoSocial == this.razaoSocial &&
          other.cnpj == this.cnpj &&
          other.cpf == this.cpf &&
          other.email == this.email &&
          other.telefone == this.telefone &&
          other.endereco == this.endereco &&
          other.cidade == this.cidade &&
          other.estado == this.estado &&
          other.cep == this.cep &&
          other.ativo == this.ativo &&
          other.criadoEm == this.criadoEm &&
          other.atualizadoEm == this.atualizadoEm);
}

class FornecedorTableCompanion extends UpdateCompanion<FornecedorData> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String?> razaoSocial;
  final Value<String?> cnpj;
  final Value<String?> cpf;
  final Value<String?> email;
  final Value<String?> telefone;
  final Value<String?> endereco;
  final Value<String?> cidade;
  final Value<String?> estado;
  final Value<String?> cep;
  final Value<bool> ativo;
  final Value<DateTime> criadoEm;
  final Value<DateTime> atualizadoEm;
  const FornecedorTableCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.razaoSocial = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.cpf = const Value.absent(),
    this.email = const Value.absent(),
    this.telefone = const Value.absent(),
    this.endereco = const Value.absent(),
    this.cidade = const Value.absent(),
    this.estado = const Value.absent(),
    this.cep = const Value.absent(),
    this.ativo = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
  });
  FornecedorTableCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    this.razaoSocial = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.cpf = const Value.absent(),
    this.email = const Value.absent(),
    this.telefone = const Value.absent(),
    this.endereco = const Value.absent(),
    this.cidade = const Value.absent(),
    this.estado = const Value.absent(),
    this.cep = const Value.absent(),
    this.ativo = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
  }) : nome = Value(nome);
  static Insertable<FornecedorData> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? razaoSocial,
    Expression<String>? cnpj,
    Expression<String>? cpf,
    Expression<String>? email,
    Expression<String>? telefone,
    Expression<String>? endereco,
    Expression<String>? cidade,
    Expression<String>? estado,
    Expression<String>? cep,
    Expression<bool>? ativo,
    Expression<DateTime>? criadoEm,
    Expression<DateTime>? atualizadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (razaoSocial != null) 'razao_social': razaoSocial,
      if (cnpj != null) 'cnpj': cnpj,
      if (cpf != null) 'cpf': cpf,
      if (email != null) 'email': email,
      if (telefone != null) 'telefone': telefone,
      if (endereco != null) 'endereco': endereco,
      if (cidade != null) 'cidade': cidade,
      if (estado != null) 'estado': estado,
      if (cep != null) 'cep': cep,
      if (ativo != null) 'ativo': ativo,
      if (criadoEm != null) 'criado_em': criadoEm,
      if (atualizadoEm != null) 'atualizado_em': atualizadoEm,
    });
  }

  FornecedorTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? nome,
      Value<String?>? razaoSocial,
      Value<String?>? cnpj,
      Value<String?>? cpf,
      Value<String?>? email,
      Value<String?>? telefone,
      Value<String?>? endereco,
      Value<String?>? cidade,
      Value<String?>? estado,
      Value<String?>? cep,
      Value<bool>? ativo,
      Value<DateTime>? criadoEm,
      Value<DateTime>? atualizadoEm}) {
    return FornecedorTableCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      razaoSocial: razaoSocial ?? this.razaoSocial,
      cnpj: cnpj ?? this.cnpj,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      ativo: ativo ?? this.ativo,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (razaoSocial.present) {
      map['razao_social'] = Variable<String>(razaoSocial.value);
    }
    if (cnpj.present) {
      map['cnpj'] = Variable<String>(cnpj.value);
    }
    if (cpf.present) {
      map['cpf'] = Variable<String>(cpf.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (endereco.present) {
      map['endereco'] = Variable<String>(endereco.value);
    }
    if (cidade.present) {
      map['cidade'] = Variable<String>(cidade.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (cep.present) {
      map['cep'] = Variable<String>(cep.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    if (atualizadoEm.present) {
      map['atualizado_em'] = Variable<DateTime>(atualizadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FornecedorTableCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('razaoSocial: $razaoSocial, ')
          ..write('cnpj: $cnpj, ')
          ..write('cpf: $cpf, ')
          ..write('email: $email, ')
          ..write('telefone: $telefone, ')
          ..write('endereco: $endereco, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('cep: $cep, ')
          ..write('ativo: $ativo, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }
}

class $PedidoCompraTableTable extends PedidoCompraTable
    with TableInfo<$PedidoCompraTableTable, PedidoCompraData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PedidoCompraTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fornecedorIdMeta =
      const VerificationMeta('fornecedorId');
  @override
  late final GeneratedColumn<int> fornecedorId = GeneratedColumn<int>(
      'fornecedor_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES fornecedor_table (id)'));
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<String> numero = GeneratedColumn<String>(
      'numero', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pendente'));
  static const VerificationMeta _valorTotalMeta =
      const VerificationMeta('valorTotal');
  @override
  late final GeneratedColumn<double> valorTotal = GeneratedColumn<double>(
      'valor_total', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _observacoesMeta =
      const VerificationMeta('observacoes');
  @override
  late final GeneratedColumn<String> observacoes = GeneratedColumn<String>(
      'observacoes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dataEmissaoMeta =
      const VerificationMeta('dataEmissao');
  @override
  late final GeneratedColumn<DateTime> dataEmissao = GeneratedColumn<DateTime>(
      'data_emissao', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _dataAprovacaoMeta =
      const VerificationMeta('dataAprovacao');
  @override
  late final GeneratedColumn<DateTime> dataAprovacao =
      GeneratedColumn<DateTime>('data_aprovacao', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dataRecebimentoMeta =
      const VerificationMeta('dataRecebimento');
  @override
  late final GeneratedColumn<DateTime> dataRecebimento =
      GeneratedColumn<DateTime>('data_recebimento', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _atualizadoEmMeta =
      const VerificationMeta('atualizadoEm');
  @override
  late final GeneratedColumn<DateTime> atualizadoEm = GeneratedColumn<DateTime>(
      'atualizado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fornecedorId,
        numero,
        status,
        valorTotal,
        observacoes,
        dataEmissao,
        dataAprovacao,
        dataRecebimento,
        criadoEm,
        atualizadoEm
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pedido_compra_table';
  @override
  VerificationContext validateIntegrity(Insertable<PedidoCompraData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fornecedor_id')) {
      context.handle(
          _fornecedorIdMeta,
          fornecedorId.isAcceptableOrUnknown(
              data['fornecedor_id']!, _fornecedorIdMeta));
    } else if (isInserting) {
      context.missing(_fornecedorIdMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(_numeroMeta,
          numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta));
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('valor_total')) {
      context.handle(
          _valorTotalMeta,
          valorTotal.isAcceptableOrUnknown(
              data['valor_total']!, _valorTotalMeta));
    }
    if (data.containsKey('observacoes')) {
      context.handle(
          _observacoesMeta,
          observacoes.isAcceptableOrUnknown(
              data['observacoes']!, _observacoesMeta));
    }
    if (data.containsKey('data_emissao')) {
      context.handle(
          _dataEmissaoMeta,
          dataEmissao.isAcceptableOrUnknown(
              data['data_emissao']!, _dataEmissaoMeta));
    }
    if (data.containsKey('data_aprovacao')) {
      context.handle(
          _dataAprovacaoMeta,
          dataAprovacao.isAcceptableOrUnknown(
              data['data_aprovacao']!, _dataAprovacaoMeta));
    }
    if (data.containsKey('data_recebimento')) {
      context.handle(
          _dataRecebimentoMeta,
          dataRecebimento.isAcceptableOrUnknown(
              data['data_recebimento']!, _dataRecebimentoMeta));
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    }
    if (data.containsKey('atualizado_em')) {
      context.handle(
          _atualizadoEmMeta,
          atualizadoEm.isAcceptableOrUnknown(
              data['atualizado_em']!, _atualizadoEmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PedidoCompraData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PedidoCompraData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fornecedorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fornecedor_id'])!,
      numero: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      valorTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor_total'])!,
      observacoes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacoes']),
      dataEmissao: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_emissao'])!,
      dataAprovacao: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_aprovacao']),
      dataRecebimento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_recebimento']),
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
      atualizadoEm: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}atualizado_em'])!,
    );
  }

  @override
  $PedidoCompraTableTable createAlias(String alias) {
    return $PedidoCompraTableTable(attachedDatabase, alias);
  }
}

class PedidoCompraData extends DataClass
    implements Insertable<PedidoCompraData> {
  final int id;
  final int fornecedorId;
  final String numero;
  final String status;
  final double valorTotal;
  final String? observacoes;
  final DateTime dataEmissao;
  final DateTime? dataAprovacao;
  final DateTime? dataRecebimento;
  final DateTime criadoEm;
  final DateTime atualizadoEm;
  const PedidoCompraData(
      {required this.id,
      required this.fornecedorId,
      required this.numero,
      required this.status,
      required this.valorTotal,
      this.observacoes,
      required this.dataEmissao,
      this.dataAprovacao,
      this.dataRecebimento,
      required this.criadoEm,
      required this.atualizadoEm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fornecedor_id'] = Variable<int>(fornecedorId);
    map['numero'] = Variable<String>(numero);
    map['status'] = Variable<String>(status);
    map['valor_total'] = Variable<double>(valorTotal);
    if (!nullToAbsent || observacoes != null) {
      map['observacoes'] = Variable<String>(observacoes);
    }
    map['data_emissao'] = Variable<DateTime>(dataEmissao);
    if (!nullToAbsent || dataAprovacao != null) {
      map['data_aprovacao'] = Variable<DateTime>(dataAprovacao);
    }
    if (!nullToAbsent || dataRecebimento != null) {
      map['data_recebimento'] = Variable<DateTime>(dataRecebimento);
    }
    map['criado_em'] = Variable<DateTime>(criadoEm);
    map['atualizado_em'] = Variable<DateTime>(atualizadoEm);
    return map;
  }

  PedidoCompraTableCompanion toCompanion(bool nullToAbsent) {
    return PedidoCompraTableCompanion(
      id: Value(id),
      fornecedorId: Value(fornecedorId),
      numero: Value(numero),
      status: Value(status),
      valorTotal: Value(valorTotal),
      observacoes: observacoes == null && nullToAbsent
          ? const Value.absent()
          : Value(observacoes),
      dataEmissao: Value(dataEmissao),
      dataAprovacao: dataAprovacao == null && nullToAbsent
          ? const Value.absent()
          : Value(dataAprovacao),
      dataRecebimento: dataRecebimento == null && nullToAbsent
          ? const Value.absent()
          : Value(dataRecebimento),
      criadoEm: Value(criadoEm),
      atualizadoEm: Value(atualizadoEm),
    );
  }

  factory PedidoCompraData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PedidoCompraData(
      id: serializer.fromJson<int>(json['id']),
      fornecedorId: serializer.fromJson<int>(json['fornecedorId']),
      numero: serializer.fromJson<String>(json['numero']),
      status: serializer.fromJson<String>(json['status']),
      valorTotal: serializer.fromJson<double>(json['valorTotal']),
      observacoes: serializer.fromJson<String?>(json['observacoes']),
      dataEmissao: serializer.fromJson<DateTime>(json['dataEmissao']),
      dataAprovacao: serializer.fromJson<DateTime?>(json['dataAprovacao']),
      dataRecebimento: serializer.fromJson<DateTime?>(json['dataRecebimento']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
      atualizadoEm: serializer.fromJson<DateTime>(json['atualizadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fornecedorId': serializer.toJson<int>(fornecedorId),
      'numero': serializer.toJson<String>(numero),
      'status': serializer.toJson<String>(status),
      'valorTotal': serializer.toJson<double>(valorTotal),
      'observacoes': serializer.toJson<String?>(observacoes),
      'dataEmissao': serializer.toJson<DateTime>(dataEmissao),
      'dataAprovacao': serializer.toJson<DateTime?>(dataAprovacao),
      'dataRecebimento': serializer.toJson<DateTime?>(dataRecebimento),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
      'atualizadoEm': serializer.toJson<DateTime>(atualizadoEm),
    };
  }

  PedidoCompraData copyWith(
          {int? id,
          int? fornecedorId,
          String? numero,
          String? status,
          double? valorTotal,
          Value<String?> observacoes = const Value.absent(),
          DateTime? dataEmissao,
          Value<DateTime?> dataAprovacao = const Value.absent(),
          Value<DateTime?> dataRecebimento = const Value.absent(),
          DateTime? criadoEm,
          DateTime? atualizadoEm}) =>
      PedidoCompraData(
        id: id ?? this.id,
        fornecedorId: fornecedorId ?? this.fornecedorId,
        numero: numero ?? this.numero,
        status: status ?? this.status,
        valorTotal: valorTotal ?? this.valorTotal,
        observacoes: observacoes.present ? observacoes.value : this.observacoes,
        dataEmissao: dataEmissao ?? this.dataEmissao,
        dataAprovacao:
            dataAprovacao.present ? dataAprovacao.value : this.dataAprovacao,
        dataRecebimento: dataRecebimento.present
            ? dataRecebimento.value
            : this.dataRecebimento,
        criadoEm: criadoEm ?? this.criadoEm,
        atualizadoEm: atualizadoEm ?? this.atualizadoEm,
      );
  PedidoCompraData copyWithCompanion(PedidoCompraTableCompanion data) {
    return PedidoCompraData(
      id: data.id.present ? data.id.value : this.id,
      fornecedorId: data.fornecedorId.present
          ? data.fornecedorId.value
          : this.fornecedorId,
      numero: data.numero.present ? data.numero.value : this.numero,
      status: data.status.present ? data.status.value : this.status,
      valorTotal:
          data.valorTotal.present ? data.valorTotal.value : this.valorTotal,
      observacoes:
          data.observacoes.present ? data.observacoes.value : this.observacoes,
      dataEmissao:
          data.dataEmissao.present ? data.dataEmissao.value : this.dataEmissao,
      dataAprovacao: data.dataAprovacao.present
          ? data.dataAprovacao.value
          : this.dataAprovacao,
      dataRecebimento: data.dataRecebimento.present
          ? data.dataRecebimento.value
          : this.dataRecebimento,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
      atualizadoEm: data.atualizadoEm.present
          ? data.atualizadoEm.value
          : this.atualizadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PedidoCompraData(')
          ..write('id: $id, ')
          ..write('fornecedorId: $fornecedorId, ')
          ..write('numero: $numero, ')
          ..write('status: $status, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('observacoes: $observacoes, ')
          ..write('dataEmissao: $dataEmissao, ')
          ..write('dataAprovacao: $dataAprovacao, ')
          ..write('dataRecebimento: $dataRecebimento, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      fornecedorId,
      numero,
      status,
      valorTotal,
      observacoes,
      dataEmissao,
      dataAprovacao,
      dataRecebimento,
      criadoEm,
      atualizadoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PedidoCompraData &&
          other.id == this.id &&
          other.fornecedorId == this.fornecedorId &&
          other.numero == this.numero &&
          other.status == this.status &&
          other.valorTotal == this.valorTotal &&
          other.observacoes == this.observacoes &&
          other.dataEmissao == this.dataEmissao &&
          other.dataAprovacao == this.dataAprovacao &&
          other.dataRecebimento == this.dataRecebimento &&
          other.criadoEm == this.criadoEm &&
          other.atualizadoEm == this.atualizadoEm);
}

class PedidoCompraTableCompanion extends UpdateCompanion<PedidoCompraData> {
  final Value<int> id;
  final Value<int> fornecedorId;
  final Value<String> numero;
  final Value<String> status;
  final Value<double> valorTotal;
  final Value<String?> observacoes;
  final Value<DateTime> dataEmissao;
  final Value<DateTime?> dataAprovacao;
  final Value<DateTime?> dataRecebimento;
  final Value<DateTime> criadoEm;
  final Value<DateTime> atualizadoEm;
  const PedidoCompraTableCompanion({
    this.id = const Value.absent(),
    this.fornecedorId = const Value.absent(),
    this.numero = const Value.absent(),
    this.status = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.dataEmissao = const Value.absent(),
    this.dataAprovacao = const Value.absent(),
    this.dataRecebimento = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
  });
  PedidoCompraTableCompanion.insert({
    this.id = const Value.absent(),
    required int fornecedorId,
    required String numero,
    this.status = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.dataEmissao = const Value.absent(),
    this.dataAprovacao = const Value.absent(),
    this.dataRecebimento = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
  })  : fornecedorId = Value(fornecedorId),
        numero = Value(numero);
  static Insertable<PedidoCompraData> custom({
    Expression<int>? id,
    Expression<int>? fornecedorId,
    Expression<String>? numero,
    Expression<String>? status,
    Expression<double>? valorTotal,
    Expression<String>? observacoes,
    Expression<DateTime>? dataEmissao,
    Expression<DateTime>? dataAprovacao,
    Expression<DateTime>? dataRecebimento,
    Expression<DateTime>? criadoEm,
    Expression<DateTime>? atualizadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fornecedorId != null) 'fornecedor_id': fornecedorId,
      if (numero != null) 'numero': numero,
      if (status != null) 'status': status,
      if (valorTotal != null) 'valor_total': valorTotal,
      if (observacoes != null) 'observacoes': observacoes,
      if (dataEmissao != null) 'data_emissao': dataEmissao,
      if (dataAprovacao != null) 'data_aprovacao': dataAprovacao,
      if (dataRecebimento != null) 'data_recebimento': dataRecebimento,
      if (criadoEm != null) 'criado_em': criadoEm,
      if (atualizadoEm != null) 'atualizado_em': atualizadoEm,
    });
  }

  PedidoCompraTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? fornecedorId,
      Value<String>? numero,
      Value<String>? status,
      Value<double>? valorTotal,
      Value<String?>? observacoes,
      Value<DateTime>? dataEmissao,
      Value<DateTime?>? dataAprovacao,
      Value<DateTime?>? dataRecebimento,
      Value<DateTime>? criadoEm,
      Value<DateTime>? atualizadoEm}) {
    return PedidoCompraTableCompanion(
      id: id ?? this.id,
      fornecedorId: fornecedorId ?? this.fornecedorId,
      numero: numero ?? this.numero,
      status: status ?? this.status,
      valorTotal: valorTotal ?? this.valorTotal,
      observacoes: observacoes ?? this.observacoes,
      dataEmissao: dataEmissao ?? this.dataEmissao,
      dataAprovacao: dataAprovacao ?? this.dataAprovacao,
      dataRecebimento: dataRecebimento ?? this.dataRecebimento,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fornecedorId.present) {
      map['fornecedor_id'] = Variable<int>(fornecedorId.value);
    }
    if (numero.present) {
      map['numero'] = Variable<String>(numero.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (valorTotal.present) {
      map['valor_total'] = Variable<double>(valorTotal.value);
    }
    if (observacoes.present) {
      map['observacoes'] = Variable<String>(observacoes.value);
    }
    if (dataEmissao.present) {
      map['data_emissao'] = Variable<DateTime>(dataEmissao.value);
    }
    if (dataAprovacao.present) {
      map['data_aprovacao'] = Variable<DateTime>(dataAprovacao.value);
    }
    if (dataRecebimento.present) {
      map['data_recebimento'] = Variable<DateTime>(dataRecebimento.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    if (atualizadoEm.present) {
      map['atualizado_em'] = Variable<DateTime>(atualizadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PedidoCompraTableCompanion(')
          ..write('id: $id, ')
          ..write('fornecedorId: $fornecedorId, ')
          ..write('numero: $numero, ')
          ..write('status: $status, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('observacoes: $observacoes, ')
          ..write('dataEmissao: $dataEmissao, ')
          ..write('dataAprovacao: $dataAprovacao, ')
          ..write('dataRecebimento: $dataRecebimento, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }
}

class $ItemCompraTableTable extends ItemCompraTable
    with TableInfo<$ItemCompraTableTable, ItemCompraData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemCompraTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pedidoCompraIdMeta =
      const VerificationMeta('pedidoCompraId');
  @override
  late final GeneratedColumn<int> pedidoCompraId = GeneratedColumn<int>(
      'pedido_compra_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES pedido_compra_table (id)'));
  static const VerificationMeta _produtoIdMeta =
      const VerificationMeta('produtoId');
  @override
  late final GeneratedColumn<int> produtoId = GeneratedColumn<int>(
      'produto_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES produto_table (id)'));
  static const VerificationMeta _quantidadeMeta =
      const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _precoUnitarioMeta =
      const VerificationMeta('precoUnitario');
  @override
  late final GeneratedColumn<double> precoUnitario = GeneratedColumn<double>(
      'preco_unitario', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _precoTotalMeta =
      const VerificationMeta('precoTotal');
  @override
  late final GeneratedColumn<double> precoTotal = GeneratedColumn<double>(
      'preco_total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _observacoesMeta =
      const VerificationMeta('observacoes');
  @override
  late final GeneratedColumn<String> observacoes = GeneratedColumn<String>(
      'observacoes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        pedidoCompraId,
        produtoId,
        quantidade,
        precoUnitario,
        precoTotal,
        observacoes,
        criadoEm
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_compra_table';
  @override
  VerificationContext validateIntegrity(Insertable<ItemCompraData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pedido_compra_id')) {
      context.handle(
          _pedidoCompraIdMeta,
          pedidoCompraId.isAcceptableOrUnknown(
              data['pedido_compra_id']!, _pedidoCompraIdMeta));
    } else if (isInserting) {
      context.missing(_pedidoCompraIdMeta);
    }
    if (data.containsKey('produto_id')) {
      context.handle(_produtoIdMeta,
          produtoId.isAcceptableOrUnknown(data['produto_id']!, _produtoIdMeta));
    } else if (isInserting) {
      context.missing(_produtoIdMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('preco_unitario')) {
      context.handle(
          _precoUnitarioMeta,
          precoUnitario.isAcceptableOrUnknown(
              data['preco_unitario']!, _precoUnitarioMeta));
    } else if (isInserting) {
      context.missing(_precoUnitarioMeta);
    }
    if (data.containsKey('preco_total')) {
      context.handle(
          _precoTotalMeta,
          precoTotal.isAcceptableOrUnknown(
              data['preco_total']!, _precoTotalMeta));
    } else if (isInserting) {
      context.missing(_precoTotalMeta);
    }
    if (data.containsKey('observacoes')) {
      context.handle(
          _observacoesMeta,
          observacoes.isAcceptableOrUnknown(
              data['observacoes']!, _observacoesMeta));
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemCompraData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemCompraData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      pedidoCompraId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pedido_compra_id'])!,
      produtoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}produto_id'])!,
      quantidade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
      precoUnitario: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}preco_unitario'])!,
      precoTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}preco_total'])!,
      observacoes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacoes']),
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
    );
  }

  @override
  $ItemCompraTableTable createAlias(String alias) {
    return $ItemCompraTableTable(attachedDatabase, alias);
  }
}

class ItemCompraData extends DataClass implements Insertable<ItemCompraData> {
  final int id;
  final int pedidoCompraId;
  final int produtoId;
  final int quantidade;
  final double precoUnitario;
  final double precoTotal;
  final String? observacoes;
  final DateTime criadoEm;
  const ItemCompraData(
      {required this.id,
      required this.pedidoCompraId,
      required this.produtoId,
      required this.quantidade,
      required this.precoUnitario,
      required this.precoTotal,
      this.observacoes,
      required this.criadoEm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pedido_compra_id'] = Variable<int>(pedidoCompraId);
    map['produto_id'] = Variable<int>(produtoId);
    map['quantidade'] = Variable<int>(quantidade);
    map['preco_unitario'] = Variable<double>(precoUnitario);
    map['preco_total'] = Variable<double>(precoTotal);
    if (!nullToAbsent || observacoes != null) {
      map['observacoes'] = Variable<String>(observacoes);
    }
    map['criado_em'] = Variable<DateTime>(criadoEm);
    return map;
  }

  ItemCompraTableCompanion toCompanion(bool nullToAbsent) {
    return ItemCompraTableCompanion(
      id: Value(id),
      pedidoCompraId: Value(pedidoCompraId),
      produtoId: Value(produtoId),
      quantidade: Value(quantidade),
      precoUnitario: Value(precoUnitario),
      precoTotal: Value(precoTotal),
      observacoes: observacoes == null && nullToAbsent
          ? const Value.absent()
          : Value(observacoes),
      criadoEm: Value(criadoEm),
    );
  }

  factory ItemCompraData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemCompraData(
      id: serializer.fromJson<int>(json['id']),
      pedidoCompraId: serializer.fromJson<int>(json['pedidoCompraId']),
      produtoId: serializer.fromJson<int>(json['produtoId']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      precoUnitario: serializer.fromJson<double>(json['precoUnitario']),
      precoTotal: serializer.fromJson<double>(json['precoTotal']),
      observacoes: serializer.fromJson<String?>(json['observacoes']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pedidoCompraId': serializer.toJson<int>(pedidoCompraId),
      'produtoId': serializer.toJson<int>(produtoId),
      'quantidade': serializer.toJson<int>(quantidade),
      'precoUnitario': serializer.toJson<double>(precoUnitario),
      'precoTotal': serializer.toJson<double>(precoTotal),
      'observacoes': serializer.toJson<String?>(observacoes),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
    };
  }

  ItemCompraData copyWith(
          {int? id,
          int? pedidoCompraId,
          int? produtoId,
          int? quantidade,
          double? precoUnitario,
          double? precoTotal,
          Value<String?> observacoes = const Value.absent(),
          DateTime? criadoEm}) =>
      ItemCompraData(
        id: id ?? this.id,
        pedidoCompraId: pedidoCompraId ?? this.pedidoCompraId,
        produtoId: produtoId ?? this.produtoId,
        quantidade: quantidade ?? this.quantidade,
        precoUnitario: precoUnitario ?? this.precoUnitario,
        precoTotal: precoTotal ?? this.precoTotal,
        observacoes: observacoes.present ? observacoes.value : this.observacoes,
        criadoEm: criadoEm ?? this.criadoEm,
      );
  ItemCompraData copyWithCompanion(ItemCompraTableCompanion data) {
    return ItemCompraData(
      id: data.id.present ? data.id.value : this.id,
      pedidoCompraId: data.pedidoCompraId.present
          ? data.pedidoCompraId.value
          : this.pedidoCompraId,
      produtoId: data.produtoId.present ? data.produtoId.value : this.produtoId,
      quantidade:
          data.quantidade.present ? data.quantidade.value : this.quantidade,
      precoUnitario: data.precoUnitario.present
          ? data.precoUnitario.value
          : this.precoUnitario,
      precoTotal:
          data.precoTotal.present ? data.precoTotal.value : this.precoTotal,
      observacoes:
          data.observacoes.present ? data.observacoes.value : this.observacoes,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemCompraData(')
          ..write('id: $id, ')
          ..write('pedidoCompraId: $pedidoCompraId, ')
          ..write('produtoId: $produtoId, ')
          ..write('quantidade: $quantidade, ')
          ..write('precoUnitario: $precoUnitario, ')
          ..write('precoTotal: $precoTotal, ')
          ..write('observacoes: $observacoes, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pedidoCompraId, produtoId, quantidade,
      precoUnitario, precoTotal, observacoes, criadoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemCompraData &&
          other.id == this.id &&
          other.pedidoCompraId == this.pedidoCompraId &&
          other.produtoId == this.produtoId &&
          other.quantidade == this.quantidade &&
          other.precoUnitario == this.precoUnitario &&
          other.precoTotal == this.precoTotal &&
          other.observacoes == this.observacoes &&
          other.criadoEm == this.criadoEm);
}

class ItemCompraTableCompanion extends UpdateCompanion<ItemCompraData> {
  final Value<int> id;
  final Value<int> pedidoCompraId;
  final Value<int> produtoId;
  final Value<int> quantidade;
  final Value<double> precoUnitario;
  final Value<double> precoTotal;
  final Value<String?> observacoes;
  final Value<DateTime> criadoEm;
  const ItemCompraTableCompanion({
    this.id = const Value.absent(),
    this.pedidoCompraId = const Value.absent(),
    this.produtoId = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.precoUnitario = const Value.absent(),
    this.precoTotal = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.criadoEm = const Value.absent(),
  });
  ItemCompraTableCompanion.insert({
    this.id = const Value.absent(),
    required int pedidoCompraId,
    required int produtoId,
    required int quantidade,
    required double precoUnitario,
    required double precoTotal,
    this.observacoes = const Value.absent(),
    this.criadoEm = const Value.absent(),
  })  : pedidoCompraId = Value(pedidoCompraId),
        produtoId = Value(produtoId),
        quantidade = Value(quantidade),
        precoUnitario = Value(precoUnitario),
        precoTotal = Value(precoTotal);
  static Insertable<ItemCompraData> custom({
    Expression<int>? id,
    Expression<int>? pedidoCompraId,
    Expression<int>? produtoId,
    Expression<int>? quantidade,
    Expression<double>? precoUnitario,
    Expression<double>? precoTotal,
    Expression<String>? observacoes,
    Expression<DateTime>? criadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pedidoCompraId != null) 'pedido_compra_id': pedidoCompraId,
      if (produtoId != null) 'produto_id': produtoId,
      if (quantidade != null) 'quantidade': quantidade,
      if (precoUnitario != null) 'preco_unitario': precoUnitario,
      if (precoTotal != null) 'preco_total': precoTotal,
      if (observacoes != null) 'observacoes': observacoes,
      if (criadoEm != null) 'criado_em': criadoEm,
    });
  }

  ItemCompraTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? pedidoCompraId,
      Value<int>? produtoId,
      Value<int>? quantidade,
      Value<double>? precoUnitario,
      Value<double>? precoTotal,
      Value<String?>? observacoes,
      Value<DateTime>? criadoEm}) {
    return ItemCompraTableCompanion(
      id: id ?? this.id,
      pedidoCompraId: pedidoCompraId ?? this.pedidoCompraId,
      produtoId: produtoId ?? this.produtoId,
      quantidade: quantidade ?? this.quantidade,
      precoUnitario: precoUnitario ?? this.precoUnitario,
      precoTotal: precoTotal ?? this.precoTotal,
      observacoes: observacoes ?? this.observacoes,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pedidoCompraId.present) {
      map['pedido_compra_id'] = Variable<int>(pedidoCompraId.value);
    }
    if (produtoId.present) {
      map['produto_id'] = Variable<int>(produtoId.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    if (precoUnitario.present) {
      map['preco_unitario'] = Variable<double>(precoUnitario.value);
    }
    if (precoTotal.present) {
      map['preco_total'] = Variable<double>(precoTotal.value);
    }
    if (observacoes.present) {
      map['observacoes'] = Variable<String>(observacoes.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemCompraTableCompanion(')
          ..write('id: $id, ')
          ..write('pedidoCompraId: $pedidoCompraId, ')
          ..write('produtoId: $produtoId, ')
          ..write('quantidade: $quantidade, ')
          ..write('precoUnitario: $precoUnitario, ')
          ..write('precoTotal: $precoTotal, ')
          ..write('observacoes: $observacoes, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }
}

class $VendaTableTable extends VendaTable
    with TableInfo<$VendaTableTable, Venda> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VendaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dataVendaMeta =
      const VerificationMeta('dataVenda');
  @override
  late final GeneratedColumn<DateTime> dataVenda = GeneratedColumn<DateTime>(
      'data_venda', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descontoMeta =
      const VerificationMeta('desconto');
  @override
  late final GeneratedColumn<double> desconto = GeneratedColumn<double>(
      'desconto', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _formaPagamentoMeta =
      const VerificationMeta('formaPagamento');
  @override
  late final GeneratedColumn<String> formaPagamento = GeneratedColumn<String>(
      'forma_pagamento', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _observacoesMeta =
      const VerificationMeta('observacoes');
  @override
  late final GeneratedColumn<String> observacoes = GeneratedColumn<String>(
      'observacoes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _atualizadoEmMeta =
      const VerificationMeta('atualizadoEm');
  @override
  late final GeneratedColumn<DateTime> atualizadoEm = GeneratedColumn<DateTime>(
      'atualizado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        dataVenda,
        subtotal,
        desconto,
        total,
        formaPagamento,
        observacoes,
        criadoEm,
        atualizadoEm
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vendas';
  @override
  VerificationContext validateIntegrity(Insertable<Venda> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data_venda')) {
      context.handle(_dataVendaMeta,
          dataVenda.isAcceptableOrUnknown(data['data_venda']!, _dataVendaMeta));
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('desconto')) {
      context.handle(_descontoMeta,
          desconto.isAcceptableOrUnknown(data['desconto']!, _descontoMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('forma_pagamento')) {
      context.handle(
          _formaPagamentoMeta,
          formaPagamento.isAcceptableOrUnknown(
              data['forma_pagamento']!, _formaPagamentoMeta));
    } else if (isInserting) {
      context.missing(_formaPagamentoMeta);
    }
    if (data.containsKey('observacoes')) {
      context.handle(
          _observacoesMeta,
          observacoes.isAcceptableOrUnknown(
              data['observacoes']!, _observacoesMeta));
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    }
    if (data.containsKey('atualizado_em')) {
      context.handle(
          _atualizadoEmMeta,
          atualizadoEm.isAcceptableOrUnknown(
              data['atualizado_em']!, _atualizadoEmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Venda map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Venda(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dataVenda: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_venda'])!,
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      desconto: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}desconto'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      formaPagamento: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}forma_pagamento'])!,
      observacoes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacoes']),
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
      atualizadoEm: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}atualizado_em'])!,
    );
  }

  @override
  $VendaTableTable createAlias(String alias) {
    return $VendaTableTable(attachedDatabase, alias);
  }
}

class Venda extends DataClass implements Insertable<Venda> {
  final int id;
  final DateTime dataVenda;
  final double subtotal;
  final double desconto;
  final double total;
  final String formaPagamento;
  final String? observacoes;
  final DateTime criadoEm;
  final DateTime atualizadoEm;
  const Venda(
      {required this.id,
      required this.dataVenda,
      required this.subtotal,
      required this.desconto,
      required this.total,
      required this.formaPagamento,
      this.observacoes,
      required this.criadoEm,
      required this.atualizadoEm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['data_venda'] = Variable<DateTime>(dataVenda);
    map['subtotal'] = Variable<double>(subtotal);
    map['desconto'] = Variable<double>(desconto);
    map['total'] = Variable<double>(total);
    map['forma_pagamento'] = Variable<String>(formaPagamento);
    if (!nullToAbsent || observacoes != null) {
      map['observacoes'] = Variable<String>(observacoes);
    }
    map['criado_em'] = Variable<DateTime>(criadoEm);
    map['atualizado_em'] = Variable<DateTime>(atualizadoEm);
    return map;
  }

  VendaTableCompanion toCompanion(bool nullToAbsent) {
    return VendaTableCompanion(
      id: Value(id),
      dataVenda: Value(dataVenda),
      subtotal: Value(subtotal),
      desconto: Value(desconto),
      total: Value(total),
      formaPagamento: Value(formaPagamento),
      observacoes: observacoes == null && nullToAbsent
          ? const Value.absent()
          : Value(observacoes),
      criadoEm: Value(criadoEm),
      atualizadoEm: Value(atualizadoEm),
    );
  }

  factory Venda.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Venda(
      id: serializer.fromJson<int>(json['id']),
      dataVenda: serializer.fromJson<DateTime>(json['dataVenda']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      desconto: serializer.fromJson<double>(json['desconto']),
      total: serializer.fromJson<double>(json['total']),
      formaPagamento: serializer.fromJson<String>(json['formaPagamento']),
      observacoes: serializer.fromJson<String?>(json['observacoes']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
      atualizadoEm: serializer.fromJson<DateTime>(json['atualizadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dataVenda': serializer.toJson<DateTime>(dataVenda),
      'subtotal': serializer.toJson<double>(subtotal),
      'desconto': serializer.toJson<double>(desconto),
      'total': serializer.toJson<double>(total),
      'formaPagamento': serializer.toJson<String>(formaPagamento),
      'observacoes': serializer.toJson<String?>(observacoes),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
      'atualizadoEm': serializer.toJson<DateTime>(atualizadoEm),
    };
  }

  Venda copyWith(
          {int? id,
          DateTime? dataVenda,
          double? subtotal,
          double? desconto,
          double? total,
          String? formaPagamento,
          Value<String?> observacoes = const Value.absent(),
          DateTime? criadoEm,
          DateTime? atualizadoEm}) =>
      Venda(
        id: id ?? this.id,
        dataVenda: dataVenda ?? this.dataVenda,
        subtotal: subtotal ?? this.subtotal,
        desconto: desconto ?? this.desconto,
        total: total ?? this.total,
        formaPagamento: formaPagamento ?? this.formaPagamento,
        observacoes: observacoes.present ? observacoes.value : this.observacoes,
        criadoEm: criadoEm ?? this.criadoEm,
        atualizadoEm: atualizadoEm ?? this.atualizadoEm,
      );
  Venda copyWithCompanion(VendaTableCompanion data) {
    return Venda(
      id: data.id.present ? data.id.value : this.id,
      dataVenda: data.dataVenda.present ? data.dataVenda.value : this.dataVenda,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      desconto: data.desconto.present ? data.desconto.value : this.desconto,
      total: data.total.present ? data.total.value : this.total,
      formaPagamento: data.formaPagamento.present
          ? data.formaPagamento.value
          : this.formaPagamento,
      observacoes:
          data.observacoes.present ? data.observacoes.value : this.observacoes,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
      atualizadoEm: data.atualizadoEm.present
          ? data.atualizadoEm.value
          : this.atualizadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Venda(')
          ..write('id: $id, ')
          ..write('dataVenda: $dataVenda, ')
          ..write('subtotal: $subtotal, ')
          ..write('desconto: $desconto, ')
          ..write('total: $total, ')
          ..write('formaPagamento: $formaPagamento, ')
          ..write('observacoes: $observacoes, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dataVenda, subtotal, desconto, total,
      formaPagamento, observacoes, criadoEm, atualizadoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Venda &&
          other.id == this.id &&
          other.dataVenda == this.dataVenda &&
          other.subtotal == this.subtotal &&
          other.desconto == this.desconto &&
          other.total == this.total &&
          other.formaPagamento == this.formaPagamento &&
          other.observacoes == this.observacoes &&
          other.criadoEm == this.criadoEm &&
          other.atualizadoEm == this.atualizadoEm);
}

class VendaTableCompanion extends UpdateCompanion<Venda> {
  final Value<int> id;
  final Value<DateTime> dataVenda;
  final Value<double> subtotal;
  final Value<double> desconto;
  final Value<double> total;
  final Value<String> formaPagamento;
  final Value<String?> observacoes;
  final Value<DateTime> criadoEm;
  final Value<DateTime> atualizadoEm;
  const VendaTableCompanion({
    this.id = const Value.absent(),
    this.dataVenda = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.desconto = const Value.absent(),
    this.total = const Value.absent(),
    this.formaPagamento = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
  });
  VendaTableCompanion.insert({
    this.id = const Value.absent(),
    this.dataVenda = const Value.absent(),
    required double subtotal,
    this.desconto = const Value.absent(),
    required double total,
    required String formaPagamento,
    this.observacoes = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
  })  : subtotal = Value(subtotal),
        total = Value(total),
        formaPagamento = Value(formaPagamento);
  static Insertable<Venda> custom({
    Expression<int>? id,
    Expression<DateTime>? dataVenda,
    Expression<double>? subtotal,
    Expression<double>? desconto,
    Expression<double>? total,
    Expression<String>? formaPagamento,
    Expression<String>? observacoes,
    Expression<DateTime>? criadoEm,
    Expression<DateTime>? atualizadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dataVenda != null) 'data_venda': dataVenda,
      if (subtotal != null) 'subtotal': subtotal,
      if (desconto != null) 'desconto': desconto,
      if (total != null) 'total': total,
      if (formaPagamento != null) 'forma_pagamento': formaPagamento,
      if (observacoes != null) 'observacoes': observacoes,
      if (criadoEm != null) 'criado_em': criadoEm,
      if (atualizadoEm != null) 'atualizado_em': atualizadoEm,
    });
  }

  VendaTableCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? dataVenda,
      Value<double>? subtotal,
      Value<double>? desconto,
      Value<double>? total,
      Value<String>? formaPagamento,
      Value<String?>? observacoes,
      Value<DateTime>? criadoEm,
      Value<DateTime>? atualizadoEm}) {
    return VendaTableCompanion(
      id: id ?? this.id,
      dataVenda: dataVenda ?? this.dataVenda,
      subtotal: subtotal ?? this.subtotal,
      desconto: desconto ?? this.desconto,
      total: total ?? this.total,
      formaPagamento: formaPagamento ?? this.formaPagamento,
      observacoes: observacoes ?? this.observacoes,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dataVenda.present) {
      map['data_venda'] = Variable<DateTime>(dataVenda.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (desconto.present) {
      map['desconto'] = Variable<double>(desconto.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (formaPagamento.present) {
      map['forma_pagamento'] = Variable<String>(formaPagamento.value);
    }
    if (observacoes.present) {
      map['observacoes'] = Variable<String>(observacoes.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    if (atualizadoEm.present) {
      map['atualizado_em'] = Variable<DateTime>(atualizadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VendaTableCompanion(')
          ..write('id: $id, ')
          ..write('dataVenda: $dataVenda, ')
          ..write('subtotal: $subtotal, ')
          ..write('desconto: $desconto, ')
          ..write('total: $total, ')
          ..write('formaPagamento: $formaPagamento, ')
          ..write('observacoes: $observacoes, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }
}

class $ItemVendaTableTable extends ItemVendaTable
    with TableInfo<$ItemVendaTableTable, ItemVenda> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemVendaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _vendaIdMeta =
      const VerificationMeta('vendaId');
  @override
  late final GeneratedColumn<int> vendaId = GeneratedColumn<int>(
      'venda_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES vendas (id) ON DELETE CASCADE'));
  static const VerificationMeta _produtoIdMeta =
      const VerificationMeta('produtoId');
  @override
  late final GeneratedColumn<int> produtoId = GeneratedColumn<int>(
      'produto_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES produto_table (id)'));
  static const VerificationMeta _quantidadeMeta =
      const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _precoUnitarioMeta =
      const VerificationMeta('precoUnitario');
  @override
  late final GeneratedColumn<double> precoUnitario = GeneratedColumn<double>(
      'preco_unitario', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, vendaId, produtoId, quantidade, precoUnitario, subtotal, criadoEm];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'itens_venda';
  @override
  VerificationContext validateIntegrity(Insertable<ItemVenda> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('venda_id')) {
      context.handle(_vendaIdMeta,
          vendaId.isAcceptableOrUnknown(data['venda_id']!, _vendaIdMeta));
    } else if (isInserting) {
      context.missing(_vendaIdMeta);
    }
    if (data.containsKey('produto_id')) {
      context.handle(_produtoIdMeta,
          produtoId.isAcceptableOrUnknown(data['produto_id']!, _produtoIdMeta));
    } else if (isInserting) {
      context.missing(_produtoIdMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('preco_unitario')) {
      context.handle(
          _precoUnitarioMeta,
          precoUnitario.isAcceptableOrUnknown(
              data['preco_unitario']!, _precoUnitarioMeta));
    } else if (isInserting) {
      context.missing(_precoUnitarioMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemVenda map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemVenda(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      vendaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}venda_id'])!,
      produtoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}produto_id'])!,
      quantidade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
      precoUnitario: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}preco_unitario'])!,
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
    );
  }

  @override
  $ItemVendaTableTable createAlias(String alias) {
    return $ItemVendaTableTable(attachedDatabase, alias);
  }
}

class ItemVenda extends DataClass implements Insertable<ItemVenda> {
  final int id;
  final int vendaId;
  final int produtoId;
  final int quantidade;
  final double precoUnitario;
  final double subtotal;
  final DateTime criadoEm;
  const ItemVenda(
      {required this.id,
      required this.vendaId,
      required this.produtoId,
      required this.quantidade,
      required this.precoUnitario,
      required this.subtotal,
      required this.criadoEm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['venda_id'] = Variable<int>(vendaId);
    map['produto_id'] = Variable<int>(produtoId);
    map['quantidade'] = Variable<int>(quantidade);
    map['preco_unitario'] = Variable<double>(precoUnitario);
    map['subtotal'] = Variable<double>(subtotal);
    map['criado_em'] = Variable<DateTime>(criadoEm);
    return map;
  }

  ItemVendaTableCompanion toCompanion(bool nullToAbsent) {
    return ItemVendaTableCompanion(
      id: Value(id),
      vendaId: Value(vendaId),
      produtoId: Value(produtoId),
      quantidade: Value(quantidade),
      precoUnitario: Value(precoUnitario),
      subtotal: Value(subtotal),
      criadoEm: Value(criadoEm),
    );
  }

  factory ItemVenda.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemVenda(
      id: serializer.fromJson<int>(json['id']),
      vendaId: serializer.fromJson<int>(json['vendaId']),
      produtoId: serializer.fromJson<int>(json['produtoId']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      precoUnitario: serializer.fromJson<double>(json['precoUnitario']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vendaId': serializer.toJson<int>(vendaId),
      'produtoId': serializer.toJson<int>(produtoId),
      'quantidade': serializer.toJson<int>(quantidade),
      'precoUnitario': serializer.toJson<double>(precoUnitario),
      'subtotal': serializer.toJson<double>(subtotal),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
    };
  }

  ItemVenda copyWith(
          {int? id,
          int? vendaId,
          int? produtoId,
          int? quantidade,
          double? precoUnitario,
          double? subtotal,
          DateTime? criadoEm}) =>
      ItemVenda(
        id: id ?? this.id,
        vendaId: vendaId ?? this.vendaId,
        produtoId: produtoId ?? this.produtoId,
        quantidade: quantidade ?? this.quantidade,
        precoUnitario: precoUnitario ?? this.precoUnitario,
        subtotal: subtotal ?? this.subtotal,
        criadoEm: criadoEm ?? this.criadoEm,
      );
  ItemVenda copyWithCompanion(ItemVendaTableCompanion data) {
    return ItemVenda(
      id: data.id.present ? data.id.value : this.id,
      vendaId: data.vendaId.present ? data.vendaId.value : this.vendaId,
      produtoId: data.produtoId.present ? data.produtoId.value : this.produtoId,
      quantidade:
          data.quantidade.present ? data.quantidade.value : this.quantidade,
      precoUnitario: data.precoUnitario.present
          ? data.precoUnitario.value
          : this.precoUnitario,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemVenda(')
          ..write('id: $id, ')
          ..write('vendaId: $vendaId, ')
          ..write('produtoId: $produtoId, ')
          ..write('quantidade: $quantidade, ')
          ..write('precoUnitario: $precoUnitario, ')
          ..write('subtotal: $subtotal, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, vendaId, produtoId, quantidade, precoUnitario, subtotal, criadoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemVenda &&
          other.id == this.id &&
          other.vendaId == this.vendaId &&
          other.produtoId == this.produtoId &&
          other.quantidade == this.quantidade &&
          other.precoUnitario == this.precoUnitario &&
          other.subtotal == this.subtotal &&
          other.criadoEm == this.criadoEm);
}

class ItemVendaTableCompanion extends UpdateCompanion<ItemVenda> {
  final Value<int> id;
  final Value<int> vendaId;
  final Value<int> produtoId;
  final Value<int> quantidade;
  final Value<double> precoUnitario;
  final Value<double> subtotal;
  final Value<DateTime> criadoEm;
  const ItemVendaTableCompanion({
    this.id = const Value.absent(),
    this.vendaId = const Value.absent(),
    this.produtoId = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.precoUnitario = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.criadoEm = const Value.absent(),
  });
  ItemVendaTableCompanion.insert({
    this.id = const Value.absent(),
    required int vendaId,
    required int produtoId,
    required int quantidade,
    required double precoUnitario,
    required double subtotal,
    this.criadoEm = const Value.absent(),
  })  : vendaId = Value(vendaId),
        produtoId = Value(produtoId),
        quantidade = Value(quantidade),
        precoUnitario = Value(precoUnitario),
        subtotal = Value(subtotal);
  static Insertable<ItemVenda> custom({
    Expression<int>? id,
    Expression<int>? vendaId,
    Expression<int>? produtoId,
    Expression<int>? quantidade,
    Expression<double>? precoUnitario,
    Expression<double>? subtotal,
    Expression<DateTime>? criadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vendaId != null) 'venda_id': vendaId,
      if (produtoId != null) 'produto_id': produtoId,
      if (quantidade != null) 'quantidade': quantidade,
      if (precoUnitario != null) 'preco_unitario': precoUnitario,
      if (subtotal != null) 'subtotal': subtotal,
      if (criadoEm != null) 'criado_em': criadoEm,
    });
  }

  ItemVendaTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? vendaId,
      Value<int>? produtoId,
      Value<int>? quantidade,
      Value<double>? precoUnitario,
      Value<double>? subtotal,
      Value<DateTime>? criadoEm}) {
    return ItemVendaTableCompanion(
      id: id ?? this.id,
      vendaId: vendaId ?? this.vendaId,
      produtoId: produtoId ?? this.produtoId,
      quantidade: quantidade ?? this.quantidade,
      precoUnitario: precoUnitario ?? this.precoUnitario,
      subtotal: subtotal ?? this.subtotal,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vendaId.present) {
      map['venda_id'] = Variable<int>(vendaId.value);
    }
    if (produtoId.present) {
      map['produto_id'] = Variable<int>(produtoId.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    if (precoUnitario.present) {
      map['preco_unitario'] = Variable<double>(precoUnitario.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemVendaTableCompanion(')
          ..write('id: $id, ')
          ..write('vendaId: $vendaId, ')
          ..write('produtoId: $produtoId, ')
          ..write('quantidade: $quantidade, ')
          ..write('precoUnitario: $precoUnitario, ')
          ..write('subtotal: $subtotal, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }
}

class $ClienteTableTable extends ClienteTable
    with TableInfo<$ClienteTableTable, ClienteTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClienteTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _cpfCnpjMeta =
      const VerificationMeta('cpfCnpj');
  @override
  late final GeneratedColumn<String> cpfCnpj = GeneratedColumn<String>(
      'cpf_cnpj', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 18),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _enderecoMeta =
      const VerificationMeta('endereco');
  @override
  late final GeneratedColumn<String> endereco = GeneratedColumn<String>(
      'endereco', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _cidadeMeta = const VerificationMeta('cidade');
  @override
  late final GeneratedColumn<String> cidade = GeneratedColumn<String>(
      'cidade', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _cepMeta = const VerificationMeta('cep');
  @override
  late final GeneratedColumn<String> cep = GeneratedColumn<String>(
      'cep', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _observacoesMeta =
      const VerificationMeta('observacoes');
  @override
  late final GeneratedColumn<String> observacoes = GeneratedColumn<String>(
      'observacoes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nome,
        email,
        telefone,
        cpfCnpj,
        endereco,
        cidade,
        estado,
        cep,
        observacoes,
        ativo,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cliente_table';
  @override
  VerificationContext validateIntegrity(Insertable<ClienteTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    }
    if (data.containsKey('cpf_cnpj')) {
      context.handle(_cpfCnpjMeta,
          cpfCnpj.isAcceptableOrUnknown(data['cpf_cnpj']!, _cpfCnpjMeta));
    }
    if (data.containsKey('endereco')) {
      context.handle(_enderecoMeta,
          endereco.isAcceptableOrUnknown(data['endereco']!, _enderecoMeta));
    }
    if (data.containsKey('cidade')) {
      context.handle(_cidadeMeta,
          cidade.isAcceptableOrUnknown(data['cidade']!, _cidadeMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('cep')) {
      context.handle(
          _cepMeta, cep.isAcceptableOrUnknown(data['cep']!, _cepMeta));
    }
    if (data.containsKey('observacoes')) {
      context.handle(
          _observacoesMeta,
          observacoes.isAcceptableOrUnknown(
              data['observacoes']!, _observacoesMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClienteTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClienteTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      telefone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefone']),
      cpfCnpj: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cpf_cnpj']),
      endereco: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endereco']),
      cidade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cidade']),
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado']),
      cep: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cep']),
      observacoes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacoes']),
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ClienteTableTable createAlias(String alias) {
    return $ClienteTableTable(attachedDatabase, alias);
  }
}

class ClienteTableData extends DataClass
    implements Insertable<ClienteTableData> {
  final int id;
  final String nome;
  final String? email;
  final String? telefone;
  final String? cpfCnpj;
  final String? endereco;
  final String? cidade;
  final String? estado;
  final String? cep;
  final String? observacoes;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ClienteTableData(
      {required this.id,
      required this.nome,
      this.email,
      this.telefone,
      this.cpfCnpj,
      this.endereco,
      this.cidade,
      this.estado,
      this.cep,
      this.observacoes,
      required this.ativo,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || telefone != null) {
      map['telefone'] = Variable<String>(telefone);
    }
    if (!nullToAbsent || cpfCnpj != null) {
      map['cpf_cnpj'] = Variable<String>(cpfCnpj);
    }
    if (!nullToAbsent || endereco != null) {
      map['endereco'] = Variable<String>(endereco);
    }
    if (!nullToAbsent || cidade != null) {
      map['cidade'] = Variable<String>(cidade);
    }
    if (!nullToAbsent || estado != null) {
      map['estado'] = Variable<String>(estado);
    }
    if (!nullToAbsent || cep != null) {
      map['cep'] = Variable<String>(cep);
    }
    if (!nullToAbsent || observacoes != null) {
      map['observacoes'] = Variable<String>(observacoes);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ClienteTableCompanion toCompanion(bool nullToAbsent) {
    return ClienteTableCompanion(
      id: Value(id),
      nome: Value(nome),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      telefone: telefone == null && nullToAbsent
          ? const Value.absent()
          : Value(telefone),
      cpfCnpj: cpfCnpj == null && nullToAbsent
          ? const Value.absent()
          : Value(cpfCnpj),
      endereco: endereco == null && nullToAbsent
          ? const Value.absent()
          : Value(endereco),
      cidade:
          cidade == null && nullToAbsent ? const Value.absent() : Value(cidade),
      estado:
          estado == null && nullToAbsent ? const Value.absent() : Value(estado),
      cep: cep == null && nullToAbsent ? const Value.absent() : Value(cep),
      observacoes: observacoes == null && nullToAbsent
          ? const Value.absent()
          : Value(observacoes),
      ativo: Value(ativo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ClienteTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClienteTableData(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      email: serializer.fromJson<String?>(json['email']),
      telefone: serializer.fromJson<String?>(json['telefone']),
      cpfCnpj: serializer.fromJson<String?>(json['cpfCnpj']),
      endereco: serializer.fromJson<String?>(json['endereco']),
      cidade: serializer.fromJson<String?>(json['cidade']),
      estado: serializer.fromJson<String?>(json['estado']),
      cep: serializer.fromJson<String?>(json['cep']),
      observacoes: serializer.fromJson<String?>(json['observacoes']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'email': serializer.toJson<String?>(email),
      'telefone': serializer.toJson<String?>(telefone),
      'cpfCnpj': serializer.toJson<String?>(cpfCnpj),
      'endereco': serializer.toJson<String?>(endereco),
      'cidade': serializer.toJson<String?>(cidade),
      'estado': serializer.toJson<String?>(estado),
      'cep': serializer.toJson<String?>(cep),
      'observacoes': serializer.toJson<String?>(observacoes),
      'ativo': serializer.toJson<bool>(ativo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ClienteTableData copyWith(
          {int? id,
          String? nome,
          Value<String?> email = const Value.absent(),
          Value<String?> telefone = const Value.absent(),
          Value<String?> cpfCnpj = const Value.absent(),
          Value<String?> endereco = const Value.absent(),
          Value<String?> cidade = const Value.absent(),
          Value<String?> estado = const Value.absent(),
          Value<String?> cep = const Value.absent(),
          Value<String?> observacoes = const Value.absent(),
          bool? ativo,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ClienteTableData(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        email: email.present ? email.value : this.email,
        telefone: telefone.present ? telefone.value : this.telefone,
        cpfCnpj: cpfCnpj.present ? cpfCnpj.value : this.cpfCnpj,
        endereco: endereco.present ? endereco.value : this.endereco,
        cidade: cidade.present ? cidade.value : this.cidade,
        estado: estado.present ? estado.value : this.estado,
        cep: cep.present ? cep.value : this.cep,
        observacoes: observacoes.present ? observacoes.value : this.observacoes,
        ativo: ativo ?? this.ativo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ClienteTableData copyWithCompanion(ClienteTableCompanion data) {
    return ClienteTableData(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      email: data.email.present ? data.email.value : this.email,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
      cpfCnpj: data.cpfCnpj.present ? data.cpfCnpj.value : this.cpfCnpj,
      endereco: data.endereco.present ? data.endereco.value : this.endereco,
      cidade: data.cidade.present ? data.cidade.value : this.cidade,
      estado: data.estado.present ? data.estado.value : this.estado,
      cep: data.cep.present ? data.cep.value : this.cep,
      observacoes:
          data.observacoes.present ? data.observacoes.value : this.observacoes,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClienteTableData(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('telefone: $telefone, ')
          ..write('cpfCnpj: $cpfCnpj, ')
          ..write('endereco: $endereco, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('cep: $cep, ')
          ..write('observacoes: $observacoes, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, email, telefone, cpfCnpj, endereco,
      cidade, estado, cep, observacoes, ativo, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClienteTableData &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.email == this.email &&
          other.telefone == this.telefone &&
          other.cpfCnpj == this.cpfCnpj &&
          other.endereco == this.endereco &&
          other.cidade == this.cidade &&
          other.estado == this.estado &&
          other.cep == this.cep &&
          other.observacoes == this.observacoes &&
          other.ativo == this.ativo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClienteTableCompanion extends UpdateCompanion<ClienteTableData> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String?> email;
  final Value<String?> telefone;
  final Value<String?> cpfCnpj;
  final Value<String?> endereco;
  final Value<String?> cidade;
  final Value<String?> estado;
  final Value<String?> cep;
  final Value<String?> observacoes;
  final Value<bool> ativo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ClienteTableCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.email = const Value.absent(),
    this.telefone = const Value.absent(),
    this.cpfCnpj = const Value.absent(),
    this.endereco = const Value.absent(),
    this.cidade = const Value.absent(),
    this.estado = const Value.absent(),
    this.cep = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ClienteTableCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    this.email = const Value.absent(),
    this.telefone = const Value.absent(),
    this.cpfCnpj = const Value.absent(),
    this.endereco = const Value.absent(),
    this.cidade = const Value.absent(),
    this.estado = const Value.absent(),
    this.cep = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : nome = Value(nome);
  static Insertable<ClienteTableData> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? email,
    Expression<String>? telefone,
    Expression<String>? cpfCnpj,
    Expression<String>? endereco,
    Expression<String>? cidade,
    Expression<String>? estado,
    Expression<String>? cep,
    Expression<String>? observacoes,
    Expression<bool>? ativo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (email != null) 'email': email,
      if (telefone != null) 'telefone': telefone,
      if (cpfCnpj != null) 'cpf_cnpj': cpfCnpj,
      if (endereco != null) 'endereco': endereco,
      if (cidade != null) 'cidade': cidade,
      if (estado != null) 'estado': estado,
      if (cep != null) 'cep': cep,
      if (observacoes != null) 'observacoes': observacoes,
      if (ativo != null) 'ativo': ativo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ClienteTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? nome,
      Value<String?>? email,
      Value<String?>? telefone,
      Value<String?>? cpfCnpj,
      Value<String?>? endereco,
      Value<String?>? cidade,
      Value<String?>? estado,
      Value<String?>? cep,
      Value<String?>? observacoes,
      Value<bool>? ativo,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ClienteTableCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      cpfCnpj: cpfCnpj ?? this.cpfCnpj,
      endereco: endereco ?? this.endereco,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      observacoes: observacoes ?? this.observacoes,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (cpfCnpj.present) {
      map['cpf_cnpj'] = Variable<String>(cpfCnpj.value);
    }
    if (endereco.present) {
      map['endereco'] = Variable<String>(endereco.value);
    }
    if (cidade.present) {
      map['cidade'] = Variable<String>(cidade.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (cep.present) {
      map['cep'] = Variable<String>(cep.value);
    }
    if (observacoes.present) {
      map['observacoes'] = Variable<String>(observacoes.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClienteTableCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('telefone: $telefone, ')
          ..write('cpfCnpj: $cpfCnpj, ')
          ..write('endereco: $endereco, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('cep: $cep, ')
          ..write('observacoes: $observacoes, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ServicosTableTable extends ServicosTable
    with TableInfo<$ServicosTableTable, ServicosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<double> valor = GeneratedColumn<double>(
      'valor', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _duracaoMinutosMeta =
      const VerificationMeta('duracaoMinutos');
  @override
  late final GeneratedColumn<int> duracaoMinutos = GeneratedColumn<int>(
      'duracao_minutos', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nome,
        descricao,
        valor,
        categoria,
        duracaoMinutos,
        ativo,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'servicos';
  @override
  VerificationContext validateIntegrity(Insertable<ServicosTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    }
    if (data.containsKey('duracao_minutos')) {
      context.handle(
          _duracaoMinutosMeta,
          duracaoMinutos.isAcceptableOrUnknown(
              data['duracao_minutos']!, _duracaoMinutosMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServicosTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServicosTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao']),
      valor: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor'])!,
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria']),
      duracaoMinutos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duracao_minutos']),
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ServicosTableTable createAlias(String alias) {
    return $ServicosTableTable(attachedDatabase, alias);
  }
}

class ServicosTableData extends DataClass
    implements Insertable<ServicosTableData> {
  final int id;
  final String nome;
  final String? descricao;
  final double valor;
  final String? categoria;
  final int? duracaoMinutos;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ServicosTableData(
      {required this.id,
      required this.nome,
      this.descricao,
      required this.valor,
      this.categoria,
      this.duracaoMinutos,
      required this.ativo,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    map['valor'] = Variable<double>(valor);
    if (!nullToAbsent || categoria != null) {
      map['categoria'] = Variable<String>(categoria);
    }
    if (!nullToAbsent || duracaoMinutos != null) {
      map['duracao_minutos'] = Variable<int>(duracaoMinutos);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ServicosTableCompanion toCompanion(bool nullToAbsent) {
    return ServicosTableCompanion(
      id: Value(id),
      nome: Value(nome),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
      valor: Value(valor),
      categoria: categoria == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria),
      duracaoMinutos: duracaoMinutos == null && nullToAbsent
          ? const Value.absent()
          : Value(duracaoMinutos),
      ativo: Value(ativo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ServicosTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServicosTableData(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      descricao: serializer.fromJson<String?>(json['descricao']),
      valor: serializer.fromJson<double>(json['valor']),
      categoria: serializer.fromJson<String?>(json['categoria']),
      duracaoMinutos: serializer.fromJson<int?>(json['duracaoMinutos']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'descricao': serializer.toJson<String?>(descricao),
      'valor': serializer.toJson<double>(valor),
      'categoria': serializer.toJson<String?>(categoria),
      'duracaoMinutos': serializer.toJson<int?>(duracaoMinutos),
      'ativo': serializer.toJson<bool>(ativo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ServicosTableData copyWith(
          {int? id,
          String? nome,
          Value<String?> descricao = const Value.absent(),
          double? valor,
          Value<String?> categoria = const Value.absent(),
          Value<int?> duracaoMinutos = const Value.absent(),
          bool? ativo,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ServicosTableData(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        descricao: descricao.present ? descricao.value : this.descricao,
        valor: valor ?? this.valor,
        categoria: categoria.present ? categoria.value : this.categoria,
        duracaoMinutos:
            duracaoMinutos.present ? duracaoMinutos.value : this.duracaoMinutos,
        ativo: ativo ?? this.ativo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ServicosTableData copyWithCompanion(ServicosTableCompanion data) {
    return ServicosTableData(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      valor: data.valor.present ? data.valor.value : this.valor,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      duracaoMinutos: data.duracaoMinutos.present
          ? data.duracaoMinutos.value
          : this.duracaoMinutos,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServicosTableData(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('valor: $valor, ')
          ..write('categoria: $categoria, ')
          ..write('duracaoMinutos: $duracaoMinutos, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, descricao, valor, categoria,
      duracaoMinutos, ativo, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServicosTableData &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.descricao == this.descricao &&
          other.valor == this.valor &&
          other.categoria == this.categoria &&
          other.duracaoMinutos == this.duracaoMinutos &&
          other.ativo == this.ativo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ServicosTableCompanion extends UpdateCompanion<ServicosTableData> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String?> descricao;
  final Value<double> valor;
  final Value<String?> categoria;
  final Value<int?> duracaoMinutos;
  final Value<bool> ativo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ServicosTableCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.descricao = const Value.absent(),
    this.valor = const Value.absent(),
    this.categoria = const Value.absent(),
    this.duracaoMinutos = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ServicosTableCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    this.descricao = const Value.absent(),
    required double valor,
    this.categoria = const Value.absent(),
    this.duracaoMinutos = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : nome = Value(nome),
        valor = Value(valor);
  static Insertable<ServicosTableData> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? descricao,
    Expression<double>? valor,
    Expression<String>? categoria,
    Expression<int>? duracaoMinutos,
    Expression<bool>? ativo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (descricao != null) 'descricao': descricao,
      if (valor != null) 'valor': valor,
      if (categoria != null) 'categoria': categoria,
      if (duracaoMinutos != null) 'duracao_minutos': duracaoMinutos,
      if (ativo != null) 'ativo': ativo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ServicosTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? nome,
      Value<String?>? descricao,
      Value<double>? valor,
      Value<String?>? categoria,
      Value<int?>? duracaoMinutos,
      Value<bool>? ativo,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ServicosTableCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      categoria: categoria ?? this.categoria,
      duracaoMinutos: duracaoMinutos ?? this.duracaoMinutos,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (valor.present) {
      map['valor'] = Variable<double>(valor.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (duracaoMinutos.present) {
      map['duracao_minutos'] = Variable<int>(duracaoMinutos.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicosTableCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('valor: $valor, ')
          ..write('categoria: $categoria, ')
          ..write('duracaoMinutos: $duracaoMinutos, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $OrcamentoTableTable extends OrcamentoTable
    with TableInfo<$OrcamentoTableTable, OrcamentoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrcamentoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<String> numero = GeneratedColumn<String>(
      'numero', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _clienteIdMeta =
      const VerificationMeta('clienteId');
  @override
  late final GeneratedColumn<int> clienteId = GeneratedColumn<int>(
      'cliente_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _valorTotalMeta =
      const VerificationMeta('valorTotal');
  @override
  late final GeneratedColumn<double> valorTotal = GeneratedColumn<double>(
      'valor_total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descontoMeta =
      const VerificationMeta('desconto');
  @override
  late final GeneratedColumn<double> desconto = GeneratedColumn<double>(
      'desconto', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _valorFinalMeta =
      const VerificationMeta('valorFinal');
  @override
  late final GeneratedColumn<double> valorFinal = GeneratedColumn<double>(
      'valor_final', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<StatusOrcamento, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('rascunho'))
          .withConverter<StatusOrcamento>(
              $OrcamentoTableTable.$converterstatus);
  static const VerificationMeta _dataVencimentoMeta =
      const VerificationMeta('dataVencimento');
  @override
  late final GeneratedColumn<DateTime> dataVencimento =
      GeneratedColumn<DateTime>('data_vencimento', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _observacoesMeta =
      const VerificationMeta('observacoes');
  @override
  late final GeneratedColumn<String> observacoes = GeneratedColumn<String>(
      'observacoes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fotosDefeitoUrlsMeta =
      const VerificationMeta('fotosDefeitoUrls');
  @override
  late final GeneratedColumn<String> fotosDefeitoUrls = GeneratedColumn<String>(
      'fotos_defeito_urls', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fotosReposicaoUrlsMeta =
      const VerificationMeta('fotosReposicaoUrls');
  @override
  late final GeneratedColumn<String> fotosReposicaoUrls =
      GeneratedColumn<String>('fotos_reposicao_urls', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        numero,
        clienteId,
        descricao,
        valorTotal,
        desconto,
        valorFinal,
        status,
        dataVencimento,
        observacoes,
        fotosDefeitoUrls,
        fotosReposicaoUrls,
        ativo,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orcamento_table';
  @override
  VerificationContext validateIntegrity(Insertable<OrcamentoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('numero')) {
      context.handle(_numeroMeta,
          numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta));
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('cliente_id')) {
      context.handle(_clienteIdMeta,
          clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    if (data.containsKey('valor_total')) {
      context.handle(
          _valorTotalMeta,
          valorTotal.isAcceptableOrUnknown(
              data['valor_total']!, _valorTotalMeta));
    } else if (isInserting) {
      context.missing(_valorTotalMeta);
    }
    if (data.containsKey('desconto')) {
      context.handle(_descontoMeta,
          desconto.isAcceptableOrUnknown(data['desconto']!, _descontoMeta));
    }
    if (data.containsKey('valor_final')) {
      context.handle(
          _valorFinalMeta,
          valorFinal.isAcceptableOrUnknown(
              data['valor_final']!, _valorFinalMeta));
    } else if (isInserting) {
      context.missing(_valorFinalMeta);
    }
    if (data.containsKey('data_vencimento')) {
      context.handle(
          _dataVencimentoMeta,
          dataVencimento.isAcceptableOrUnknown(
              data['data_vencimento']!, _dataVencimentoMeta));
    }
    if (data.containsKey('observacoes')) {
      context.handle(
          _observacoesMeta,
          observacoes.isAcceptableOrUnknown(
              data['observacoes']!, _observacoesMeta));
    }
    if (data.containsKey('fotos_defeito_urls')) {
      context.handle(
          _fotosDefeitoUrlsMeta,
          fotosDefeitoUrls.isAcceptableOrUnknown(
              data['fotos_defeito_urls']!, _fotosDefeitoUrlsMeta));
    }
    if (data.containsKey('fotos_reposicao_urls')) {
      context.handle(
          _fotosReposicaoUrlsMeta,
          fotosReposicaoUrls.isAcceptableOrUnknown(
              data['fotos_reposicao_urls']!, _fotosReposicaoUrlsMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrcamentoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrcamentoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      numero: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero'])!,
      clienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cliente_id']),
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao']),
      valorTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor_total'])!,
      desconto: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}desconto'])!,
      valorFinal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor_final'])!,
      status: $OrcamentoTableTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      dataVencimento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_vencimento']),
      observacoes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacoes']),
      fotosDefeitoUrls: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}fotos_defeito_urls']),
      fotosReposicaoUrls: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}fotos_reposicao_urls']),
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $OrcamentoTableTable createAlias(String alias) {
    return $OrcamentoTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StatusOrcamento, String, String> $converterstatus =
      const EnumNameConverter<StatusOrcamento>(StatusOrcamento.values);
}

class OrcamentoData extends DataClass implements Insertable<OrcamentoData> {
  final int id;
  final String numero;
  final int? clienteId;
  final String? descricao;
  final double valorTotal;
  final double desconto;
  final double valorFinal;
  final StatusOrcamento status;
  final DateTime? dataVencimento;
  final String? observacoes;
  final String? fotosDefeitoUrls;
  final String? fotosReposicaoUrls;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;
  const OrcamentoData(
      {required this.id,
      required this.numero,
      this.clienteId,
      this.descricao,
      required this.valorTotal,
      required this.desconto,
      required this.valorFinal,
      required this.status,
      this.dataVencimento,
      this.observacoes,
      this.fotosDefeitoUrls,
      this.fotosReposicaoUrls,
      required this.ativo,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['numero'] = Variable<String>(numero);
    if (!nullToAbsent || clienteId != null) {
      map['cliente_id'] = Variable<int>(clienteId);
    }
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    map['valor_total'] = Variable<double>(valorTotal);
    map['desconto'] = Variable<double>(desconto);
    map['valor_final'] = Variable<double>(valorFinal);
    {
      map['status'] =
          Variable<String>($OrcamentoTableTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || dataVencimento != null) {
      map['data_vencimento'] = Variable<DateTime>(dataVencimento);
    }
    if (!nullToAbsent || observacoes != null) {
      map['observacoes'] = Variable<String>(observacoes);
    }
    if (!nullToAbsent || fotosDefeitoUrls != null) {
      map['fotos_defeito_urls'] = Variable<String>(fotosDefeitoUrls);
    }
    if (!nullToAbsent || fotosReposicaoUrls != null) {
      map['fotos_reposicao_urls'] = Variable<String>(fotosReposicaoUrls);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OrcamentoTableCompanion toCompanion(bool nullToAbsent) {
    return OrcamentoTableCompanion(
      id: Value(id),
      numero: Value(numero),
      clienteId: clienteId == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteId),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
      valorTotal: Value(valorTotal),
      desconto: Value(desconto),
      valorFinal: Value(valorFinal),
      status: Value(status),
      dataVencimento: dataVencimento == null && nullToAbsent
          ? const Value.absent()
          : Value(dataVencimento),
      observacoes: observacoes == null && nullToAbsent
          ? const Value.absent()
          : Value(observacoes),
      fotosDefeitoUrls: fotosDefeitoUrls == null && nullToAbsent
          ? const Value.absent()
          : Value(fotosDefeitoUrls),
      fotosReposicaoUrls: fotosReposicaoUrls == null && nullToAbsent
          ? const Value.absent()
          : Value(fotosReposicaoUrls),
      ativo: Value(ativo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory OrcamentoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrcamentoData(
      id: serializer.fromJson<int>(json['id']),
      numero: serializer.fromJson<String>(json['numero']),
      clienteId: serializer.fromJson<int?>(json['clienteId']),
      descricao: serializer.fromJson<String?>(json['descricao']),
      valorTotal: serializer.fromJson<double>(json['valorTotal']),
      desconto: serializer.fromJson<double>(json['desconto']),
      valorFinal: serializer.fromJson<double>(json['valorFinal']),
      status: $OrcamentoTableTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      dataVencimento: serializer.fromJson<DateTime?>(json['dataVencimento']),
      observacoes: serializer.fromJson<String?>(json['observacoes']),
      fotosDefeitoUrls: serializer.fromJson<String?>(json['fotosDefeitoUrls']),
      fotosReposicaoUrls:
          serializer.fromJson<String?>(json['fotosReposicaoUrls']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'numero': serializer.toJson<String>(numero),
      'clienteId': serializer.toJson<int?>(clienteId),
      'descricao': serializer.toJson<String?>(descricao),
      'valorTotal': serializer.toJson<double>(valorTotal),
      'desconto': serializer.toJson<double>(desconto),
      'valorFinal': serializer.toJson<double>(valorFinal),
      'status': serializer
          .toJson<String>($OrcamentoTableTable.$converterstatus.toJson(status)),
      'dataVencimento': serializer.toJson<DateTime?>(dataVencimento),
      'observacoes': serializer.toJson<String?>(observacoes),
      'fotosDefeitoUrls': serializer.toJson<String?>(fotosDefeitoUrls),
      'fotosReposicaoUrls': serializer.toJson<String?>(fotosReposicaoUrls),
      'ativo': serializer.toJson<bool>(ativo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  OrcamentoData copyWith(
          {int? id,
          String? numero,
          Value<int?> clienteId = const Value.absent(),
          Value<String?> descricao = const Value.absent(),
          double? valorTotal,
          double? desconto,
          double? valorFinal,
          StatusOrcamento? status,
          Value<DateTime?> dataVencimento = const Value.absent(),
          Value<String?> observacoes = const Value.absent(),
          Value<String?> fotosDefeitoUrls = const Value.absent(),
          Value<String?> fotosReposicaoUrls = const Value.absent(),
          bool? ativo,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      OrcamentoData(
        id: id ?? this.id,
        numero: numero ?? this.numero,
        clienteId: clienteId.present ? clienteId.value : this.clienteId,
        descricao: descricao.present ? descricao.value : this.descricao,
        valorTotal: valorTotal ?? this.valorTotal,
        desconto: desconto ?? this.desconto,
        valorFinal: valorFinal ?? this.valorFinal,
        status: status ?? this.status,
        dataVencimento:
            dataVencimento.present ? dataVencimento.value : this.dataVencimento,
        observacoes: observacoes.present ? observacoes.value : this.observacoes,
        fotosDefeitoUrls: fotosDefeitoUrls.present
            ? fotosDefeitoUrls.value
            : this.fotosDefeitoUrls,
        fotosReposicaoUrls: fotosReposicaoUrls.present
            ? fotosReposicaoUrls.value
            : this.fotosReposicaoUrls,
        ativo: ativo ?? this.ativo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  OrcamentoData copyWithCompanion(OrcamentoTableCompanion data) {
    return OrcamentoData(
      id: data.id.present ? data.id.value : this.id,
      numero: data.numero.present ? data.numero.value : this.numero,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      valorTotal:
          data.valorTotal.present ? data.valorTotal.value : this.valorTotal,
      desconto: data.desconto.present ? data.desconto.value : this.desconto,
      valorFinal:
          data.valorFinal.present ? data.valorFinal.value : this.valorFinal,
      status: data.status.present ? data.status.value : this.status,
      dataVencimento: data.dataVencimento.present
          ? data.dataVencimento.value
          : this.dataVencimento,
      observacoes:
          data.observacoes.present ? data.observacoes.value : this.observacoes,
      fotosDefeitoUrls: data.fotosDefeitoUrls.present
          ? data.fotosDefeitoUrls.value
          : this.fotosDefeitoUrls,
      fotosReposicaoUrls: data.fotosReposicaoUrls.present
          ? data.fotosReposicaoUrls.value
          : this.fotosReposicaoUrls,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrcamentoData(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('clienteId: $clienteId, ')
          ..write('descricao: $descricao, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('desconto: $desconto, ')
          ..write('valorFinal: $valorFinal, ')
          ..write('status: $status, ')
          ..write('dataVencimento: $dataVencimento, ')
          ..write('observacoes: $observacoes, ')
          ..write('fotosDefeitoUrls: $fotosDefeitoUrls, ')
          ..write('fotosReposicaoUrls: $fotosReposicaoUrls, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      numero,
      clienteId,
      descricao,
      valorTotal,
      desconto,
      valorFinal,
      status,
      dataVencimento,
      observacoes,
      fotosDefeitoUrls,
      fotosReposicaoUrls,
      ativo,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrcamentoData &&
          other.id == this.id &&
          other.numero == this.numero &&
          other.clienteId == this.clienteId &&
          other.descricao == this.descricao &&
          other.valorTotal == this.valorTotal &&
          other.desconto == this.desconto &&
          other.valorFinal == this.valorFinal &&
          other.status == this.status &&
          other.dataVencimento == this.dataVencimento &&
          other.observacoes == this.observacoes &&
          other.fotosDefeitoUrls == this.fotosDefeitoUrls &&
          other.fotosReposicaoUrls == this.fotosReposicaoUrls &&
          other.ativo == this.ativo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OrcamentoTableCompanion extends UpdateCompanion<OrcamentoData> {
  final Value<int> id;
  final Value<String> numero;
  final Value<int?> clienteId;
  final Value<String?> descricao;
  final Value<double> valorTotal;
  final Value<double> desconto;
  final Value<double> valorFinal;
  final Value<StatusOrcamento> status;
  final Value<DateTime?> dataVencimento;
  final Value<String?> observacoes;
  final Value<String?> fotosDefeitoUrls;
  final Value<String?> fotosReposicaoUrls;
  final Value<bool> ativo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const OrcamentoTableCompanion({
    this.id = const Value.absent(),
    this.numero = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.descricao = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.desconto = const Value.absent(),
    this.valorFinal = const Value.absent(),
    this.status = const Value.absent(),
    this.dataVencimento = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.fotosDefeitoUrls = const Value.absent(),
    this.fotosReposicaoUrls = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  OrcamentoTableCompanion.insert({
    this.id = const Value.absent(),
    required String numero,
    this.clienteId = const Value.absent(),
    this.descricao = const Value.absent(),
    required double valorTotal,
    this.desconto = const Value.absent(),
    required double valorFinal,
    this.status = const Value.absent(),
    this.dataVencimento = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.fotosDefeitoUrls = const Value.absent(),
    this.fotosReposicaoUrls = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : numero = Value(numero),
        valorTotal = Value(valorTotal),
        valorFinal = Value(valorFinal);
  static Insertable<OrcamentoData> custom({
    Expression<int>? id,
    Expression<String>? numero,
    Expression<int>? clienteId,
    Expression<String>? descricao,
    Expression<double>? valorTotal,
    Expression<double>? desconto,
    Expression<double>? valorFinal,
    Expression<String>? status,
    Expression<DateTime>? dataVencimento,
    Expression<String>? observacoes,
    Expression<String>? fotosDefeitoUrls,
    Expression<String>? fotosReposicaoUrls,
    Expression<bool>? ativo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (numero != null) 'numero': numero,
      if (clienteId != null) 'cliente_id': clienteId,
      if (descricao != null) 'descricao': descricao,
      if (valorTotal != null) 'valor_total': valorTotal,
      if (desconto != null) 'desconto': desconto,
      if (valorFinal != null) 'valor_final': valorFinal,
      if (status != null) 'status': status,
      if (dataVencimento != null) 'data_vencimento': dataVencimento,
      if (observacoes != null) 'observacoes': observacoes,
      if (fotosDefeitoUrls != null) 'fotos_defeito_urls': fotosDefeitoUrls,
      if (fotosReposicaoUrls != null)
        'fotos_reposicao_urls': fotosReposicaoUrls,
      if (ativo != null) 'ativo': ativo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  OrcamentoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? numero,
      Value<int?>? clienteId,
      Value<String?>? descricao,
      Value<double>? valorTotal,
      Value<double>? desconto,
      Value<double>? valorFinal,
      Value<StatusOrcamento>? status,
      Value<DateTime?>? dataVencimento,
      Value<String?>? observacoes,
      Value<String?>? fotosDefeitoUrls,
      Value<String?>? fotosReposicaoUrls,
      Value<bool>? ativo,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return OrcamentoTableCompanion(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      clienteId: clienteId ?? this.clienteId,
      descricao: descricao ?? this.descricao,
      valorTotal: valorTotal ?? this.valorTotal,
      desconto: desconto ?? this.desconto,
      valorFinal: valorFinal ?? this.valorFinal,
      status: status ?? this.status,
      dataVencimento: dataVencimento ?? this.dataVencimento,
      observacoes: observacoes ?? this.observacoes,
      fotosDefeitoUrls: fotosDefeitoUrls ?? this.fotosDefeitoUrls,
      fotosReposicaoUrls: fotosReposicaoUrls ?? this.fotosReposicaoUrls,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (numero.present) {
      map['numero'] = Variable<String>(numero.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<int>(clienteId.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (valorTotal.present) {
      map['valor_total'] = Variable<double>(valorTotal.value);
    }
    if (desconto.present) {
      map['desconto'] = Variable<double>(desconto.value);
    }
    if (valorFinal.present) {
      map['valor_final'] = Variable<double>(valorFinal.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $OrcamentoTableTable.$converterstatus.toSql(status.value));
    }
    if (dataVencimento.present) {
      map['data_vencimento'] = Variable<DateTime>(dataVencimento.value);
    }
    if (observacoes.present) {
      map['observacoes'] = Variable<String>(observacoes.value);
    }
    if (fotosDefeitoUrls.present) {
      map['fotos_defeito_urls'] = Variable<String>(fotosDefeitoUrls.value);
    }
    if (fotosReposicaoUrls.present) {
      map['fotos_reposicao_urls'] = Variable<String>(fotosReposicaoUrls.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrcamentoTableCompanion(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('clienteId: $clienteId, ')
          ..write('descricao: $descricao, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('desconto: $desconto, ')
          ..write('valorFinal: $valorFinal, ')
          ..write('status: $status, ')
          ..write('dataVencimento: $dataVencimento, ')
          ..write('observacoes: $observacoes, ')
          ..write('fotosDefeitoUrls: $fotosDefeitoUrls, ')
          ..write('fotosReposicaoUrls: $fotosReposicaoUrls, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ItemOrcamentoTableTable extends ItemOrcamentoTable
    with TableInfo<$ItemOrcamentoTableTable, ItemOrcamentoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemOrcamentoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orcamentoIdMeta =
      const VerificationMeta('orcamentoId');
  @override
  late final GeneratedColumn<int> orcamentoId = GeneratedColumn<int>(
      'orcamento_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES orcamento_table (id)'));
  static const VerificationMeta _produtoIdMeta =
      const VerificationMeta('produtoId');
  @override
  late final GeneratedColumn<int> produtoId = GeneratedColumn<int>(
      'produto_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _servicoIdMeta =
      const VerificationMeta('servicoId');
  @override
  late final GeneratedColumn<int> servicoId = GeneratedColumn<int>(
      'servico_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantidadeMeta =
      const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _valorUnitarioMeta =
      const VerificationMeta('valorUnitario');
  @override
  late final GeneratedColumn<double> valorUnitario = GeneratedColumn<double>(
      'valor_unitario', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _valorTotalMeta =
      const VerificationMeta('valorTotal');
  @override
  late final GeneratedColumn<double> valorTotal = GeneratedColumn<double>(
      'valor_total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        orcamentoId,
        produtoId,
        servicoId,
        descricao,
        quantidade,
        valorUnitario,
        valorTotal,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_orcamento_table';
  @override
  VerificationContext validateIntegrity(Insertable<ItemOrcamentoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orcamento_id')) {
      context.handle(
          _orcamentoIdMeta,
          orcamentoId.isAcceptableOrUnknown(
              data['orcamento_id']!, _orcamentoIdMeta));
    } else if (isInserting) {
      context.missing(_orcamentoIdMeta);
    }
    if (data.containsKey('produto_id')) {
      context.handle(_produtoIdMeta,
          produtoId.isAcceptableOrUnknown(data['produto_id']!, _produtoIdMeta));
    }
    if (data.containsKey('servico_id')) {
      context.handle(_servicoIdMeta,
          servicoId.isAcceptableOrUnknown(data['servico_id']!, _servicoIdMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('valor_unitario')) {
      context.handle(
          _valorUnitarioMeta,
          valorUnitario.isAcceptableOrUnknown(
              data['valor_unitario']!, _valorUnitarioMeta));
    } else if (isInserting) {
      context.missing(_valorUnitarioMeta);
    }
    if (data.containsKey('valor_total')) {
      context.handle(
          _valorTotalMeta,
          valorTotal.isAcceptableOrUnknown(
              data['valor_total']!, _valorTotalMeta));
    } else if (isInserting) {
      context.missing(_valorTotalMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemOrcamentoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemOrcamentoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      orcamentoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orcamento_id'])!,
      produtoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}produto_id']),
      servicoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}servico_id']),
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
      quantidade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
      valorUnitario: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor_unitario'])!,
      valorTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor_total'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ItemOrcamentoTableTable createAlias(String alias) {
    return $ItemOrcamentoTableTable(attachedDatabase, alias);
  }
}

class ItemOrcamentoData extends DataClass
    implements Insertable<ItemOrcamentoData> {
  final int id;
  final int orcamentoId;
  final int? produtoId;
  final int? servicoId;
  final String descricao;
  final int quantidade;
  final double valorUnitario;
  final double valorTotal;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ItemOrcamentoData(
      {required this.id,
      required this.orcamentoId,
      this.produtoId,
      this.servicoId,
      required this.descricao,
      required this.quantidade,
      required this.valorUnitario,
      required this.valorTotal,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orcamento_id'] = Variable<int>(orcamentoId);
    if (!nullToAbsent || produtoId != null) {
      map['produto_id'] = Variable<int>(produtoId);
    }
    if (!nullToAbsent || servicoId != null) {
      map['servico_id'] = Variable<int>(servicoId);
    }
    map['descricao'] = Variable<String>(descricao);
    map['quantidade'] = Variable<int>(quantidade);
    map['valor_unitario'] = Variable<double>(valorUnitario);
    map['valor_total'] = Variable<double>(valorTotal);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ItemOrcamentoTableCompanion toCompanion(bool nullToAbsent) {
    return ItemOrcamentoTableCompanion(
      id: Value(id),
      orcamentoId: Value(orcamentoId),
      produtoId: produtoId == null && nullToAbsent
          ? const Value.absent()
          : Value(produtoId),
      servicoId: servicoId == null && nullToAbsent
          ? const Value.absent()
          : Value(servicoId),
      descricao: Value(descricao),
      quantidade: Value(quantidade),
      valorUnitario: Value(valorUnitario),
      valorTotal: Value(valorTotal),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ItemOrcamentoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemOrcamentoData(
      id: serializer.fromJson<int>(json['id']),
      orcamentoId: serializer.fromJson<int>(json['orcamentoId']),
      produtoId: serializer.fromJson<int?>(json['produtoId']),
      servicoId: serializer.fromJson<int?>(json['servicoId']),
      descricao: serializer.fromJson<String>(json['descricao']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      valorUnitario: serializer.fromJson<double>(json['valorUnitario']),
      valorTotal: serializer.fromJson<double>(json['valorTotal']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orcamentoId': serializer.toJson<int>(orcamentoId),
      'produtoId': serializer.toJson<int?>(produtoId),
      'servicoId': serializer.toJson<int?>(servicoId),
      'descricao': serializer.toJson<String>(descricao),
      'quantidade': serializer.toJson<int>(quantidade),
      'valorUnitario': serializer.toJson<double>(valorUnitario),
      'valorTotal': serializer.toJson<double>(valorTotal),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ItemOrcamentoData copyWith(
          {int? id,
          int? orcamentoId,
          Value<int?> produtoId = const Value.absent(),
          Value<int?> servicoId = const Value.absent(),
          String? descricao,
          int? quantidade,
          double? valorUnitario,
          double? valorTotal,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ItemOrcamentoData(
        id: id ?? this.id,
        orcamentoId: orcamentoId ?? this.orcamentoId,
        produtoId: produtoId.present ? produtoId.value : this.produtoId,
        servicoId: servicoId.present ? servicoId.value : this.servicoId,
        descricao: descricao ?? this.descricao,
        quantidade: quantidade ?? this.quantidade,
        valorUnitario: valorUnitario ?? this.valorUnitario,
        valorTotal: valorTotal ?? this.valorTotal,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ItemOrcamentoData copyWithCompanion(ItemOrcamentoTableCompanion data) {
    return ItemOrcamentoData(
      id: data.id.present ? data.id.value : this.id,
      orcamentoId:
          data.orcamentoId.present ? data.orcamentoId.value : this.orcamentoId,
      produtoId: data.produtoId.present ? data.produtoId.value : this.produtoId,
      servicoId: data.servicoId.present ? data.servicoId.value : this.servicoId,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      quantidade:
          data.quantidade.present ? data.quantidade.value : this.quantidade,
      valorUnitario: data.valorUnitario.present
          ? data.valorUnitario.value
          : this.valorUnitario,
      valorTotal:
          data.valorTotal.present ? data.valorTotal.value : this.valorTotal,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemOrcamentoData(')
          ..write('id: $id, ')
          ..write('orcamentoId: $orcamentoId, ')
          ..write('produtoId: $produtoId, ')
          ..write('servicoId: $servicoId, ')
          ..write('descricao: $descricao, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, orcamentoId, produtoId, servicoId,
      descricao, quantidade, valorUnitario, valorTotal, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemOrcamentoData &&
          other.id == this.id &&
          other.orcamentoId == this.orcamentoId &&
          other.produtoId == this.produtoId &&
          other.servicoId == this.servicoId &&
          other.descricao == this.descricao &&
          other.quantidade == this.quantidade &&
          other.valorUnitario == this.valorUnitario &&
          other.valorTotal == this.valorTotal &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ItemOrcamentoTableCompanion extends UpdateCompanion<ItemOrcamentoData> {
  final Value<int> id;
  final Value<int> orcamentoId;
  final Value<int?> produtoId;
  final Value<int?> servicoId;
  final Value<String> descricao;
  final Value<int> quantidade;
  final Value<double> valorUnitario;
  final Value<double> valorTotal;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ItemOrcamentoTableCompanion({
    this.id = const Value.absent(),
    this.orcamentoId = const Value.absent(),
    this.produtoId = const Value.absent(),
    this.servicoId = const Value.absent(),
    this.descricao = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorUnitario = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ItemOrcamentoTableCompanion.insert({
    this.id = const Value.absent(),
    required int orcamentoId,
    this.produtoId = const Value.absent(),
    this.servicoId = const Value.absent(),
    required String descricao,
    required int quantidade,
    required double valorUnitario,
    required double valorTotal,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : orcamentoId = Value(orcamentoId),
        descricao = Value(descricao),
        quantidade = Value(quantidade),
        valorUnitario = Value(valorUnitario),
        valorTotal = Value(valorTotal);
  static Insertable<ItemOrcamentoData> custom({
    Expression<int>? id,
    Expression<int>? orcamentoId,
    Expression<int>? produtoId,
    Expression<int>? servicoId,
    Expression<String>? descricao,
    Expression<int>? quantidade,
    Expression<double>? valorUnitario,
    Expression<double>? valorTotal,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orcamentoId != null) 'orcamento_id': orcamentoId,
      if (produtoId != null) 'produto_id': produtoId,
      if (servicoId != null) 'servico_id': servicoId,
      if (descricao != null) 'descricao': descricao,
      if (quantidade != null) 'quantidade': quantidade,
      if (valorUnitario != null) 'valor_unitario': valorUnitario,
      if (valorTotal != null) 'valor_total': valorTotal,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ItemOrcamentoTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? orcamentoId,
      Value<int?>? produtoId,
      Value<int?>? servicoId,
      Value<String>? descricao,
      Value<int>? quantidade,
      Value<double>? valorUnitario,
      Value<double>? valorTotal,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ItemOrcamentoTableCompanion(
      id: id ?? this.id,
      orcamentoId: orcamentoId ?? this.orcamentoId,
      produtoId: produtoId ?? this.produtoId,
      servicoId: servicoId ?? this.servicoId,
      descricao: descricao ?? this.descricao,
      quantidade: quantidade ?? this.quantidade,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      valorTotal: valorTotal ?? this.valorTotal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orcamentoId.present) {
      map['orcamento_id'] = Variable<int>(orcamentoId.value);
    }
    if (produtoId.present) {
      map['produto_id'] = Variable<int>(produtoId.value);
    }
    if (servicoId.present) {
      map['servico_id'] = Variable<int>(servicoId.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    if (valorUnitario.present) {
      map['valor_unitario'] = Variable<double>(valorUnitario.value);
    }
    if (valorTotal.present) {
      map['valor_total'] = Variable<double>(valorTotal.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemOrcamentoTableCompanion(')
          ..write('id: $id, ')
          ..write('orcamentoId: $orcamentoId, ')
          ..write('produtoId: $produtoId, ')
          ..write('servicoId: $servicoId, ')
          ..write('descricao: $descricao, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $OrdensServicoTableTable extends OrdensServicoTable
    with TableInfo<$OrdensServicoTableTable, OrdensServicoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdensServicoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<String> numero = GeneratedColumn<String>(
      'numero', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _clienteIdMeta =
      const VerificationMeta('clienteId');
  @override
  late final GeneratedColumn<int> clienteId = GeneratedColumn<int>(
      'cliente_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nomeClienteMeta =
      const VerificationMeta('nomeCliente');
  @override
  late final GeneratedColumn<String> nomeCliente = GeneratedColumn<String>(
      'nome_cliente', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _emailClienteMeta =
      const VerificationMeta('emailCliente');
  @override
  late final GeneratedColumn<String> emailCliente = GeneratedColumn<String>(
      'email_cliente', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _telefoneClienteMeta =
      const VerificationMeta('telefoneCliente');
  @override
  late final GeneratedColumn<String> telefoneCliente = GeneratedColumn<String>(
      'telefone_cliente', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descontoMeta =
      const VerificationMeta('desconto');
  @override
  late final GeneratedColumn<double> desconto = GeneratedColumn<double>(
      'desconto', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _prioridadeMeta =
      const VerificationMeta('prioridade');
  @override
  late final GeneratedColumn<String> prioridade = GeneratedColumn<String>(
      'prioridade', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dataAgendamentoMeta =
      const VerificationMeta('dataAgendamento');
  @override
  late final GeneratedColumn<DateTime> dataAgendamento =
      GeneratedColumn<DateTime>('data_agendamento', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dataPrevistaMeta =
      const VerificationMeta('dataPrevista');
  @override
  late final GeneratedColumn<DateTime> dataPrevista = GeneratedColumn<DateTime>(
      'data_prevista', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dataInicioMeta =
      const VerificationMeta('dataInicio');
  @override
  late final GeneratedColumn<DateTime> dataInicio = GeneratedColumn<DateTime>(
      'data_inicio', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dataConclusaoMeta =
      const VerificationMeta('dataConclusao');
  @override
  late final GeneratedColumn<DateTime> dataConclusao =
      GeneratedColumn<DateTime>('data_conclusao', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _observacoesMeta =
      const VerificationMeta('observacoes');
  @override
  late final GeneratedColumn<String> observacoes = GeneratedColumn<String>(
      'observacoes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _observacoesInternasMeta =
      const VerificationMeta('observacoesInternas');
  @override
  late final GeneratedColumn<String> observacoesInternas =
      GeneratedColumn<String>('observacoes_internas', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tecnicoResponsavelMeta =
      const VerificationMeta('tecnicoResponsavel');
  @override
  late final GeneratedColumn<String> tecnicoResponsavel =
      GeneratedColumn<String>('tecnico_responsavel', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _equipamentoMeta =
      const VerificationMeta('equipamento');
  @override
  late final GeneratedColumn<String> equipamento = GeneratedColumn<String>(
      'equipamento', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _problemaRelatadoMeta =
      const VerificationMeta('problemaRelatado');
  @override
  late final GeneratedColumn<String> problemaRelatado = GeneratedColumn<String>(
      'problema_relatado', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _solucaoAplicadaMeta =
      const VerificationMeta('solucaoAplicada');
  @override
  late final GeneratedColumn<String> solucaoAplicada = GeneratedColumn<String>(
      'solucao_aplicada', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        numero,
        clienteId,
        nomeCliente,
        emailCliente,
        telefoneCliente,
        subtotal,
        desconto,
        total,
        status,
        prioridade,
        dataAgendamento,
        dataPrevista,
        dataInicio,
        dataConclusao,
        observacoes,
        observacoesInternas,
        tecnicoResponsavel,
        equipamento,
        problemaRelatado,
        solucaoAplicada,
        ativo,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordens_servico';
  @override
  VerificationContext validateIntegrity(
      Insertable<OrdensServicoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('numero')) {
      context.handle(_numeroMeta,
          numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta));
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('cliente_id')) {
      context.handle(_clienteIdMeta,
          clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta));
    } else if (isInserting) {
      context.missing(_clienteIdMeta);
    }
    if (data.containsKey('nome_cliente')) {
      context.handle(
          _nomeClienteMeta,
          nomeCliente.isAcceptableOrUnknown(
              data['nome_cliente']!, _nomeClienteMeta));
    } else if (isInserting) {
      context.missing(_nomeClienteMeta);
    }
    if (data.containsKey('email_cliente')) {
      context.handle(
          _emailClienteMeta,
          emailCliente.isAcceptableOrUnknown(
              data['email_cliente']!, _emailClienteMeta));
    }
    if (data.containsKey('telefone_cliente')) {
      context.handle(
          _telefoneClienteMeta,
          telefoneCliente.isAcceptableOrUnknown(
              data['telefone_cliente']!, _telefoneClienteMeta));
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('desconto')) {
      context.handle(_descontoMeta,
          desconto.isAcceptableOrUnknown(data['desconto']!, _descontoMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('prioridade')) {
      context.handle(
          _prioridadeMeta,
          prioridade.isAcceptableOrUnknown(
              data['prioridade']!, _prioridadeMeta));
    } else if (isInserting) {
      context.missing(_prioridadeMeta);
    }
    if (data.containsKey('data_agendamento')) {
      context.handle(
          _dataAgendamentoMeta,
          dataAgendamento.isAcceptableOrUnknown(
              data['data_agendamento']!, _dataAgendamentoMeta));
    } else if (isInserting) {
      context.missing(_dataAgendamentoMeta);
    }
    if (data.containsKey('data_prevista')) {
      context.handle(
          _dataPrevistaMeta,
          dataPrevista.isAcceptableOrUnknown(
              data['data_prevista']!, _dataPrevistaMeta));
    }
    if (data.containsKey('data_inicio')) {
      context.handle(
          _dataInicioMeta,
          dataInicio.isAcceptableOrUnknown(
              data['data_inicio']!, _dataInicioMeta));
    }
    if (data.containsKey('data_conclusao')) {
      context.handle(
          _dataConclusaoMeta,
          dataConclusao.isAcceptableOrUnknown(
              data['data_conclusao']!, _dataConclusaoMeta));
    }
    if (data.containsKey('observacoes')) {
      context.handle(
          _observacoesMeta,
          observacoes.isAcceptableOrUnknown(
              data['observacoes']!, _observacoesMeta));
    }
    if (data.containsKey('observacoes_internas')) {
      context.handle(
          _observacoesInternasMeta,
          observacoesInternas.isAcceptableOrUnknown(
              data['observacoes_internas']!, _observacoesInternasMeta));
    }
    if (data.containsKey('tecnico_responsavel')) {
      context.handle(
          _tecnicoResponsavelMeta,
          tecnicoResponsavel.isAcceptableOrUnknown(
              data['tecnico_responsavel']!, _tecnicoResponsavelMeta));
    }
    if (data.containsKey('equipamento')) {
      context.handle(
          _equipamentoMeta,
          equipamento.isAcceptableOrUnknown(
              data['equipamento']!, _equipamentoMeta));
    }
    if (data.containsKey('problema_relatado')) {
      context.handle(
          _problemaRelatadoMeta,
          problemaRelatado.isAcceptableOrUnknown(
              data['problema_relatado']!, _problemaRelatadoMeta));
    }
    if (data.containsKey('solucao_aplicada')) {
      context.handle(
          _solucaoAplicadaMeta,
          solucaoAplicada.isAcceptableOrUnknown(
              data['solucao_aplicada']!, _solucaoAplicadaMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdensServicoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdensServicoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      numero: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero'])!,
      clienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cliente_id'])!,
      nomeCliente: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_cliente'])!,
      emailCliente: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email_cliente']),
      telefoneCliente: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}telefone_cliente']),
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      desconto: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}desconto'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      prioridade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prioridade'])!,
      dataAgendamento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_agendamento'])!,
      dataPrevista: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_prevista']),
      dataInicio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_inicio']),
      dataConclusao: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_conclusao']),
      observacoes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacoes']),
      observacoesInternas: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}observacoes_internas']),
      tecnicoResponsavel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}tecnico_responsavel']),
      equipamento: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}equipamento']),
      problemaRelatado: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}problema_relatado']),
      solucaoAplicada: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}solucao_aplicada']),
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $OrdensServicoTableTable createAlias(String alias) {
    return $OrdensServicoTableTable(attachedDatabase, alias);
  }
}

class OrdensServicoTableData extends DataClass
    implements Insertable<OrdensServicoTableData> {
  final int id;
  final String numero;
  final int clienteId;
  final String nomeCliente;
  final String? emailCliente;
  final String? telefoneCliente;
  final double subtotal;
  final double desconto;
  final double total;
  final String status;
  final String prioridade;
  final DateTime dataAgendamento;
  final DateTime? dataPrevista;
  final DateTime? dataInicio;
  final DateTime? dataConclusao;
  final String? observacoes;
  final String? observacoesInternas;
  final String? tecnicoResponsavel;
  final String? equipamento;
  final String? problemaRelatado;
  final String? solucaoAplicada;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;
  const OrdensServicoTableData(
      {required this.id,
      required this.numero,
      required this.clienteId,
      required this.nomeCliente,
      this.emailCliente,
      this.telefoneCliente,
      required this.subtotal,
      required this.desconto,
      required this.total,
      required this.status,
      required this.prioridade,
      required this.dataAgendamento,
      this.dataPrevista,
      this.dataInicio,
      this.dataConclusao,
      this.observacoes,
      this.observacoesInternas,
      this.tecnicoResponsavel,
      this.equipamento,
      this.problemaRelatado,
      this.solucaoAplicada,
      required this.ativo,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['numero'] = Variable<String>(numero);
    map['cliente_id'] = Variable<int>(clienteId);
    map['nome_cliente'] = Variable<String>(nomeCliente);
    if (!nullToAbsent || emailCliente != null) {
      map['email_cliente'] = Variable<String>(emailCliente);
    }
    if (!nullToAbsent || telefoneCliente != null) {
      map['telefone_cliente'] = Variable<String>(telefoneCliente);
    }
    map['subtotal'] = Variable<double>(subtotal);
    map['desconto'] = Variable<double>(desconto);
    map['total'] = Variable<double>(total);
    map['status'] = Variable<String>(status);
    map['prioridade'] = Variable<String>(prioridade);
    map['data_agendamento'] = Variable<DateTime>(dataAgendamento);
    if (!nullToAbsent || dataPrevista != null) {
      map['data_prevista'] = Variable<DateTime>(dataPrevista);
    }
    if (!nullToAbsent || dataInicio != null) {
      map['data_inicio'] = Variable<DateTime>(dataInicio);
    }
    if (!nullToAbsent || dataConclusao != null) {
      map['data_conclusao'] = Variable<DateTime>(dataConclusao);
    }
    if (!nullToAbsent || observacoes != null) {
      map['observacoes'] = Variable<String>(observacoes);
    }
    if (!nullToAbsent || observacoesInternas != null) {
      map['observacoes_internas'] = Variable<String>(observacoesInternas);
    }
    if (!nullToAbsent || tecnicoResponsavel != null) {
      map['tecnico_responsavel'] = Variable<String>(tecnicoResponsavel);
    }
    if (!nullToAbsent || equipamento != null) {
      map['equipamento'] = Variable<String>(equipamento);
    }
    if (!nullToAbsent || problemaRelatado != null) {
      map['problema_relatado'] = Variable<String>(problemaRelatado);
    }
    if (!nullToAbsent || solucaoAplicada != null) {
      map['solucao_aplicada'] = Variable<String>(solucaoAplicada);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OrdensServicoTableCompanion toCompanion(bool nullToAbsent) {
    return OrdensServicoTableCompanion(
      id: Value(id),
      numero: Value(numero),
      clienteId: Value(clienteId),
      nomeCliente: Value(nomeCliente),
      emailCliente: emailCliente == null && nullToAbsent
          ? const Value.absent()
          : Value(emailCliente),
      telefoneCliente: telefoneCliente == null && nullToAbsent
          ? const Value.absent()
          : Value(telefoneCliente),
      subtotal: Value(subtotal),
      desconto: Value(desconto),
      total: Value(total),
      status: Value(status),
      prioridade: Value(prioridade),
      dataAgendamento: Value(dataAgendamento),
      dataPrevista: dataPrevista == null && nullToAbsent
          ? const Value.absent()
          : Value(dataPrevista),
      dataInicio: dataInicio == null && nullToAbsent
          ? const Value.absent()
          : Value(dataInicio),
      dataConclusao: dataConclusao == null && nullToAbsent
          ? const Value.absent()
          : Value(dataConclusao),
      observacoes: observacoes == null && nullToAbsent
          ? const Value.absent()
          : Value(observacoes),
      observacoesInternas: observacoesInternas == null && nullToAbsent
          ? const Value.absent()
          : Value(observacoesInternas),
      tecnicoResponsavel: tecnicoResponsavel == null && nullToAbsent
          ? const Value.absent()
          : Value(tecnicoResponsavel),
      equipamento: equipamento == null && nullToAbsent
          ? const Value.absent()
          : Value(equipamento),
      problemaRelatado: problemaRelatado == null && nullToAbsent
          ? const Value.absent()
          : Value(problemaRelatado),
      solucaoAplicada: solucaoAplicada == null && nullToAbsent
          ? const Value.absent()
          : Value(solucaoAplicada),
      ativo: Value(ativo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory OrdensServicoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdensServicoTableData(
      id: serializer.fromJson<int>(json['id']),
      numero: serializer.fromJson<String>(json['numero']),
      clienteId: serializer.fromJson<int>(json['clienteId']),
      nomeCliente: serializer.fromJson<String>(json['nomeCliente']),
      emailCliente: serializer.fromJson<String?>(json['emailCliente']),
      telefoneCliente: serializer.fromJson<String?>(json['telefoneCliente']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      desconto: serializer.fromJson<double>(json['desconto']),
      total: serializer.fromJson<double>(json['total']),
      status: serializer.fromJson<String>(json['status']),
      prioridade: serializer.fromJson<String>(json['prioridade']),
      dataAgendamento: serializer.fromJson<DateTime>(json['dataAgendamento']),
      dataPrevista: serializer.fromJson<DateTime?>(json['dataPrevista']),
      dataInicio: serializer.fromJson<DateTime?>(json['dataInicio']),
      dataConclusao: serializer.fromJson<DateTime?>(json['dataConclusao']),
      observacoes: serializer.fromJson<String?>(json['observacoes']),
      observacoesInternas:
          serializer.fromJson<String?>(json['observacoesInternas']),
      tecnicoResponsavel:
          serializer.fromJson<String?>(json['tecnicoResponsavel']),
      equipamento: serializer.fromJson<String?>(json['equipamento']),
      problemaRelatado: serializer.fromJson<String?>(json['problemaRelatado']),
      solucaoAplicada: serializer.fromJson<String?>(json['solucaoAplicada']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'numero': serializer.toJson<String>(numero),
      'clienteId': serializer.toJson<int>(clienteId),
      'nomeCliente': serializer.toJson<String>(nomeCliente),
      'emailCliente': serializer.toJson<String?>(emailCliente),
      'telefoneCliente': serializer.toJson<String?>(telefoneCliente),
      'subtotal': serializer.toJson<double>(subtotal),
      'desconto': serializer.toJson<double>(desconto),
      'total': serializer.toJson<double>(total),
      'status': serializer.toJson<String>(status),
      'prioridade': serializer.toJson<String>(prioridade),
      'dataAgendamento': serializer.toJson<DateTime>(dataAgendamento),
      'dataPrevista': serializer.toJson<DateTime?>(dataPrevista),
      'dataInicio': serializer.toJson<DateTime?>(dataInicio),
      'dataConclusao': serializer.toJson<DateTime?>(dataConclusao),
      'observacoes': serializer.toJson<String?>(observacoes),
      'observacoesInternas': serializer.toJson<String?>(observacoesInternas),
      'tecnicoResponsavel': serializer.toJson<String?>(tecnicoResponsavel),
      'equipamento': serializer.toJson<String?>(equipamento),
      'problemaRelatado': serializer.toJson<String?>(problemaRelatado),
      'solucaoAplicada': serializer.toJson<String?>(solucaoAplicada),
      'ativo': serializer.toJson<bool>(ativo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  OrdensServicoTableData copyWith(
          {int? id,
          String? numero,
          int? clienteId,
          String? nomeCliente,
          Value<String?> emailCliente = const Value.absent(),
          Value<String?> telefoneCliente = const Value.absent(),
          double? subtotal,
          double? desconto,
          double? total,
          String? status,
          String? prioridade,
          DateTime? dataAgendamento,
          Value<DateTime?> dataPrevista = const Value.absent(),
          Value<DateTime?> dataInicio = const Value.absent(),
          Value<DateTime?> dataConclusao = const Value.absent(),
          Value<String?> observacoes = const Value.absent(),
          Value<String?> observacoesInternas = const Value.absent(),
          Value<String?> tecnicoResponsavel = const Value.absent(),
          Value<String?> equipamento = const Value.absent(),
          Value<String?> problemaRelatado = const Value.absent(),
          Value<String?> solucaoAplicada = const Value.absent(),
          bool? ativo,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      OrdensServicoTableData(
        id: id ?? this.id,
        numero: numero ?? this.numero,
        clienteId: clienteId ?? this.clienteId,
        nomeCliente: nomeCliente ?? this.nomeCliente,
        emailCliente:
            emailCliente.present ? emailCliente.value : this.emailCliente,
        telefoneCliente: telefoneCliente.present
            ? telefoneCliente.value
            : this.telefoneCliente,
        subtotal: subtotal ?? this.subtotal,
        desconto: desconto ?? this.desconto,
        total: total ?? this.total,
        status: status ?? this.status,
        prioridade: prioridade ?? this.prioridade,
        dataAgendamento: dataAgendamento ?? this.dataAgendamento,
        dataPrevista:
            dataPrevista.present ? dataPrevista.value : this.dataPrevista,
        dataInicio: dataInicio.present ? dataInicio.value : this.dataInicio,
        dataConclusao:
            dataConclusao.present ? dataConclusao.value : this.dataConclusao,
        observacoes: observacoes.present ? observacoes.value : this.observacoes,
        observacoesInternas: observacoesInternas.present
            ? observacoesInternas.value
            : this.observacoesInternas,
        tecnicoResponsavel: tecnicoResponsavel.present
            ? tecnicoResponsavel.value
            : this.tecnicoResponsavel,
        equipamento: equipamento.present ? equipamento.value : this.equipamento,
        problemaRelatado: problemaRelatado.present
            ? problemaRelatado.value
            : this.problemaRelatado,
        solucaoAplicada: solucaoAplicada.present
            ? solucaoAplicada.value
            : this.solucaoAplicada,
        ativo: ativo ?? this.ativo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  OrdensServicoTableData copyWithCompanion(OrdensServicoTableCompanion data) {
    return OrdensServicoTableData(
      id: data.id.present ? data.id.value : this.id,
      numero: data.numero.present ? data.numero.value : this.numero,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      nomeCliente:
          data.nomeCliente.present ? data.nomeCliente.value : this.nomeCliente,
      emailCliente: data.emailCliente.present
          ? data.emailCliente.value
          : this.emailCliente,
      telefoneCliente: data.telefoneCliente.present
          ? data.telefoneCliente.value
          : this.telefoneCliente,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      desconto: data.desconto.present ? data.desconto.value : this.desconto,
      total: data.total.present ? data.total.value : this.total,
      status: data.status.present ? data.status.value : this.status,
      prioridade:
          data.prioridade.present ? data.prioridade.value : this.prioridade,
      dataAgendamento: data.dataAgendamento.present
          ? data.dataAgendamento.value
          : this.dataAgendamento,
      dataPrevista: data.dataPrevista.present
          ? data.dataPrevista.value
          : this.dataPrevista,
      dataInicio:
          data.dataInicio.present ? data.dataInicio.value : this.dataInicio,
      dataConclusao: data.dataConclusao.present
          ? data.dataConclusao.value
          : this.dataConclusao,
      observacoes:
          data.observacoes.present ? data.observacoes.value : this.observacoes,
      observacoesInternas: data.observacoesInternas.present
          ? data.observacoesInternas.value
          : this.observacoesInternas,
      tecnicoResponsavel: data.tecnicoResponsavel.present
          ? data.tecnicoResponsavel.value
          : this.tecnicoResponsavel,
      equipamento:
          data.equipamento.present ? data.equipamento.value : this.equipamento,
      problemaRelatado: data.problemaRelatado.present
          ? data.problemaRelatado.value
          : this.problemaRelatado,
      solucaoAplicada: data.solucaoAplicada.present
          ? data.solucaoAplicada.value
          : this.solucaoAplicada,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdensServicoTableData(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('clienteId: $clienteId, ')
          ..write('nomeCliente: $nomeCliente, ')
          ..write('emailCliente: $emailCliente, ')
          ..write('telefoneCliente: $telefoneCliente, ')
          ..write('subtotal: $subtotal, ')
          ..write('desconto: $desconto, ')
          ..write('total: $total, ')
          ..write('status: $status, ')
          ..write('prioridade: $prioridade, ')
          ..write('dataAgendamento: $dataAgendamento, ')
          ..write('dataPrevista: $dataPrevista, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataConclusao: $dataConclusao, ')
          ..write('observacoes: $observacoes, ')
          ..write('observacoesInternas: $observacoesInternas, ')
          ..write('tecnicoResponsavel: $tecnicoResponsavel, ')
          ..write('equipamento: $equipamento, ')
          ..write('problemaRelatado: $problemaRelatado, ')
          ..write('solucaoAplicada: $solucaoAplicada, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        numero,
        clienteId,
        nomeCliente,
        emailCliente,
        telefoneCliente,
        subtotal,
        desconto,
        total,
        status,
        prioridade,
        dataAgendamento,
        dataPrevista,
        dataInicio,
        dataConclusao,
        observacoes,
        observacoesInternas,
        tecnicoResponsavel,
        equipamento,
        problemaRelatado,
        solucaoAplicada,
        ativo,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdensServicoTableData &&
          other.id == this.id &&
          other.numero == this.numero &&
          other.clienteId == this.clienteId &&
          other.nomeCliente == this.nomeCliente &&
          other.emailCliente == this.emailCliente &&
          other.telefoneCliente == this.telefoneCliente &&
          other.subtotal == this.subtotal &&
          other.desconto == this.desconto &&
          other.total == this.total &&
          other.status == this.status &&
          other.prioridade == this.prioridade &&
          other.dataAgendamento == this.dataAgendamento &&
          other.dataPrevista == this.dataPrevista &&
          other.dataInicio == this.dataInicio &&
          other.dataConclusao == this.dataConclusao &&
          other.observacoes == this.observacoes &&
          other.observacoesInternas == this.observacoesInternas &&
          other.tecnicoResponsavel == this.tecnicoResponsavel &&
          other.equipamento == this.equipamento &&
          other.problemaRelatado == this.problemaRelatado &&
          other.solucaoAplicada == this.solucaoAplicada &&
          other.ativo == this.ativo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OrdensServicoTableCompanion
    extends UpdateCompanion<OrdensServicoTableData> {
  final Value<int> id;
  final Value<String> numero;
  final Value<int> clienteId;
  final Value<String> nomeCliente;
  final Value<String?> emailCliente;
  final Value<String?> telefoneCliente;
  final Value<double> subtotal;
  final Value<double> desconto;
  final Value<double> total;
  final Value<String> status;
  final Value<String> prioridade;
  final Value<DateTime> dataAgendamento;
  final Value<DateTime?> dataPrevista;
  final Value<DateTime?> dataInicio;
  final Value<DateTime?> dataConclusao;
  final Value<String?> observacoes;
  final Value<String?> observacoesInternas;
  final Value<String?> tecnicoResponsavel;
  final Value<String?> equipamento;
  final Value<String?> problemaRelatado;
  final Value<String?> solucaoAplicada;
  final Value<bool> ativo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const OrdensServicoTableCompanion({
    this.id = const Value.absent(),
    this.numero = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.nomeCliente = const Value.absent(),
    this.emailCliente = const Value.absent(),
    this.telefoneCliente = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.desconto = const Value.absent(),
    this.total = const Value.absent(),
    this.status = const Value.absent(),
    this.prioridade = const Value.absent(),
    this.dataAgendamento = const Value.absent(),
    this.dataPrevista = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataConclusao = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.observacoesInternas = const Value.absent(),
    this.tecnicoResponsavel = const Value.absent(),
    this.equipamento = const Value.absent(),
    this.problemaRelatado = const Value.absent(),
    this.solucaoAplicada = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  OrdensServicoTableCompanion.insert({
    this.id = const Value.absent(),
    required String numero,
    required int clienteId,
    required String nomeCliente,
    this.emailCliente = const Value.absent(),
    this.telefoneCliente = const Value.absent(),
    required double subtotal,
    this.desconto = const Value.absent(),
    required double total,
    required String status,
    required String prioridade,
    required DateTime dataAgendamento,
    this.dataPrevista = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataConclusao = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.observacoesInternas = const Value.absent(),
    this.tecnicoResponsavel = const Value.absent(),
    this.equipamento = const Value.absent(),
    this.problemaRelatado = const Value.absent(),
    this.solucaoAplicada = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : numero = Value(numero),
        clienteId = Value(clienteId),
        nomeCliente = Value(nomeCliente),
        subtotal = Value(subtotal),
        total = Value(total),
        status = Value(status),
        prioridade = Value(prioridade),
        dataAgendamento = Value(dataAgendamento);
  static Insertable<OrdensServicoTableData> custom({
    Expression<int>? id,
    Expression<String>? numero,
    Expression<int>? clienteId,
    Expression<String>? nomeCliente,
    Expression<String>? emailCliente,
    Expression<String>? telefoneCliente,
    Expression<double>? subtotal,
    Expression<double>? desconto,
    Expression<double>? total,
    Expression<String>? status,
    Expression<String>? prioridade,
    Expression<DateTime>? dataAgendamento,
    Expression<DateTime>? dataPrevista,
    Expression<DateTime>? dataInicio,
    Expression<DateTime>? dataConclusao,
    Expression<String>? observacoes,
    Expression<String>? observacoesInternas,
    Expression<String>? tecnicoResponsavel,
    Expression<String>? equipamento,
    Expression<String>? problemaRelatado,
    Expression<String>? solucaoAplicada,
    Expression<bool>? ativo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (numero != null) 'numero': numero,
      if (clienteId != null) 'cliente_id': clienteId,
      if (nomeCliente != null) 'nome_cliente': nomeCliente,
      if (emailCliente != null) 'email_cliente': emailCliente,
      if (telefoneCliente != null) 'telefone_cliente': telefoneCliente,
      if (subtotal != null) 'subtotal': subtotal,
      if (desconto != null) 'desconto': desconto,
      if (total != null) 'total': total,
      if (status != null) 'status': status,
      if (prioridade != null) 'prioridade': prioridade,
      if (dataAgendamento != null) 'data_agendamento': dataAgendamento,
      if (dataPrevista != null) 'data_prevista': dataPrevista,
      if (dataInicio != null) 'data_inicio': dataInicio,
      if (dataConclusao != null) 'data_conclusao': dataConclusao,
      if (observacoes != null) 'observacoes': observacoes,
      if (observacoesInternas != null)
        'observacoes_internas': observacoesInternas,
      if (tecnicoResponsavel != null) 'tecnico_responsavel': tecnicoResponsavel,
      if (equipamento != null) 'equipamento': equipamento,
      if (problemaRelatado != null) 'problema_relatado': problemaRelatado,
      if (solucaoAplicada != null) 'solucao_aplicada': solucaoAplicada,
      if (ativo != null) 'ativo': ativo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  OrdensServicoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? numero,
      Value<int>? clienteId,
      Value<String>? nomeCliente,
      Value<String?>? emailCliente,
      Value<String?>? telefoneCliente,
      Value<double>? subtotal,
      Value<double>? desconto,
      Value<double>? total,
      Value<String>? status,
      Value<String>? prioridade,
      Value<DateTime>? dataAgendamento,
      Value<DateTime?>? dataPrevista,
      Value<DateTime?>? dataInicio,
      Value<DateTime?>? dataConclusao,
      Value<String?>? observacoes,
      Value<String?>? observacoesInternas,
      Value<String?>? tecnicoResponsavel,
      Value<String?>? equipamento,
      Value<String?>? problemaRelatado,
      Value<String?>? solucaoAplicada,
      Value<bool>? ativo,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return OrdensServicoTableCompanion(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      clienteId: clienteId ?? this.clienteId,
      nomeCliente: nomeCliente ?? this.nomeCliente,
      emailCliente: emailCliente ?? this.emailCliente,
      telefoneCliente: telefoneCliente ?? this.telefoneCliente,
      subtotal: subtotal ?? this.subtotal,
      desconto: desconto ?? this.desconto,
      total: total ?? this.total,
      status: status ?? this.status,
      prioridade: prioridade ?? this.prioridade,
      dataAgendamento: dataAgendamento ?? this.dataAgendamento,
      dataPrevista: dataPrevista ?? this.dataPrevista,
      dataInicio: dataInicio ?? this.dataInicio,
      dataConclusao: dataConclusao ?? this.dataConclusao,
      observacoes: observacoes ?? this.observacoes,
      observacoesInternas: observacoesInternas ?? this.observacoesInternas,
      tecnicoResponsavel: tecnicoResponsavel ?? this.tecnicoResponsavel,
      equipamento: equipamento ?? this.equipamento,
      problemaRelatado: problemaRelatado ?? this.problemaRelatado,
      solucaoAplicada: solucaoAplicada ?? this.solucaoAplicada,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (numero.present) {
      map['numero'] = Variable<String>(numero.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<int>(clienteId.value);
    }
    if (nomeCliente.present) {
      map['nome_cliente'] = Variable<String>(nomeCliente.value);
    }
    if (emailCliente.present) {
      map['email_cliente'] = Variable<String>(emailCliente.value);
    }
    if (telefoneCliente.present) {
      map['telefone_cliente'] = Variable<String>(telefoneCliente.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (desconto.present) {
      map['desconto'] = Variable<double>(desconto.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (prioridade.present) {
      map['prioridade'] = Variable<String>(prioridade.value);
    }
    if (dataAgendamento.present) {
      map['data_agendamento'] = Variable<DateTime>(dataAgendamento.value);
    }
    if (dataPrevista.present) {
      map['data_prevista'] = Variable<DateTime>(dataPrevista.value);
    }
    if (dataInicio.present) {
      map['data_inicio'] = Variable<DateTime>(dataInicio.value);
    }
    if (dataConclusao.present) {
      map['data_conclusao'] = Variable<DateTime>(dataConclusao.value);
    }
    if (observacoes.present) {
      map['observacoes'] = Variable<String>(observacoes.value);
    }
    if (observacoesInternas.present) {
      map['observacoes_internas'] = Variable<String>(observacoesInternas.value);
    }
    if (tecnicoResponsavel.present) {
      map['tecnico_responsavel'] = Variable<String>(tecnicoResponsavel.value);
    }
    if (equipamento.present) {
      map['equipamento'] = Variable<String>(equipamento.value);
    }
    if (problemaRelatado.present) {
      map['problema_relatado'] = Variable<String>(problemaRelatado.value);
    }
    if (solucaoAplicada.present) {
      map['solucao_aplicada'] = Variable<String>(solucaoAplicada.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdensServicoTableCompanion(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('clienteId: $clienteId, ')
          ..write('nomeCliente: $nomeCliente, ')
          ..write('emailCliente: $emailCliente, ')
          ..write('telefoneCliente: $telefoneCliente, ')
          ..write('subtotal: $subtotal, ')
          ..write('desconto: $desconto, ')
          ..write('total: $total, ')
          ..write('status: $status, ')
          ..write('prioridade: $prioridade, ')
          ..write('dataAgendamento: $dataAgendamento, ')
          ..write('dataPrevista: $dataPrevista, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataConclusao: $dataConclusao, ')
          ..write('observacoes: $observacoes, ')
          ..write('observacoesInternas: $observacoesInternas, ')
          ..write('tecnicoResponsavel: $tecnicoResponsavel, ')
          ..write('equipamento: $equipamento, ')
          ..write('problemaRelatado: $problemaRelatado, ')
          ..write('solucaoAplicada: $solucaoAplicada, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ItensOrdemServicoTableTable extends ItensOrdemServicoTable
    with TableInfo<$ItensOrdemServicoTableTable, ItensOrdemServicoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItensOrdemServicoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ordemServicoIdMeta =
      const VerificationMeta('ordemServicoId');
  @override
  late final GeneratedColumn<int> ordemServicoId = GeneratedColumn<int>(
      'ordem_servico_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _servicoIdMeta =
      const VerificationMeta('servicoId');
  @override
  late final GeneratedColumn<int> servicoId = GeneratedColumn<int>(
      'servico_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nomeServicoMeta =
      const VerificationMeta('nomeServico');
  @override
  late final GeneratedColumn<String> nomeServico = GeneratedColumn<String>(
      'nome_servico', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descricaoServicoMeta =
      const VerificationMeta('descricaoServico');
  @override
  late final GeneratedColumn<String> descricaoServico = GeneratedColumn<String>(
      'descricao_servico', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantidadeMeta =
      const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _valorUnitarioMeta =
      const VerificationMeta('valorUnitario');
  @override
  late final GeneratedColumn<double> valorUnitario = GeneratedColumn<double>(
      'valor_unitario', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _duracaoMinutosMeta =
      const VerificationMeta('duracaoMinutos');
  @override
  late final GeneratedColumn<int> duracaoMinutos = GeneratedColumn<int>(
      'duracao_minutos', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        ordemServicoId,
        servicoId,
        nomeServico,
        descricaoServico,
        quantidade,
        valorUnitario,
        subtotal,
        duracaoMinutos,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'itens_ordem_servico';
  @override
  VerificationContext validateIntegrity(
      Insertable<ItensOrdemServicoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ordem_servico_id')) {
      context.handle(
          _ordemServicoIdMeta,
          ordemServicoId.isAcceptableOrUnknown(
              data['ordem_servico_id']!, _ordemServicoIdMeta));
    } else if (isInserting) {
      context.missing(_ordemServicoIdMeta);
    }
    if (data.containsKey('servico_id')) {
      context.handle(_servicoIdMeta,
          servicoId.isAcceptableOrUnknown(data['servico_id']!, _servicoIdMeta));
    }
    if (data.containsKey('nome_servico')) {
      context.handle(
          _nomeServicoMeta,
          nomeServico.isAcceptableOrUnknown(
              data['nome_servico']!, _nomeServicoMeta));
    } else if (isInserting) {
      context.missing(_nomeServicoMeta);
    }
    if (data.containsKey('descricao_servico')) {
      context.handle(
          _descricaoServicoMeta,
          descricaoServico.isAcceptableOrUnknown(
              data['descricao_servico']!, _descricaoServicoMeta));
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('valor_unitario')) {
      context.handle(
          _valorUnitarioMeta,
          valorUnitario.isAcceptableOrUnknown(
              data['valor_unitario']!, _valorUnitarioMeta));
    } else if (isInserting) {
      context.missing(_valorUnitarioMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('duracao_minutos')) {
      context.handle(
          _duracaoMinutosMeta,
          duracaoMinutos.isAcceptableOrUnknown(
              data['duracao_minutos']!, _duracaoMinutosMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItensOrdemServicoTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItensOrdemServicoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ordemServicoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordem_servico_id'])!,
      servicoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}servico_id']),
      nomeServico: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_servico'])!,
      descricaoServico: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}descricao_servico']),
      quantidade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
      valorUnitario: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor_unitario'])!,
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      duracaoMinutos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duracao_minutos']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ItensOrdemServicoTableTable createAlias(String alias) {
    return $ItensOrdemServicoTableTable(attachedDatabase, alias);
  }
}

class ItensOrdemServicoTableData extends DataClass
    implements Insertable<ItensOrdemServicoTableData> {
  final int id;
  final int ordemServicoId;
  final int? servicoId;
  final String nomeServico;
  final String? descricaoServico;
  final int quantidade;
  final double valorUnitario;
  final double subtotal;
  final int? duracaoMinutos;
  final DateTime createdAt;
  const ItensOrdemServicoTableData(
      {required this.id,
      required this.ordemServicoId,
      this.servicoId,
      required this.nomeServico,
      this.descricaoServico,
      required this.quantidade,
      required this.valorUnitario,
      required this.subtotal,
      this.duracaoMinutos,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ordem_servico_id'] = Variable<int>(ordemServicoId);
    if (!nullToAbsent || servicoId != null) {
      map['servico_id'] = Variable<int>(servicoId);
    }
    map['nome_servico'] = Variable<String>(nomeServico);
    if (!nullToAbsent || descricaoServico != null) {
      map['descricao_servico'] = Variable<String>(descricaoServico);
    }
    map['quantidade'] = Variable<int>(quantidade);
    map['valor_unitario'] = Variable<double>(valorUnitario);
    map['subtotal'] = Variable<double>(subtotal);
    if (!nullToAbsent || duracaoMinutos != null) {
      map['duracao_minutos'] = Variable<int>(duracaoMinutos);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ItensOrdemServicoTableCompanion toCompanion(bool nullToAbsent) {
    return ItensOrdemServicoTableCompanion(
      id: Value(id),
      ordemServicoId: Value(ordemServicoId),
      servicoId: servicoId == null && nullToAbsent
          ? const Value.absent()
          : Value(servicoId),
      nomeServico: Value(nomeServico),
      descricaoServico: descricaoServico == null && nullToAbsent
          ? const Value.absent()
          : Value(descricaoServico),
      quantidade: Value(quantidade),
      valorUnitario: Value(valorUnitario),
      subtotal: Value(subtotal),
      duracaoMinutos: duracaoMinutos == null && nullToAbsent
          ? const Value.absent()
          : Value(duracaoMinutos),
      createdAt: Value(createdAt),
    );
  }

  factory ItensOrdemServicoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItensOrdemServicoTableData(
      id: serializer.fromJson<int>(json['id']),
      ordemServicoId: serializer.fromJson<int>(json['ordemServicoId']),
      servicoId: serializer.fromJson<int?>(json['servicoId']),
      nomeServico: serializer.fromJson<String>(json['nomeServico']),
      descricaoServico: serializer.fromJson<String?>(json['descricaoServico']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      valorUnitario: serializer.fromJson<double>(json['valorUnitario']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      duracaoMinutos: serializer.fromJson<int?>(json['duracaoMinutos']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordemServicoId': serializer.toJson<int>(ordemServicoId),
      'servicoId': serializer.toJson<int?>(servicoId),
      'nomeServico': serializer.toJson<String>(nomeServico),
      'descricaoServico': serializer.toJson<String?>(descricaoServico),
      'quantidade': serializer.toJson<int>(quantidade),
      'valorUnitario': serializer.toJson<double>(valorUnitario),
      'subtotal': serializer.toJson<double>(subtotal),
      'duracaoMinutos': serializer.toJson<int?>(duracaoMinutos),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ItensOrdemServicoTableData copyWith(
          {int? id,
          int? ordemServicoId,
          Value<int?> servicoId = const Value.absent(),
          String? nomeServico,
          Value<String?> descricaoServico = const Value.absent(),
          int? quantidade,
          double? valorUnitario,
          double? subtotal,
          Value<int?> duracaoMinutos = const Value.absent(),
          DateTime? createdAt}) =>
      ItensOrdemServicoTableData(
        id: id ?? this.id,
        ordemServicoId: ordemServicoId ?? this.ordemServicoId,
        servicoId: servicoId.present ? servicoId.value : this.servicoId,
        nomeServico: nomeServico ?? this.nomeServico,
        descricaoServico: descricaoServico.present
            ? descricaoServico.value
            : this.descricaoServico,
        quantidade: quantidade ?? this.quantidade,
        valorUnitario: valorUnitario ?? this.valorUnitario,
        subtotal: subtotal ?? this.subtotal,
        duracaoMinutos:
            duracaoMinutos.present ? duracaoMinutos.value : this.duracaoMinutos,
        createdAt: createdAt ?? this.createdAt,
      );
  ItensOrdemServicoTableData copyWithCompanion(
      ItensOrdemServicoTableCompanion data) {
    return ItensOrdemServicoTableData(
      id: data.id.present ? data.id.value : this.id,
      ordemServicoId: data.ordemServicoId.present
          ? data.ordemServicoId.value
          : this.ordemServicoId,
      servicoId: data.servicoId.present ? data.servicoId.value : this.servicoId,
      nomeServico:
          data.nomeServico.present ? data.nomeServico.value : this.nomeServico,
      descricaoServico: data.descricaoServico.present
          ? data.descricaoServico.value
          : this.descricaoServico,
      quantidade:
          data.quantidade.present ? data.quantidade.value : this.quantidade,
      valorUnitario: data.valorUnitario.present
          ? data.valorUnitario.value
          : this.valorUnitario,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      duracaoMinutos: data.duracaoMinutos.present
          ? data.duracaoMinutos.value
          : this.duracaoMinutos,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItensOrdemServicoTableData(')
          ..write('id: $id, ')
          ..write('ordemServicoId: $ordemServicoId, ')
          ..write('servicoId: $servicoId, ')
          ..write('nomeServico: $nomeServico, ')
          ..write('descricaoServico: $descricaoServico, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('subtotal: $subtotal, ')
          ..write('duracaoMinutos: $duracaoMinutos, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      ordemServicoId,
      servicoId,
      nomeServico,
      descricaoServico,
      quantidade,
      valorUnitario,
      subtotal,
      duracaoMinutos,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItensOrdemServicoTableData &&
          other.id == this.id &&
          other.ordemServicoId == this.ordemServicoId &&
          other.servicoId == this.servicoId &&
          other.nomeServico == this.nomeServico &&
          other.descricaoServico == this.descricaoServico &&
          other.quantidade == this.quantidade &&
          other.valorUnitario == this.valorUnitario &&
          other.subtotal == this.subtotal &&
          other.duracaoMinutos == this.duracaoMinutos &&
          other.createdAt == this.createdAt);
}

class ItensOrdemServicoTableCompanion
    extends UpdateCompanion<ItensOrdemServicoTableData> {
  final Value<int> id;
  final Value<int> ordemServicoId;
  final Value<int?> servicoId;
  final Value<String> nomeServico;
  final Value<String?> descricaoServico;
  final Value<int> quantidade;
  final Value<double> valorUnitario;
  final Value<double> subtotal;
  final Value<int?> duracaoMinutos;
  final Value<DateTime> createdAt;
  const ItensOrdemServicoTableCompanion({
    this.id = const Value.absent(),
    this.ordemServicoId = const Value.absent(),
    this.servicoId = const Value.absent(),
    this.nomeServico = const Value.absent(),
    this.descricaoServico = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorUnitario = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.duracaoMinutos = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ItensOrdemServicoTableCompanion.insert({
    this.id = const Value.absent(),
    required int ordemServicoId,
    this.servicoId = const Value.absent(),
    required String nomeServico,
    this.descricaoServico = const Value.absent(),
    required int quantidade,
    required double valorUnitario,
    required double subtotal,
    this.duracaoMinutos = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : ordemServicoId = Value(ordemServicoId),
        nomeServico = Value(nomeServico),
        quantidade = Value(quantidade),
        valorUnitario = Value(valorUnitario),
        subtotal = Value(subtotal);
  static Insertable<ItensOrdemServicoTableData> custom({
    Expression<int>? id,
    Expression<int>? ordemServicoId,
    Expression<int>? servicoId,
    Expression<String>? nomeServico,
    Expression<String>? descricaoServico,
    Expression<int>? quantidade,
    Expression<double>? valorUnitario,
    Expression<double>? subtotal,
    Expression<int>? duracaoMinutos,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordemServicoId != null) 'ordem_servico_id': ordemServicoId,
      if (servicoId != null) 'servico_id': servicoId,
      if (nomeServico != null) 'nome_servico': nomeServico,
      if (descricaoServico != null) 'descricao_servico': descricaoServico,
      if (quantidade != null) 'quantidade': quantidade,
      if (valorUnitario != null) 'valor_unitario': valorUnitario,
      if (subtotal != null) 'subtotal': subtotal,
      if (duracaoMinutos != null) 'duracao_minutos': duracaoMinutos,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ItensOrdemServicoTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? ordemServicoId,
      Value<int?>? servicoId,
      Value<String>? nomeServico,
      Value<String?>? descricaoServico,
      Value<int>? quantidade,
      Value<double>? valorUnitario,
      Value<double>? subtotal,
      Value<int?>? duracaoMinutos,
      Value<DateTime>? createdAt}) {
    return ItensOrdemServicoTableCompanion(
      id: id ?? this.id,
      ordemServicoId: ordemServicoId ?? this.ordemServicoId,
      servicoId: servicoId ?? this.servicoId,
      nomeServico: nomeServico ?? this.nomeServico,
      descricaoServico: descricaoServico ?? this.descricaoServico,
      quantidade: quantidade ?? this.quantidade,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      subtotal: subtotal ?? this.subtotal,
      duracaoMinutos: duracaoMinutos ?? this.duracaoMinutos,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordemServicoId.present) {
      map['ordem_servico_id'] = Variable<int>(ordemServicoId.value);
    }
    if (servicoId.present) {
      map['servico_id'] = Variable<int>(servicoId.value);
    }
    if (nomeServico.present) {
      map['nome_servico'] = Variable<String>(nomeServico.value);
    }
    if (descricaoServico.present) {
      map['descricao_servico'] = Variable<String>(descricaoServico.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    if (valorUnitario.present) {
      map['valor_unitario'] = Variable<double>(valorUnitario.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (duracaoMinutos.present) {
      map['duracao_minutos'] = Variable<int>(duracaoMinutos.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItensOrdemServicoTableCompanion(')
          ..write('id: $id, ')
          ..write('ordemServicoId: $ordemServicoId, ')
          ..write('servicoId: $servicoId, ')
          ..write('nomeServico: $nomeServico, ')
          ..write('descricaoServico: $descricaoServico, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('subtotal: $subtotal, ')
          ..write('duracaoMinutos: $duracaoMinutos, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AuditoriaTableTable extends AuditoriaTable
    with TableInfo<$AuditoriaTableTable, AuditoriaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditoriaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entidadeMeta =
      const VerificationMeta('entidade');
  @override
  late final GeneratedColumn<String> entidade = GeneratedColumn<String>(
      'entidade', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _acaoMeta = const VerificationMeta('acao');
  @override
  late final GeneratedColumn<String> acao = GeneratedColumn<String>(
      'acao', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _entidadeIdMeta =
      const VerificationMeta('entidadeId');
  @override
  late final GeneratedColumn<int> entidadeId = GeneratedColumn<int>(
      'entidade_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _usuarioMeta =
      const VerificationMeta('usuario');
  @override
  late final GeneratedColumn<String> usuario = GeneratedColumn<String>(
      'usuario', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _detalhesMeta =
      const VerificationMeta('detalhes');
  @override
  late final GeneratedColumn<String> detalhes = GeneratedColumn<String>(
      'detalhes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _valoresAnterioresMeta =
      const VerificationMeta('valoresAnteriores');
  @override
  late final GeneratedColumn<String> valoresAnteriores =
      GeneratedColumn<String>('valores_anteriores', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _valoresNovosMeta =
      const VerificationMeta('valoresNovos');
  @override
  late final GeneratedColumn<String> valoresNovos = GeneratedColumn<String>(
      'valores_novos', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dataAcaoMeta =
      const VerificationMeta('dataAcao');
  @override
  late final GeneratedColumn<DateTime> dataAcao = GeneratedColumn<DateTime>(
      'data_acao', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        entidade,
        acao,
        entidadeId,
        usuario,
        detalhes,
        valoresAnteriores,
        valoresNovos,
        dataAcao
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'auditoria_table';
  @override
  VerificationContext validateIntegrity(Insertable<AuditoriaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entidade')) {
      context.handle(_entidadeMeta,
          entidade.isAcceptableOrUnknown(data['entidade']!, _entidadeMeta));
    } else if (isInserting) {
      context.missing(_entidadeMeta);
    }
    if (data.containsKey('acao')) {
      context.handle(
          _acaoMeta, acao.isAcceptableOrUnknown(data['acao']!, _acaoMeta));
    } else if (isInserting) {
      context.missing(_acaoMeta);
    }
    if (data.containsKey('entidade_id')) {
      context.handle(
          _entidadeIdMeta,
          entidadeId.isAcceptableOrUnknown(
              data['entidade_id']!, _entidadeIdMeta));
    } else if (isInserting) {
      context.missing(_entidadeIdMeta);
    }
    if (data.containsKey('usuario')) {
      context.handle(_usuarioMeta,
          usuario.isAcceptableOrUnknown(data['usuario']!, _usuarioMeta));
    } else if (isInserting) {
      context.missing(_usuarioMeta);
    }
    if (data.containsKey('detalhes')) {
      context.handle(_detalhesMeta,
          detalhes.isAcceptableOrUnknown(data['detalhes']!, _detalhesMeta));
    }
    if (data.containsKey('valores_anteriores')) {
      context.handle(
          _valoresAnterioresMeta,
          valoresAnteriores.isAcceptableOrUnknown(
              data['valores_anteriores']!, _valoresAnterioresMeta));
    }
    if (data.containsKey('valores_novos')) {
      context.handle(
          _valoresNovosMeta,
          valoresNovos.isAcceptableOrUnknown(
              data['valores_novos']!, _valoresNovosMeta));
    }
    if (data.containsKey('data_acao')) {
      context.handle(_dataAcaoMeta,
          dataAcao.isAcceptableOrUnknown(data['data_acao']!, _dataAcaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditoriaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditoriaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entidade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entidade'])!,
      acao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}acao'])!,
      entidadeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}entidade_id'])!,
      usuario: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}usuario'])!,
      detalhes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}detalhes']),
      valoresAnteriores: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}valores_anteriores']),
      valoresNovos: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}valores_novos']),
      dataAcao: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_acao'])!,
    );
  }

  @override
  $AuditoriaTableTable createAlias(String alias) {
    return $AuditoriaTableTable(attachedDatabase, alias);
  }
}

class AuditoriaData extends DataClass implements Insertable<AuditoriaData> {
  final int id;
  final String entidade;
  final String acao;
  final int entidadeId;
  final String usuario;
  final String? detalhes;
  final String? valoresAnteriores;
  final String? valoresNovos;
  final DateTime dataAcao;
  const AuditoriaData(
      {required this.id,
      required this.entidade,
      required this.acao,
      required this.entidadeId,
      required this.usuario,
      this.detalhes,
      this.valoresAnteriores,
      this.valoresNovos,
      required this.dataAcao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entidade'] = Variable<String>(entidade);
    map['acao'] = Variable<String>(acao);
    map['entidade_id'] = Variable<int>(entidadeId);
    map['usuario'] = Variable<String>(usuario);
    if (!nullToAbsent || detalhes != null) {
      map['detalhes'] = Variable<String>(detalhes);
    }
    if (!nullToAbsent || valoresAnteriores != null) {
      map['valores_anteriores'] = Variable<String>(valoresAnteriores);
    }
    if (!nullToAbsent || valoresNovos != null) {
      map['valores_novos'] = Variable<String>(valoresNovos);
    }
    map['data_acao'] = Variable<DateTime>(dataAcao);
    return map;
  }

  AuditoriaTableCompanion toCompanion(bool nullToAbsent) {
    return AuditoriaTableCompanion(
      id: Value(id),
      entidade: Value(entidade),
      acao: Value(acao),
      entidadeId: Value(entidadeId),
      usuario: Value(usuario),
      detalhes: detalhes == null && nullToAbsent
          ? const Value.absent()
          : Value(detalhes),
      valoresAnteriores: valoresAnteriores == null && nullToAbsent
          ? const Value.absent()
          : Value(valoresAnteriores),
      valoresNovos: valoresNovos == null && nullToAbsent
          ? const Value.absent()
          : Value(valoresNovos),
      dataAcao: Value(dataAcao),
    );
  }

  factory AuditoriaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditoriaData(
      id: serializer.fromJson<int>(json['id']),
      entidade: serializer.fromJson<String>(json['entidade']),
      acao: serializer.fromJson<String>(json['acao']),
      entidadeId: serializer.fromJson<int>(json['entidadeId']),
      usuario: serializer.fromJson<String>(json['usuario']),
      detalhes: serializer.fromJson<String?>(json['detalhes']),
      valoresAnteriores:
          serializer.fromJson<String?>(json['valoresAnteriores']),
      valoresNovos: serializer.fromJson<String?>(json['valoresNovos']),
      dataAcao: serializer.fromJson<DateTime>(json['dataAcao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entidade': serializer.toJson<String>(entidade),
      'acao': serializer.toJson<String>(acao),
      'entidadeId': serializer.toJson<int>(entidadeId),
      'usuario': serializer.toJson<String>(usuario),
      'detalhes': serializer.toJson<String?>(detalhes),
      'valoresAnteriores': serializer.toJson<String?>(valoresAnteriores),
      'valoresNovos': serializer.toJson<String?>(valoresNovos),
      'dataAcao': serializer.toJson<DateTime>(dataAcao),
    };
  }

  AuditoriaData copyWith(
          {int? id,
          String? entidade,
          String? acao,
          int? entidadeId,
          String? usuario,
          Value<String?> detalhes = const Value.absent(),
          Value<String?> valoresAnteriores = const Value.absent(),
          Value<String?> valoresNovos = const Value.absent(),
          DateTime? dataAcao}) =>
      AuditoriaData(
        id: id ?? this.id,
        entidade: entidade ?? this.entidade,
        acao: acao ?? this.acao,
        entidadeId: entidadeId ?? this.entidadeId,
        usuario: usuario ?? this.usuario,
        detalhes: detalhes.present ? detalhes.value : this.detalhes,
        valoresAnteriores: valoresAnteriores.present
            ? valoresAnteriores.value
            : this.valoresAnteriores,
        valoresNovos:
            valoresNovos.present ? valoresNovos.value : this.valoresNovos,
        dataAcao: dataAcao ?? this.dataAcao,
      );
  AuditoriaData copyWithCompanion(AuditoriaTableCompanion data) {
    return AuditoriaData(
      id: data.id.present ? data.id.value : this.id,
      entidade: data.entidade.present ? data.entidade.value : this.entidade,
      acao: data.acao.present ? data.acao.value : this.acao,
      entidadeId:
          data.entidadeId.present ? data.entidadeId.value : this.entidadeId,
      usuario: data.usuario.present ? data.usuario.value : this.usuario,
      detalhes: data.detalhes.present ? data.detalhes.value : this.detalhes,
      valoresAnteriores: data.valoresAnteriores.present
          ? data.valoresAnteriores.value
          : this.valoresAnteriores,
      valoresNovos: data.valoresNovos.present
          ? data.valoresNovos.value
          : this.valoresNovos,
      dataAcao: data.dataAcao.present ? data.dataAcao.value : this.dataAcao,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditoriaData(')
          ..write('id: $id, ')
          ..write('entidade: $entidade, ')
          ..write('acao: $acao, ')
          ..write('entidadeId: $entidadeId, ')
          ..write('usuario: $usuario, ')
          ..write('detalhes: $detalhes, ')
          ..write('valoresAnteriores: $valoresAnteriores, ')
          ..write('valoresNovos: $valoresNovos, ')
          ..write('dataAcao: $dataAcao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entidade, acao, entidadeId, usuario,
      detalhes, valoresAnteriores, valoresNovos, dataAcao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditoriaData &&
          other.id == this.id &&
          other.entidade == this.entidade &&
          other.acao == this.acao &&
          other.entidadeId == this.entidadeId &&
          other.usuario == this.usuario &&
          other.detalhes == this.detalhes &&
          other.valoresAnteriores == this.valoresAnteriores &&
          other.valoresNovos == this.valoresNovos &&
          other.dataAcao == this.dataAcao);
}

class AuditoriaTableCompanion extends UpdateCompanion<AuditoriaData> {
  final Value<int> id;
  final Value<String> entidade;
  final Value<String> acao;
  final Value<int> entidadeId;
  final Value<String> usuario;
  final Value<String?> detalhes;
  final Value<String?> valoresAnteriores;
  final Value<String?> valoresNovos;
  final Value<DateTime> dataAcao;
  const AuditoriaTableCompanion({
    this.id = const Value.absent(),
    this.entidade = const Value.absent(),
    this.acao = const Value.absent(),
    this.entidadeId = const Value.absent(),
    this.usuario = const Value.absent(),
    this.detalhes = const Value.absent(),
    this.valoresAnteriores = const Value.absent(),
    this.valoresNovos = const Value.absent(),
    this.dataAcao = const Value.absent(),
  });
  AuditoriaTableCompanion.insert({
    this.id = const Value.absent(),
    required String entidade,
    required String acao,
    required int entidadeId,
    required String usuario,
    this.detalhes = const Value.absent(),
    this.valoresAnteriores = const Value.absent(),
    this.valoresNovos = const Value.absent(),
    this.dataAcao = const Value.absent(),
  })  : entidade = Value(entidade),
        acao = Value(acao),
        entidadeId = Value(entidadeId),
        usuario = Value(usuario);
  static Insertable<AuditoriaData> custom({
    Expression<int>? id,
    Expression<String>? entidade,
    Expression<String>? acao,
    Expression<int>? entidadeId,
    Expression<String>? usuario,
    Expression<String>? detalhes,
    Expression<String>? valoresAnteriores,
    Expression<String>? valoresNovos,
    Expression<DateTime>? dataAcao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entidade != null) 'entidade': entidade,
      if (acao != null) 'acao': acao,
      if (entidadeId != null) 'entidade_id': entidadeId,
      if (usuario != null) 'usuario': usuario,
      if (detalhes != null) 'detalhes': detalhes,
      if (valoresAnteriores != null) 'valores_anteriores': valoresAnteriores,
      if (valoresNovos != null) 'valores_novos': valoresNovos,
      if (dataAcao != null) 'data_acao': dataAcao,
    });
  }

  AuditoriaTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? entidade,
      Value<String>? acao,
      Value<int>? entidadeId,
      Value<String>? usuario,
      Value<String?>? detalhes,
      Value<String?>? valoresAnteriores,
      Value<String?>? valoresNovos,
      Value<DateTime>? dataAcao}) {
    return AuditoriaTableCompanion(
      id: id ?? this.id,
      entidade: entidade ?? this.entidade,
      acao: acao ?? this.acao,
      entidadeId: entidadeId ?? this.entidadeId,
      usuario: usuario ?? this.usuario,
      detalhes: detalhes ?? this.detalhes,
      valoresAnteriores: valoresAnteriores ?? this.valoresAnteriores,
      valoresNovos: valoresNovos ?? this.valoresNovos,
      dataAcao: dataAcao ?? this.dataAcao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entidade.present) {
      map['entidade'] = Variable<String>(entidade.value);
    }
    if (acao.present) {
      map['acao'] = Variable<String>(acao.value);
    }
    if (entidadeId.present) {
      map['entidade_id'] = Variable<int>(entidadeId.value);
    }
    if (usuario.present) {
      map['usuario'] = Variable<String>(usuario.value);
    }
    if (detalhes.present) {
      map['detalhes'] = Variable<String>(detalhes.value);
    }
    if (valoresAnteriores.present) {
      map['valores_anteriores'] = Variable<String>(valoresAnteriores.value);
    }
    if (valoresNovos.present) {
      map['valores_novos'] = Variable<String>(valoresNovos.value);
    }
    if (dataAcao.present) {
      map['data_acao'] = Variable<DateTime>(dataAcao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditoriaTableCompanion(')
          ..write('id: $id, ')
          ..write('entidade: $entidade, ')
          ..write('acao: $acao, ')
          ..write('entidadeId: $entidadeId, ')
          ..write('usuario: $usuario, ')
          ..write('detalhes: $detalhes, ')
          ..write('valoresAnteriores: $valoresAnteriores, ')
          ..write('valoresNovos: $valoresNovos, ')
          ..write('dataAcao: $dataAcao')
          ..write(')'))
        .toString();
  }
}

class $EmpresaConfigsTable extends EmpresaConfigs
    with TableInfo<$EmpresaConfigsTable, EmpresaConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmpresaConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeEmpresaMeta =
      const VerificationMeta('nomeEmpresa');
  @override
  late final GeneratedColumn<String> nomeEmpresa = GeneratedColumn<String>(
      'nome_empresa', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nomeFantasiaMeta =
      const VerificationMeta('nomeFantasia');
  @override
  late final GeneratedColumn<String> nomeFantasia = GeneratedColumn<String>(
      'nome_fantasia', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _tipoEmpresaMeta =
      const VerificationMeta('tipoEmpresa');
  @override
  late final GeneratedColumn<String> tipoEmpresa = GeneratedColumn<String>(
      'tipo_empresa', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _documentoMeta =
      const VerificationMeta('documento');
  @override
  late final GeneratedColumn<String> documento = GeneratedColumn<String>(
      'documento', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 11, maxTextLength: 18),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _inscricaoEstadualMeta =
      const VerificationMeta('inscricaoEstadual');
  @override
  late final GeneratedColumn<String> inscricaoEstadual =
      GeneratedColumn<String>('inscricao_estadual', aliasedName, true,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
          type: DriftSqlType.string,
          requiredDuringInsert: false);
  static const VerificationMeta _inscricaoMunicipalMeta =
      const VerificationMeta('inscricaoMunicipal');
  @override
  late final GeneratedColumn<String> inscricaoMunicipal =
      GeneratedColumn<String>('inscricao_municipal', aliasedName, true,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
          type: DriftSqlType.string,
          requiredDuringInsert: false);
  static const VerificationMeta _enderecoMeta =
      const VerificationMeta('endereco');
  @override
  late final GeneratedColumn<String> endereco = GeneratedColumn<String>(
      'endereco', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<String> numero = GeneratedColumn<String>(
      'numero', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _complementoMeta =
      const VerificationMeta('complemento');
  @override
  late final GeneratedColumn<String> complemento = GeneratedColumn<String>(
      'complemento', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _bairroMeta = const VerificationMeta('bairro');
  @override
  late final GeneratedColumn<String> bairro = GeneratedColumn<String>(
      'bairro', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cidadeMeta = const VerificationMeta('cidade');
  @override
  late final GeneratedColumn<String> cidade = GeneratedColumn<String>(
      'cidade', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cepMeta = const VerificationMeta('cep');
  @override
  late final GeneratedColumn<String> cep = GeneratedColumn<String>(
      'cep', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 8, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _celularMeta =
      const VerificationMeta('celular');
  @override
  late final GeneratedColumn<String> celular = GeneratedColumn<String>(
      'celular', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _websiteMeta =
      const VerificationMeta('website');
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
      'website', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _exibirLogoMeta =
      const VerificationMeta('exibirLogo');
  @override
  late final GeneratedColumn<bool> exibirLogo = GeneratedColumn<bool>(
      'exibir_logo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("exibir_logo" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _caminhoLogoMeta =
      const VerificationMeta('caminhoLogo');
  @override
  late final GeneratedColumn<String> caminhoLogo = GeneratedColumn<String>(
      'caminho_logo', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _mensagemRodapeMeta =
      const VerificationMeta('mensagemRodape');
  @override
  late final GeneratedColumn<String> mensagemRodape = GeneratedColumn<String>(
      'mensagem_rodape', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _exibirQrCodeMeta =
      const VerificationMeta('exibirQrCode');
  @override
  late final GeneratedColumn<bool> exibirQrCode = GeneratedColumn<bool>(
      'exibir_qr_code', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("exibir_qr_code" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _corPrimariaMeta =
      const VerificationMeta('corPrimaria');
  @override
  late final GeneratedColumn<String> corPrimaria = GeneratedColumn<String>(
      'cor_primaria', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 7),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _bancoMeta = const VerificationMeta('banco');
  @override
  late final GeneratedColumn<String> banco = GeneratedColumn<String>(
      'banco', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _agenciaMeta =
      const VerificationMeta('agencia');
  @override
  late final GeneratedColumn<String> agencia = GeneratedColumn<String>(
      'agencia', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _contaMeta = const VerificationMeta('conta');
  @override
  late final GeneratedColumn<String> conta = GeneratedColumn<String>(
      'conta', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _pixMeta = const VerificationMeta('pix');
  @override
  late final GeneratedColumn<String> pix = GeneratedColumn<String>(
      'pix', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _regimeTributarioMeta =
      const VerificationMeta('regimeTributario');
  @override
  late final GeneratedColumn<String> regimeTributario = GeneratedColumn<String>(
      'regime_tributario', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _emitirNfceMeta =
      const VerificationMeta('emitirNfce');
  @override
  late final GeneratedColumn<bool> emitirNfce = GeneratedColumn<bool>(
      'emitir_nfce', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("emitir_nfce" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _certificadoA1PathMeta =
      const VerificationMeta('certificadoA1Path');
  @override
  late final GeneratedColumn<String> certificadoA1Path =
      GeneratedColumn<String>('certificado_a1_path', aliasedName, true,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
          type: DriftSqlType.string,
          requiredDuringInsert: false);
  static const VerificationMeta _senhaA1Meta =
      const VerificationMeta('senhaA1');
  @override
  late final GeneratedColumn<String> senhaA1 = GeneratedColumn<String>(
      'senha_a1', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _atualizadoEmMeta =
      const VerificationMeta('atualizadoEm');
  @override
  late final GeneratedColumn<DateTime> atualizadoEm = GeneratedColumn<DateTime>(
      'atualizado_em', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nomeEmpresa,
        nomeFantasia,
        tipoEmpresa,
        documento,
        inscricaoEstadual,
        inscricaoMunicipal,
        endereco,
        numero,
        complemento,
        bairro,
        cidade,
        estado,
        cep,
        telefone,
        celular,
        email,
        website,
        exibirLogo,
        caminhoLogo,
        mensagemRodape,
        exibirQrCode,
        corPrimaria,
        banco,
        agencia,
        conta,
        pix,
        regimeTributario,
        emitirNfce,
        certificadoA1Path,
        senhaA1,
        criadoEm,
        atualizadoEm
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'empresa_configs';
  @override
  VerificationContext validateIntegrity(Insertable<EmpresaConfigData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome_empresa')) {
      context.handle(
          _nomeEmpresaMeta,
          nomeEmpresa.isAcceptableOrUnknown(
              data['nome_empresa']!, _nomeEmpresaMeta));
    } else if (isInserting) {
      context.missing(_nomeEmpresaMeta);
    }
    if (data.containsKey('nome_fantasia')) {
      context.handle(
          _nomeFantasiaMeta,
          nomeFantasia.isAcceptableOrUnknown(
              data['nome_fantasia']!, _nomeFantasiaMeta));
    }
    if (data.containsKey('tipo_empresa')) {
      context.handle(
          _tipoEmpresaMeta,
          tipoEmpresa.isAcceptableOrUnknown(
              data['tipo_empresa']!, _tipoEmpresaMeta));
    } else if (isInserting) {
      context.missing(_tipoEmpresaMeta);
    }
    if (data.containsKey('documento')) {
      context.handle(_documentoMeta,
          documento.isAcceptableOrUnknown(data['documento']!, _documentoMeta));
    } else if (isInserting) {
      context.missing(_documentoMeta);
    }
    if (data.containsKey('inscricao_estadual')) {
      context.handle(
          _inscricaoEstadualMeta,
          inscricaoEstadual.isAcceptableOrUnknown(
              data['inscricao_estadual']!, _inscricaoEstadualMeta));
    }
    if (data.containsKey('inscricao_municipal')) {
      context.handle(
          _inscricaoMunicipalMeta,
          inscricaoMunicipal.isAcceptableOrUnknown(
              data['inscricao_municipal']!, _inscricaoMunicipalMeta));
    }
    if (data.containsKey('endereco')) {
      context.handle(_enderecoMeta,
          endereco.isAcceptableOrUnknown(data['endereco']!, _enderecoMeta));
    } else if (isInserting) {
      context.missing(_enderecoMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(_numeroMeta,
          numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta));
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('complemento')) {
      context.handle(
          _complementoMeta,
          complemento.isAcceptableOrUnknown(
              data['complemento']!, _complementoMeta));
    }
    if (data.containsKey('bairro')) {
      context.handle(_bairroMeta,
          bairro.isAcceptableOrUnknown(data['bairro']!, _bairroMeta));
    } else if (isInserting) {
      context.missing(_bairroMeta);
    }
    if (data.containsKey('cidade')) {
      context.handle(_cidadeMeta,
          cidade.isAcceptableOrUnknown(data['cidade']!, _cidadeMeta));
    } else if (isInserting) {
      context.missing(_cidadeMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('cep')) {
      context.handle(
          _cepMeta, cep.isAcceptableOrUnknown(data['cep']!, _cepMeta));
    } else if (isInserting) {
      context.missing(_cepMeta);
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    }
    if (data.containsKey('celular')) {
      context.handle(_celularMeta,
          celular.isAcceptableOrUnknown(data['celular']!, _celularMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('website')) {
      context.handle(_websiteMeta,
          website.isAcceptableOrUnknown(data['website']!, _websiteMeta));
    }
    if (data.containsKey('exibir_logo')) {
      context.handle(
          _exibirLogoMeta,
          exibirLogo.isAcceptableOrUnknown(
              data['exibir_logo']!, _exibirLogoMeta));
    }
    if (data.containsKey('caminho_logo')) {
      context.handle(
          _caminhoLogoMeta,
          caminhoLogo.isAcceptableOrUnknown(
              data['caminho_logo']!, _caminhoLogoMeta));
    }
    if (data.containsKey('mensagem_rodape')) {
      context.handle(
          _mensagemRodapeMeta,
          mensagemRodape.isAcceptableOrUnknown(
              data['mensagem_rodape']!, _mensagemRodapeMeta));
    }
    if (data.containsKey('exibir_qr_code')) {
      context.handle(
          _exibirQrCodeMeta,
          exibirQrCode.isAcceptableOrUnknown(
              data['exibir_qr_code']!, _exibirQrCodeMeta));
    }
    if (data.containsKey('cor_primaria')) {
      context.handle(
          _corPrimariaMeta,
          corPrimaria.isAcceptableOrUnknown(
              data['cor_primaria']!, _corPrimariaMeta));
    }
    if (data.containsKey('banco')) {
      context.handle(
          _bancoMeta, banco.isAcceptableOrUnknown(data['banco']!, _bancoMeta));
    }
    if (data.containsKey('agencia')) {
      context.handle(_agenciaMeta,
          agencia.isAcceptableOrUnknown(data['agencia']!, _agenciaMeta));
    }
    if (data.containsKey('conta')) {
      context.handle(
          _contaMeta, conta.isAcceptableOrUnknown(data['conta']!, _contaMeta));
    }
    if (data.containsKey('pix')) {
      context.handle(
          _pixMeta, pix.isAcceptableOrUnknown(data['pix']!, _pixMeta));
    }
    if (data.containsKey('regime_tributario')) {
      context.handle(
          _regimeTributarioMeta,
          regimeTributario.isAcceptableOrUnknown(
              data['regime_tributario']!, _regimeTributarioMeta));
    }
    if (data.containsKey('emitir_nfce')) {
      context.handle(
          _emitirNfceMeta,
          emitirNfce.isAcceptableOrUnknown(
              data['emitir_nfce']!, _emitirNfceMeta));
    }
    if (data.containsKey('certificado_a1_path')) {
      context.handle(
          _certificadoA1PathMeta,
          certificadoA1Path.isAcceptableOrUnknown(
              data['certificado_a1_path']!, _certificadoA1PathMeta));
    }
    if (data.containsKey('senha_a1')) {
      context.handle(_senhaA1Meta,
          senhaA1.isAcceptableOrUnknown(data['senha_a1']!, _senhaA1Meta));
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    }
    if (data.containsKey('atualizado_em')) {
      context.handle(
          _atualizadoEmMeta,
          atualizadoEm.isAcceptableOrUnknown(
              data['atualizado_em']!, _atualizadoEmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmpresaConfigData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmpresaConfigData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nomeEmpresa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_empresa'])!,
      nomeFantasia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_fantasia']),
      tipoEmpresa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo_empresa'])!,
      documento: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}documento'])!,
      inscricaoEstadual: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}inscricao_estadual']),
      inscricaoMunicipal: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}inscricao_municipal']),
      endereco: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endereco'])!,
      numero: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero'])!,
      complemento: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}complemento']),
      bairro: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bairro'])!,
      cidade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cidade'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      cep: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cep'])!,
      telefone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefone']),
      celular: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}celular']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      website: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}website']),
      exibirLogo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}exibir_logo'])!,
      caminhoLogo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caminho_logo']),
      mensagemRodape: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mensagem_rodape']),
      exibirQrCode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}exibir_qr_code'])!,
      corPrimaria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cor_primaria']),
      banco: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}banco']),
      agencia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agencia']),
      conta: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}conta']),
      pix: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pix']),
      regimeTributario: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}regime_tributario']),
      emitirNfce: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}emitir_nfce'])!,
      certificadoA1Path: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}certificado_a1_path']),
      senhaA1: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}senha_a1']),
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em']),
      atualizadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}atualizado_em']),
    );
  }

  @override
  $EmpresaConfigsTable createAlias(String alias) {
    return $EmpresaConfigsTable(attachedDatabase, alias);
  }
}

class EmpresaConfigData extends DataClass
    implements Insertable<EmpresaConfigData> {
  final int id;
  final String nomeEmpresa;
  final String? nomeFantasia;
  final String tipoEmpresa;
  final String documento;
  final String? inscricaoEstadual;
  final String? inscricaoMunicipal;
  final String endereco;
  final String numero;
  final String? complemento;
  final String bairro;
  final String cidade;
  final String estado;
  final String cep;
  final String? telefone;
  final String? celular;
  final String? email;
  final String? website;
  final bool exibirLogo;
  final String? caminhoLogo;
  final String? mensagemRodape;
  final bool exibirQrCode;
  final String? corPrimaria;
  final String? banco;
  final String? agencia;
  final String? conta;
  final String? pix;
  final String? regimeTributario;
  final bool emitirNfce;
  final String? certificadoA1Path;
  final String? senhaA1;
  final DateTime? criadoEm;
  final DateTime? atualizadoEm;
  const EmpresaConfigData(
      {required this.id,
      required this.nomeEmpresa,
      this.nomeFantasia,
      required this.tipoEmpresa,
      required this.documento,
      this.inscricaoEstadual,
      this.inscricaoMunicipal,
      required this.endereco,
      required this.numero,
      this.complemento,
      required this.bairro,
      required this.cidade,
      required this.estado,
      required this.cep,
      this.telefone,
      this.celular,
      this.email,
      this.website,
      required this.exibirLogo,
      this.caminhoLogo,
      this.mensagemRodape,
      required this.exibirQrCode,
      this.corPrimaria,
      this.banco,
      this.agencia,
      this.conta,
      this.pix,
      this.regimeTributario,
      required this.emitirNfce,
      this.certificadoA1Path,
      this.senhaA1,
      this.criadoEm,
      this.atualizadoEm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome_empresa'] = Variable<String>(nomeEmpresa);
    if (!nullToAbsent || nomeFantasia != null) {
      map['nome_fantasia'] = Variable<String>(nomeFantasia);
    }
    map['tipo_empresa'] = Variable<String>(tipoEmpresa);
    map['documento'] = Variable<String>(documento);
    if (!nullToAbsent || inscricaoEstadual != null) {
      map['inscricao_estadual'] = Variable<String>(inscricaoEstadual);
    }
    if (!nullToAbsent || inscricaoMunicipal != null) {
      map['inscricao_municipal'] = Variable<String>(inscricaoMunicipal);
    }
    map['endereco'] = Variable<String>(endereco);
    map['numero'] = Variable<String>(numero);
    if (!nullToAbsent || complemento != null) {
      map['complemento'] = Variable<String>(complemento);
    }
    map['bairro'] = Variable<String>(bairro);
    map['cidade'] = Variable<String>(cidade);
    map['estado'] = Variable<String>(estado);
    map['cep'] = Variable<String>(cep);
    if (!nullToAbsent || telefone != null) {
      map['telefone'] = Variable<String>(telefone);
    }
    if (!nullToAbsent || celular != null) {
      map['celular'] = Variable<String>(celular);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    map['exibir_logo'] = Variable<bool>(exibirLogo);
    if (!nullToAbsent || caminhoLogo != null) {
      map['caminho_logo'] = Variable<String>(caminhoLogo);
    }
    if (!nullToAbsent || mensagemRodape != null) {
      map['mensagem_rodape'] = Variable<String>(mensagemRodape);
    }
    map['exibir_qr_code'] = Variable<bool>(exibirQrCode);
    if (!nullToAbsent || corPrimaria != null) {
      map['cor_primaria'] = Variable<String>(corPrimaria);
    }
    if (!nullToAbsent || banco != null) {
      map['banco'] = Variable<String>(banco);
    }
    if (!nullToAbsent || agencia != null) {
      map['agencia'] = Variable<String>(agencia);
    }
    if (!nullToAbsent || conta != null) {
      map['conta'] = Variable<String>(conta);
    }
    if (!nullToAbsent || pix != null) {
      map['pix'] = Variable<String>(pix);
    }
    if (!nullToAbsent || regimeTributario != null) {
      map['regime_tributario'] = Variable<String>(regimeTributario);
    }
    map['emitir_nfce'] = Variable<bool>(emitirNfce);
    if (!nullToAbsent || certificadoA1Path != null) {
      map['certificado_a1_path'] = Variable<String>(certificadoA1Path);
    }
    if (!nullToAbsent || senhaA1 != null) {
      map['senha_a1'] = Variable<String>(senhaA1);
    }
    if (!nullToAbsent || criadoEm != null) {
      map['criado_em'] = Variable<DateTime>(criadoEm);
    }
    if (!nullToAbsent || atualizadoEm != null) {
      map['atualizado_em'] = Variable<DateTime>(atualizadoEm);
    }
    return map;
  }

  EmpresaConfigsCompanion toCompanion(bool nullToAbsent) {
    return EmpresaConfigsCompanion(
      id: Value(id),
      nomeEmpresa: Value(nomeEmpresa),
      nomeFantasia: nomeFantasia == null && nullToAbsent
          ? const Value.absent()
          : Value(nomeFantasia),
      tipoEmpresa: Value(tipoEmpresa),
      documento: Value(documento),
      inscricaoEstadual: inscricaoEstadual == null && nullToAbsent
          ? const Value.absent()
          : Value(inscricaoEstadual),
      inscricaoMunicipal: inscricaoMunicipal == null && nullToAbsent
          ? const Value.absent()
          : Value(inscricaoMunicipal),
      endereco: Value(endereco),
      numero: Value(numero),
      complemento: complemento == null && nullToAbsent
          ? const Value.absent()
          : Value(complemento),
      bairro: Value(bairro),
      cidade: Value(cidade),
      estado: Value(estado),
      cep: Value(cep),
      telefone: telefone == null && nullToAbsent
          ? const Value.absent()
          : Value(telefone),
      celular: celular == null && nullToAbsent
          ? const Value.absent()
          : Value(celular),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      exibirLogo: Value(exibirLogo),
      caminhoLogo: caminhoLogo == null && nullToAbsent
          ? const Value.absent()
          : Value(caminhoLogo),
      mensagemRodape: mensagemRodape == null && nullToAbsent
          ? const Value.absent()
          : Value(mensagemRodape),
      exibirQrCode: Value(exibirQrCode),
      corPrimaria: corPrimaria == null && nullToAbsent
          ? const Value.absent()
          : Value(corPrimaria),
      banco:
          banco == null && nullToAbsent ? const Value.absent() : Value(banco),
      agencia: agencia == null && nullToAbsent
          ? const Value.absent()
          : Value(agencia),
      conta:
          conta == null && nullToAbsent ? const Value.absent() : Value(conta),
      pix: pix == null && nullToAbsent ? const Value.absent() : Value(pix),
      regimeTributario: regimeTributario == null && nullToAbsent
          ? const Value.absent()
          : Value(regimeTributario),
      emitirNfce: Value(emitirNfce),
      certificadoA1Path: certificadoA1Path == null && nullToAbsent
          ? const Value.absent()
          : Value(certificadoA1Path),
      senhaA1: senhaA1 == null && nullToAbsent
          ? const Value.absent()
          : Value(senhaA1),
      criadoEm: criadoEm == null && nullToAbsent
          ? const Value.absent()
          : Value(criadoEm),
      atualizadoEm: atualizadoEm == null && nullToAbsent
          ? const Value.absent()
          : Value(atualizadoEm),
    );
  }

  factory EmpresaConfigData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmpresaConfigData(
      id: serializer.fromJson<int>(json['id']),
      nomeEmpresa: serializer.fromJson<String>(json['nomeEmpresa']),
      nomeFantasia: serializer.fromJson<String?>(json['nomeFantasia']),
      tipoEmpresa: serializer.fromJson<String>(json['tipoEmpresa']),
      documento: serializer.fromJson<String>(json['documento']),
      inscricaoEstadual:
          serializer.fromJson<String?>(json['inscricaoEstadual']),
      inscricaoMunicipal:
          serializer.fromJson<String?>(json['inscricaoMunicipal']),
      endereco: serializer.fromJson<String>(json['endereco']),
      numero: serializer.fromJson<String>(json['numero']),
      complemento: serializer.fromJson<String?>(json['complemento']),
      bairro: serializer.fromJson<String>(json['bairro']),
      cidade: serializer.fromJson<String>(json['cidade']),
      estado: serializer.fromJson<String>(json['estado']),
      cep: serializer.fromJson<String>(json['cep']),
      telefone: serializer.fromJson<String?>(json['telefone']),
      celular: serializer.fromJson<String?>(json['celular']),
      email: serializer.fromJson<String?>(json['email']),
      website: serializer.fromJson<String?>(json['website']),
      exibirLogo: serializer.fromJson<bool>(json['exibirLogo']),
      caminhoLogo: serializer.fromJson<String?>(json['caminhoLogo']),
      mensagemRodape: serializer.fromJson<String?>(json['mensagemRodape']),
      exibirQrCode: serializer.fromJson<bool>(json['exibirQrCode']),
      corPrimaria: serializer.fromJson<String?>(json['corPrimaria']),
      banco: serializer.fromJson<String?>(json['banco']),
      agencia: serializer.fromJson<String?>(json['agencia']),
      conta: serializer.fromJson<String?>(json['conta']),
      pix: serializer.fromJson<String?>(json['pix']),
      regimeTributario: serializer.fromJson<String?>(json['regimeTributario']),
      emitirNfce: serializer.fromJson<bool>(json['emitirNfce']),
      certificadoA1Path:
          serializer.fromJson<String?>(json['certificadoA1Path']),
      senhaA1: serializer.fromJson<String?>(json['senhaA1']),
      criadoEm: serializer.fromJson<DateTime?>(json['criadoEm']),
      atualizadoEm: serializer.fromJson<DateTime?>(json['atualizadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nomeEmpresa': serializer.toJson<String>(nomeEmpresa),
      'nomeFantasia': serializer.toJson<String?>(nomeFantasia),
      'tipoEmpresa': serializer.toJson<String>(tipoEmpresa),
      'documento': serializer.toJson<String>(documento),
      'inscricaoEstadual': serializer.toJson<String?>(inscricaoEstadual),
      'inscricaoMunicipal': serializer.toJson<String?>(inscricaoMunicipal),
      'endereco': serializer.toJson<String>(endereco),
      'numero': serializer.toJson<String>(numero),
      'complemento': serializer.toJson<String?>(complemento),
      'bairro': serializer.toJson<String>(bairro),
      'cidade': serializer.toJson<String>(cidade),
      'estado': serializer.toJson<String>(estado),
      'cep': serializer.toJson<String>(cep),
      'telefone': serializer.toJson<String?>(telefone),
      'celular': serializer.toJson<String?>(celular),
      'email': serializer.toJson<String?>(email),
      'website': serializer.toJson<String?>(website),
      'exibirLogo': serializer.toJson<bool>(exibirLogo),
      'caminhoLogo': serializer.toJson<String?>(caminhoLogo),
      'mensagemRodape': serializer.toJson<String?>(mensagemRodape),
      'exibirQrCode': serializer.toJson<bool>(exibirQrCode),
      'corPrimaria': serializer.toJson<String?>(corPrimaria),
      'banco': serializer.toJson<String?>(banco),
      'agencia': serializer.toJson<String?>(agencia),
      'conta': serializer.toJson<String?>(conta),
      'pix': serializer.toJson<String?>(pix),
      'regimeTributario': serializer.toJson<String?>(regimeTributario),
      'emitirNfce': serializer.toJson<bool>(emitirNfce),
      'certificadoA1Path': serializer.toJson<String?>(certificadoA1Path),
      'senhaA1': serializer.toJson<String?>(senhaA1),
      'criadoEm': serializer.toJson<DateTime?>(criadoEm),
      'atualizadoEm': serializer.toJson<DateTime?>(atualizadoEm),
    };
  }

  EmpresaConfigData copyWith(
          {int? id,
          String? nomeEmpresa,
          Value<String?> nomeFantasia = const Value.absent(),
          String? tipoEmpresa,
          String? documento,
          Value<String?> inscricaoEstadual = const Value.absent(),
          Value<String?> inscricaoMunicipal = const Value.absent(),
          String? endereco,
          String? numero,
          Value<String?> complemento = const Value.absent(),
          String? bairro,
          String? cidade,
          String? estado,
          String? cep,
          Value<String?> telefone = const Value.absent(),
          Value<String?> celular = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> website = const Value.absent(),
          bool? exibirLogo,
          Value<String?> caminhoLogo = const Value.absent(),
          Value<String?> mensagemRodape = const Value.absent(),
          bool? exibirQrCode,
          Value<String?> corPrimaria = const Value.absent(),
          Value<String?> banco = const Value.absent(),
          Value<String?> agencia = const Value.absent(),
          Value<String?> conta = const Value.absent(),
          Value<String?> pix = const Value.absent(),
          Value<String?> regimeTributario = const Value.absent(),
          bool? emitirNfce,
          Value<String?> certificadoA1Path = const Value.absent(),
          Value<String?> senhaA1 = const Value.absent(),
          Value<DateTime?> criadoEm = const Value.absent(),
          Value<DateTime?> atualizadoEm = const Value.absent()}) =>
      EmpresaConfigData(
        id: id ?? this.id,
        nomeEmpresa: nomeEmpresa ?? this.nomeEmpresa,
        nomeFantasia:
            nomeFantasia.present ? nomeFantasia.value : this.nomeFantasia,
        tipoEmpresa: tipoEmpresa ?? this.tipoEmpresa,
        documento: documento ?? this.documento,
        inscricaoEstadual: inscricaoEstadual.present
            ? inscricaoEstadual.value
            : this.inscricaoEstadual,
        inscricaoMunicipal: inscricaoMunicipal.present
            ? inscricaoMunicipal.value
            : this.inscricaoMunicipal,
        endereco: endereco ?? this.endereco,
        numero: numero ?? this.numero,
        complemento: complemento.present ? complemento.value : this.complemento,
        bairro: bairro ?? this.bairro,
        cidade: cidade ?? this.cidade,
        estado: estado ?? this.estado,
        cep: cep ?? this.cep,
        telefone: telefone.present ? telefone.value : this.telefone,
        celular: celular.present ? celular.value : this.celular,
        email: email.present ? email.value : this.email,
        website: website.present ? website.value : this.website,
        exibirLogo: exibirLogo ?? this.exibirLogo,
        caminhoLogo: caminhoLogo.present ? caminhoLogo.value : this.caminhoLogo,
        mensagemRodape:
            mensagemRodape.present ? mensagemRodape.value : this.mensagemRodape,
        exibirQrCode: exibirQrCode ?? this.exibirQrCode,
        corPrimaria: corPrimaria.present ? corPrimaria.value : this.corPrimaria,
        banco: banco.present ? banco.value : this.banco,
        agencia: agencia.present ? agencia.value : this.agencia,
        conta: conta.present ? conta.value : this.conta,
        pix: pix.present ? pix.value : this.pix,
        regimeTributario: regimeTributario.present
            ? regimeTributario.value
            : this.regimeTributario,
        emitirNfce: emitirNfce ?? this.emitirNfce,
        certificadoA1Path: certificadoA1Path.present
            ? certificadoA1Path.value
            : this.certificadoA1Path,
        senhaA1: senhaA1.present ? senhaA1.value : this.senhaA1,
        criadoEm: criadoEm.present ? criadoEm.value : this.criadoEm,
        atualizadoEm:
            atualizadoEm.present ? atualizadoEm.value : this.atualizadoEm,
      );
  EmpresaConfigData copyWithCompanion(EmpresaConfigsCompanion data) {
    return EmpresaConfigData(
      id: data.id.present ? data.id.value : this.id,
      nomeEmpresa:
          data.nomeEmpresa.present ? data.nomeEmpresa.value : this.nomeEmpresa,
      nomeFantasia: data.nomeFantasia.present
          ? data.nomeFantasia.value
          : this.nomeFantasia,
      tipoEmpresa:
          data.tipoEmpresa.present ? data.tipoEmpresa.value : this.tipoEmpresa,
      documento: data.documento.present ? data.documento.value : this.documento,
      inscricaoEstadual: data.inscricaoEstadual.present
          ? data.inscricaoEstadual.value
          : this.inscricaoEstadual,
      inscricaoMunicipal: data.inscricaoMunicipal.present
          ? data.inscricaoMunicipal.value
          : this.inscricaoMunicipal,
      endereco: data.endereco.present ? data.endereco.value : this.endereco,
      numero: data.numero.present ? data.numero.value : this.numero,
      complemento:
          data.complemento.present ? data.complemento.value : this.complemento,
      bairro: data.bairro.present ? data.bairro.value : this.bairro,
      cidade: data.cidade.present ? data.cidade.value : this.cidade,
      estado: data.estado.present ? data.estado.value : this.estado,
      cep: data.cep.present ? data.cep.value : this.cep,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
      celular: data.celular.present ? data.celular.value : this.celular,
      email: data.email.present ? data.email.value : this.email,
      website: data.website.present ? data.website.value : this.website,
      exibirLogo:
          data.exibirLogo.present ? data.exibirLogo.value : this.exibirLogo,
      caminhoLogo:
          data.caminhoLogo.present ? data.caminhoLogo.value : this.caminhoLogo,
      mensagemRodape: data.mensagemRodape.present
          ? data.mensagemRodape.value
          : this.mensagemRodape,
      exibirQrCode: data.exibirQrCode.present
          ? data.exibirQrCode.value
          : this.exibirQrCode,
      corPrimaria:
          data.corPrimaria.present ? data.corPrimaria.value : this.corPrimaria,
      banco: data.banco.present ? data.banco.value : this.banco,
      agencia: data.agencia.present ? data.agencia.value : this.agencia,
      conta: data.conta.present ? data.conta.value : this.conta,
      pix: data.pix.present ? data.pix.value : this.pix,
      regimeTributario: data.regimeTributario.present
          ? data.regimeTributario.value
          : this.regimeTributario,
      emitirNfce:
          data.emitirNfce.present ? data.emitirNfce.value : this.emitirNfce,
      certificadoA1Path: data.certificadoA1Path.present
          ? data.certificadoA1Path.value
          : this.certificadoA1Path,
      senhaA1: data.senhaA1.present ? data.senhaA1.value : this.senhaA1,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
      atualizadoEm: data.atualizadoEm.present
          ? data.atualizadoEm.value
          : this.atualizadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmpresaConfigData(')
          ..write('id: $id, ')
          ..write('nomeEmpresa: $nomeEmpresa, ')
          ..write('nomeFantasia: $nomeFantasia, ')
          ..write('tipoEmpresa: $tipoEmpresa, ')
          ..write('documento: $documento, ')
          ..write('inscricaoEstadual: $inscricaoEstadual, ')
          ..write('inscricaoMunicipal: $inscricaoMunicipal, ')
          ..write('endereco: $endereco, ')
          ..write('numero: $numero, ')
          ..write('complemento: $complemento, ')
          ..write('bairro: $bairro, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('cep: $cep, ')
          ..write('telefone: $telefone, ')
          ..write('celular: $celular, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('exibirLogo: $exibirLogo, ')
          ..write('caminhoLogo: $caminhoLogo, ')
          ..write('mensagemRodape: $mensagemRodape, ')
          ..write('exibirQrCode: $exibirQrCode, ')
          ..write('corPrimaria: $corPrimaria, ')
          ..write('banco: $banco, ')
          ..write('agencia: $agencia, ')
          ..write('conta: $conta, ')
          ..write('pix: $pix, ')
          ..write('regimeTributario: $regimeTributario, ')
          ..write('emitirNfce: $emitirNfce, ')
          ..write('certificadoA1Path: $certificadoA1Path, ')
          ..write('senhaA1: $senhaA1, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        nomeEmpresa,
        nomeFantasia,
        tipoEmpresa,
        documento,
        inscricaoEstadual,
        inscricaoMunicipal,
        endereco,
        numero,
        complemento,
        bairro,
        cidade,
        estado,
        cep,
        telefone,
        celular,
        email,
        website,
        exibirLogo,
        caminhoLogo,
        mensagemRodape,
        exibirQrCode,
        corPrimaria,
        banco,
        agencia,
        conta,
        pix,
        regimeTributario,
        emitirNfce,
        certificadoA1Path,
        senhaA1,
        criadoEm,
        atualizadoEm
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmpresaConfigData &&
          other.id == this.id &&
          other.nomeEmpresa == this.nomeEmpresa &&
          other.nomeFantasia == this.nomeFantasia &&
          other.tipoEmpresa == this.tipoEmpresa &&
          other.documento == this.documento &&
          other.inscricaoEstadual == this.inscricaoEstadual &&
          other.inscricaoMunicipal == this.inscricaoMunicipal &&
          other.endereco == this.endereco &&
          other.numero == this.numero &&
          other.complemento == this.complemento &&
          other.bairro == this.bairro &&
          other.cidade == this.cidade &&
          other.estado == this.estado &&
          other.cep == this.cep &&
          other.telefone == this.telefone &&
          other.celular == this.celular &&
          other.email == this.email &&
          other.website == this.website &&
          other.exibirLogo == this.exibirLogo &&
          other.caminhoLogo == this.caminhoLogo &&
          other.mensagemRodape == this.mensagemRodape &&
          other.exibirQrCode == this.exibirQrCode &&
          other.corPrimaria == this.corPrimaria &&
          other.banco == this.banco &&
          other.agencia == this.agencia &&
          other.conta == this.conta &&
          other.pix == this.pix &&
          other.regimeTributario == this.regimeTributario &&
          other.emitirNfce == this.emitirNfce &&
          other.certificadoA1Path == this.certificadoA1Path &&
          other.senhaA1 == this.senhaA1 &&
          other.criadoEm == this.criadoEm &&
          other.atualizadoEm == this.atualizadoEm);
}

class EmpresaConfigsCompanion extends UpdateCompanion<EmpresaConfigData> {
  final Value<int> id;
  final Value<String> nomeEmpresa;
  final Value<String?> nomeFantasia;
  final Value<String> tipoEmpresa;
  final Value<String> documento;
  final Value<String?> inscricaoEstadual;
  final Value<String?> inscricaoMunicipal;
  final Value<String> endereco;
  final Value<String> numero;
  final Value<String?> complemento;
  final Value<String> bairro;
  final Value<String> cidade;
  final Value<String> estado;
  final Value<String> cep;
  final Value<String?> telefone;
  final Value<String?> celular;
  final Value<String?> email;
  final Value<String?> website;
  final Value<bool> exibirLogo;
  final Value<String?> caminhoLogo;
  final Value<String?> mensagemRodape;
  final Value<bool> exibirQrCode;
  final Value<String?> corPrimaria;
  final Value<String?> banco;
  final Value<String?> agencia;
  final Value<String?> conta;
  final Value<String?> pix;
  final Value<String?> regimeTributario;
  final Value<bool> emitirNfce;
  final Value<String?> certificadoA1Path;
  final Value<String?> senhaA1;
  final Value<DateTime?> criadoEm;
  final Value<DateTime?> atualizadoEm;
  const EmpresaConfigsCompanion({
    this.id = const Value.absent(),
    this.nomeEmpresa = const Value.absent(),
    this.nomeFantasia = const Value.absent(),
    this.tipoEmpresa = const Value.absent(),
    this.documento = const Value.absent(),
    this.inscricaoEstadual = const Value.absent(),
    this.inscricaoMunicipal = const Value.absent(),
    this.endereco = const Value.absent(),
    this.numero = const Value.absent(),
    this.complemento = const Value.absent(),
    this.bairro = const Value.absent(),
    this.cidade = const Value.absent(),
    this.estado = const Value.absent(),
    this.cep = const Value.absent(),
    this.telefone = const Value.absent(),
    this.celular = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.exibirLogo = const Value.absent(),
    this.caminhoLogo = const Value.absent(),
    this.mensagemRodape = const Value.absent(),
    this.exibirQrCode = const Value.absent(),
    this.corPrimaria = const Value.absent(),
    this.banco = const Value.absent(),
    this.agencia = const Value.absent(),
    this.conta = const Value.absent(),
    this.pix = const Value.absent(),
    this.regimeTributario = const Value.absent(),
    this.emitirNfce = const Value.absent(),
    this.certificadoA1Path = const Value.absent(),
    this.senhaA1 = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
  });
  EmpresaConfigsCompanion.insert({
    this.id = const Value.absent(),
    required String nomeEmpresa,
    this.nomeFantasia = const Value.absent(),
    required String tipoEmpresa,
    required String documento,
    this.inscricaoEstadual = const Value.absent(),
    this.inscricaoMunicipal = const Value.absent(),
    required String endereco,
    required String numero,
    this.complemento = const Value.absent(),
    required String bairro,
    required String cidade,
    required String estado,
    required String cep,
    this.telefone = const Value.absent(),
    this.celular = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.exibirLogo = const Value.absent(),
    this.caminhoLogo = const Value.absent(),
    this.mensagemRodape = const Value.absent(),
    this.exibirQrCode = const Value.absent(),
    this.corPrimaria = const Value.absent(),
    this.banco = const Value.absent(),
    this.agencia = const Value.absent(),
    this.conta = const Value.absent(),
    this.pix = const Value.absent(),
    this.regimeTributario = const Value.absent(),
    this.emitirNfce = const Value.absent(),
    this.certificadoA1Path = const Value.absent(),
    this.senhaA1 = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
  })  : nomeEmpresa = Value(nomeEmpresa),
        tipoEmpresa = Value(tipoEmpresa),
        documento = Value(documento),
        endereco = Value(endereco),
        numero = Value(numero),
        bairro = Value(bairro),
        cidade = Value(cidade),
        estado = Value(estado),
        cep = Value(cep);
  static Insertable<EmpresaConfigData> custom({
    Expression<int>? id,
    Expression<String>? nomeEmpresa,
    Expression<String>? nomeFantasia,
    Expression<String>? tipoEmpresa,
    Expression<String>? documento,
    Expression<String>? inscricaoEstadual,
    Expression<String>? inscricaoMunicipal,
    Expression<String>? endereco,
    Expression<String>? numero,
    Expression<String>? complemento,
    Expression<String>? bairro,
    Expression<String>? cidade,
    Expression<String>? estado,
    Expression<String>? cep,
    Expression<String>? telefone,
    Expression<String>? celular,
    Expression<String>? email,
    Expression<String>? website,
    Expression<bool>? exibirLogo,
    Expression<String>? caminhoLogo,
    Expression<String>? mensagemRodape,
    Expression<bool>? exibirQrCode,
    Expression<String>? corPrimaria,
    Expression<String>? banco,
    Expression<String>? agencia,
    Expression<String>? conta,
    Expression<String>? pix,
    Expression<String>? regimeTributario,
    Expression<bool>? emitirNfce,
    Expression<String>? certificadoA1Path,
    Expression<String>? senhaA1,
    Expression<DateTime>? criadoEm,
    Expression<DateTime>? atualizadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nomeEmpresa != null) 'nome_empresa': nomeEmpresa,
      if (nomeFantasia != null) 'nome_fantasia': nomeFantasia,
      if (tipoEmpresa != null) 'tipo_empresa': tipoEmpresa,
      if (documento != null) 'documento': documento,
      if (inscricaoEstadual != null) 'inscricao_estadual': inscricaoEstadual,
      if (inscricaoMunicipal != null) 'inscricao_municipal': inscricaoMunicipal,
      if (endereco != null) 'endereco': endereco,
      if (numero != null) 'numero': numero,
      if (complemento != null) 'complemento': complemento,
      if (bairro != null) 'bairro': bairro,
      if (cidade != null) 'cidade': cidade,
      if (estado != null) 'estado': estado,
      if (cep != null) 'cep': cep,
      if (telefone != null) 'telefone': telefone,
      if (celular != null) 'celular': celular,
      if (email != null) 'email': email,
      if (website != null) 'website': website,
      if (exibirLogo != null) 'exibir_logo': exibirLogo,
      if (caminhoLogo != null) 'caminho_logo': caminhoLogo,
      if (mensagemRodape != null) 'mensagem_rodape': mensagemRodape,
      if (exibirQrCode != null) 'exibir_qr_code': exibirQrCode,
      if (corPrimaria != null) 'cor_primaria': corPrimaria,
      if (banco != null) 'banco': banco,
      if (agencia != null) 'agencia': agencia,
      if (conta != null) 'conta': conta,
      if (pix != null) 'pix': pix,
      if (regimeTributario != null) 'regime_tributario': regimeTributario,
      if (emitirNfce != null) 'emitir_nfce': emitirNfce,
      if (certificadoA1Path != null) 'certificado_a1_path': certificadoA1Path,
      if (senhaA1 != null) 'senha_a1': senhaA1,
      if (criadoEm != null) 'criado_em': criadoEm,
      if (atualizadoEm != null) 'atualizado_em': atualizadoEm,
    });
  }

  EmpresaConfigsCompanion copyWith(
      {Value<int>? id,
      Value<String>? nomeEmpresa,
      Value<String?>? nomeFantasia,
      Value<String>? tipoEmpresa,
      Value<String>? documento,
      Value<String?>? inscricaoEstadual,
      Value<String?>? inscricaoMunicipal,
      Value<String>? endereco,
      Value<String>? numero,
      Value<String?>? complemento,
      Value<String>? bairro,
      Value<String>? cidade,
      Value<String>? estado,
      Value<String>? cep,
      Value<String?>? telefone,
      Value<String?>? celular,
      Value<String?>? email,
      Value<String?>? website,
      Value<bool>? exibirLogo,
      Value<String?>? caminhoLogo,
      Value<String?>? mensagemRodape,
      Value<bool>? exibirQrCode,
      Value<String?>? corPrimaria,
      Value<String?>? banco,
      Value<String?>? agencia,
      Value<String?>? conta,
      Value<String?>? pix,
      Value<String?>? regimeTributario,
      Value<bool>? emitirNfce,
      Value<String?>? certificadoA1Path,
      Value<String?>? senhaA1,
      Value<DateTime?>? criadoEm,
      Value<DateTime?>? atualizadoEm}) {
    return EmpresaConfigsCompanion(
      id: id ?? this.id,
      nomeEmpresa: nomeEmpresa ?? this.nomeEmpresa,
      nomeFantasia: nomeFantasia ?? this.nomeFantasia,
      tipoEmpresa: tipoEmpresa ?? this.tipoEmpresa,
      documento: documento ?? this.documento,
      inscricaoEstadual: inscricaoEstadual ?? this.inscricaoEstadual,
      inscricaoMunicipal: inscricaoMunicipal ?? this.inscricaoMunicipal,
      endereco: endereco ?? this.endereco,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      telefone: telefone ?? this.telefone,
      celular: celular ?? this.celular,
      email: email ?? this.email,
      website: website ?? this.website,
      exibirLogo: exibirLogo ?? this.exibirLogo,
      caminhoLogo: caminhoLogo ?? this.caminhoLogo,
      mensagemRodape: mensagemRodape ?? this.mensagemRodape,
      exibirQrCode: exibirQrCode ?? this.exibirQrCode,
      corPrimaria: corPrimaria ?? this.corPrimaria,
      banco: banco ?? this.banco,
      agencia: agencia ?? this.agencia,
      conta: conta ?? this.conta,
      pix: pix ?? this.pix,
      regimeTributario: regimeTributario ?? this.regimeTributario,
      emitirNfce: emitirNfce ?? this.emitirNfce,
      certificadoA1Path: certificadoA1Path ?? this.certificadoA1Path,
      senhaA1: senhaA1 ?? this.senhaA1,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nomeEmpresa.present) {
      map['nome_empresa'] = Variable<String>(nomeEmpresa.value);
    }
    if (nomeFantasia.present) {
      map['nome_fantasia'] = Variable<String>(nomeFantasia.value);
    }
    if (tipoEmpresa.present) {
      map['tipo_empresa'] = Variable<String>(tipoEmpresa.value);
    }
    if (documento.present) {
      map['documento'] = Variable<String>(documento.value);
    }
    if (inscricaoEstadual.present) {
      map['inscricao_estadual'] = Variable<String>(inscricaoEstadual.value);
    }
    if (inscricaoMunicipal.present) {
      map['inscricao_municipal'] = Variable<String>(inscricaoMunicipal.value);
    }
    if (endereco.present) {
      map['endereco'] = Variable<String>(endereco.value);
    }
    if (numero.present) {
      map['numero'] = Variable<String>(numero.value);
    }
    if (complemento.present) {
      map['complemento'] = Variable<String>(complemento.value);
    }
    if (bairro.present) {
      map['bairro'] = Variable<String>(bairro.value);
    }
    if (cidade.present) {
      map['cidade'] = Variable<String>(cidade.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (cep.present) {
      map['cep'] = Variable<String>(cep.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (celular.present) {
      map['celular'] = Variable<String>(celular.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (exibirLogo.present) {
      map['exibir_logo'] = Variable<bool>(exibirLogo.value);
    }
    if (caminhoLogo.present) {
      map['caminho_logo'] = Variable<String>(caminhoLogo.value);
    }
    if (mensagemRodape.present) {
      map['mensagem_rodape'] = Variable<String>(mensagemRodape.value);
    }
    if (exibirQrCode.present) {
      map['exibir_qr_code'] = Variable<bool>(exibirQrCode.value);
    }
    if (corPrimaria.present) {
      map['cor_primaria'] = Variable<String>(corPrimaria.value);
    }
    if (banco.present) {
      map['banco'] = Variable<String>(banco.value);
    }
    if (agencia.present) {
      map['agencia'] = Variable<String>(agencia.value);
    }
    if (conta.present) {
      map['conta'] = Variable<String>(conta.value);
    }
    if (pix.present) {
      map['pix'] = Variable<String>(pix.value);
    }
    if (regimeTributario.present) {
      map['regime_tributario'] = Variable<String>(regimeTributario.value);
    }
    if (emitirNfce.present) {
      map['emitir_nfce'] = Variable<bool>(emitirNfce.value);
    }
    if (certificadoA1Path.present) {
      map['certificado_a1_path'] = Variable<String>(certificadoA1Path.value);
    }
    if (senhaA1.present) {
      map['senha_a1'] = Variable<String>(senhaA1.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    if (atualizadoEm.present) {
      map['atualizado_em'] = Variable<DateTime>(atualizadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmpresaConfigsCompanion(')
          ..write('id: $id, ')
          ..write('nomeEmpresa: $nomeEmpresa, ')
          ..write('nomeFantasia: $nomeFantasia, ')
          ..write('tipoEmpresa: $tipoEmpresa, ')
          ..write('documento: $documento, ')
          ..write('inscricaoEstadual: $inscricaoEstadual, ')
          ..write('inscricaoMunicipal: $inscricaoMunicipal, ')
          ..write('endereco: $endereco, ')
          ..write('numero: $numero, ')
          ..write('complemento: $complemento, ')
          ..write('bairro: $bairro, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('cep: $cep, ')
          ..write('telefone: $telefone, ')
          ..write('celular: $celular, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('exibirLogo: $exibirLogo, ')
          ..write('caminhoLogo: $caminhoLogo, ')
          ..write('mensagemRodape: $mensagemRodape, ')
          ..write('exibirQrCode: $exibirQrCode, ')
          ..write('corPrimaria: $corPrimaria, ')
          ..write('banco: $banco, ')
          ..write('agencia: $agencia, ')
          ..write('conta: $conta, ')
          ..write('pix: $pix, ')
          ..write('regimeTributario: $regimeTributario, ')
          ..write('emitirNfce: $emitirNfce, ')
          ..write('certificadoA1Path: $certificadoA1Path, ')
          ..write('senhaA1: $senhaA1, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }
}

class $UsuarioTableTable extends UsuarioTable
    with TableInfo<$UsuarioTableTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuarioTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _senhaMeta = const VerificationMeta('senha');
  @override
  late final GeneratedColumn<String> senha = GeneratedColumn<String>(
      'senha', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _empresaMeta =
      const VerificationMeta('empresa');
  @override
  late final GeneratedColumn<String> empresa = GeneratedColumn<String>(
      'empresa', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cnpjMeta = const VerificationMeta('cnpj');
  @override
  late final GeneratedColumn<String> cnpj = GeneratedColumn<String>(
      'cnpj', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _enderecoMeta =
      const VerificationMeta('endereco');
  @override
  late final GeneratedColumn<String> endereco = GeneratedColumn<String>(
      'endereco', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cidadeMeta = const VerificationMeta('cidade');
  @override
  late final GeneratedColumn<String> cidade = GeneratedColumn<String>(
      'cidade', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cepMeta = const VerificationMeta('cep');
  @override
  late final GeneratedColumn<String> cep = GeneratedColumn<String>(
      'cep', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _logoPathMeta =
      const VerificationMeta('logoPath');
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
      'logo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _corPrimariaMeta =
      const VerificationMeta('corPrimaria');
  @override
  late final GeneratedColumn<String> corPrimaria = GeneratedColumn<String>(
      'cor_primaria', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _corSecundariaMeta =
      const VerificationMeta('corSecundaria');
  @override
  late final GeneratedColumn<String> corSecundaria = GeneratedColumn<String>(
      'cor_secundaria', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nomeFantasiaMeta =
      const VerificationMeta('nomeFantasia');
  @override
  late final GeneratedColumn<String> nomeFantasia = GeneratedColumn<String>(
      'nome_fantasia', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('user'));
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _atualizadoEmMeta =
      const VerificationMeta('atualizadoEm');
  @override
  late final GeneratedColumn<DateTime> atualizadoEm = GeneratedColumn<DateTime>(
      'atualizado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _ultimoLoginMeta =
      const VerificationMeta('ultimoLogin');
  @override
  late final GeneratedColumn<DateTime> ultimoLogin = GeneratedColumn<DateTime>(
      'ultimo_login', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nome,
        email,
        senha,
        empresa,
        cnpj,
        telefone,
        endereco,
        cidade,
        estado,
        cep,
        logoPath,
        corPrimaria,
        corSecundaria,
        nomeFantasia,
        role,
        ativo,
        criadoEm,
        atualizadoEm,
        ultimoLogin
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuario_table';
  @override
  VerificationContext validateIntegrity(Insertable<Usuario> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('senha')) {
      context.handle(
          _senhaMeta, senha.isAcceptableOrUnknown(data['senha']!, _senhaMeta));
    } else if (isInserting) {
      context.missing(_senhaMeta);
    }
    if (data.containsKey('empresa')) {
      context.handle(_empresaMeta,
          empresa.isAcceptableOrUnknown(data['empresa']!, _empresaMeta));
    } else if (isInserting) {
      context.missing(_empresaMeta);
    }
    if (data.containsKey('cnpj')) {
      context.handle(
          _cnpjMeta, cnpj.isAcceptableOrUnknown(data['cnpj']!, _cnpjMeta));
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    }
    if (data.containsKey('endereco')) {
      context.handle(_enderecoMeta,
          endereco.isAcceptableOrUnknown(data['endereco']!, _enderecoMeta));
    }
    if (data.containsKey('cidade')) {
      context.handle(_cidadeMeta,
          cidade.isAcceptableOrUnknown(data['cidade']!, _cidadeMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('cep')) {
      context.handle(
          _cepMeta, cep.isAcceptableOrUnknown(data['cep']!, _cepMeta));
    }
    if (data.containsKey('logo_path')) {
      context.handle(_logoPathMeta,
          logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta));
    }
    if (data.containsKey('cor_primaria')) {
      context.handle(
          _corPrimariaMeta,
          corPrimaria.isAcceptableOrUnknown(
              data['cor_primaria']!, _corPrimariaMeta));
    }
    if (data.containsKey('cor_secundaria')) {
      context.handle(
          _corSecundariaMeta,
          corSecundaria.isAcceptableOrUnknown(
              data['cor_secundaria']!, _corSecundariaMeta));
    }
    if (data.containsKey('nome_fantasia')) {
      context.handle(
          _nomeFantasiaMeta,
          nomeFantasia.isAcceptableOrUnknown(
              data['nome_fantasia']!, _nomeFantasiaMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    }
    if (data.containsKey('atualizado_em')) {
      context.handle(
          _atualizadoEmMeta,
          atualizadoEm.isAcceptableOrUnknown(
              data['atualizado_em']!, _atualizadoEmMeta));
    }
    if (data.containsKey('ultimo_login')) {
      context.handle(
          _ultimoLoginMeta,
          ultimoLogin.isAcceptableOrUnknown(
              data['ultimo_login']!, _ultimoLoginMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      senha: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}senha'])!,
      empresa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}empresa'])!,
      cnpj: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cnpj']),
      telefone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefone']),
      endereco: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endereco']),
      cidade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cidade']),
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado']),
      cep: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cep']),
      logoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_path']),
      corPrimaria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cor_primaria']),
      corSecundaria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cor_secundaria']),
      nomeFantasia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_fantasia']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
      atualizadoEm: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}atualizado_em'])!,
      ultimoLogin: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ultimo_login']),
    );
  }

  @override
  $UsuarioTableTable createAlias(String alias) {
    return $UsuarioTableTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int id;
  final String nome;
  final String email;
  final String senha;
  final String empresa;
  final String? cnpj;
  final String? telefone;
  final String? endereco;
  final String? cidade;
  final String? estado;
  final String? cep;
  final String? logoPath;
  final String? corPrimaria;
  final String? corSecundaria;
  final String? nomeFantasia;
  final String role;
  final bool ativo;
  final DateTime criadoEm;
  final DateTime atualizadoEm;
  final DateTime? ultimoLogin;
  const Usuario(
      {required this.id,
      required this.nome,
      required this.email,
      required this.senha,
      required this.empresa,
      this.cnpj,
      this.telefone,
      this.endereco,
      this.cidade,
      this.estado,
      this.cep,
      this.logoPath,
      this.corPrimaria,
      this.corSecundaria,
      this.nomeFantasia,
      required this.role,
      required this.ativo,
      required this.criadoEm,
      required this.atualizadoEm,
      this.ultimoLogin});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['email'] = Variable<String>(email);
    map['senha'] = Variable<String>(senha);
    map['empresa'] = Variable<String>(empresa);
    if (!nullToAbsent || cnpj != null) {
      map['cnpj'] = Variable<String>(cnpj);
    }
    if (!nullToAbsent || telefone != null) {
      map['telefone'] = Variable<String>(telefone);
    }
    if (!nullToAbsent || endereco != null) {
      map['endereco'] = Variable<String>(endereco);
    }
    if (!nullToAbsent || cidade != null) {
      map['cidade'] = Variable<String>(cidade);
    }
    if (!nullToAbsent || estado != null) {
      map['estado'] = Variable<String>(estado);
    }
    if (!nullToAbsent || cep != null) {
      map['cep'] = Variable<String>(cep);
    }
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    if (!nullToAbsent || corPrimaria != null) {
      map['cor_primaria'] = Variable<String>(corPrimaria);
    }
    if (!nullToAbsent || corSecundaria != null) {
      map['cor_secundaria'] = Variable<String>(corSecundaria);
    }
    if (!nullToAbsent || nomeFantasia != null) {
      map['nome_fantasia'] = Variable<String>(nomeFantasia);
    }
    map['role'] = Variable<String>(role);
    map['ativo'] = Variable<bool>(ativo);
    map['criado_em'] = Variable<DateTime>(criadoEm);
    map['atualizado_em'] = Variable<DateTime>(atualizadoEm);
    if (!nullToAbsent || ultimoLogin != null) {
      map['ultimo_login'] = Variable<DateTime>(ultimoLogin);
    }
    return map;
  }

  UsuarioTableCompanion toCompanion(bool nullToAbsent) {
    return UsuarioTableCompanion(
      id: Value(id),
      nome: Value(nome),
      email: Value(email),
      senha: Value(senha),
      empresa: Value(empresa),
      cnpj: cnpj == null && nullToAbsent ? const Value.absent() : Value(cnpj),
      telefone: telefone == null && nullToAbsent
          ? const Value.absent()
          : Value(telefone),
      endereco: endereco == null && nullToAbsent
          ? const Value.absent()
          : Value(endereco),
      cidade:
          cidade == null && nullToAbsent ? const Value.absent() : Value(cidade),
      estado:
          estado == null && nullToAbsent ? const Value.absent() : Value(estado),
      cep: cep == null && nullToAbsent ? const Value.absent() : Value(cep),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      corPrimaria: corPrimaria == null && nullToAbsent
          ? const Value.absent()
          : Value(corPrimaria),
      corSecundaria: corSecundaria == null && nullToAbsent
          ? const Value.absent()
          : Value(corSecundaria),
      nomeFantasia: nomeFantasia == null && nullToAbsent
          ? const Value.absent()
          : Value(nomeFantasia),
      role: Value(role),
      ativo: Value(ativo),
      criadoEm: Value(criadoEm),
      atualizadoEm: Value(atualizadoEm),
      ultimoLogin: ultimoLogin == null && nullToAbsent
          ? const Value.absent()
          : Value(ultimoLogin),
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      email: serializer.fromJson<String>(json['email']),
      senha: serializer.fromJson<String>(json['senha']),
      empresa: serializer.fromJson<String>(json['empresa']),
      cnpj: serializer.fromJson<String?>(json['cnpj']),
      telefone: serializer.fromJson<String?>(json['telefone']),
      endereco: serializer.fromJson<String?>(json['endereco']),
      cidade: serializer.fromJson<String?>(json['cidade']),
      estado: serializer.fromJson<String?>(json['estado']),
      cep: serializer.fromJson<String?>(json['cep']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      corPrimaria: serializer.fromJson<String?>(json['corPrimaria']),
      corSecundaria: serializer.fromJson<String?>(json['corSecundaria']),
      nomeFantasia: serializer.fromJson<String?>(json['nomeFantasia']),
      role: serializer.fromJson<String>(json['role']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
      atualizadoEm: serializer.fromJson<DateTime>(json['atualizadoEm']),
      ultimoLogin: serializer.fromJson<DateTime?>(json['ultimoLogin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'email': serializer.toJson<String>(email),
      'senha': serializer.toJson<String>(senha),
      'empresa': serializer.toJson<String>(empresa),
      'cnpj': serializer.toJson<String?>(cnpj),
      'telefone': serializer.toJson<String?>(telefone),
      'endereco': serializer.toJson<String?>(endereco),
      'cidade': serializer.toJson<String?>(cidade),
      'estado': serializer.toJson<String?>(estado),
      'cep': serializer.toJson<String?>(cep),
      'logoPath': serializer.toJson<String?>(logoPath),
      'corPrimaria': serializer.toJson<String?>(corPrimaria),
      'corSecundaria': serializer.toJson<String?>(corSecundaria),
      'nomeFantasia': serializer.toJson<String?>(nomeFantasia),
      'role': serializer.toJson<String>(role),
      'ativo': serializer.toJson<bool>(ativo),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
      'atualizadoEm': serializer.toJson<DateTime>(atualizadoEm),
      'ultimoLogin': serializer.toJson<DateTime?>(ultimoLogin),
    };
  }

  Usuario copyWith(
          {int? id,
          String? nome,
          String? email,
          String? senha,
          String? empresa,
          Value<String?> cnpj = const Value.absent(),
          Value<String?> telefone = const Value.absent(),
          Value<String?> endereco = const Value.absent(),
          Value<String?> cidade = const Value.absent(),
          Value<String?> estado = const Value.absent(),
          Value<String?> cep = const Value.absent(),
          Value<String?> logoPath = const Value.absent(),
          Value<String?> corPrimaria = const Value.absent(),
          Value<String?> corSecundaria = const Value.absent(),
          Value<String?> nomeFantasia = const Value.absent(),
          String? role,
          bool? ativo,
          DateTime? criadoEm,
          DateTime? atualizadoEm,
          Value<DateTime?> ultimoLogin = const Value.absent()}) =>
      Usuario(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        senha: senha ?? this.senha,
        empresa: empresa ?? this.empresa,
        cnpj: cnpj.present ? cnpj.value : this.cnpj,
        telefone: telefone.present ? telefone.value : this.telefone,
        endereco: endereco.present ? endereco.value : this.endereco,
        cidade: cidade.present ? cidade.value : this.cidade,
        estado: estado.present ? estado.value : this.estado,
        cep: cep.present ? cep.value : this.cep,
        logoPath: logoPath.present ? logoPath.value : this.logoPath,
        corPrimaria: corPrimaria.present ? corPrimaria.value : this.corPrimaria,
        corSecundaria:
            corSecundaria.present ? corSecundaria.value : this.corSecundaria,
        nomeFantasia:
            nomeFantasia.present ? nomeFantasia.value : this.nomeFantasia,
        role: role ?? this.role,
        ativo: ativo ?? this.ativo,
        criadoEm: criadoEm ?? this.criadoEm,
        atualizadoEm: atualizadoEm ?? this.atualizadoEm,
        ultimoLogin: ultimoLogin.present ? ultimoLogin.value : this.ultimoLogin,
      );
  Usuario copyWithCompanion(UsuarioTableCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      email: data.email.present ? data.email.value : this.email,
      senha: data.senha.present ? data.senha.value : this.senha,
      empresa: data.empresa.present ? data.empresa.value : this.empresa,
      cnpj: data.cnpj.present ? data.cnpj.value : this.cnpj,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
      endereco: data.endereco.present ? data.endereco.value : this.endereco,
      cidade: data.cidade.present ? data.cidade.value : this.cidade,
      estado: data.estado.present ? data.estado.value : this.estado,
      cep: data.cep.present ? data.cep.value : this.cep,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      corPrimaria:
          data.corPrimaria.present ? data.corPrimaria.value : this.corPrimaria,
      corSecundaria: data.corSecundaria.present
          ? data.corSecundaria.value
          : this.corSecundaria,
      nomeFantasia: data.nomeFantasia.present
          ? data.nomeFantasia.value
          : this.nomeFantasia,
      role: data.role.present ? data.role.value : this.role,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
      atualizadoEm: data.atualizadoEm.present
          ? data.atualizadoEm.value
          : this.atualizadoEm,
      ultimoLogin:
          data.ultimoLogin.present ? data.ultimoLogin.value : this.ultimoLogin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('senha: $senha, ')
          ..write('empresa: $empresa, ')
          ..write('cnpj: $cnpj, ')
          ..write('telefone: $telefone, ')
          ..write('endereco: $endereco, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('cep: $cep, ')
          ..write('logoPath: $logoPath, ')
          ..write('corPrimaria: $corPrimaria, ')
          ..write('corSecundaria: $corSecundaria, ')
          ..write('nomeFantasia: $nomeFantasia, ')
          ..write('role: $role, ')
          ..write('ativo: $ativo, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm, ')
          ..write('ultimoLogin: $ultimoLogin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nome,
      email,
      senha,
      empresa,
      cnpj,
      telefone,
      endereco,
      cidade,
      estado,
      cep,
      logoPath,
      corPrimaria,
      corSecundaria,
      nomeFantasia,
      role,
      ativo,
      criadoEm,
      atualizadoEm,
      ultimoLogin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.email == this.email &&
          other.senha == this.senha &&
          other.empresa == this.empresa &&
          other.cnpj == this.cnpj &&
          other.telefone == this.telefone &&
          other.endereco == this.endereco &&
          other.cidade == this.cidade &&
          other.estado == this.estado &&
          other.cep == this.cep &&
          other.logoPath == this.logoPath &&
          other.corPrimaria == this.corPrimaria &&
          other.corSecundaria == this.corSecundaria &&
          other.nomeFantasia == this.nomeFantasia &&
          other.role == this.role &&
          other.ativo == this.ativo &&
          other.criadoEm == this.criadoEm &&
          other.atualizadoEm == this.atualizadoEm &&
          other.ultimoLogin == this.ultimoLogin);
}

class UsuarioTableCompanion extends UpdateCompanion<Usuario> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> email;
  final Value<String> senha;
  final Value<String> empresa;
  final Value<String?> cnpj;
  final Value<String?> telefone;
  final Value<String?> endereco;
  final Value<String?> cidade;
  final Value<String?> estado;
  final Value<String?> cep;
  final Value<String?> logoPath;
  final Value<String?> corPrimaria;
  final Value<String?> corSecundaria;
  final Value<String?> nomeFantasia;
  final Value<String> role;
  final Value<bool> ativo;
  final Value<DateTime> criadoEm;
  final Value<DateTime> atualizadoEm;
  final Value<DateTime?> ultimoLogin;
  const UsuarioTableCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.email = const Value.absent(),
    this.senha = const Value.absent(),
    this.empresa = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.telefone = const Value.absent(),
    this.endereco = const Value.absent(),
    this.cidade = const Value.absent(),
    this.estado = const Value.absent(),
    this.cep = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.corPrimaria = const Value.absent(),
    this.corSecundaria = const Value.absent(),
    this.nomeFantasia = const Value.absent(),
    this.role = const Value.absent(),
    this.ativo = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
    this.ultimoLogin = const Value.absent(),
  });
  UsuarioTableCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String email,
    required String senha,
    required String empresa,
    this.cnpj = const Value.absent(),
    this.telefone = const Value.absent(),
    this.endereco = const Value.absent(),
    this.cidade = const Value.absent(),
    this.estado = const Value.absent(),
    this.cep = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.corPrimaria = const Value.absent(),
    this.corSecundaria = const Value.absent(),
    this.nomeFantasia = const Value.absent(),
    this.role = const Value.absent(),
    this.ativo = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
    this.ultimoLogin = const Value.absent(),
  })  : nome = Value(nome),
        email = Value(email),
        senha = Value(senha),
        empresa = Value(empresa);
  static Insertable<Usuario> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? email,
    Expression<String>? senha,
    Expression<String>? empresa,
    Expression<String>? cnpj,
    Expression<String>? telefone,
    Expression<String>? endereco,
    Expression<String>? cidade,
    Expression<String>? estado,
    Expression<String>? cep,
    Expression<String>? logoPath,
    Expression<String>? corPrimaria,
    Expression<String>? corSecundaria,
    Expression<String>? nomeFantasia,
    Expression<String>? role,
    Expression<bool>? ativo,
    Expression<DateTime>? criadoEm,
    Expression<DateTime>? atualizadoEm,
    Expression<DateTime>? ultimoLogin,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (email != null) 'email': email,
      if (senha != null) 'senha': senha,
      if (empresa != null) 'empresa': empresa,
      if (cnpj != null) 'cnpj': cnpj,
      if (telefone != null) 'telefone': telefone,
      if (endereco != null) 'endereco': endereco,
      if (cidade != null) 'cidade': cidade,
      if (estado != null) 'estado': estado,
      if (cep != null) 'cep': cep,
      if (logoPath != null) 'logo_path': logoPath,
      if (corPrimaria != null) 'cor_primaria': corPrimaria,
      if (corSecundaria != null) 'cor_secundaria': corSecundaria,
      if (nomeFantasia != null) 'nome_fantasia': nomeFantasia,
      if (role != null) 'role': role,
      if (ativo != null) 'ativo': ativo,
      if (criadoEm != null) 'criado_em': criadoEm,
      if (atualizadoEm != null) 'atualizado_em': atualizadoEm,
      if (ultimoLogin != null) 'ultimo_login': ultimoLogin,
    });
  }

  UsuarioTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? nome,
      Value<String>? email,
      Value<String>? senha,
      Value<String>? empresa,
      Value<String?>? cnpj,
      Value<String?>? telefone,
      Value<String?>? endereco,
      Value<String?>? cidade,
      Value<String?>? estado,
      Value<String?>? cep,
      Value<String?>? logoPath,
      Value<String?>? corPrimaria,
      Value<String?>? corSecundaria,
      Value<String?>? nomeFantasia,
      Value<String>? role,
      Value<bool>? ativo,
      Value<DateTime>? criadoEm,
      Value<DateTime>? atualizadoEm,
      Value<DateTime?>? ultimoLogin}) {
    return UsuarioTableCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      empresa: empresa ?? this.empresa,
      cnpj: cnpj ?? this.cnpj,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      logoPath: logoPath ?? this.logoPath,
      corPrimaria: corPrimaria ?? this.corPrimaria,
      corSecundaria: corSecundaria ?? this.corSecundaria,
      nomeFantasia: nomeFantasia ?? this.nomeFantasia,
      role: role ?? this.role,
      ativo: ativo ?? this.ativo,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
      ultimoLogin: ultimoLogin ?? this.ultimoLogin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (senha.present) {
      map['senha'] = Variable<String>(senha.value);
    }
    if (empresa.present) {
      map['empresa'] = Variable<String>(empresa.value);
    }
    if (cnpj.present) {
      map['cnpj'] = Variable<String>(cnpj.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (endereco.present) {
      map['endereco'] = Variable<String>(endereco.value);
    }
    if (cidade.present) {
      map['cidade'] = Variable<String>(cidade.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (cep.present) {
      map['cep'] = Variable<String>(cep.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (corPrimaria.present) {
      map['cor_primaria'] = Variable<String>(corPrimaria.value);
    }
    if (corSecundaria.present) {
      map['cor_secundaria'] = Variable<String>(corSecundaria.value);
    }
    if (nomeFantasia.present) {
      map['nome_fantasia'] = Variable<String>(nomeFantasia.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    if (atualizadoEm.present) {
      map['atualizado_em'] = Variable<DateTime>(atualizadoEm.value);
    }
    if (ultimoLogin.present) {
      map['ultimo_login'] = Variable<DateTime>(ultimoLogin.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioTableCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('senha: $senha, ')
          ..write('empresa: $empresa, ')
          ..write('cnpj: $cnpj, ')
          ..write('telefone: $telefone, ')
          ..write('endereco: $endereco, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('cep: $cep, ')
          ..write('logoPath: $logoPath, ')
          ..write('corPrimaria: $corPrimaria, ')
          ..write('corSecundaria: $corSecundaria, ')
          ..write('nomeFantasia: $nomeFantasia, ')
          ..write('role: $role, ')
          ..write('ativo: $ativo, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm, ')
          ..write('ultimoLogin: $ultimoLogin')
          ..write(')'))
        .toString();
  }
}

class $AssinaturaTableTable extends AssinaturaTable
    with TableInfo<$AssinaturaTableTable, Assinatura> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssinaturaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usuarioIdMeta =
      const VerificationMeta('usuarioId');
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
      'usuario_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario_table (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<TipoAssinatura, int> tipo =
      GeneratedColumn<int>('tipo', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TipoAssinatura>($AssinaturaTableTable.$convertertipo);
  @override
  late final GeneratedColumnWithTypeConverter<StatusAssinatura, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<StatusAssinatura>(
              $AssinaturaTableTable.$converterstatus);
  static const VerificationMeta _dataInicioMeta =
      const VerificationMeta('dataInicio');
  @override
  late final GeneratedColumn<DateTime> dataInicio = GeneratedColumn<DateTime>(
      'data_inicio', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dataFimMeta =
      const VerificationMeta('dataFim');
  @override
  late final GeneratedColumn<DateTime> dataFim = GeneratedColumn<DateTime>(
      'data_fim', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _atualizadoEmMeta =
      const VerificationMeta('atualizadoEm');
  @override
  late final GeneratedColumn<DateTime> atualizadoEm = GeneratedColumn<DateTime>(
      'atualizado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<double> valor = GeneratedColumn<double>(
      'valor', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _pagoMeta = const VerificationMeta('pago');
  @override
  late final GeneratedColumn<bool> pago = GeneratedColumn<bool>(
      'pago', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("pago" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _dataPagamentoMeta =
      const VerificationMeta('dataPagamento');
  @override
  late final GeneratedColumn<DateTime> dataPagamento =
      GeneratedColumn<DateTime>('data_pagamento', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _metodoPagamentoMeta =
      const VerificationMeta('metodoPagamento');
  @override
  late final GeneratedColumn<String> metodoPagamento = GeneratedColumn<String>(
      'metodo_pagamento', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transacaoIdMeta =
      const VerificationMeta('transacaoId');
  @override
  late final GeneratedColumn<String> transacaoId = GeneratedColumn<String>(
      'transacao_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _observacoesMeta =
      const VerificationMeta('observacoes');
  @override
  late final GeneratedColumn<String> observacoes = GeneratedColumn<String>(
      'observacoes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        usuarioId,
        tipo,
        status,
        dataInicio,
        dataFim,
        criadoEm,
        atualizadoEm,
        valor,
        pago,
        dataPagamento,
        metodoPagamento,
        transacaoId,
        observacoes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assinatura_table';
  @override
  VerificationContext validateIntegrity(Insertable<Assinatura> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(_usuarioIdMeta,
          usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta));
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('data_inicio')) {
      context.handle(
          _dataInicioMeta,
          dataInicio.isAcceptableOrUnknown(
              data['data_inicio']!, _dataInicioMeta));
    } else if (isInserting) {
      context.missing(_dataInicioMeta);
    }
    if (data.containsKey('data_fim')) {
      context.handle(_dataFimMeta,
          dataFim.isAcceptableOrUnknown(data['data_fim']!, _dataFimMeta));
    } else if (isInserting) {
      context.missing(_dataFimMeta);
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    }
    if (data.containsKey('atualizado_em')) {
      context.handle(
          _atualizadoEmMeta,
          atualizadoEm.isAcceptableOrUnknown(
              data['atualizado_em']!, _atualizadoEmMeta));
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    }
    if (data.containsKey('pago')) {
      context.handle(
          _pagoMeta, pago.isAcceptableOrUnknown(data['pago']!, _pagoMeta));
    }
    if (data.containsKey('data_pagamento')) {
      context.handle(
          _dataPagamentoMeta,
          dataPagamento.isAcceptableOrUnknown(
              data['data_pagamento']!, _dataPagamentoMeta));
    }
    if (data.containsKey('metodo_pagamento')) {
      context.handle(
          _metodoPagamentoMeta,
          metodoPagamento.isAcceptableOrUnknown(
              data['metodo_pagamento']!, _metodoPagamentoMeta));
    }
    if (data.containsKey('transacao_id')) {
      context.handle(
          _transacaoIdMeta,
          transacaoId.isAcceptableOrUnknown(
              data['transacao_id']!, _transacaoIdMeta));
    }
    if (data.containsKey('observacoes')) {
      context.handle(
          _observacoesMeta,
          observacoes.isAcceptableOrUnknown(
              data['observacoes']!, _observacoesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Assinatura map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Assinatura(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      usuarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usuario_id'])!,
      tipo: $AssinaturaTableTable.$convertertipo.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tipo'])!),
      status: $AssinaturaTableTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      dataInicio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_inicio'])!,
      dataFim: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_fim'])!,
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
      atualizadoEm: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}atualizado_em'])!,
      valor: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor']),
      pago: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pago'])!,
      dataPagamento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_pagamento']),
      metodoPagamento: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}metodo_pagamento']),
      transacaoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transacao_id']),
      observacoes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacoes']),
    );
  }

  @override
  $AssinaturaTableTable createAlias(String alias) {
    return $AssinaturaTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TipoAssinatura, int, int> $convertertipo =
      const EnumIndexConverter<TipoAssinatura>(TipoAssinatura.values);
  static JsonTypeConverter2<StatusAssinatura, int, int> $converterstatus =
      const EnumIndexConverter<StatusAssinatura>(StatusAssinatura.values);
}

class Assinatura extends DataClass implements Insertable<Assinatura> {
  final int id;
  final int usuarioId;
  final TipoAssinatura tipo;
  final StatusAssinatura status;
  final DateTime dataInicio;
  final DateTime dataFim;
  final DateTime criadoEm;
  final DateTime atualizadoEm;
  final double? valor;
  final bool pago;
  final DateTime? dataPagamento;
  final String? metodoPagamento;
  final String? transacaoId;
  final String? observacoes;
  const Assinatura(
      {required this.id,
      required this.usuarioId,
      required this.tipo,
      required this.status,
      required this.dataInicio,
      required this.dataFim,
      required this.criadoEm,
      required this.atualizadoEm,
      this.valor,
      required this.pago,
      this.dataPagamento,
      this.metodoPagamento,
      this.transacaoId,
      this.observacoes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<int>(usuarioId);
    {
      map['tipo'] =
          Variable<int>($AssinaturaTableTable.$convertertipo.toSql(tipo));
    }
    {
      map['status'] =
          Variable<int>($AssinaturaTableTable.$converterstatus.toSql(status));
    }
    map['data_inicio'] = Variable<DateTime>(dataInicio);
    map['data_fim'] = Variable<DateTime>(dataFim);
    map['criado_em'] = Variable<DateTime>(criadoEm);
    map['atualizado_em'] = Variable<DateTime>(atualizadoEm);
    if (!nullToAbsent || valor != null) {
      map['valor'] = Variable<double>(valor);
    }
    map['pago'] = Variable<bool>(pago);
    if (!nullToAbsent || dataPagamento != null) {
      map['data_pagamento'] = Variable<DateTime>(dataPagamento);
    }
    if (!nullToAbsent || metodoPagamento != null) {
      map['metodo_pagamento'] = Variable<String>(metodoPagamento);
    }
    if (!nullToAbsent || transacaoId != null) {
      map['transacao_id'] = Variable<String>(transacaoId);
    }
    if (!nullToAbsent || observacoes != null) {
      map['observacoes'] = Variable<String>(observacoes);
    }
    return map;
  }

  AssinaturaTableCompanion toCompanion(bool nullToAbsent) {
    return AssinaturaTableCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      tipo: Value(tipo),
      status: Value(status),
      dataInicio: Value(dataInicio),
      dataFim: Value(dataFim),
      criadoEm: Value(criadoEm),
      atualizadoEm: Value(atualizadoEm),
      valor:
          valor == null && nullToAbsent ? const Value.absent() : Value(valor),
      pago: Value(pago),
      dataPagamento: dataPagamento == null && nullToAbsent
          ? const Value.absent()
          : Value(dataPagamento),
      metodoPagamento: metodoPagamento == null && nullToAbsent
          ? const Value.absent()
          : Value(metodoPagamento),
      transacaoId: transacaoId == null && nullToAbsent
          ? const Value.absent()
          : Value(transacaoId),
      observacoes: observacoes == null && nullToAbsent
          ? const Value.absent()
          : Value(observacoes),
    );
  }

  factory Assinatura.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Assinatura(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      tipo: $AssinaturaTableTable.$convertertipo
          .fromJson(serializer.fromJson<int>(json['tipo'])),
      status: $AssinaturaTableTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      dataInicio: serializer.fromJson<DateTime>(json['dataInicio']),
      dataFim: serializer.fromJson<DateTime>(json['dataFim']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
      atualizadoEm: serializer.fromJson<DateTime>(json['atualizadoEm']),
      valor: serializer.fromJson<double?>(json['valor']),
      pago: serializer.fromJson<bool>(json['pago']),
      dataPagamento: serializer.fromJson<DateTime?>(json['dataPagamento']),
      metodoPagamento: serializer.fromJson<String?>(json['metodoPagamento']),
      transacaoId: serializer.fromJson<String?>(json['transacaoId']),
      observacoes: serializer.fromJson<String?>(json['observacoes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'tipo': serializer
          .toJson<int>($AssinaturaTableTable.$convertertipo.toJson(tipo)),
      'status': serializer
          .toJson<int>($AssinaturaTableTable.$converterstatus.toJson(status)),
      'dataInicio': serializer.toJson<DateTime>(dataInicio),
      'dataFim': serializer.toJson<DateTime>(dataFim),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
      'atualizadoEm': serializer.toJson<DateTime>(atualizadoEm),
      'valor': serializer.toJson<double?>(valor),
      'pago': serializer.toJson<bool>(pago),
      'dataPagamento': serializer.toJson<DateTime?>(dataPagamento),
      'metodoPagamento': serializer.toJson<String?>(metodoPagamento),
      'transacaoId': serializer.toJson<String?>(transacaoId),
      'observacoes': serializer.toJson<String?>(observacoes),
    };
  }

  Assinatura copyWith(
          {int? id,
          int? usuarioId,
          TipoAssinatura? tipo,
          StatusAssinatura? status,
          DateTime? dataInicio,
          DateTime? dataFim,
          DateTime? criadoEm,
          DateTime? atualizadoEm,
          Value<double?> valor = const Value.absent(),
          bool? pago,
          Value<DateTime?> dataPagamento = const Value.absent(),
          Value<String?> metodoPagamento = const Value.absent(),
          Value<String?> transacaoId = const Value.absent(),
          Value<String?> observacoes = const Value.absent()}) =>
      Assinatura(
        id: id ?? this.id,
        usuarioId: usuarioId ?? this.usuarioId,
        tipo: tipo ?? this.tipo,
        status: status ?? this.status,
        dataInicio: dataInicio ?? this.dataInicio,
        dataFim: dataFim ?? this.dataFim,
        criadoEm: criadoEm ?? this.criadoEm,
        atualizadoEm: atualizadoEm ?? this.atualizadoEm,
        valor: valor.present ? valor.value : this.valor,
        pago: pago ?? this.pago,
        dataPagamento:
            dataPagamento.present ? dataPagamento.value : this.dataPagamento,
        metodoPagamento: metodoPagamento.present
            ? metodoPagamento.value
            : this.metodoPagamento,
        transacaoId: transacaoId.present ? transacaoId.value : this.transacaoId,
        observacoes: observacoes.present ? observacoes.value : this.observacoes,
      );
  Assinatura copyWithCompanion(AssinaturaTableCompanion data) {
    return Assinatura(
      id: data.id.present ? data.id.value : this.id,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      status: data.status.present ? data.status.value : this.status,
      dataInicio:
          data.dataInicio.present ? data.dataInicio.value : this.dataInicio,
      dataFim: data.dataFim.present ? data.dataFim.value : this.dataFim,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
      atualizadoEm: data.atualizadoEm.present
          ? data.atualizadoEm.value
          : this.atualizadoEm,
      valor: data.valor.present ? data.valor.value : this.valor,
      pago: data.pago.present ? data.pago.value : this.pago,
      dataPagamento: data.dataPagamento.present
          ? data.dataPagamento.value
          : this.dataPagamento,
      metodoPagamento: data.metodoPagamento.present
          ? data.metodoPagamento.value
          : this.metodoPagamento,
      transacaoId:
          data.transacaoId.present ? data.transacaoId.value : this.transacaoId,
      observacoes:
          data.observacoes.present ? data.observacoes.value : this.observacoes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Assinatura(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('tipo: $tipo, ')
          ..write('status: $status, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm, ')
          ..write('valor: $valor, ')
          ..write('pago: $pago, ')
          ..write('dataPagamento: $dataPagamento, ')
          ..write('metodoPagamento: $metodoPagamento, ')
          ..write('transacaoId: $transacaoId, ')
          ..write('observacoes: $observacoes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      usuarioId,
      tipo,
      status,
      dataInicio,
      dataFim,
      criadoEm,
      atualizadoEm,
      valor,
      pago,
      dataPagamento,
      metodoPagamento,
      transacaoId,
      observacoes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Assinatura &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.tipo == this.tipo &&
          other.status == this.status &&
          other.dataInicio == this.dataInicio &&
          other.dataFim == this.dataFim &&
          other.criadoEm == this.criadoEm &&
          other.atualizadoEm == this.atualizadoEm &&
          other.valor == this.valor &&
          other.pago == this.pago &&
          other.dataPagamento == this.dataPagamento &&
          other.metodoPagamento == this.metodoPagamento &&
          other.transacaoId == this.transacaoId &&
          other.observacoes == this.observacoes);
}

class AssinaturaTableCompanion extends UpdateCompanion<Assinatura> {
  final Value<int> id;
  final Value<int> usuarioId;
  final Value<TipoAssinatura> tipo;
  final Value<StatusAssinatura> status;
  final Value<DateTime> dataInicio;
  final Value<DateTime> dataFim;
  final Value<DateTime> criadoEm;
  final Value<DateTime> atualizadoEm;
  final Value<double?> valor;
  final Value<bool> pago;
  final Value<DateTime?> dataPagamento;
  final Value<String?> metodoPagamento;
  final Value<String?> transacaoId;
  final Value<String?> observacoes;
  const AssinaturaTableCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.status = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataFim = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
    this.valor = const Value.absent(),
    this.pago = const Value.absent(),
    this.dataPagamento = const Value.absent(),
    this.metodoPagamento = const Value.absent(),
    this.transacaoId = const Value.absent(),
    this.observacoes = const Value.absent(),
  });
  AssinaturaTableCompanion.insert({
    this.id = const Value.absent(),
    required int usuarioId,
    required TipoAssinatura tipo,
    this.status = const Value.absent(),
    required DateTime dataInicio,
    required DateTime dataFim,
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
    this.valor = const Value.absent(),
    this.pago = const Value.absent(),
    this.dataPagamento = const Value.absent(),
    this.metodoPagamento = const Value.absent(),
    this.transacaoId = const Value.absent(),
    this.observacoes = const Value.absent(),
  })  : usuarioId = Value(usuarioId),
        tipo = Value(tipo),
        dataInicio = Value(dataInicio),
        dataFim = Value(dataFim);
  static Insertable<Assinatura> custom({
    Expression<int>? id,
    Expression<int>? usuarioId,
    Expression<int>? tipo,
    Expression<int>? status,
    Expression<DateTime>? dataInicio,
    Expression<DateTime>? dataFim,
    Expression<DateTime>? criadoEm,
    Expression<DateTime>? atualizadoEm,
    Expression<double>? valor,
    Expression<bool>? pago,
    Expression<DateTime>? dataPagamento,
    Expression<String>? metodoPagamento,
    Expression<String>? transacaoId,
    Expression<String>? observacoes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (tipo != null) 'tipo': tipo,
      if (status != null) 'status': status,
      if (dataInicio != null) 'data_inicio': dataInicio,
      if (dataFim != null) 'data_fim': dataFim,
      if (criadoEm != null) 'criado_em': criadoEm,
      if (atualizadoEm != null) 'atualizado_em': atualizadoEm,
      if (valor != null) 'valor': valor,
      if (pago != null) 'pago': pago,
      if (dataPagamento != null) 'data_pagamento': dataPagamento,
      if (metodoPagamento != null) 'metodo_pagamento': metodoPagamento,
      if (transacaoId != null) 'transacao_id': transacaoId,
      if (observacoes != null) 'observacoes': observacoes,
    });
  }

  AssinaturaTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? usuarioId,
      Value<TipoAssinatura>? tipo,
      Value<StatusAssinatura>? status,
      Value<DateTime>? dataInicio,
      Value<DateTime>? dataFim,
      Value<DateTime>? criadoEm,
      Value<DateTime>? atualizadoEm,
      Value<double?>? valor,
      Value<bool>? pago,
      Value<DateTime?>? dataPagamento,
      Value<String?>? metodoPagamento,
      Value<String?>? transacaoId,
      Value<String?>? observacoes}) {
    return AssinaturaTableCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      tipo: tipo ?? this.tipo,
      status: status ?? this.status,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
      valor: valor ?? this.valor,
      pago: pago ?? this.pago,
      dataPagamento: dataPagamento ?? this.dataPagamento,
      metodoPagamento: metodoPagamento ?? this.metodoPagamento,
      transacaoId: transacaoId ?? this.transacaoId,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (tipo.present) {
      map['tipo'] =
          Variable<int>($AssinaturaTableTable.$convertertipo.toSql(tipo.value));
    }
    if (status.present) {
      map['status'] = Variable<int>(
          $AssinaturaTableTable.$converterstatus.toSql(status.value));
    }
    if (dataInicio.present) {
      map['data_inicio'] = Variable<DateTime>(dataInicio.value);
    }
    if (dataFim.present) {
      map['data_fim'] = Variable<DateTime>(dataFim.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    if (atualizadoEm.present) {
      map['atualizado_em'] = Variable<DateTime>(atualizadoEm.value);
    }
    if (valor.present) {
      map['valor'] = Variable<double>(valor.value);
    }
    if (pago.present) {
      map['pago'] = Variable<bool>(pago.value);
    }
    if (dataPagamento.present) {
      map['data_pagamento'] = Variable<DateTime>(dataPagamento.value);
    }
    if (metodoPagamento.present) {
      map['metodo_pagamento'] = Variable<String>(metodoPagamento.value);
    }
    if (transacaoId.present) {
      map['transacao_id'] = Variable<String>(transacaoId.value);
    }
    if (observacoes.present) {
      map['observacoes'] = Variable<String>(observacoes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssinaturaTableCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('tipo: $tipo, ')
          ..write('status: $status, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm, ')
          ..write('valor: $valor, ')
          ..write('pago: $pago, ')
          ..write('dataPagamento: $dataPagamento, ')
          ..write('metodoPagamento: $metodoPagamento, ')
          ..write('transacaoId: $transacaoId, ')
          ..write('observacoes: $observacoes')
          ..write(')'))
        .toString();
  }
}

class $WhatsAppMessagesTableTable extends WhatsAppMessagesTable
    with TableInfo<$WhatsAppMessagesTableTable, WhatsAppMessagesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WhatsAppMessagesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clienteIdMeta =
      const VerificationMeta('clienteId');
  @override
  late final GeneratedColumn<String> clienteId = GeneratedColumn<String>(
      'cliente_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mensagemMeta =
      const VerificationMeta('mensagem');
  @override
  late final GeneratedColumn<String> mensagem = GeneratedColumn<String>(
      'mensagem', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pendente'));
  static const VerificationMeta _dataEnvioMeta =
      const VerificationMeta('dataEnvio');
  @override
  late final GeneratedColumn<DateTime> dataEnvio = GeneratedColumn<DateTime>(
      'data_envio', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dataEntregaMeta =
      const VerificationMeta('dataEntrega');
  @override
  late final GeneratedColumn<DateTime> dataEntrega = GeneratedColumn<DateTime>(
      'data_entrega', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dataLeituraMeta =
      const VerificationMeta('dataLeitura');
  @override
  late final GeneratedColumn<DateTime> dataLeitura = GeneratedColumn<DateTime>(
      'data_leitura', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _erroMeta = const VerificationMeta('erro');
  @override
  late final GeneratedColumn<String> erro = GeneratedColumn<String>(
      'erro', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clienteId,
        telefone,
        mensagem,
        tipo,
        status,
        dataEnvio,
        dataEntrega,
        dataLeitura,
        erro,
        metadata,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'whatsapp_messages';
  @override
  VerificationContext validateIntegrity(
      Insertable<WhatsAppMessagesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cliente_id')) {
      context.handle(_clienteIdMeta,
          clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta));
    } else if (isInserting) {
      context.missing(_clienteIdMeta);
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    } else if (isInserting) {
      context.missing(_telefoneMeta);
    }
    if (data.containsKey('mensagem')) {
      context.handle(_mensagemMeta,
          mensagem.isAcceptableOrUnknown(data['mensagem']!, _mensagemMeta));
    } else if (isInserting) {
      context.missing(_mensagemMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('data_envio')) {
      context.handle(_dataEnvioMeta,
          dataEnvio.isAcceptableOrUnknown(data['data_envio']!, _dataEnvioMeta));
    }
    if (data.containsKey('data_entrega')) {
      context.handle(
          _dataEntregaMeta,
          dataEntrega.isAcceptableOrUnknown(
              data['data_entrega']!, _dataEntregaMeta));
    }
    if (data.containsKey('data_leitura')) {
      context.handle(
          _dataLeituraMeta,
          dataLeitura.isAcceptableOrUnknown(
              data['data_leitura']!, _dataLeituraMeta));
    }
    if (data.containsKey('erro')) {
      context.handle(
          _erroMeta, erro.isAcceptableOrUnknown(data['erro']!, _erroMeta));
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WhatsAppMessagesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WhatsAppMessagesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cliente_id'])!,
      telefone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefone'])!,
      mensagem: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mensagem'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      dataEnvio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_envio']),
      dataEntrega: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_entrega']),
      dataLeitura: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_leitura']),
      erro: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}erro']),
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WhatsAppMessagesTableTable createAlias(String alias) {
    return $WhatsAppMessagesTableTable(attachedDatabase, alias);
  }
}

class WhatsAppMessagesTableData extends DataClass
    implements Insertable<WhatsAppMessagesTableData> {
  final int id;
  final String clienteId;
  final String telefone;
  final String mensagem;
  final String tipo;
  final String status;
  final DateTime? dataEnvio;
  final DateTime? dataEntrega;
  final DateTime? dataLeitura;
  final String? erro;
  final String? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WhatsAppMessagesTableData(
      {required this.id,
      required this.clienteId,
      required this.telefone,
      required this.mensagem,
      required this.tipo,
      required this.status,
      this.dataEnvio,
      this.dataEntrega,
      this.dataLeitura,
      this.erro,
      this.metadata,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cliente_id'] = Variable<String>(clienteId);
    map['telefone'] = Variable<String>(telefone);
    map['mensagem'] = Variable<String>(mensagem);
    map['tipo'] = Variable<String>(tipo);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || dataEnvio != null) {
      map['data_envio'] = Variable<DateTime>(dataEnvio);
    }
    if (!nullToAbsent || dataEntrega != null) {
      map['data_entrega'] = Variable<DateTime>(dataEntrega);
    }
    if (!nullToAbsent || dataLeitura != null) {
      map['data_leitura'] = Variable<DateTime>(dataLeitura);
    }
    if (!nullToAbsent || erro != null) {
      map['erro'] = Variable<String>(erro);
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WhatsAppMessagesTableCompanion toCompanion(bool nullToAbsent) {
    return WhatsAppMessagesTableCompanion(
      id: Value(id),
      clienteId: Value(clienteId),
      telefone: Value(telefone),
      mensagem: Value(mensagem),
      tipo: Value(tipo),
      status: Value(status),
      dataEnvio: dataEnvio == null && nullToAbsent
          ? const Value.absent()
          : Value(dataEnvio),
      dataEntrega: dataEntrega == null && nullToAbsent
          ? const Value.absent()
          : Value(dataEntrega),
      dataLeitura: dataLeitura == null && nullToAbsent
          ? const Value.absent()
          : Value(dataLeitura),
      erro: erro == null && nullToAbsent ? const Value.absent() : Value(erro),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WhatsAppMessagesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WhatsAppMessagesTableData(
      id: serializer.fromJson<int>(json['id']),
      clienteId: serializer.fromJson<String>(json['clienteId']),
      telefone: serializer.fromJson<String>(json['telefone']),
      mensagem: serializer.fromJson<String>(json['mensagem']),
      tipo: serializer.fromJson<String>(json['tipo']),
      status: serializer.fromJson<String>(json['status']),
      dataEnvio: serializer.fromJson<DateTime?>(json['dataEnvio']),
      dataEntrega: serializer.fromJson<DateTime?>(json['dataEntrega']),
      dataLeitura: serializer.fromJson<DateTime?>(json['dataLeitura']),
      erro: serializer.fromJson<String?>(json['erro']),
      metadata: serializer.fromJson<String?>(json['metadata']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clienteId': serializer.toJson<String>(clienteId),
      'telefone': serializer.toJson<String>(telefone),
      'mensagem': serializer.toJson<String>(mensagem),
      'tipo': serializer.toJson<String>(tipo),
      'status': serializer.toJson<String>(status),
      'dataEnvio': serializer.toJson<DateTime?>(dataEnvio),
      'dataEntrega': serializer.toJson<DateTime?>(dataEntrega),
      'dataLeitura': serializer.toJson<DateTime?>(dataLeitura),
      'erro': serializer.toJson<String?>(erro),
      'metadata': serializer.toJson<String?>(metadata),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WhatsAppMessagesTableData copyWith(
          {int? id,
          String? clienteId,
          String? telefone,
          String? mensagem,
          String? tipo,
          String? status,
          Value<DateTime?> dataEnvio = const Value.absent(),
          Value<DateTime?> dataEntrega = const Value.absent(),
          Value<DateTime?> dataLeitura = const Value.absent(),
          Value<String?> erro = const Value.absent(),
          Value<String?> metadata = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      WhatsAppMessagesTableData(
        id: id ?? this.id,
        clienteId: clienteId ?? this.clienteId,
        telefone: telefone ?? this.telefone,
        mensagem: mensagem ?? this.mensagem,
        tipo: tipo ?? this.tipo,
        status: status ?? this.status,
        dataEnvio: dataEnvio.present ? dataEnvio.value : this.dataEnvio,
        dataEntrega: dataEntrega.present ? dataEntrega.value : this.dataEntrega,
        dataLeitura: dataLeitura.present ? dataLeitura.value : this.dataLeitura,
        erro: erro.present ? erro.value : this.erro,
        metadata: metadata.present ? metadata.value : this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WhatsAppMessagesTableData copyWithCompanion(
      WhatsAppMessagesTableCompanion data) {
    return WhatsAppMessagesTableData(
      id: data.id.present ? data.id.value : this.id,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
      mensagem: data.mensagem.present ? data.mensagem.value : this.mensagem,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      status: data.status.present ? data.status.value : this.status,
      dataEnvio: data.dataEnvio.present ? data.dataEnvio.value : this.dataEnvio,
      dataEntrega:
          data.dataEntrega.present ? data.dataEntrega.value : this.dataEntrega,
      dataLeitura:
          data.dataLeitura.present ? data.dataLeitura.value : this.dataLeitura,
      erro: data.erro.present ? data.erro.value : this.erro,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WhatsAppMessagesTableData(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('telefone: $telefone, ')
          ..write('mensagem: $mensagem, ')
          ..write('tipo: $tipo, ')
          ..write('status: $status, ')
          ..write('dataEnvio: $dataEnvio, ')
          ..write('dataEntrega: $dataEntrega, ')
          ..write('dataLeitura: $dataLeitura, ')
          ..write('erro: $erro, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      clienteId,
      telefone,
      mensagem,
      tipo,
      status,
      dataEnvio,
      dataEntrega,
      dataLeitura,
      erro,
      metadata,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WhatsAppMessagesTableData &&
          other.id == this.id &&
          other.clienteId == this.clienteId &&
          other.telefone == this.telefone &&
          other.mensagem == this.mensagem &&
          other.tipo == this.tipo &&
          other.status == this.status &&
          other.dataEnvio == this.dataEnvio &&
          other.dataEntrega == this.dataEntrega &&
          other.dataLeitura == this.dataLeitura &&
          other.erro == this.erro &&
          other.metadata == this.metadata &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WhatsAppMessagesTableCompanion
    extends UpdateCompanion<WhatsAppMessagesTableData> {
  final Value<int> id;
  final Value<String> clienteId;
  final Value<String> telefone;
  final Value<String> mensagem;
  final Value<String> tipo;
  final Value<String> status;
  final Value<DateTime?> dataEnvio;
  final Value<DateTime?> dataEntrega;
  final Value<DateTime?> dataLeitura;
  final Value<String?> erro;
  final Value<String?> metadata;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WhatsAppMessagesTableCompanion({
    this.id = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.telefone = const Value.absent(),
    this.mensagem = const Value.absent(),
    this.tipo = const Value.absent(),
    this.status = const Value.absent(),
    this.dataEnvio = const Value.absent(),
    this.dataEntrega = const Value.absent(),
    this.dataLeitura = const Value.absent(),
    this.erro = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WhatsAppMessagesTableCompanion.insert({
    this.id = const Value.absent(),
    required String clienteId,
    required String telefone,
    required String mensagem,
    required String tipo,
    this.status = const Value.absent(),
    this.dataEnvio = const Value.absent(),
    this.dataEntrega = const Value.absent(),
    this.dataLeitura = const Value.absent(),
    this.erro = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : clienteId = Value(clienteId),
        telefone = Value(telefone),
        mensagem = Value(mensagem),
        tipo = Value(tipo);
  static Insertable<WhatsAppMessagesTableData> custom({
    Expression<int>? id,
    Expression<String>? clienteId,
    Expression<String>? telefone,
    Expression<String>? mensagem,
    Expression<String>? tipo,
    Expression<String>? status,
    Expression<DateTime>? dataEnvio,
    Expression<DateTime>? dataEntrega,
    Expression<DateTime>? dataLeitura,
    Expression<String>? erro,
    Expression<String>? metadata,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clienteId != null) 'cliente_id': clienteId,
      if (telefone != null) 'telefone': telefone,
      if (mensagem != null) 'mensagem': mensagem,
      if (tipo != null) 'tipo': tipo,
      if (status != null) 'status': status,
      if (dataEnvio != null) 'data_envio': dataEnvio,
      if (dataEntrega != null) 'data_entrega': dataEntrega,
      if (dataLeitura != null) 'data_leitura': dataLeitura,
      if (erro != null) 'erro': erro,
      if (metadata != null) 'metadata': metadata,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WhatsAppMessagesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? clienteId,
      Value<String>? telefone,
      Value<String>? mensagem,
      Value<String>? tipo,
      Value<String>? status,
      Value<DateTime?>? dataEnvio,
      Value<DateTime?>? dataEntrega,
      Value<DateTime?>? dataLeitura,
      Value<String?>? erro,
      Value<String?>? metadata,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return WhatsAppMessagesTableCompanion(
      id: id ?? this.id,
      clienteId: clienteId ?? this.clienteId,
      telefone: telefone ?? this.telefone,
      mensagem: mensagem ?? this.mensagem,
      tipo: tipo ?? this.tipo,
      status: status ?? this.status,
      dataEnvio: dataEnvio ?? this.dataEnvio,
      dataEntrega: dataEntrega ?? this.dataEntrega,
      dataLeitura: dataLeitura ?? this.dataLeitura,
      erro: erro ?? this.erro,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<String>(clienteId.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (mensagem.present) {
      map['mensagem'] = Variable<String>(mensagem.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dataEnvio.present) {
      map['data_envio'] = Variable<DateTime>(dataEnvio.value);
    }
    if (dataEntrega.present) {
      map['data_entrega'] = Variable<DateTime>(dataEntrega.value);
    }
    if (dataLeitura.present) {
      map['data_leitura'] = Variable<DateTime>(dataLeitura.value);
    }
    if (erro.present) {
      map['erro'] = Variable<String>(erro.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WhatsAppMessagesTableCompanion(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('telefone: $telefone, ')
          ..write('mensagem: $mensagem, ')
          ..write('tipo: $tipo, ')
          ..write('status: $status, ')
          ..write('dataEnvio: $dataEnvio, ')
          ..write('dataEntrega: $dataEntrega, ')
          ..write('dataLeitura: $dataLeitura, ')
          ..write('erro: $erro, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WhatsAppConfigTableTable extends WhatsAppConfigTable
    with TableInfo<$WhatsAppConfigTableTable, WhatsAppConfigTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WhatsAppConfigTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _apiUrlMeta = const VerificationMeta('apiUrl');
  @override
  late final GeneratedColumn<String> apiUrl = GeneratedColumn<String>(
      'api_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _apiTokenMeta =
      const VerificationMeta('apiToken');
  @override
  late final GeneratedColumn<String> apiToken = GeneratedColumn<String>(
      'api_token', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _instanceIdMeta =
      const VerificationMeta('instanceId');
  @override
  late final GeneratedColumn<String> instanceId = GeneratedColumn<String>(
      'instance_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _enviarAgendamentoMeta =
      const VerificationMeta('enviarAgendamento');
  @override
  late final GeneratedColumn<bool> enviarAgendamento = GeneratedColumn<bool>(
      'enviar_agendamento', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enviar_agendamento" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _enviarLembretesMeta =
      const VerificationMeta('enviarLembretes');
  @override
  late final GeneratedColumn<bool> enviarLembretes = GeneratedColumn<bool>(
      'enviar_lembretes', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enviar_lembretes" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _enviarConfirmacoesMeta =
      const VerificationMeta('enviarConfirmacoes');
  @override
  late final GeneratedColumn<bool> enviarConfirmacoes = GeneratedColumn<bool>(
      'enviar_confirmacoes', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enviar_confirmacoes" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _enviarPromocoesMeta =
      const VerificationMeta('enviarPromocoes');
  @override
  late final GeneratedColumn<bool> enviarPromocoes = GeneratedColumn<bool>(
      'enviar_promocoes', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enviar_promocoes" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _horasAntesLembreteMeta =
      const VerificationMeta('horasAntesLembrete');
  @override
  late final GeneratedColumn<int> horasAntesLembrete = GeneratedColumn<int>(
      'horas_antes_lembrete', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(24));
  static const VerificationMeta _horarioInicioEnvioMeta =
      const VerificationMeta('horarioInicioEnvio');
  @override
  late final GeneratedColumn<String> horarioInicioEnvio =
      GeneratedColumn<String>('horario_inicio_envio', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('08:00'));
  static const VerificationMeta _horarioFimEnvioMeta =
      const VerificationMeta('horarioFimEnvio');
  @override
  late final GeneratedColumn<String> horarioFimEnvio = GeneratedColumn<String>(
      'horario_fim_envio', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('18:00'));
  static const VerificationMeta _diasSemanaEnvioMeta =
      const VerificationMeta('diasSemanaEnvio');
  @override
  late final GeneratedColumn<String> diasSemanaEnvio = GeneratedColumn<String>(
      'dias_semana_envio', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[1,2,3,4,5,6]'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        apiUrl,
        apiToken,
        instanceId,
        ativo,
        enviarAgendamento,
        enviarLembretes,
        enviarConfirmacoes,
        enviarPromocoes,
        horasAntesLembrete,
        horarioInicioEnvio,
        horarioFimEnvio,
        diasSemanaEnvio,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'whatsapp_config';
  @override
  VerificationContext validateIntegrity(
      Insertable<WhatsAppConfigTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('api_url')) {
      context.handle(_apiUrlMeta,
          apiUrl.isAcceptableOrUnknown(data['api_url']!, _apiUrlMeta));
    } else if (isInserting) {
      context.missing(_apiUrlMeta);
    }
    if (data.containsKey('api_token')) {
      context.handle(_apiTokenMeta,
          apiToken.isAcceptableOrUnknown(data['api_token']!, _apiTokenMeta));
    } else if (isInserting) {
      context.missing(_apiTokenMeta);
    }
    if (data.containsKey('instance_id')) {
      context.handle(
          _instanceIdMeta,
          instanceId.isAcceptableOrUnknown(
              data['instance_id']!, _instanceIdMeta));
    } else if (isInserting) {
      context.missing(_instanceIdMeta);
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('enviar_agendamento')) {
      context.handle(
          _enviarAgendamentoMeta,
          enviarAgendamento.isAcceptableOrUnknown(
              data['enviar_agendamento']!, _enviarAgendamentoMeta));
    }
    if (data.containsKey('enviar_lembretes')) {
      context.handle(
          _enviarLembretesMeta,
          enviarLembretes.isAcceptableOrUnknown(
              data['enviar_lembretes']!, _enviarLembretesMeta));
    }
    if (data.containsKey('enviar_confirmacoes')) {
      context.handle(
          _enviarConfirmacoesMeta,
          enviarConfirmacoes.isAcceptableOrUnknown(
              data['enviar_confirmacoes']!, _enviarConfirmacoesMeta));
    }
    if (data.containsKey('enviar_promocoes')) {
      context.handle(
          _enviarPromocoesMeta,
          enviarPromocoes.isAcceptableOrUnknown(
              data['enviar_promocoes']!, _enviarPromocoesMeta));
    }
    if (data.containsKey('horas_antes_lembrete')) {
      context.handle(
          _horasAntesLembreteMeta,
          horasAntesLembrete.isAcceptableOrUnknown(
              data['horas_antes_lembrete']!, _horasAntesLembreteMeta));
    }
    if (data.containsKey('horario_inicio_envio')) {
      context.handle(
          _horarioInicioEnvioMeta,
          horarioInicioEnvio.isAcceptableOrUnknown(
              data['horario_inicio_envio']!, _horarioInicioEnvioMeta));
    }
    if (data.containsKey('horario_fim_envio')) {
      context.handle(
          _horarioFimEnvioMeta,
          horarioFimEnvio.isAcceptableOrUnknown(
              data['horario_fim_envio']!, _horarioFimEnvioMeta));
    }
    if (data.containsKey('dias_semana_envio')) {
      context.handle(
          _diasSemanaEnvioMeta,
          diasSemanaEnvio.isAcceptableOrUnknown(
              data['dias_semana_envio']!, _diasSemanaEnvioMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WhatsAppConfigTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WhatsAppConfigTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      apiUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}api_url'])!,
      apiToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}api_token'])!,
      instanceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instance_id'])!,
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      enviarAgendamento: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}enviar_agendamento'])!,
      enviarLembretes: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enviar_lembretes'])!,
      enviarConfirmacoes: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}enviar_confirmacoes'])!,
      enviarPromocoes: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enviar_promocoes'])!,
      horasAntesLembrete: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}horas_antes_lembrete'])!,
      horarioInicioEnvio: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}horario_inicio_envio'])!,
      horarioFimEnvio: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}horario_fim_envio'])!,
      diasSemanaEnvio: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}dias_semana_envio'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WhatsAppConfigTableTable createAlias(String alias) {
    return $WhatsAppConfigTableTable(attachedDatabase, alias);
  }
}

class WhatsAppConfigTableData extends DataClass
    implements Insertable<WhatsAppConfigTableData> {
  final int id;
  final String apiUrl;
  final String apiToken;
  final String instanceId;
  final bool ativo;
  final bool enviarAgendamento;
  final bool enviarLembretes;
  final bool enviarConfirmacoes;
  final bool enviarPromocoes;
  final int horasAntesLembrete;
  final String horarioInicioEnvio;
  final String horarioFimEnvio;
  final String diasSemanaEnvio;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WhatsAppConfigTableData(
      {required this.id,
      required this.apiUrl,
      required this.apiToken,
      required this.instanceId,
      required this.ativo,
      required this.enviarAgendamento,
      required this.enviarLembretes,
      required this.enviarConfirmacoes,
      required this.enviarPromocoes,
      required this.horasAntesLembrete,
      required this.horarioInicioEnvio,
      required this.horarioFimEnvio,
      required this.diasSemanaEnvio,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['api_url'] = Variable<String>(apiUrl);
    map['api_token'] = Variable<String>(apiToken);
    map['instance_id'] = Variable<String>(instanceId);
    map['ativo'] = Variable<bool>(ativo);
    map['enviar_agendamento'] = Variable<bool>(enviarAgendamento);
    map['enviar_lembretes'] = Variable<bool>(enviarLembretes);
    map['enviar_confirmacoes'] = Variable<bool>(enviarConfirmacoes);
    map['enviar_promocoes'] = Variable<bool>(enviarPromocoes);
    map['horas_antes_lembrete'] = Variable<int>(horasAntesLembrete);
    map['horario_inicio_envio'] = Variable<String>(horarioInicioEnvio);
    map['horario_fim_envio'] = Variable<String>(horarioFimEnvio);
    map['dias_semana_envio'] = Variable<String>(diasSemanaEnvio);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WhatsAppConfigTableCompanion toCompanion(bool nullToAbsent) {
    return WhatsAppConfigTableCompanion(
      id: Value(id),
      apiUrl: Value(apiUrl),
      apiToken: Value(apiToken),
      instanceId: Value(instanceId),
      ativo: Value(ativo),
      enviarAgendamento: Value(enviarAgendamento),
      enviarLembretes: Value(enviarLembretes),
      enviarConfirmacoes: Value(enviarConfirmacoes),
      enviarPromocoes: Value(enviarPromocoes),
      horasAntesLembrete: Value(horasAntesLembrete),
      horarioInicioEnvio: Value(horarioInicioEnvio),
      horarioFimEnvio: Value(horarioFimEnvio),
      diasSemanaEnvio: Value(diasSemanaEnvio),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WhatsAppConfigTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WhatsAppConfigTableData(
      id: serializer.fromJson<int>(json['id']),
      apiUrl: serializer.fromJson<String>(json['apiUrl']),
      apiToken: serializer.fromJson<String>(json['apiToken']),
      instanceId: serializer.fromJson<String>(json['instanceId']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      enviarAgendamento: serializer.fromJson<bool>(json['enviarAgendamento']),
      enviarLembretes: serializer.fromJson<bool>(json['enviarLembretes']),
      enviarConfirmacoes: serializer.fromJson<bool>(json['enviarConfirmacoes']),
      enviarPromocoes: serializer.fromJson<bool>(json['enviarPromocoes']),
      horasAntesLembrete: serializer.fromJson<int>(json['horasAntesLembrete']),
      horarioInicioEnvio:
          serializer.fromJson<String>(json['horarioInicioEnvio']),
      horarioFimEnvio: serializer.fromJson<String>(json['horarioFimEnvio']),
      diasSemanaEnvio: serializer.fromJson<String>(json['diasSemanaEnvio']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'apiUrl': serializer.toJson<String>(apiUrl),
      'apiToken': serializer.toJson<String>(apiToken),
      'instanceId': serializer.toJson<String>(instanceId),
      'ativo': serializer.toJson<bool>(ativo),
      'enviarAgendamento': serializer.toJson<bool>(enviarAgendamento),
      'enviarLembretes': serializer.toJson<bool>(enviarLembretes),
      'enviarConfirmacoes': serializer.toJson<bool>(enviarConfirmacoes),
      'enviarPromocoes': serializer.toJson<bool>(enviarPromocoes),
      'horasAntesLembrete': serializer.toJson<int>(horasAntesLembrete),
      'horarioInicioEnvio': serializer.toJson<String>(horarioInicioEnvio),
      'horarioFimEnvio': serializer.toJson<String>(horarioFimEnvio),
      'diasSemanaEnvio': serializer.toJson<String>(diasSemanaEnvio),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WhatsAppConfigTableData copyWith(
          {int? id,
          String? apiUrl,
          String? apiToken,
          String? instanceId,
          bool? ativo,
          bool? enviarAgendamento,
          bool? enviarLembretes,
          bool? enviarConfirmacoes,
          bool? enviarPromocoes,
          int? horasAntesLembrete,
          String? horarioInicioEnvio,
          String? horarioFimEnvio,
          String? diasSemanaEnvio,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      WhatsAppConfigTableData(
        id: id ?? this.id,
        apiUrl: apiUrl ?? this.apiUrl,
        apiToken: apiToken ?? this.apiToken,
        instanceId: instanceId ?? this.instanceId,
        ativo: ativo ?? this.ativo,
        enviarAgendamento: enviarAgendamento ?? this.enviarAgendamento,
        enviarLembretes: enviarLembretes ?? this.enviarLembretes,
        enviarConfirmacoes: enviarConfirmacoes ?? this.enviarConfirmacoes,
        enviarPromocoes: enviarPromocoes ?? this.enviarPromocoes,
        horasAntesLembrete: horasAntesLembrete ?? this.horasAntesLembrete,
        horarioInicioEnvio: horarioInicioEnvio ?? this.horarioInicioEnvio,
        horarioFimEnvio: horarioFimEnvio ?? this.horarioFimEnvio,
        diasSemanaEnvio: diasSemanaEnvio ?? this.diasSemanaEnvio,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WhatsAppConfigTableData copyWithCompanion(WhatsAppConfigTableCompanion data) {
    return WhatsAppConfigTableData(
      id: data.id.present ? data.id.value : this.id,
      apiUrl: data.apiUrl.present ? data.apiUrl.value : this.apiUrl,
      apiToken: data.apiToken.present ? data.apiToken.value : this.apiToken,
      instanceId:
          data.instanceId.present ? data.instanceId.value : this.instanceId,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      enviarAgendamento: data.enviarAgendamento.present
          ? data.enviarAgendamento.value
          : this.enviarAgendamento,
      enviarLembretes: data.enviarLembretes.present
          ? data.enviarLembretes.value
          : this.enviarLembretes,
      enviarConfirmacoes: data.enviarConfirmacoes.present
          ? data.enviarConfirmacoes.value
          : this.enviarConfirmacoes,
      enviarPromocoes: data.enviarPromocoes.present
          ? data.enviarPromocoes.value
          : this.enviarPromocoes,
      horasAntesLembrete: data.horasAntesLembrete.present
          ? data.horasAntesLembrete.value
          : this.horasAntesLembrete,
      horarioInicioEnvio: data.horarioInicioEnvio.present
          ? data.horarioInicioEnvio.value
          : this.horarioInicioEnvio,
      horarioFimEnvio: data.horarioFimEnvio.present
          ? data.horarioFimEnvio.value
          : this.horarioFimEnvio,
      diasSemanaEnvio: data.diasSemanaEnvio.present
          ? data.diasSemanaEnvio.value
          : this.diasSemanaEnvio,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WhatsAppConfigTableData(')
          ..write('id: $id, ')
          ..write('apiUrl: $apiUrl, ')
          ..write('apiToken: $apiToken, ')
          ..write('instanceId: $instanceId, ')
          ..write('ativo: $ativo, ')
          ..write('enviarAgendamento: $enviarAgendamento, ')
          ..write('enviarLembretes: $enviarLembretes, ')
          ..write('enviarConfirmacoes: $enviarConfirmacoes, ')
          ..write('enviarPromocoes: $enviarPromocoes, ')
          ..write('horasAntesLembrete: $horasAntesLembrete, ')
          ..write('horarioInicioEnvio: $horarioInicioEnvio, ')
          ..write('horarioFimEnvio: $horarioFimEnvio, ')
          ..write('diasSemanaEnvio: $diasSemanaEnvio, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      apiUrl,
      apiToken,
      instanceId,
      ativo,
      enviarAgendamento,
      enviarLembretes,
      enviarConfirmacoes,
      enviarPromocoes,
      horasAntesLembrete,
      horarioInicioEnvio,
      horarioFimEnvio,
      diasSemanaEnvio,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WhatsAppConfigTableData &&
          other.id == this.id &&
          other.apiUrl == this.apiUrl &&
          other.apiToken == this.apiToken &&
          other.instanceId == this.instanceId &&
          other.ativo == this.ativo &&
          other.enviarAgendamento == this.enviarAgendamento &&
          other.enviarLembretes == this.enviarLembretes &&
          other.enviarConfirmacoes == this.enviarConfirmacoes &&
          other.enviarPromocoes == this.enviarPromocoes &&
          other.horasAntesLembrete == this.horasAntesLembrete &&
          other.horarioInicioEnvio == this.horarioInicioEnvio &&
          other.horarioFimEnvio == this.horarioFimEnvio &&
          other.diasSemanaEnvio == this.diasSemanaEnvio &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WhatsAppConfigTableCompanion
    extends UpdateCompanion<WhatsAppConfigTableData> {
  final Value<int> id;
  final Value<String> apiUrl;
  final Value<String> apiToken;
  final Value<String> instanceId;
  final Value<bool> ativo;
  final Value<bool> enviarAgendamento;
  final Value<bool> enviarLembretes;
  final Value<bool> enviarConfirmacoes;
  final Value<bool> enviarPromocoes;
  final Value<int> horasAntesLembrete;
  final Value<String> horarioInicioEnvio;
  final Value<String> horarioFimEnvio;
  final Value<String> diasSemanaEnvio;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WhatsAppConfigTableCompanion({
    this.id = const Value.absent(),
    this.apiUrl = const Value.absent(),
    this.apiToken = const Value.absent(),
    this.instanceId = const Value.absent(),
    this.ativo = const Value.absent(),
    this.enviarAgendamento = const Value.absent(),
    this.enviarLembretes = const Value.absent(),
    this.enviarConfirmacoes = const Value.absent(),
    this.enviarPromocoes = const Value.absent(),
    this.horasAntesLembrete = const Value.absent(),
    this.horarioInicioEnvio = const Value.absent(),
    this.horarioFimEnvio = const Value.absent(),
    this.diasSemanaEnvio = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WhatsAppConfigTableCompanion.insert({
    this.id = const Value.absent(),
    required String apiUrl,
    required String apiToken,
    required String instanceId,
    this.ativo = const Value.absent(),
    this.enviarAgendamento = const Value.absent(),
    this.enviarLembretes = const Value.absent(),
    this.enviarConfirmacoes = const Value.absent(),
    this.enviarPromocoes = const Value.absent(),
    this.horasAntesLembrete = const Value.absent(),
    this.horarioInicioEnvio = const Value.absent(),
    this.horarioFimEnvio = const Value.absent(),
    this.diasSemanaEnvio = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : apiUrl = Value(apiUrl),
        apiToken = Value(apiToken),
        instanceId = Value(instanceId);
  static Insertable<WhatsAppConfigTableData> custom({
    Expression<int>? id,
    Expression<String>? apiUrl,
    Expression<String>? apiToken,
    Expression<String>? instanceId,
    Expression<bool>? ativo,
    Expression<bool>? enviarAgendamento,
    Expression<bool>? enviarLembretes,
    Expression<bool>? enviarConfirmacoes,
    Expression<bool>? enviarPromocoes,
    Expression<int>? horasAntesLembrete,
    Expression<String>? horarioInicioEnvio,
    Expression<String>? horarioFimEnvio,
    Expression<String>? diasSemanaEnvio,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (apiUrl != null) 'api_url': apiUrl,
      if (apiToken != null) 'api_token': apiToken,
      if (instanceId != null) 'instance_id': instanceId,
      if (ativo != null) 'ativo': ativo,
      if (enviarAgendamento != null) 'enviar_agendamento': enviarAgendamento,
      if (enviarLembretes != null) 'enviar_lembretes': enviarLembretes,
      if (enviarConfirmacoes != null) 'enviar_confirmacoes': enviarConfirmacoes,
      if (enviarPromocoes != null) 'enviar_promocoes': enviarPromocoes,
      if (horasAntesLembrete != null)
        'horas_antes_lembrete': horasAntesLembrete,
      if (horarioInicioEnvio != null)
        'horario_inicio_envio': horarioInicioEnvio,
      if (horarioFimEnvio != null) 'horario_fim_envio': horarioFimEnvio,
      if (diasSemanaEnvio != null) 'dias_semana_envio': diasSemanaEnvio,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WhatsAppConfigTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? apiUrl,
      Value<String>? apiToken,
      Value<String>? instanceId,
      Value<bool>? ativo,
      Value<bool>? enviarAgendamento,
      Value<bool>? enviarLembretes,
      Value<bool>? enviarConfirmacoes,
      Value<bool>? enviarPromocoes,
      Value<int>? horasAntesLembrete,
      Value<String>? horarioInicioEnvio,
      Value<String>? horarioFimEnvio,
      Value<String>? diasSemanaEnvio,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return WhatsAppConfigTableCompanion(
      id: id ?? this.id,
      apiUrl: apiUrl ?? this.apiUrl,
      apiToken: apiToken ?? this.apiToken,
      instanceId: instanceId ?? this.instanceId,
      ativo: ativo ?? this.ativo,
      enviarAgendamento: enviarAgendamento ?? this.enviarAgendamento,
      enviarLembretes: enviarLembretes ?? this.enviarLembretes,
      enviarConfirmacoes: enviarConfirmacoes ?? this.enviarConfirmacoes,
      enviarPromocoes: enviarPromocoes ?? this.enviarPromocoes,
      horasAntesLembrete: horasAntesLembrete ?? this.horasAntesLembrete,
      horarioInicioEnvio: horarioInicioEnvio ?? this.horarioInicioEnvio,
      horarioFimEnvio: horarioFimEnvio ?? this.horarioFimEnvio,
      diasSemanaEnvio: diasSemanaEnvio ?? this.diasSemanaEnvio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (apiUrl.present) {
      map['api_url'] = Variable<String>(apiUrl.value);
    }
    if (apiToken.present) {
      map['api_token'] = Variable<String>(apiToken.value);
    }
    if (instanceId.present) {
      map['instance_id'] = Variable<String>(instanceId.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (enviarAgendamento.present) {
      map['enviar_agendamento'] = Variable<bool>(enviarAgendamento.value);
    }
    if (enviarLembretes.present) {
      map['enviar_lembretes'] = Variable<bool>(enviarLembretes.value);
    }
    if (enviarConfirmacoes.present) {
      map['enviar_confirmacoes'] = Variable<bool>(enviarConfirmacoes.value);
    }
    if (enviarPromocoes.present) {
      map['enviar_promocoes'] = Variable<bool>(enviarPromocoes.value);
    }
    if (horasAntesLembrete.present) {
      map['horas_antes_lembrete'] = Variable<int>(horasAntesLembrete.value);
    }
    if (horarioInicioEnvio.present) {
      map['horario_inicio_envio'] = Variable<String>(horarioInicioEnvio.value);
    }
    if (horarioFimEnvio.present) {
      map['horario_fim_envio'] = Variable<String>(horarioFimEnvio.value);
    }
    if (diasSemanaEnvio.present) {
      map['dias_semana_envio'] = Variable<String>(diasSemanaEnvio.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WhatsAppConfigTableCompanion(')
          ..write('id: $id, ')
          ..write('apiUrl: $apiUrl, ')
          ..write('apiToken: $apiToken, ')
          ..write('instanceId: $instanceId, ')
          ..write('ativo: $ativo, ')
          ..write('enviarAgendamento: $enviarAgendamento, ')
          ..write('enviarLembretes: $enviarLembretes, ')
          ..write('enviarConfirmacoes: $enviarConfirmacoes, ')
          ..write('enviarPromocoes: $enviarPromocoes, ')
          ..write('horasAntesLembrete: $horasAntesLembrete, ')
          ..write('horarioInicioEnvio: $horarioInicioEnvio, ')
          ..write('horarioFimEnvio: $horarioFimEnvio, ')
          ..write('diasSemanaEnvio: $diasSemanaEnvio, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProdutoTableTable produtoTable = $ProdutoTableTable(this);
  late final $FornecedorTableTable fornecedorTable =
      $FornecedorTableTable(this);
  late final $PedidoCompraTableTable pedidoCompraTable =
      $PedidoCompraTableTable(this);
  late final $ItemCompraTableTable itemCompraTable =
      $ItemCompraTableTable(this);
  late final $VendaTableTable vendaTable = $VendaTableTable(this);
  late final $ItemVendaTableTable itemVendaTable = $ItemVendaTableTable(this);
  late final $ClienteTableTable clienteTable = $ClienteTableTable(this);
  late final $ServicosTableTable servicosTable = $ServicosTableTable(this);
  late final $OrcamentoTableTable orcamentoTable = $OrcamentoTableTable(this);
  late final $ItemOrcamentoTableTable itemOrcamentoTable =
      $ItemOrcamentoTableTable(this);
  late final $OrdensServicoTableTable ordensServicoTable =
      $OrdensServicoTableTable(this);
  late final $ItensOrdemServicoTableTable itensOrdemServicoTable =
      $ItensOrdemServicoTableTable(this);
  late final $AuditoriaTableTable auditoriaTable = $AuditoriaTableTable(this);
  late final $EmpresaConfigsTable empresaConfigs = $EmpresaConfigsTable(this);
  late final $UsuarioTableTable usuarioTable = $UsuarioTableTable(this);
  late final $AssinaturaTableTable assinaturaTable =
      $AssinaturaTableTable(this);
  late final $WhatsAppMessagesTableTable whatsAppMessagesTable =
      $WhatsAppMessagesTableTable(this);
  late final $WhatsAppConfigTableTable whatsAppConfigTable =
      $WhatsAppConfigTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        produtoTable,
        fornecedorTable,
        pedidoCompraTable,
        itemCompraTable,
        vendaTable,
        itemVendaTable,
        clienteTable,
        servicosTable,
        orcamentoTable,
        itemOrcamentoTable,
        ordensServicoTable,
        itensOrdemServicoTable,
        auditoriaTable,
        empresaConfigs,
        usuarioTable,
        assinaturaTable,
        whatsAppMessagesTable,
        whatsAppConfigTable
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('vendas',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('itens_venda', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$ProdutoTableTableCreateCompanionBuilder = ProdutoTableCompanion
    Function({
  Value<int> id,
  required String codigo,
  required String nome,
  Value<String?> descricao,
  Value<double> precoCompra,
  required double precoVenda,
  Value<int> estoqueMinimo,
  Value<int> quantidade,
  Value<String> unidade,
  Value<String?> categoria,
  Value<String?> codigoBarras,
  Value<String?> qrCode,
  Value<String?> imagemPath,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ProdutoTableTableUpdateCompanionBuilder = ProdutoTableCompanion
    Function({
  Value<int> id,
  Value<String> codigo,
  Value<String> nome,
  Value<String?> descricao,
  Value<double> precoCompra,
  Value<double> precoVenda,
  Value<int> estoqueMinimo,
  Value<int> quantidade,
  Value<String> unidade,
  Value<String?> categoria,
  Value<String?> codigoBarras,
  Value<String?> qrCode,
  Value<String?> imagemPath,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ProdutoTableTableReferences extends BaseReferences<_$AppDatabase,
    $ProdutoTableTable, ProdutoTableData> {
  $$ProdutoTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItemCompraTableTable, List<ItemCompraData>>
      _itemCompraTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.itemCompraTable,
              aliasName: $_aliasNameGenerator(
                  db.produtoTable.id, db.itemCompraTable.produtoId));

  $$ItemCompraTableTableProcessedTableManager get itemCompraTableRefs {
    final manager =
        $$ItemCompraTableTableTableManager($_db, $_db.itemCompraTable)
            .filter((f) => f.produtoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_itemCompraTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ItemVendaTableTable, List<ItemVenda>>
      _itemVendaTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.itemVendaTable,
              aliasName: $_aliasNameGenerator(
                  db.produtoTable.id, db.itemVendaTable.produtoId));

  $$ItemVendaTableTableProcessedTableManager get itemVendaTableRefs {
    final manager = $$ItemVendaTableTableTableManager($_db, $_db.itemVendaTable)
        .filter((f) => f.produtoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemVendaTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProdutoTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProdutoTableTable> {
  $$ProdutoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precoCompra => $composableBuilder(
      column: $table.precoCompra, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precoVenda => $composableBuilder(
      column: $table.precoVenda, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get estoqueMinimo => $composableBuilder(
      column: $table.estoqueMinimo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unidade => $composableBuilder(
      column: $table.unidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigoBarras => $composableBuilder(
      column: $table.codigoBarras, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get qrCode => $composableBuilder(
      column: $table.qrCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagemPath => $composableBuilder(
      column: $table.imagemPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> itemCompraTableRefs(
      Expression<bool> Function($$ItemCompraTableTableFilterComposer f) f) {
    final $$ItemCompraTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemCompraTable,
        getReferencedColumn: (t) => t.produtoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemCompraTableTableFilterComposer(
              $db: $db,
              $table: $db.itemCompraTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> itemVendaTableRefs(
      Expression<bool> Function($$ItemVendaTableTableFilterComposer f) f) {
    final $$ItemVendaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemVendaTable,
        getReferencedColumn: (t) => t.produtoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemVendaTableTableFilterComposer(
              $db: $db,
              $table: $db.itemVendaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProdutoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProdutoTableTable> {
  $$ProdutoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precoCompra => $composableBuilder(
      column: $table.precoCompra, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precoVenda => $composableBuilder(
      column: $table.precoVenda, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get estoqueMinimo => $composableBuilder(
      column: $table.estoqueMinimo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unidade => $composableBuilder(
      column: $table.unidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigoBarras => $composableBuilder(
      column: $table.codigoBarras,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get qrCode => $composableBuilder(
      column: $table.qrCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagemPath => $composableBuilder(
      column: $table.imagemPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProdutoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProdutoTableTable> {
  $$ProdutoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<double> get precoCompra => $composableBuilder(
      column: $table.precoCompra, builder: (column) => column);

  GeneratedColumn<double> get precoVenda => $composableBuilder(
      column: $table.precoVenda, builder: (column) => column);

  GeneratedColumn<int> get estoqueMinimo => $composableBuilder(
      column: $table.estoqueMinimo, builder: (column) => column);

  GeneratedColumn<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => column);

  GeneratedColumn<String> get unidade =>
      $composableBuilder(column: $table.unidade, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<String> get codigoBarras => $composableBuilder(
      column: $table.codigoBarras, builder: (column) => column);

  GeneratedColumn<String> get qrCode =>
      $composableBuilder(column: $table.qrCode, builder: (column) => column);

  GeneratedColumn<String> get imagemPath => $composableBuilder(
      column: $table.imagemPath, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> itemCompraTableRefs<T extends Object>(
      Expression<T> Function($$ItemCompraTableTableAnnotationComposer a) f) {
    final $$ItemCompraTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemCompraTable,
        getReferencedColumn: (t) => t.produtoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemCompraTableTableAnnotationComposer(
              $db: $db,
              $table: $db.itemCompraTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> itemVendaTableRefs<T extends Object>(
      Expression<T> Function($$ItemVendaTableTableAnnotationComposer a) f) {
    final $$ItemVendaTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemVendaTable,
        getReferencedColumn: (t) => t.produtoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemVendaTableTableAnnotationComposer(
              $db: $db,
              $table: $db.itemVendaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProdutoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProdutoTableTable,
    ProdutoTableData,
    $$ProdutoTableTableFilterComposer,
    $$ProdutoTableTableOrderingComposer,
    $$ProdutoTableTableAnnotationComposer,
    $$ProdutoTableTableCreateCompanionBuilder,
    $$ProdutoTableTableUpdateCompanionBuilder,
    (ProdutoTableData, $$ProdutoTableTableReferences),
    ProdutoTableData,
    PrefetchHooks Function(
        {bool itemCompraTableRefs, bool itemVendaTableRefs})> {
  $$ProdutoTableTableTableManager(_$AppDatabase db, $ProdutoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProdutoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProdutoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProdutoTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> codigo = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
            Value<double> precoCompra = const Value.absent(),
            Value<double> precoVenda = const Value.absent(),
            Value<int> estoqueMinimo = const Value.absent(),
            Value<int> quantidade = const Value.absent(),
            Value<String> unidade = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
            Value<String?> codigoBarras = const Value.absent(),
            Value<String?> qrCode = const Value.absent(),
            Value<String?> imagemPath = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ProdutoTableCompanion(
            id: id,
            codigo: codigo,
            nome: nome,
            descricao: descricao,
            precoCompra: precoCompra,
            precoVenda: precoVenda,
            estoqueMinimo: estoqueMinimo,
            quantidade: quantidade,
            unidade: unidade,
            categoria: categoria,
            codigoBarras: codigoBarras,
            qrCode: qrCode,
            imagemPath: imagemPath,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String codigo,
            required String nome,
            Value<String?> descricao = const Value.absent(),
            Value<double> precoCompra = const Value.absent(),
            required double precoVenda,
            Value<int> estoqueMinimo = const Value.absent(),
            Value<int> quantidade = const Value.absent(),
            Value<String> unidade = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
            Value<String?> codigoBarras = const Value.absent(),
            Value<String?> qrCode = const Value.absent(),
            Value<String?> imagemPath = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ProdutoTableCompanion.insert(
            id: id,
            codigo: codigo,
            nome: nome,
            descricao: descricao,
            precoCompra: precoCompra,
            precoVenda: precoVenda,
            estoqueMinimo: estoqueMinimo,
            quantidade: quantidade,
            unidade: unidade,
            categoria: categoria,
            codigoBarras: codigoBarras,
            qrCode: qrCode,
            imagemPath: imagemPath,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProdutoTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {itemCompraTableRefs = false, itemVendaTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (itemCompraTableRefs) db.itemCompraTable,
                if (itemVendaTableRefs) db.itemVendaTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemCompraTableRefs)
                    await $_getPrefetchedData<ProdutoTableData,
                            $ProdutoTableTable, ItemCompraData>(
                        currentTable: table,
                        referencedTable: $$ProdutoTableTableReferences
                            ._itemCompraTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProdutoTableTableReferences(db, table, p0)
                                .itemCompraTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.produtoId == item.id),
                        typedResults: items),
                  if (itemVendaTableRefs)
                    await $_getPrefetchedData<ProdutoTableData,
                            $ProdutoTableTable, ItemVenda>(
                        currentTable: table,
                        referencedTable: $$ProdutoTableTableReferences
                            ._itemVendaTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProdutoTableTableReferences(db, table, p0)
                                .itemVendaTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.produtoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProdutoTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProdutoTableTable,
    ProdutoTableData,
    $$ProdutoTableTableFilterComposer,
    $$ProdutoTableTableOrderingComposer,
    $$ProdutoTableTableAnnotationComposer,
    $$ProdutoTableTableCreateCompanionBuilder,
    $$ProdutoTableTableUpdateCompanionBuilder,
    (ProdutoTableData, $$ProdutoTableTableReferences),
    ProdutoTableData,
    PrefetchHooks Function(
        {bool itemCompraTableRefs, bool itemVendaTableRefs})>;
typedef $$FornecedorTableTableCreateCompanionBuilder = FornecedorTableCompanion
    Function({
  Value<int> id,
  required String nome,
  Value<String?> razaoSocial,
  Value<String?> cnpj,
  Value<String?> cpf,
  Value<String?> email,
  Value<String?> telefone,
  Value<String?> endereco,
  Value<String?> cidade,
  Value<String?> estado,
  Value<String?> cep,
  Value<bool> ativo,
  Value<DateTime> criadoEm,
  Value<DateTime> atualizadoEm,
});
typedef $$FornecedorTableTableUpdateCompanionBuilder = FornecedorTableCompanion
    Function({
  Value<int> id,
  Value<String> nome,
  Value<String?> razaoSocial,
  Value<String?> cnpj,
  Value<String?> cpf,
  Value<String?> email,
  Value<String?> telefone,
  Value<String?> endereco,
  Value<String?> cidade,
  Value<String?> estado,
  Value<String?> cep,
  Value<bool> ativo,
  Value<DateTime> criadoEm,
  Value<DateTime> atualizadoEm,
});

final class $$FornecedorTableTableReferences extends BaseReferences<
    _$AppDatabase, $FornecedorTableTable, FornecedorData> {
  $$FornecedorTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PedidoCompraTableTable, List<PedidoCompraData>>
      _pedidoCompraTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.pedidoCompraTable,
              aliasName: $_aliasNameGenerator(
                  db.fornecedorTable.id, db.pedidoCompraTable.fornecedorId));

  $$PedidoCompraTableTableProcessedTableManager get pedidoCompraTableRefs {
    final manager = $$PedidoCompraTableTableTableManager(
            $_db, $_db.pedidoCompraTable)
        .filter((f) => f.fornecedorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_pedidoCompraTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FornecedorTableTableFilterComposer
    extends Composer<_$AppDatabase, $FornecedorTableTable> {
  $$FornecedorTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get razaoSocial => $composableBuilder(
      column: $table.razaoSocial, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cnpj => $composableBuilder(
      column: $table.cnpj, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cpf => $composableBuilder(
      column: $table.cpf, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endereco => $composableBuilder(
      column: $table.endereco, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cep => $composableBuilder(
      column: $table.cep, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => ColumnFilters(column));

  Expression<bool> pedidoCompraTableRefs(
      Expression<bool> Function($$PedidoCompraTableTableFilterComposer f) f) {
    final $$PedidoCompraTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pedidoCompraTable,
        getReferencedColumn: (t) => t.fornecedorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PedidoCompraTableTableFilterComposer(
              $db: $db,
              $table: $db.pedidoCompraTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FornecedorTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FornecedorTableTable> {
  $$FornecedorTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get razaoSocial => $composableBuilder(
      column: $table.razaoSocial, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cnpj => $composableBuilder(
      column: $table.cnpj, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cpf => $composableBuilder(
      column: $table.cpf, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endereco => $composableBuilder(
      column: $table.endereco, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cep => $composableBuilder(
      column: $table.cep, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm,
      builder: (column) => ColumnOrderings(column));
}

class $$FornecedorTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FornecedorTableTable> {
  $$FornecedorTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get razaoSocial => $composableBuilder(
      column: $table.razaoSocial, builder: (column) => column);

  GeneratedColumn<String> get cnpj =>
      $composableBuilder(column: $table.cnpj, builder: (column) => column);

  GeneratedColumn<String> get cpf =>
      $composableBuilder(column: $table.cpf, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get telefone =>
      $composableBuilder(column: $table.telefone, builder: (column) => column);

  GeneratedColumn<String> get endereco =>
      $composableBuilder(column: $table.endereco, builder: (column) => column);

  GeneratedColumn<String> get cidade =>
      $composableBuilder(column: $table.cidade, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get cep =>
      $composableBuilder(column: $table.cep, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  GeneratedColumn<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => column);

  Expression<T> pedidoCompraTableRefs<T extends Object>(
      Expression<T> Function($$PedidoCompraTableTableAnnotationComposer a) f) {
    final $$PedidoCompraTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.pedidoCompraTable,
            getReferencedColumn: (t) => t.fornecedorId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PedidoCompraTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.pedidoCompraTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FornecedorTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FornecedorTableTable,
    FornecedorData,
    $$FornecedorTableTableFilterComposer,
    $$FornecedorTableTableOrderingComposer,
    $$FornecedorTableTableAnnotationComposer,
    $$FornecedorTableTableCreateCompanionBuilder,
    $$FornecedorTableTableUpdateCompanionBuilder,
    (FornecedorData, $$FornecedorTableTableReferences),
    FornecedorData,
    PrefetchHooks Function({bool pedidoCompraTableRefs})> {
  $$FornecedorTableTableTableManager(
      _$AppDatabase db, $FornecedorTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FornecedorTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FornecedorTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FornecedorTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String?> razaoSocial = const Value.absent(),
            Value<String?> cnpj = const Value.absent(),
            Value<String?> cpf = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<String?> endereco = const Value.absent(),
            Value<String?> cidade = const Value.absent(),
            Value<String?> estado = const Value.absent(),
            Value<String?> cep = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
            Value<DateTime> atualizadoEm = const Value.absent(),
          }) =>
              FornecedorTableCompanion(
            id: id,
            nome: nome,
            razaoSocial: razaoSocial,
            cnpj: cnpj,
            cpf: cpf,
            email: email,
            telefone: telefone,
            endereco: endereco,
            cidade: cidade,
            estado: estado,
            cep: cep,
            ativo: ativo,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nome,
            Value<String?> razaoSocial = const Value.absent(),
            Value<String?> cnpj = const Value.absent(),
            Value<String?> cpf = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<String?> endereco = const Value.absent(),
            Value<String?> cidade = const Value.absent(),
            Value<String?> estado = const Value.absent(),
            Value<String?> cep = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
            Value<DateTime> atualizadoEm = const Value.absent(),
          }) =>
              FornecedorTableCompanion.insert(
            id: id,
            nome: nome,
            razaoSocial: razaoSocial,
            cnpj: cnpj,
            cpf: cpf,
            email: email,
            telefone: telefone,
            endereco: endereco,
            cidade: cidade,
            estado: estado,
            cep: cep,
            ativo: ativo,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FornecedorTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pedidoCompraTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pedidoCompraTableRefs) db.pedidoCompraTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pedidoCompraTableRefs)
                    await $_getPrefetchedData<FornecedorData,
                            $FornecedorTableTable, PedidoCompraData>(
                        currentTable: table,
                        referencedTable: $$FornecedorTableTableReferences
                            ._pedidoCompraTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FornecedorTableTableReferences(db, table, p0)
                                .pedidoCompraTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.fornecedorId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FornecedorTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FornecedorTableTable,
    FornecedorData,
    $$FornecedorTableTableFilterComposer,
    $$FornecedorTableTableOrderingComposer,
    $$FornecedorTableTableAnnotationComposer,
    $$FornecedorTableTableCreateCompanionBuilder,
    $$FornecedorTableTableUpdateCompanionBuilder,
    (FornecedorData, $$FornecedorTableTableReferences),
    FornecedorData,
    PrefetchHooks Function({bool pedidoCompraTableRefs})>;
typedef $$PedidoCompraTableTableCreateCompanionBuilder
    = PedidoCompraTableCompanion Function({
  Value<int> id,
  required int fornecedorId,
  required String numero,
  Value<String> status,
  Value<double> valorTotal,
  Value<String?> observacoes,
  Value<DateTime> dataEmissao,
  Value<DateTime?> dataAprovacao,
  Value<DateTime?> dataRecebimento,
  Value<DateTime> criadoEm,
  Value<DateTime> atualizadoEm,
});
typedef $$PedidoCompraTableTableUpdateCompanionBuilder
    = PedidoCompraTableCompanion Function({
  Value<int> id,
  Value<int> fornecedorId,
  Value<String> numero,
  Value<String> status,
  Value<double> valorTotal,
  Value<String?> observacoes,
  Value<DateTime> dataEmissao,
  Value<DateTime?> dataAprovacao,
  Value<DateTime?> dataRecebimento,
  Value<DateTime> criadoEm,
  Value<DateTime> atualizadoEm,
});

final class $$PedidoCompraTableTableReferences extends BaseReferences<
    _$AppDatabase, $PedidoCompraTableTable, PedidoCompraData> {
  $$PedidoCompraTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $FornecedorTableTable _fornecedorIdTable(_$AppDatabase db) =>
      db.fornecedorTable.createAlias($_aliasNameGenerator(
          db.pedidoCompraTable.fornecedorId, db.fornecedorTable.id));

  $$FornecedorTableTableProcessedTableManager get fornecedorId {
    final $_column = $_itemColumn<int>('fornecedor_id')!;

    final manager =
        $$FornecedorTableTableTableManager($_db, $_db.fornecedorTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fornecedorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ItemCompraTableTable, List<ItemCompraData>>
      _itemCompraTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.itemCompraTable,
              aliasName: $_aliasNameGenerator(
                  db.pedidoCompraTable.id, db.itemCompraTable.pedidoCompraId));

  $$ItemCompraTableTableProcessedTableManager get itemCompraTableRefs {
    final manager = $$ItemCompraTableTableTableManager(
            $_db, $_db.itemCompraTable)
        .filter((f) => f.pedidoCompraId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_itemCompraTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PedidoCompraTableTableFilterComposer
    extends Composer<_$AppDatabase, $PedidoCompraTableTable> {
  $$PedidoCompraTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataEmissao => $composableBuilder(
      column: $table.dataEmissao, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataAprovacao => $composableBuilder(
      column: $table.dataAprovacao, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataRecebimento => $composableBuilder(
      column: $table.dataRecebimento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => ColumnFilters(column));

  $$FornecedorTableTableFilterComposer get fornecedorId {
    final $$FornecedorTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fornecedorId,
        referencedTable: $db.fornecedorTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FornecedorTableTableFilterComposer(
              $db: $db,
              $table: $db.fornecedorTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> itemCompraTableRefs(
      Expression<bool> Function($$ItemCompraTableTableFilterComposer f) f) {
    final $$ItemCompraTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemCompraTable,
        getReferencedColumn: (t) => t.pedidoCompraId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemCompraTableTableFilterComposer(
              $db: $db,
              $table: $db.itemCompraTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PedidoCompraTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PedidoCompraTableTable> {
  $$PedidoCompraTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataEmissao => $composableBuilder(
      column: $table.dataEmissao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataAprovacao => $composableBuilder(
      column: $table.dataAprovacao,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataRecebimento => $composableBuilder(
      column: $table.dataRecebimento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm,
      builder: (column) => ColumnOrderings(column));

  $$FornecedorTableTableOrderingComposer get fornecedorId {
    final $$FornecedorTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fornecedorId,
        referencedTable: $db.fornecedorTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FornecedorTableTableOrderingComposer(
              $db: $db,
              $table: $db.fornecedorTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PedidoCompraTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PedidoCompraTableTable> {
  $$PedidoCompraTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => column);

  GeneratedColumn<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => column);

  GeneratedColumn<DateTime> get dataEmissao => $composableBuilder(
      column: $table.dataEmissao, builder: (column) => column);

  GeneratedColumn<DateTime> get dataAprovacao => $composableBuilder(
      column: $table.dataAprovacao, builder: (column) => column);

  GeneratedColumn<DateTime> get dataRecebimento => $composableBuilder(
      column: $table.dataRecebimento, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  GeneratedColumn<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => column);

  $$FornecedorTableTableAnnotationComposer get fornecedorId {
    final $$FornecedorTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fornecedorId,
        referencedTable: $db.fornecedorTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FornecedorTableTableAnnotationComposer(
              $db: $db,
              $table: $db.fornecedorTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> itemCompraTableRefs<T extends Object>(
      Expression<T> Function($$ItemCompraTableTableAnnotationComposer a) f) {
    final $$ItemCompraTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemCompraTable,
        getReferencedColumn: (t) => t.pedidoCompraId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemCompraTableTableAnnotationComposer(
              $db: $db,
              $table: $db.itemCompraTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PedidoCompraTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PedidoCompraTableTable,
    PedidoCompraData,
    $$PedidoCompraTableTableFilterComposer,
    $$PedidoCompraTableTableOrderingComposer,
    $$PedidoCompraTableTableAnnotationComposer,
    $$PedidoCompraTableTableCreateCompanionBuilder,
    $$PedidoCompraTableTableUpdateCompanionBuilder,
    (PedidoCompraData, $$PedidoCompraTableTableReferences),
    PedidoCompraData,
    PrefetchHooks Function({bool fornecedorId, bool itemCompraTableRefs})> {
  $$PedidoCompraTableTableTableManager(
      _$AppDatabase db, $PedidoCompraTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PedidoCompraTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PedidoCompraTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PedidoCompraTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> fornecedorId = const Value.absent(),
            Value<String> numero = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<double> valorTotal = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<DateTime> dataEmissao = const Value.absent(),
            Value<DateTime?> dataAprovacao = const Value.absent(),
            Value<DateTime?> dataRecebimento = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
            Value<DateTime> atualizadoEm = const Value.absent(),
          }) =>
              PedidoCompraTableCompanion(
            id: id,
            fornecedorId: fornecedorId,
            numero: numero,
            status: status,
            valorTotal: valorTotal,
            observacoes: observacoes,
            dataEmissao: dataEmissao,
            dataAprovacao: dataAprovacao,
            dataRecebimento: dataRecebimento,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int fornecedorId,
            required String numero,
            Value<String> status = const Value.absent(),
            Value<double> valorTotal = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<DateTime> dataEmissao = const Value.absent(),
            Value<DateTime?> dataAprovacao = const Value.absent(),
            Value<DateTime?> dataRecebimento = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
            Value<DateTime> atualizadoEm = const Value.absent(),
          }) =>
              PedidoCompraTableCompanion.insert(
            id: id,
            fornecedorId: fornecedorId,
            numero: numero,
            status: status,
            valorTotal: valorTotal,
            observacoes: observacoes,
            dataEmissao: dataEmissao,
            dataAprovacao: dataAprovacao,
            dataRecebimento: dataRecebimento,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PedidoCompraTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {fornecedorId = false, itemCompraTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (itemCompraTableRefs) db.itemCompraTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (fornecedorId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.fornecedorId,
                    referencedTable: $$PedidoCompraTableTableReferences
                        ._fornecedorIdTable(db),
                    referencedColumn: $$PedidoCompraTableTableReferences
                        ._fornecedorIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemCompraTableRefs)
                    await $_getPrefetchedData<PedidoCompraData,
                            $PedidoCompraTableTable, ItemCompraData>(
                        currentTable: table,
                        referencedTable: $$PedidoCompraTableTableReferences
                            ._itemCompraTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PedidoCompraTableTableReferences(db, table, p0)
                                .itemCompraTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.pedidoCompraId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PedidoCompraTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PedidoCompraTableTable,
    PedidoCompraData,
    $$PedidoCompraTableTableFilterComposer,
    $$PedidoCompraTableTableOrderingComposer,
    $$PedidoCompraTableTableAnnotationComposer,
    $$PedidoCompraTableTableCreateCompanionBuilder,
    $$PedidoCompraTableTableUpdateCompanionBuilder,
    (PedidoCompraData, $$PedidoCompraTableTableReferences),
    PedidoCompraData,
    PrefetchHooks Function({bool fornecedorId, bool itemCompraTableRefs})>;
typedef $$ItemCompraTableTableCreateCompanionBuilder = ItemCompraTableCompanion
    Function({
  Value<int> id,
  required int pedidoCompraId,
  required int produtoId,
  required int quantidade,
  required double precoUnitario,
  required double precoTotal,
  Value<String?> observacoes,
  Value<DateTime> criadoEm,
});
typedef $$ItemCompraTableTableUpdateCompanionBuilder = ItemCompraTableCompanion
    Function({
  Value<int> id,
  Value<int> pedidoCompraId,
  Value<int> produtoId,
  Value<int> quantidade,
  Value<double> precoUnitario,
  Value<double> precoTotal,
  Value<String?> observacoes,
  Value<DateTime> criadoEm,
});

final class $$ItemCompraTableTableReferences extends BaseReferences<
    _$AppDatabase, $ItemCompraTableTable, ItemCompraData> {
  $$ItemCompraTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PedidoCompraTableTable _pedidoCompraIdTable(_$AppDatabase db) =>
      db.pedidoCompraTable.createAlias($_aliasNameGenerator(
          db.itemCompraTable.pedidoCompraId, db.pedidoCompraTable.id));

  $$PedidoCompraTableTableProcessedTableManager get pedidoCompraId {
    final $_column = $_itemColumn<int>('pedido_compra_id')!;

    final manager =
        $$PedidoCompraTableTableTableManager($_db, $_db.pedidoCompraTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pedidoCompraIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProdutoTableTable _produtoIdTable(_$AppDatabase db) =>
      db.produtoTable.createAlias($_aliasNameGenerator(
          db.itemCompraTable.produtoId, db.produtoTable.id));

  $$ProdutoTableTableProcessedTableManager get produtoId {
    final $_column = $_itemColumn<int>('produto_id')!;

    final manager = $$ProdutoTableTableTableManager($_db, $_db.produtoTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_produtoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ItemCompraTableTableFilterComposer
    extends Composer<_$AppDatabase, $ItemCompraTableTable> {
  $$ItemCompraTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precoTotal => $composableBuilder(
      column: $table.precoTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnFilters(column));

  $$PedidoCompraTableTableFilterComposer get pedidoCompraId {
    final $$PedidoCompraTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pedidoCompraId,
        referencedTable: $db.pedidoCompraTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PedidoCompraTableTableFilterComposer(
              $db: $db,
              $table: $db.pedidoCompraTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProdutoTableTableFilterComposer get produtoId {
    final $$ProdutoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoId,
        referencedTable: $db.produtoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutoTableTableFilterComposer(
              $db: $db,
              $table: $db.produtoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemCompraTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemCompraTableTable> {
  $$ItemCompraTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precoTotal => $composableBuilder(
      column: $table.precoTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnOrderings(column));

  $$PedidoCompraTableTableOrderingComposer get pedidoCompraId {
    final $$PedidoCompraTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pedidoCompraId,
        referencedTable: $db.pedidoCompraTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PedidoCompraTableTableOrderingComposer(
              $db: $db,
              $table: $db.pedidoCompraTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProdutoTableTableOrderingComposer get produtoId {
    final $$ProdutoTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoId,
        referencedTable: $db.produtoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutoTableTableOrderingComposer(
              $db: $db,
              $table: $db.produtoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemCompraTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemCompraTableTable> {
  $$ItemCompraTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => column);

  GeneratedColumn<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario, builder: (column) => column);

  GeneratedColumn<double> get precoTotal => $composableBuilder(
      column: $table.precoTotal, builder: (column) => column);

  GeneratedColumn<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  $$PedidoCompraTableTableAnnotationComposer get pedidoCompraId {
    final $$PedidoCompraTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.pedidoCompraId,
            referencedTable: $db.pedidoCompraTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PedidoCompraTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.pedidoCompraTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$ProdutoTableTableAnnotationComposer get produtoId {
    final $$ProdutoTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoId,
        referencedTable: $db.produtoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutoTableTableAnnotationComposer(
              $db: $db,
              $table: $db.produtoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemCompraTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItemCompraTableTable,
    ItemCompraData,
    $$ItemCompraTableTableFilterComposer,
    $$ItemCompraTableTableOrderingComposer,
    $$ItemCompraTableTableAnnotationComposer,
    $$ItemCompraTableTableCreateCompanionBuilder,
    $$ItemCompraTableTableUpdateCompanionBuilder,
    (ItemCompraData, $$ItemCompraTableTableReferences),
    ItemCompraData,
    PrefetchHooks Function({bool pedidoCompraId, bool produtoId})> {
  $$ItemCompraTableTableTableManager(
      _$AppDatabase db, $ItemCompraTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemCompraTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemCompraTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemCompraTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> pedidoCompraId = const Value.absent(),
            Value<int> produtoId = const Value.absent(),
            Value<int> quantidade = const Value.absent(),
            Value<double> precoUnitario = const Value.absent(),
            Value<double> precoTotal = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
          }) =>
              ItemCompraTableCompanion(
            id: id,
            pedidoCompraId: pedidoCompraId,
            produtoId: produtoId,
            quantidade: quantidade,
            precoUnitario: precoUnitario,
            precoTotal: precoTotal,
            observacoes: observacoes,
            criadoEm: criadoEm,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int pedidoCompraId,
            required int produtoId,
            required int quantidade,
            required double precoUnitario,
            required double precoTotal,
            Value<String?> observacoes = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
          }) =>
              ItemCompraTableCompanion.insert(
            id: id,
            pedidoCompraId: pedidoCompraId,
            produtoId: produtoId,
            quantidade: quantidade,
            precoUnitario: precoUnitario,
            precoTotal: precoTotal,
            observacoes: observacoes,
            criadoEm: criadoEm,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ItemCompraTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pedidoCompraId = false, produtoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (pedidoCompraId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pedidoCompraId,
                    referencedTable: $$ItemCompraTableTableReferences
                        ._pedidoCompraIdTable(db),
                    referencedColumn: $$ItemCompraTableTableReferences
                        ._pedidoCompraIdTable(db)
                        .id,
                  ) as T;
                }
                if (produtoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.produtoId,
                    referencedTable:
                        $$ItemCompraTableTableReferences._produtoIdTable(db),
                    referencedColumn:
                        $$ItemCompraTableTableReferences._produtoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ItemCompraTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItemCompraTableTable,
    ItemCompraData,
    $$ItemCompraTableTableFilterComposer,
    $$ItemCompraTableTableOrderingComposer,
    $$ItemCompraTableTableAnnotationComposer,
    $$ItemCompraTableTableCreateCompanionBuilder,
    $$ItemCompraTableTableUpdateCompanionBuilder,
    (ItemCompraData, $$ItemCompraTableTableReferences),
    ItemCompraData,
    PrefetchHooks Function({bool pedidoCompraId, bool produtoId})>;
typedef $$VendaTableTableCreateCompanionBuilder = VendaTableCompanion Function({
  Value<int> id,
  Value<DateTime> dataVenda,
  required double subtotal,
  Value<double> desconto,
  required double total,
  required String formaPagamento,
  Value<String?> observacoes,
  Value<DateTime> criadoEm,
  Value<DateTime> atualizadoEm,
});
typedef $$VendaTableTableUpdateCompanionBuilder = VendaTableCompanion Function({
  Value<int> id,
  Value<DateTime> dataVenda,
  Value<double> subtotal,
  Value<double> desconto,
  Value<double> total,
  Value<String> formaPagamento,
  Value<String?> observacoes,
  Value<DateTime> criadoEm,
  Value<DateTime> atualizadoEm,
});

final class $$VendaTableTableReferences
    extends BaseReferences<_$AppDatabase, $VendaTableTable, Venda> {
  $$VendaTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItemVendaTableTable, List<ItemVenda>>
      _itemVendaTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.itemVendaTable,
              aliasName: $_aliasNameGenerator(
                  db.vendaTable.id, db.itemVendaTable.vendaId));

  $$ItemVendaTableTableProcessedTableManager get itemVendaTableRefs {
    final manager = $$ItemVendaTableTableTableManager($_db, $_db.itemVendaTable)
        .filter((f) => f.vendaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemVendaTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$VendaTableTableFilterComposer
    extends Composer<_$AppDatabase, $VendaTableTable> {
  $$VendaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataVenda => $composableBuilder(
      column: $table.dataVenda, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get desconto => $composableBuilder(
      column: $table.desconto, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get formaPagamento => $composableBuilder(
      column: $table.formaPagamento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => ColumnFilters(column));

  Expression<bool> itemVendaTableRefs(
      Expression<bool> Function($$ItemVendaTableTableFilterComposer f) f) {
    final $$ItemVendaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemVendaTable,
        getReferencedColumn: (t) => t.vendaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemVendaTableTableFilterComposer(
              $db: $db,
              $table: $db.itemVendaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VendaTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VendaTableTable> {
  $$VendaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataVenda => $composableBuilder(
      column: $table.dataVenda, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get desconto => $composableBuilder(
      column: $table.desconto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formaPagamento => $composableBuilder(
      column: $table.formaPagamento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm,
      builder: (column) => ColumnOrderings(column));
}

class $$VendaTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VendaTableTable> {
  $$VendaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dataVenda =>
      $composableBuilder(column: $table.dataVenda, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get desconto =>
      $composableBuilder(column: $table.desconto, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get formaPagamento => $composableBuilder(
      column: $table.formaPagamento, builder: (column) => column);

  GeneratedColumn<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  GeneratedColumn<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => column);

  Expression<T> itemVendaTableRefs<T extends Object>(
      Expression<T> Function($$ItemVendaTableTableAnnotationComposer a) f) {
    final $$ItemVendaTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemVendaTable,
        getReferencedColumn: (t) => t.vendaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemVendaTableTableAnnotationComposer(
              $db: $db,
              $table: $db.itemVendaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VendaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VendaTableTable,
    Venda,
    $$VendaTableTableFilterComposer,
    $$VendaTableTableOrderingComposer,
    $$VendaTableTableAnnotationComposer,
    $$VendaTableTableCreateCompanionBuilder,
    $$VendaTableTableUpdateCompanionBuilder,
    (Venda, $$VendaTableTableReferences),
    Venda,
    PrefetchHooks Function({bool itemVendaTableRefs})> {
  $$VendaTableTableTableManager(_$AppDatabase db, $VendaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VendaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VendaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VendaTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> dataVenda = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> desconto = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<String> formaPagamento = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
            Value<DateTime> atualizadoEm = const Value.absent(),
          }) =>
              VendaTableCompanion(
            id: id,
            dataVenda: dataVenda,
            subtotal: subtotal,
            desconto: desconto,
            total: total,
            formaPagamento: formaPagamento,
            observacoes: observacoes,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> dataVenda = const Value.absent(),
            required double subtotal,
            Value<double> desconto = const Value.absent(),
            required double total,
            required String formaPagamento,
            Value<String?> observacoes = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
            Value<DateTime> atualizadoEm = const Value.absent(),
          }) =>
              VendaTableCompanion.insert(
            id: id,
            dataVenda: dataVenda,
            subtotal: subtotal,
            desconto: desconto,
            total: total,
            formaPagamento: formaPagamento,
            observacoes: observacoes,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$VendaTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({itemVendaTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (itemVendaTableRefs) db.itemVendaTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemVendaTableRefs)
                    await $_getPrefetchedData<Venda, $VendaTableTable,
                            ItemVenda>(
                        currentTable: table,
                        referencedTable: $$VendaTableTableReferences
                            ._itemVendaTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VendaTableTableReferences(db, table, p0)
                                .itemVendaTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.vendaId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$VendaTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VendaTableTable,
    Venda,
    $$VendaTableTableFilterComposer,
    $$VendaTableTableOrderingComposer,
    $$VendaTableTableAnnotationComposer,
    $$VendaTableTableCreateCompanionBuilder,
    $$VendaTableTableUpdateCompanionBuilder,
    (Venda, $$VendaTableTableReferences),
    Venda,
    PrefetchHooks Function({bool itemVendaTableRefs})>;
typedef $$ItemVendaTableTableCreateCompanionBuilder = ItemVendaTableCompanion
    Function({
  Value<int> id,
  required int vendaId,
  required int produtoId,
  required int quantidade,
  required double precoUnitario,
  required double subtotal,
  Value<DateTime> criadoEm,
});
typedef $$ItemVendaTableTableUpdateCompanionBuilder = ItemVendaTableCompanion
    Function({
  Value<int> id,
  Value<int> vendaId,
  Value<int> produtoId,
  Value<int> quantidade,
  Value<double> precoUnitario,
  Value<double> subtotal,
  Value<DateTime> criadoEm,
});

final class $$ItemVendaTableTableReferences
    extends BaseReferences<_$AppDatabase, $ItemVendaTableTable, ItemVenda> {
  $$ItemVendaTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $VendaTableTable _vendaIdTable(_$AppDatabase db) =>
      db.vendaTable.createAlias(
          $_aliasNameGenerator(db.itemVendaTable.vendaId, db.vendaTable.id));

  $$VendaTableTableProcessedTableManager get vendaId {
    final $_column = $_itemColumn<int>('venda_id')!;

    final manager = $$VendaTableTableTableManager($_db, $_db.vendaTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vendaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProdutoTableTable _produtoIdTable(_$AppDatabase db) =>
      db.produtoTable.createAlias($_aliasNameGenerator(
          db.itemVendaTable.produtoId, db.produtoTable.id));

  $$ProdutoTableTableProcessedTableManager get produtoId {
    final $_column = $_itemColumn<int>('produto_id')!;

    final manager = $$ProdutoTableTableTableManager($_db, $_db.produtoTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_produtoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ItemVendaTableTableFilterComposer
    extends Composer<_$AppDatabase, $ItemVendaTableTable> {
  $$ItemVendaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnFilters(column));

  $$VendaTableTableFilterComposer get vendaId {
    final $$VendaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vendaId,
        referencedTable: $db.vendaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VendaTableTableFilterComposer(
              $db: $db,
              $table: $db.vendaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProdutoTableTableFilterComposer get produtoId {
    final $$ProdutoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoId,
        referencedTable: $db.produtoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutoTableTableFilterComposer(
              $db: $db,
              $table: $db.produtoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemVendaTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemVendaTableTable> {
  $$ItemVendaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnOrderings(column));

  $$VendaTableTableOrderingComposer get vendaId {
    final $$VendaTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vendaId,
        referencedTable: $db.vendaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VendaTableTableOrderingComposer(
              $db: $db,
              $table: $db.vendaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProdutoTableTableOrderingComposer get produtoId {
    final $$ProdutoTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoId,
        referencedTable: $db.produtoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutoTableTableOrderingComposer(
              $db: $db,
              $table: $db.produtoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemVendaTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemVendaTableTable> {
  $$ItemVendaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => column);

  GeneratedColumn<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  $$VendaTableTableAnnotationComposer get vendaId {
    final $$VendaTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vendaId,
        referencedTable: $db.vendaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VendaTableTableAnnotationComposer(
              $db: $db,
              $table: $db.vendaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProdutoTableTableAnnotationComposer get produtoId {
    final $$ProdutoTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoId,
        referencedTable: $db.produtoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutoTableTableAnnotationComposer(
              $db: $db,
              $table: $db.produtoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemVendaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItemVendaTableTable,
    ItemVenda,
    $$ItemVendaTableTableFilterComposer,
    $$ItemVendaTableTableOrderingComposer,
    $$ItemVendaTableTableAnnotationComposer,
    $$ItemVendaTableTableCreateCompanionBuilder,
    $$ItemVendaTableTableUpdateCompanionBuilder,
    (ItemVenda, $$ItemVendaTableTableReferences),
    ItemVenda,
    PrefetchHooks Function({bool vendaId, bool produtoId})> {
  $$ItemVendaTableTableTableManager(
      _$AppDatabase db, $ItemVendaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemVendaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemVendaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemVendaTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> vendaId = const Value.absent(),
            Value<int> produtoId = const Value.absent(),
            Value<int> quantidade = const Value.absent(),
            Value<double> precoUnitario = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
          }) =>
              ItemVendaTableCompanion(
            id: id,
            vendaId: vendaId,
            produtoId: produtoId,
            quantidade: quantidade,
            precoUnitario: precoUnitario,
            subtotal: subtotal,
            criadoEm: criadoEm,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int vendaId,
            required int produtoId,
            required int quantidade,
            required double precoUnitario,
            required double subtotal,
            Value<DateTime> criadoEm = const Value.absent(),
          }) =>
              ItemVendaTableCompanion.insert(
            id: id,
            vendaId: vendaId,
            produtoId: produtoId,
            quantidade: quantidade,
            precoUnitario: precoUnitario,
            subtotal: subtotal,
            criadoEm: criadoEm,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ItemVendaTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({vendaId = false, produtoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (vendaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.vendaId,
                    referencedTable:
                        $$ItemVendaTableTableReferences._vendaIdTable(db),
                    referencedColumn:
                        $$ItemVendaTableTableReferences._vendaIdTable(db).id,
                  ) as T;
                }
                if (produtoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.produtoId,
                    referencedTable:
                        $$ItemVendaTableTableReferences._produtoIdTable(db),
                    referencedColumn:
                        $$ItemVendaTableTableReferences._produtoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ItemVendaTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItemVendaTableTable,
    ItemVenda,
    $$ItemVendaTableTableFilterComposer,
    $$ItemVendaTableTableOrderingComposer,
    $$ItemVendaTableTableAnnotationComposer,
    $$ItemVendaTableTableCreateCompanionBuilder,
    $$ItemVendaTableTableUpdateCompanionBuilder,
    (ItemVenda, $$ItemVendaTableTableReferences),
    ItemVenda,
    PrefetchHooks Function({bool vendaId, bool produtoId})>;
typedef $$ClienteTableTableCreateCompanionBuilder = ClienteTableCompanion
    Function({
  Value<int> id,
  required String nome,
  Value<String?> email,
  Value<String?> telefone,
  Value<String?> cpfCnpj,
  Value<String?> endereco,
  Value<String?> cidade,
  Value<String?> estado,
  Value<String?> cep,
  Value<String?> observacoes,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ClienteTableTableUpdateCompanionBuilder = ClienteTableCompanion
    Function({
  Value<int> id,
  Value<String> nome,
  Value<String?> email,
  Value<String?> telefone,
  Value<String?> cpfCnpj,
  Value<String?> endereco,
  Value<String?> cidade,
  Value<String?> estado,
  Value<String?> cep,
  Value<String?> observacoes,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$ClienteTableTableFilterComposer
    extends Composer<_$AppDatabase, $ClienteTableTable> {
  $$ClienteTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cpfCnpj => $composableBuilder(
      column: $table.cpfCnpj, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endereco => $composableBuilder(
      column: $table.endereco, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cep => $composableBuilder(
      column: $table.cep, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ClienteTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ClienteTableTable> {
  $$ClienteTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cpfCnpj => $composableBuilder(
      column: $table.cpfCnpj, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endereco => $composableBuilder(
      column: $table.endereco, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cep => $composableBuilder(
      column: $table.cep, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ClienteTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClienteTableTable> {
  $$ClienteTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get telefone =>
      $composableBuilder(column: $table.telefone, builder: (column) => column);

  GeneratedColumn<String> get cpfCnpj =>
      $composableBuilder(column: $table.cpfCnpj, builder: (column) => column);

  GeneratedColumn<String> get endereco =>
      $composableBuilder(column: $table.endereco, builder: (column) => column);

  GeneratedColumn<String> get cidade =>
      $composableBuilder(column: $table.cidade, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get cep =>
      $composableBuilder(column: $table.cep, builder: (column) => column);

  GeneratedColumn<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ClienteTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClienteTableTable,
    ClienteTableData,
    $$ClienteTableTableFilterComposer,
    $$ClienteTableTableOrderingComposer,
    $$ClienteTableTableAnnotationComposer,
    $$ClienteTableTableCreateCompanionBuilder,
    $$ClienteTableTableUpdateCompanionBuilder,
    (
      ClienteTableData,
      BaseReferences<_$AppDatabase, $ClienteTableTable, ClienteTableData>
    ),
    ClienteTableData,
    PrefetchHooks Function()> {
  $$ClienteTableTableTableManager(_$AppDatabase db, $ClienteTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClienteTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClienteTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClienteTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<String?> cpfCnpj = const Value.absent(),
            Value<String?> endereco = const Value.absent(),
            Value<String?> cidade = const Value.absent(),
            Value<String?> estado = const Value.absent(),
            Value<String?> cep = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ClienteTableCompanion(
            id: id,
            nome: nome,
            email: email,
            telefone: telefone,
            cpfCnpj: cpfCnpj,
            endereco: endereco,
            cidade: cidade,
            estado: estado,
            cep: cep,
            observacoes: observacoes,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nome,
            Value<String?> email = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<String?> cpfCnpj = const Value.absent(),
            Value<String?> endereco = const Value.absent(),
            Value<String?> cidade = const Value.absent(),
            Value<String?> estado = const Value.absent(),
            Value<String?> cep = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ClienteTableCompanion.insert(
            id: id,
            nome: nome,
            email: email,
            telefone: telefone,
            cpfCnpj: cpfCnpj,
            endereco: endereco,
            cidade: cidade,
            estado: estado,
            cep: cep,
            observacoes: observacoes,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ClienteTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClienteTableTable,
    ClienteTableData,
    $$ClienteTableTableFilterComposer,
    $$ClienteTableTableOrderingComposer,
    $$ClienteTableTableAnnotationComposer,
    $$ClienteTableTableCreateCompanionBuilder,
    $$ClienteTableTableUpdateCompanionBuilder,
    (
      ClienteTableData,
      BaseReferences<_$AppDatabase, $ClienteTableTable, ClienteTableData>
    ),
    ClienteTableData,
    PrefetchHooks Function()>;
typedef $$ServicosTableTableCreateCompanionBuilder = ServicosTableCompanion
    Function({
  Value<int> id,
  required String nome,
  Value<String?> descricao,
  required double valor,
  Value<String?> categoria,
  Value<int?> duracaoMinutos,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ServicosTableTableUpdateCompanionBuilder = ServicosTableCompanion
    Function({
  Value<int> id,
  Value<String> nome,
  Value<String?> descricao,
  Value<double> valor,
  Value<String?> categoria,
  Value<int?> duracaoMinutos,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$ServicosTableTableFilterComposer
    extends Composer<_$AppDatabase, $ServicosTableTable> {
  $$ServicosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valor => $composableBuilder(
      column: $table.valor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duracaoMinutos => $composableBuilder(
      column: $table.duracaoMinutos,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ServicosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ServicosTableTable> {
  $$ServicosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valor => $composableBuilder(
      column: $table.valor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duracaoMinutos => $composableBuilder(
      column: $table.duracaoMinutos,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ServicosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServicosTableTable> {
  $$ServicosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<double> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<int> get duracaoMinutos => $composableBuilder(
      column: $table.duracaoMinutos, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ServicosTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ServicosTableTable,
    ServicosTableData,
    $$ServicosTableTableFilterComposer,
    $$ServicosTableTableOrderingComposer,
    $$ServicosTableTableAnnotationComposer,
    $$ServicosTableTableCreateCompanionBuilder,
    $$ServicosTableTableUpdateCompanionBuilder,
    (
      ServicosTableData,
      BaseReferences<_$AppDatabase, $ServicosTableTable, ServicosTableData>
    ),
    ServicosTableData,
    PrefetchHooks Function()> {
  $$ServicosTableTableTableManager(_$AppDatabase db, $ServicosTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServicosTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServicosTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServicosTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
            Value<double> valor = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
            Value<int?> duracaoMinutos = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ServicosTableCompanion(
            id: id,
            nome: nome,
            descricao: descricao,
            valor: valor,
            categoria: categoria,
            duracaoMinutos: duracaoMinutos,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nome,
            Value<String?> descricao = const Value.absent(),
            required double valor,
            Value<String?> categoria = const Value.absent(),
            Value<int?> duracaoMinutos = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ServicosTableCompanion.insert(
            id: id,
            nome: nome,
            descricao: descricao,
            valor: valor,
            categoria: categoria,
            duracaoMinutos: duracaoMinutos,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ServicosTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ServicosTableTable,
    ServicosTableData,
    $$ServicosTableTableFilterComposer,
    $$ServicosTableTableOrderingComposer,
    $$ServicosTableTableAnnotationComposer,
    $$ServicosTableTableCreateCompanionBuilder,
    $$ServicosTableTableUpdateCompanionBuilder,
    (
      ServicosTableData,
      BaseReferences<_$AppDatabase, $ServicosTableTable, ServicosTableData>
    ),
    ServicosTableData,
    PrefetchHooks Function()>;
typedef $$OrcamentoTableTableCreateCompanionBuilder = OrcamentoTableCompanion
    Function({
  Value<int> id,
  required String numero,
  Value<int?> clienteId,
  Value<String?> descricao,
  required double valorTotal,
  Value<double> desconto,
  required double valorFinal,
  Value<StatusOrcamento> status,
  Value<DateTime?> dataVencimento,
  Value<String?> observacoes,
  Value<String?> fotosDefeitoUrls,
  Value<String?> fotosReposicaoUrls,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$OrcamentoTableTableUpdateCompanionBuilder = OrcamentoTableCompanion
    Function({
  Value<int> id,
  Value<String> numero,
  Value<int?> clienteId,
  Value<String?> descricao,
  Value<double> valorTotal,
  Value<double> desconto,
  Value<double> valorFinal,
  Value<StatusOrcamento> status,
  Value<DateTime?> dataVencimento,
  Value<String?> observacoes,
  Value<String?> fotosDefeitoUrls,
  Value<String?> fotosReposicaoUrls,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$OrcamentoTableTableReferences
    extends BaseReferences<_$AppDatabase, $OrcamentoTableTable, OrcamentoData> {
  $$OrcamentoTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItemOrcamentoTableTable, List<ItemOrcamentoData>>
      _itemOrcamentoTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.itemOrcamentoTable,
              aliasName: $_aliasNameGenerator(
                  db.orcamentoTable.id, db.itemOrcamentoTable.orcamentoId));

  $$ItemOrcamentoTableTableProcessedTableManager get itemOrcamentoTableRefs {
    final manager = $$ItemOrcamentoTableTableTableManager(
            $_db, $_db.itemOrcamentoTable)
        .filter((f) => f.orcamentoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_itemOrcamentoTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$OrcamentoTableTableFilterComposer
    extends Composer<_$AppDatabase, $OrcamentoTableTable> {
  $$OrcamentoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get desconto => $composableBuilder(
      column: $table.desconto, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valorFinal => $composableBuilder(
      column: $table.valorFinal, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<StatusOrcamento, StatusOrcamento, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get dataVencimento => $composableBuilder(
      column: $table.dataVencimento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fotosDefeitoUrls => $composableBuilder(
      column: $table.fotosDefeitoUrls,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fotosReposicaoUrls => $composableBuilder(
      column: $table.fotosReposicaoUrls,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> itemOrcamentoTableRefs(
      Expression<bool> Function($$ItemOrcamentoTableTableFilterComposer f) f) {
    final $$ItemOrcamentoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemOrcamentoTable,
        getReferencedColumn: (t) => t.orcamentoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemOrcamentoTableTableFilterComposer(
              $db: $db,
              $table: $db.itemOrcamentoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrcamentoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OrcamentoTableTable> {
  $$OrcamentoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get desconto => $composableBuilder(
      column: $table.desconto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valorFinal => $composableBuilder(
      column: $table.valorFinal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataVencimento => $composableBuilder(
      column: $table.dataVencimento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fotosDefeitoUrls => $composableBuilder(
      column: $table.fotosDefeitoUrls,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fotosReposicaoUrls => $composableBuilder(
      column: $table.fotosReposicaoUrls,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$OrcamentoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrcamentoTableTable> {
  $$OrcamentoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<int> get clienteId =>
      $composableBuilder(column: $table.clienteId, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => column);

  GeneratedColumn<double> get desconto =>
      $composableBuilder(column: $table.desconto, builder: (column) => column);

  GeneratedColumn<double> get valorFinal => $composableBuilder(
      column: $table.valorFinal, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StatusOrcamento, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get dataVencimento => $composableBuilder(
      column: $table.dataVencimento, builder: (column) => column);

  GeneratedColumn<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => column);

  GeneratedColumn<String> get fotosDefeitoUrls => $composableBuilder(
      column: $table.fotosDefeitoUrls, builder: (column) => column);

  GeneratedColumn<String> get fotosReposicaoUrls => $composableBuilder(
      column: $table.fotosReposicaoUrls, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> itemOrcamentoTableRefs<T extends Object>(
      Expression<T> Function($$ItemOrcamentoTableTableAnnotationComposer a) f) {
    final $$ItemOrcamentoTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.itemOrcamentoTable,
            getReferencedColumn: (t) => t.orcamentoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ItemOrcamentoTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.itemOrcamentoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$OrcamentoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrcamentoTableTable,
    OrcamentoData,
    $$OrcamentoTableTableFilterComposer,
    $$OrcamentoTableTableOrderingComposer,
    $$OrcamentoTableTableAnnotationComposer,
    $$OrcamentoTableTableCreateCompanionBuilder,
    $$OrcamentoTableTableUpdateCompanionBuilder,
    (OrcamentoData, $$OrcamentoTableTableReferences),
    OrcamentoData,
    PrefetchHooks Function({bool itemOrcamentoTableRefs})> {
  $$OrcamentoTableTableTableManager(
      _$AppDatabase db, $OrcamentoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrcamentoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrcamentoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrcamentoTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> numero = const Value.absent(),
            Value<int?> clienteId = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
            Value<double> valorTotal = const Value.absent(),
            Value<double> desconto = const Value.absent(),
            Value<double> valorFinal = const Value.absent(),
            Value<StatusOrcamento> status = const Value.absent(),
            Value<DateTime?> dataVencimento = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<String?> fotosDefeitoUrls = const Value.absent(),
            Value<String?> fotosReposicaoUrls = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              OrcamentoTableCompanion(
            id: id,
            numero: numero,
            clienteId: clienteId,
            descricao: descricao,
            valorTotal: valorTotal,
            desconto: desconto,
            valorFinal: valorFinal,
            status: status,
            dataVencimento: dataVencimento,
            observacoes: observacoes,
            fotosDefeitoUrls: fotosDefeitoUrls,
            fotosReposicaoUrls: fotosReposicaoUrls,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String numero,
            Value<int?> clienteId = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
            required double valorTotal,
            Value<double> desconto = const Value.absent(),
            required double valorFinal,
            Value<StatusOrcamento> status = const Value.absent(),
            Value<DateTime?> dataVencimento = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<String?> fotosDefeitoUrls = const Value.absent(),
            Value<String?> fotosReposicaoUrls = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              OrcamentoTableCompanion.insert(
            id: id,
            numero: numero,
            clienteId: clienteId,
            descricao: descricao,
            valorTotal: valorTotal,
            desconto: desconto,
            valorFinal: valorFinal,
            status: status,
            dataVencimento: dataVencimento,
            observacoes: observacoes,
            fotosDefeitoUrls: fotosDefeitoUrls,
            fotosReposicaoUrls: fotosReposicaoUrls,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$OrcamentoTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({itemOrcamentoTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (itemOrcamentoTableRefs) db.itemOrcamentoTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemOrcamentoTableRefs)
                    await $_getPrefetchedData<OrcamentoData,
                            $OrcamentoTableTable, ItemOrcamentoData>(
                        currentTable: table,
                        referencedTable: $$OrcamentoTableTableReferences
                            ._itemOrcamentoTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$OrcamentoTableTableReferences(db, table, p0)
                                .itemOrcamentoTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.orcamentoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$OrcamentoTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrcamentoTableTable,
    OrcamentoData,
    $$OrcamentoTableTableFilterComposer,
    $$OrcamentoTableTableOrderingComposer,
    $$OrcamentoTableTableAnnotationComposer,
    $$OrcamentoTableTableCreateCompanionBuilder,
    $$OrcamentoTableTableUpdateCompanionBuilder,
    (OrcamentoData, $$OrcamentoTableTableReferences),
    OrcamentoData,
    PrefetchHooks Function({bool itemOrcamentoTableRefs})>;
typedef $$ItemOrcamentoTableTableCreateCompanionBuilder
    = ItemOrcamentoTableCompanion Function({
  Value<int> id,
  required int orcamentoId,
  Value<int?> produtoId,
  Value<int?> servicoId,
  required String descricao,
  required int quantidade,
  required double valorUnitario,
  required double valorTotal,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ItemOrcamentoTableTableUpdateCompanionBuilder
    = ItemOrcamentoTableCompanion Function({
  Value<int> id,
  Value<int> orcamentoId,
  Value<int?> produtoId,
  Value<int?> servicoId,
  Value<String> descricao,
  Value<int> quantidade,
  Value<double> valorUnitario,
  Value<double> valorTotal,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ItemOrcamentoTableTableReferences extends BaseReferences<
    _$AppDatabase, $ItemOrcamentoTableTable, ItemOrcamentoData> {
  $$ItemOrcamentoTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $OrcamentoTableTable _orcamentoIdTable(_$AppDatabase db) =>
      db.orcamentoTable.createAlias($_aliasNameGenerator(
          db.itemOrcamentoTable.orcamentoId, db.orcamentoTable.id));

  $$OrcamentoTableTableProcessedTableManager get orcamentoId {
    final $_column = $_itemColumn<int>('orcamento_id')!;

    final manager = $$OrcamentoTableTableTableManager($_db, $_db.orcamentoTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orcamentoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ItemOrcamentoTableTableFilterComposer
    extends Composer<_$AppDatabase, $ItemOrcamentoTableTable> {
  $$ItemOrcamentoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get produtoId => $composableBuilder(
      column: $table.produtoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get servicoId => $composableBuilder(
      column: $table.servicoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valorUnitario => $composableBuilder(
      column: $table.valorUnitario, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$OrcamentoTableTableFilterComposer get orcamentoId {
    final $$OrcamentoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orcamentoId,
        referencedTable: $db.orcamentoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrcamentoTableTableFilterComposer(
              $db: $db,
              $table: $db.orcamentoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemOrcamentoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemOrcamentoTableTable> {
  $$ItemOrcamentoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get produtoId => $composableBuilder(
      column: $table.produtoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get servicoId => $composableBuilder(
      column: $table.servicoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valorUnitario => $composableBuilder(
      column: $table.valorUnitario,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$OrcamentoTableTableOrderingComposer get orcamentoId {
    final $$OrcamentoTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orcamentoId,
        referencedTable: $db.orcamentoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrcamentoTableTableOrderingComposer(
              $db: $db,
              $table: $db.orcamentoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemOrcamentoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemOrcamentoTableTable> {
  $$ItemOrcamentoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get produtoId =>
      $composableBuilder(column: $table.produtoId, builder: (column) => column);

  GeneratedColumn<int> get servicoId =>
      $composableBuilder(column: $table.servicoId, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => column);

  GeneratedColumn<double> get valorUnitario => $composableBuilder(
      column: $table.valorUnitario, builder: (column) => column);

  GeneratedColumn<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$OrcamentoTableTableAnnotationComposer get orcamentoId {
    final $$OrcamentoTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orcamentoId,
        referencedTable: $db.orcamentoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrcamentoTableTableAnnotationComposer(
              $db: $db,
              $table: $db.orcamentoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemOrcamentoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItemOrcamentoTableTable,
    ItemOrcamentoData,
    $$ItemOrcamentoTableTableFilterComposer,
    $$ItemOrcamentoTableTableOrderingComposer,
    $$ItemOrcamentoTableTableAnnotationComposer,
    $$ItemOrcamentoTableTableCreateCompanionBuilder,
    $$ItemOrcamentoTableTableUpdateCompanionBuilder,
    (ItemOrcamentoData, $$ItemOrcamentoTableTableReferences),
    ItemOrcamentoData,
    PrefetchHooks Function({bool orcamentoId})> {
  $$ItemOrcamentoTableTableTableManager(
      _$AppDatabase db, $ItemOrcamentoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemOrcamentoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemOrcamentoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemOrcamentoTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> orcamentoId = const Value.absent(),
            Value<int?> produtoId = const Value.absent(),
            Value<int?> servicoId = const Value.absent(),
            Value<String> descricao = const Value.absent(),
            Value<int> quantidade = const Value.absent(),
            Value<double> valorUnitario = const Value.absent(),
            Value<double> valorTotal = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ItemOrcamentoTableCompanion(
            id: id,
            orcamentoId: orcamentoId,
            produtoId: produtoId,
            servicoId: servicoId,
            descricao: descricao,
            quantidade: quantidade,
            valorUnitario: valorUnitario,
            valorTotal: valorTotal,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int orcamentoId,
            Value<int?> produtoId = const Value.absent(),
            Value<int?> servicoId = const Value.absent(),
            required String descricao,
            required int quantidade,
            required double valorUnitario,
            required double valorTotal,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ItemOrcamentoTableCompanion.insert(
            id: id,
            orcamentoId: orcamentoId,
            produtoId: produtoId,
            servicoId: servicoId,
            descricao: descricao,
            quantidade: quantidade,
            valorUnitario: valorUnitario,
            valorTotal: valorTotal,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ItemOrcamentoTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({orcamentoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (orcamentoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.orcamentoId,
                    referencedTable: $$ItemOrcamentoTableTableReferences
                        ._orcamentoIdTable(db),
                    referencedColumn: $$ItemOrcamentoTableTableReferences
                        ._orcamentoIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ItemOrcamentoTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItemOrcamentoTableTable,
    ItemOrcamentoData,
    $$ItemOrcamentoTableTableFilterComposer,
    $$ItemOrcamentoTableTableOrderingComposer,
    $$ItemOrcamentoTableTableAnnotationComposer,
    $$ItemOrcamentoTableTableCreateCompanionBuilder,
    $$ItemOrcamentoTableTableUpdateCompanionBuilder,
    (ItemOrcamentoData, $$ItemOrcamentoTableTableReferences),
    ItemOrcamentoData,
    PrefetchHooks Function({bool orcamentoId})>;
typedef $$OrdensServicoTableTableCreateCompanionBuilder
    = OrdensServicoTableCompanion Function({
  Value<int> id,
  required String numero,
  required int clienteId,
  required String nomeCliente,
  Value<String?> emailCliente,
  Value<String?> telefoneCliente,
  required double subtotal,
  Value<double> desconto,
  required double total,
  required String status,
  required String prioridade,
  required DateTime dataAgendamento,
  Value<DateTime?> dataPrevista,
  Value<DateTime?> dataInicio,
  Value<DateTime?> dataConclusao,
  Value<String?> observacoes,
  Value<String?> observacoesInternas,
  Value<String?> tecnicoResponsavel,
  Value<String?> equipamento,
  Value<String?> problemaRelatado,
  Value<String?> solucaoAplicada,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$OrdensServicoTableTableUpdateCompanionBuilder
    = OrdensServicoTableCompanion Function({
  Value<int> id,
  Value<String> numero,
  Value<int> clienteId,
  Value<String> nomeCliente,
  Value<String?> emailCliente,
  Value<String?> telefoneCliente,
  Value<double> subtotal,
  Value<double> desconto,
  Value<double> total,
  Value<String> status,
  Value<String> prioridade,
  Value<DateTime> dataAgendamento,
  Value<DateTime?> dataPrevista,
  Value<DateTime?> dataInicio,
  Value<DateTime?> dataConclusao,
  Value<String?> observacoes,
  Value<String?> observacoesInternas,
  Value<String?> tecnicoResponsavel,
  Value<String?> equipamento,
  Value<String?> problemaRelatado,
  Value<String?> solucaoAplicada,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$OrdensServicoTableTableFilterComposer
    extends Composer<_$AppDatabase, $OrdensServicoTableTable> {
  $$OrdensServicoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeCliente => $composableBuilder(
      column: $table.nomeCliente, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emailCliente => $composableBuilder(
      column: $table.emailCliente, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefoneCliente => $composableBuilder(
      column: $table.telefoneCliente,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get desconto => $composableBuilder(
      column: $table.desconto, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prioridade => $composableBuilder(
      column: $table.prioridade, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataAgendamento => $composableBuilder(
      column: $table.dataAgendamento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataPrevista => $composableBuilder(
      column: $table.dataPrevista, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataConclusao => $composableBuilder(
      column: $table.dataConclusao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacoesInternas => $composableBuilder(
      column: $table.observacoesInternas,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tecnicoResponsavel => $composableBuilder(
      column: $table.tecnicoResponsavel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get equipamento => $composableBuilder(
      column: $table.equipamento, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get problemaRelatado => $composableBuilder(
      column: $table.problemaRelatado,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get solucaoAplicada => $composableBuilder(
      column: $table.solucaoAplicada,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$OrdensServicoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdensServicoTableTable> {
  $$OrdensServicoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeCliente => $composableBuilder(
      column: $table.nomeCliente, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emailCliente => $composableBuilder(
      column: $table.emailCliente,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefoneCliente => $composableBuilder(
      column: $table.telefoneCliente,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get desconto => $composableBuilder(
      column: $table.desconto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prioridade => $composableBuilder(
      column: $table.prioridade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataAgendamento => $composableBuilder(
      column: $table.dataAgendamento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataPrevista => $composableBuilder(
      column: $table.dataPrevista,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataConclusao => $composableBuilder(
      column: $table.dataConclusao,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacoesInternas => $composableBuilder(
      column: $table.observacoesInternas,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tecnicoResponsavel => $composableBuilder(
      column: $table.tecnicoResponsavel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipamento => $composableBuilder(
      column: $table.equipamento, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get problemaRelatado => $composableBuilder(
      column: $table.problemaRelatado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get solucaoAplicada => $composableBuilder(
      column: $table.solucaoAplicada,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$OrdensServicoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdensServicoTableTable> {
  $$OrdensServicoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<int> get clienteId =>
      $composableBuilder(column: $table.clienteId, builder: (column) => column);

  GeneratedColumn<String> get nomeCliente => $composableBuilder(
      column: $table.nomeCliente, builder: (column) => column);

  GeneratedColumn<String> get emailCliente => $composableBuilder(
      column: $table.emailCliente, builder: (column) => column);

  GeneratedColumn<String> get telefoneCliente => $composableBuilder(
      column: $table.telefoneCliente, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get desconto =>
      $composableBuilder(column: $table.desconto, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get prioridade => $composableBuilder(
      column: $table.prioridade, builder: (column) => column);

  GeneratedColumn<DateTime> get dataAgendamento => $composableBuilder(
      column: $table.dataAgendamento, builder: (column) => column);

  GeneratedColumn<DateTime> get dataPrevista => $composableBuilder(
      column: $table.dataPrevista, builder: (column) => column);

  GeneratedColumn<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => column);

  GeneratedColumn<DateTime> get dataConclusao => $composableBuilder(
      column: $table.dataConclusao, builder: (column) => column);

  GeneratedColumn<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => column);

  GeneratedColumn<String> get observacoesInternas => $composableBuilder(
      column: $table.observacoesInternas, builder: (column) => column);

  GeneratedColumn<String> get tecnicoResponsavel => $composableBuilder(
      column: $table.tecnicoResponsavel, builder: (column) => column);

  GeneratedColumn<String> get equipamento => $composableBuilder(
      column: $table.equipamento, builder: (column) => column);

  GeneratedColumn<String> get problemaRelatado => $composableBuilder(
      column: $table.problemaRelatado, builder: (column) => column);

  GeneratedColumn<String> get solucaoAplicada => $composableBuilder(
      column: $table.solucaoAplicada, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OrdensServicoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdensServicoTableTable,
    OrdensServicoTableData,
    $$OrdensServicoTableTableFilterComposer,
    $$OrdensServicoTableTableOrderingComposer,
    $$OrdensServicoTableTableAnnotationComposer,
    $$OrdensServicoTableTableCreateCompanionBuilder,
    $$OrdensServicoTableTableUpdateCompanionBuilder,
    (
      OrdensServicoTableData,
      BaseReferences<_$AppDatabase, $OrdensServicoTableTable,
          OrdensServicoTableData>
    ),
    OrdensServicoTableData,
    PrefetchHooks Function()> {
  $$OrdensServicoTableTableTableManager(
      _$AppDatabase db, $OrdensServicoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdensServicoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdensServicoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdensServicoTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> numero = const Value.absent(),
            Value<int> clienteId = const Value.absent(),
            Value<String> nomeCliente = const Value.absent(),
            Value<String?> emailCliente = const Value.absent(),
            Value<String?> telefoneCliente = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> desconto = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> prioridade = const Value.absent(),
            Value<DateTime> dataAgendamento = const Value.absent(),
            Value<DateTime?> dataPrevista = const Value.absent(),
            Value<DateTime?> dataInicio = const Value.absent(),
            Value<DateTime?> dataConclusao = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<String?> observacoesInternas = const Value.absent(),
            Value<String?> tecnicoResponsavel = const Value.absent(),
            Value<String?> equipamento = const Value.absent(),
            Value<String?> problemaRelatado = const Value.absent(),
            Value<String?> solucaoAplicada = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              OrdensServicoTableCompanion(
            id: id,
            numero: numero,
            clienteId: clienteId,
            nomeCliente: nomeCliente,
            emailCliente: emailCliente,
            telefoneCliente: telefoneCliente,
            subtotal: subtotal,
            desconto: desconto,
            total: total,
            status: status,
            prioridade: prioridade,
            dataAgendamento: dataAgendamento,
            dataPrevista: dataPrevista,
            dataInicio: dataInicio,
            dataConclusao: dataConclusao,
            observacoes: observacoes,
            observacoesInternas: observacoesInternas,
            tecnicoResponsavel: tecnicoResponsavel,
            equipamento: equipamento,
            problemaRelatado: problemaRelatado,
            solucaoAplicada: solucaoAplicada,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String numero,
            required int clienteId,
            required String nomeCliente,
            Value<String?> emailCliente = const Value.absent(),
            Value<String?> telefoneCliente = const Value.absent(),
            required double subtotal,
            Value<double> desconto = const Value.absent(),
            required double total,
            required String status,
            required String prioridade,
            required DateTime dataAgendamento,
            Value<DateTime?> dataPrevista = const Value.absent(),
            Value<DateTime?> dataInicio = const Value.absent(),
            Value<DateTime?> dataConclusao = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<String?> observacoesInternas = const Value.absent(),
            Value<String?> tecnicoResponsavel = const Value.absent(),
            Value<String?> equipamento = const Value.absent(),
            Value<String?> problemaRelatado = const Value.absent(),
            Value<String?> solucaoAplicada = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              OrdensServicoTableCompanion.insert(
            id: id,
            numero: numero,
            clienteId: clienteId,
            nomeCliente: nomeCliente,
            emailCliente: emailCliente,
            telefoneCliente: telefoneCliente,
            subtotal: subtotal,
            desconto: desconto,
            total: total,
            status: status,
            prioridade: prioridade,
            dataAgendamento: dataAgendamento,
            dataPrevista: dataPrevista,
            dataInicio: dataInicio,
            dataConclusao: dataConclusao,
            observacoes: observacoes,
            observacoesInternas: observacoesInternas,
            tecnicoResponsavel: tecnicoResponsavel,
            equipamento: equipamento,
            problemaRelatado: problemaRelatado,
            solucaoAplicada: solucaoAplicada,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrdensServicoTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdensServicoTableTable,
    OrdensServicoTableData,
    $$OrdensServicoTableTableFilterComposer,
    $$OrdensServicoTableTableOrderingComposer,
    $$OrdensServicoTableTableAnnotationComposer,
    $$OrdensServicoTableTableCreateCompanionBuilder,
    $$OrdensServicoTableTableUpdateCompanionBuilder,
    (
      OrdensServicoTableData,
      BaseReferences<_$AppDatabase, $OrdensServicoTableTable,
          OrdensServicoTableData>
    ),
    OrdensServicoTableData,
    PrefetchHooks Function()>;
typedef $$ItensOrdemServicoTableTableCreateCompanionBuilder
    = ItensOrdemServicoTableCompanion Function({
  Value<int> id,
  required int ordemServicoId,
  Value<int?> servicoId,
  required String nomeServico,
  Value<String?> descricaoServico,
  required int quantidade,
  required double valorUnitario,
  required double subtotal,
  Value<int?> duracaoMinutos,
  Value<DateTime> createdAt,
});
typedef $$ItensOrdemServicoTableTableUpdateCompanionBuilder
    = ItensOrdemServicoTableCompanion Function({
  Value<int> id,
  Value<int> ordemServicoId,
  Value<int?> servicoId,
  Value<String> nomeServico,
  Value<String?> descricaoServico,
  Value<int> quantidade,
  Value<double> valorUnitario,
  Value<double> subtotal,
  Value<int?> duracaoMinutos,
  Value<DateTime> createdAt,
});

class $$ItensOrdemServicoTableTableFilterComposer
    extends Composer<_$AppDatabase, $ItensOrdemServicoTableTable> {
  $$ItensOrdemServicoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordemServicoId => $composableBuilder(
      column: $table.ordemServicoId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get servicoId => $composableBuilder(
      column: $table.servicoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeServico => $composableBuilder(
      column: $table.nomeServico, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricaoServico => $composableBuilder(
      column: $table.descricaoServico,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valorUnitario => $composableBuilder(
      column: $table.valorUnitario, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duracaoMinutos => $composableBuilder(
      column: $table.duracaoMinutos,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$ItensOrdemServicoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ItensOrdemServicoTableTable> {
  $$ItensOrdemServicoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordemServicoId => $composableBuilder(
      column: $table.ordemServicoId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get servicoId => $composableBuilder(
      column: $table.servicoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeServico => $composableBuilder(
      column: $table.nomeServico, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricaoServico => $composableBuilder(
      column: $table.descricaoServico,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valorUnitario => $composableBuilder(
      column: $table.valorUnitario,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duracaoMinutos => $composableBuilder(
      column: $table.duracaoMinutos,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ItensOrdemServicoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItensOrdemServicoTableTable> {
  $$ItensOrdemServicoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordemServicoId => $composableBuilder(
      column: $table.ordemServicoId, builder: (column) => column);

  GeneratedColumn<int> get servicoId =>
      $composableBuilder(column: $table.servicoId, builder: (column) => column);

  GeneratedColumn<String> get nomeServico => $composableBuilder(
      column: $table.nomeServico, builder: (column) => column);

  GeneratedColumn<String> get descricaoServico => $composableBuilder(
      column: $table.descricaoServico, builder: (column) => column);

  GeneratedColumn<int> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => column);

  GeneratedColumn<double> get valorUnitario => $composableBuilder(
      column: $table.valorUnitario, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<int> get duracaoMinutos => $composableBuilder(
      column: $table.duracaoMinutos, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ItensOrdemServicoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItensOrdemServicoTableTable,
    ItensOrdemServicoTableData,
    $$ItensOrdemServicoTableTableFilterComposer,
    $$ItensOrdemServicoTableTableOrderingComposer,
    $$ItensOrdemServicoTableTableAnnotationComposer,
    $$ItensOrdemServicoTableTableCreateCompanionBuilder,
    $$ItensOrdemServicoTableTableUpdateCompanionBuilder,
    (
      ItensOrdemServicoTableData,
      BaseReferences<_$AppDatabase, $ItensOrdemServicoTableTable,
          ItensOrdemServicoTableData>
    ),
    ItensOrdemServicoTableData,
    PrefetchHooks Function()> {
  $$ItensOrdemServicoTableTableTableManager(
      _$AppDatabase db, $ItensOrdemServicoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItensOrdemServicoTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ItensOrdemServicoTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItensOrdemServicoTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ordemServicoId = const Value.absent(),
            Value<int?> servicoId = const Value.absent(),
            Value<String> nomeServico = const Value.absent(),
            Value<String?> descricaoServico = const Value.absent(),
            Value<int> quantidade = const Value.absent(),
            Value<double> valorUnitario = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<int?> duracaoMinutos = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ItensOrdemServicoTableCompanion(
            id: id,
            ordemServicoId: ordemServicoId,
            servicoId: servicoId,
            nomeServico: nomeServico,
            descricaoServico: descricaoServico,
            quantidade: quantidade,
            valorUnitario: valorUnitario,
            subtotal: subtotal,
            duracaoMinutos: duracaoMinutos,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ordemServicoId,
            Value<int?> servicoId = const Value.absent(),
            required String nomeServico,
            Value<String?> descricaoServico = const Value.absent(),
            required int quantidade,
            required double valorUnitario,
            required double subtotal,
            Value<int?> duracaoMinutos = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ItensOrdemServicoTableCompanion.insert(
            id: id,
            ordemServicoId: ordemServicoId,
            servicoId: servicoId,
            nomeServico: nomeServico,
            descricaoServico: descricaoServico,
            quantidade: quantidade,
            valorUnitario: valorUnitario,
            subtotal: subtotal,
            duracaoMinutos: duracaoMinutos,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ItensOrdemServicoTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ItensOrdemServicoTableTable,
        ItensOrdemServicoTableData,
        $$ItensOrdemServicoTableTableFilterComposer,
        $$ItensOrdemServicoTableTableOrderingComposer,
        $$ItensOrdemServicoTableTableAnnotationComposer,
        $$ItensOrdemServicoTableTableCreateCompanionBuilder,
        $$ItensOrdemServicoTableTableUpdateCompanionBuilder,
        (
          ItensOrdemServicoTableData,
          BaseReferences<_$AppDatabase, $ItensOrdemServicoTableTable,
              ItensOrdemServicoTableData>
        ),
        ItensOrdemServicoTableData,
        PrefetchHooks Function()>;
typedef $$AuditoriaTableTableCreateCompanionBuilder = AuditoriaTableCompanion
    Function({
  Value<int> id,
  required String entidade,
  required String acao,
  required int entidadeId,
  required String usuario,
  Value<String?> detalhes,
  Value<String?> valoresAnteriores,
  Value<String?> valoresNovos,
  Value<DateTime> dataAcao,
});
typedef $$AuditoriaTableTableUpdateCompanionBuilder = AuditoriaTableCompanion
    Function({
  Value<int> id,
  Value<String> entidade,
  Value<String> acao,
  Value<int> entidadeId,
  Value<String> usuario,
  Value<String?> detalhes,
  Value<String?> valoresAnteriores,
  Value<String?> valoresNovos,
  Value<DateTime> dataAcao,
});

class $$AuditoriaTableTableFilterComposer
    extends Composer<_$AppDatabase, $AuditoriaTableTable> {
  $$AuditoriaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entidade => $composableBuilder(
      column: $table.entidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get acao => $composableBuilder(
      column: $table.acao, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get entidadeId => $composableBuilder(
      column: $table.entidadeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get usuario => $composableBuilder(
      column: $table.usuario, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get detalhes => $composableBuilder(
      column: $table.detalhes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get valoresAnteriores => $composableBuilder(
      column: $table.valoresAnteriores,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get valoresNovos => $composableBuilder(
      column: $table.valoresNovos, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataAcao => $composableBuilder(
      column: $table.dataAcao, builder: (column) => ColumnFilters(column));
}

class $$AuditoriaTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditoriaTableTable> {
  $$AuditoriaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entidade => $composableBuilder(
      column: $table.entidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get acao => $composableBuilder(
      column: $table.acao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get entidadeId => $composableBuilder(
      column: $table.entidadeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get usuario => $composableBuilder(
      column: $table.usuario, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get detalhes => $composableBuilder(
      column: $table.detalhes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get valoresAnteriores => $composableBuilder(
      column: $table.valoresAnteriores,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get valoresNovos => $composableBuilder(
      column: $table.valoresNovos,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataAcao => $composableBuilder(
      column: $table.dataAcao, builder: (column) => ColumnOrderings(column));
}

class $$AuditoriaTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditoriaTableTable> {
  $$AuditoriaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entidade =>
      $composableBuilder(column: $table.entidade, builder: (column) => column);

  GeneratedColumn<String> get acao =>
      $composableBuilder(column: $table.acao, builder: (column) => column);

  GeneratedColumn<int> get entidadeId => $composableBuilder(
      column: $table.entidadeId, builder: (column) => column);

  GeneratedColumn<String> get usuario =>
      $composableBuilder(column: $table.usuario, builder: (column) => column);

  GeneratedColumn<String> get detalhes =>
      $composableBuilder(column: $table.detalhes, builder: (column) => column);

  GeneratedColumn<String> get valoresAnteriores => $composableBuilder(
      column: $table.valoresAnteriores, builder: (column) => column);

  GeneratedColumn<String> get valoresNovos => $composableBuilder(
      column: $table.valoresNovos, builder: (column) => column);

  GeneratedColumn<DateTime> get dataAcao =>
      $composableBuilder(column: $table.dataAcao, builder: (column) => column);
}

class $$AuditoriaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AuditoriaTableTable,
    AuditoriaData,
    $$AuditoriaTableTableFilterComposer,
    $$AuditoriaTableTableOrderingComposer,
    $$AuditoriaTableTableAnnotationComposer,
    $$AuditoriaTableTableCreateCompanionBuilder,
    $$AuditoriaTableTableUpdateCompanionBuilder,
    (
      AuditoriaData,
      BaseReferences<_$AppDatabase, $AuditoriaTableTable, AuditoriaData>
    ),
    AuditoriaData,
    PrefetchHooks Function()> {
  $$AuditoriaTableTableTableManager(
      _$AppDatabase db, $AuditoriaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditoriaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditoriaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditoriaTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> entidade = const Value.absent(),
            Value<String> acao = const Value.absent(),
            Value<int> entidadeId = const Value.absent(),
            Value<String> usuario = const Value.absent(),
            Value<String?> detalhes = const Value.absent(),
            Value<String?> valoresAnteriores = const Value.absent(),
            Value<String?> valoresNovos = const Value.absent(),
            Value<DateTime> dataAcao = const Value.absent(),
          }) =>
              AuditoriaTableCompanion(
            id: id,
            entidade: entidade,
            acao: acao,
            entidadeId: entidadeId,
            usuario: usuario,
            detalhes: detalhes,
            valoresAnteriores: valoresAnteriores,
            valoresNovos: valoresNovos,
            dataAcao: dataAcao,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entidade,
            required String acao,
            required int entidadeId,
            required String usuario,
            Value<String?> detalhes = const Value.absent(),
            Value<String?> valoresAnteriores = const Value.absent(),
            Value<String?> valoresNovos = const Value.absent(),
            Value<DateTime> dataAcao = const Value.absent(),
          }) =>
              AuditoriaTableCompanion.insert(
            id: id,
            entidade: entidade,
            acao: acao,
            entidadeId: entidadeId,
            usuario: usuario,
            detalhes: detalhes,
            valoresAnteriores: valoresAnteriores,
            valoresNovos: valoresNovos,
            dataAcao: dataAcao,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AuditoriaTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AuditoriaTableTable,
    AuditoriaData,
    $$AuditoriaTableTableFilterComposer,
    $$AuditoriaTableTableOrderingComposer,
    $$AuditoriaTableTableAnnotationComposer,
    $$AuditoriaTableTableCreateCompanionBuilder,
    $$AuditoriaTableTableUpdateCompanionBuilder,
    (
      AuditoriaData,
      BaseReferences<_$AppDatabase, $AuditoriaTableTable, AuditoriaData>
    ),
    AuditoriaData,
    PrefetchHooks Function()>;
typedef $$EmpresaConfigsTableCreateCompanionBuilder = EmpresaConfigsCompanion
    Function({
  Value<int> id,
  required String nomeEmpresa,
  Value<String?> nomeFantasia,
  required String tipoEmpresa,
  required String documento,
  Value<String?> inscricaoEstadual,
  Value<String?> inscricaoMunicipal,
  required String endereco,
  required String numero,
  Value<String?> complemento,
  required String bairro,
  required String cidade,
  required String estado,
  required String cep,
  Value<String?> telefone,
  Value<String?> celular,
  Value<String?> email,
  Value<String?> website,
  Value<bool> exibirLogo,
  Value<String?> caminhoLogo,
  Value<String?> mensagemRodape,
  Value<bool> exibirQrCode,
  Value<String?> corPrimaria,
  Value<String?> banco,
  Value<String?> agencia,
  Value<String?> conta,
  Value<String?> pix,
  Value<String?> regimeTributario,
  Value<bool> emitirNfce,
  Value<String?> certificadoA1Path,
  Value<String?> senhaA1,
  Value<DateTime?> criadoEm,
  Value<DateTime?> atualizadoEm,
});
typedef $$EmpresaConfigsTableUpdateCompanionBuilder = EmpresaConfigsCompanion
    Function({
  Value<int> id,
  Value<String> nomeEmpresa,
  Value<String?> nomeFantasia,
  Value<String> tipoEmpresa,
  Value<String> documento,
  Value<String?> inscricaoEstadual,
  Value<String?> inscricaoMunicipal,
  Value<String> endereco,
  Value<String> numero,
  Value<String?> complemento,
  Value<String> bairro,
  Value<String> cidade,
  Value<String> estado,
  Value<String> cep,
  Value<String?> telefone,
  Value<String?> celular,
  Value<String?> email,
  Value<String?> website,
  Value<bool> exibirLogo,
  Value<String?> caminhoLogo,
  Value<String?> mensagemRodape,
  Value<bool> exibirQrCode,
  Value<String?> corPrimaria,
  Value<String?> banco,
  Value<String?> agencia,
  Value<String?> conta,
  Value<String?> pix,
  Value<String?> regimeTributario,
  Value<bool> emitirNfce,
  Value<String?> certificadoA1Path,
  Value<String?> senhaA1,
  Value<DateTime?> criadoEm,
  Value<DateTime?> atualizadoEm,
});

class $$EmpresaConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $EmpresaConfigsTable> {
  $$EmpresaConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeEmpresa => $composableBuilder(
      column: $table.nomeEmpresa, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeFantasia => $composableBuilder(
      column: $table.nomeFantasia, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipoEmpresa => $composableBuilder(
      column: $table.tipoEmpresa, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get documento => $composableBuilder(
      column: $table.documento, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inscricaoEstadual => $composableBuilder(
      column: $table.inscricaoEstadual,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inscricaoMunicipal => $composableBuilder(
      column: $table.inscricaoMunicipal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endereco => $composableBuilder(
      column: $table.endereco, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get complemento => $composableBuilder(
      column: $table.complemento, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bairro => $composableBuilder(
      column: $table.bairro, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cep => $composableBuilder(
      column: $table.cep, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get celular => $composableBuilder(
      column: $table.celular, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get exibirLogo => $composableBuilder(
      column: $table.exibirLogo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get caminhoLogo => $composableBuilder(
      column: $table.caminhoLogo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mensagemRodape => $composableBuilder(
      column: $table.mensagemRodape,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get exibirQrCode => $composableBuilder(
      column: $table.exibirQrCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get corPrimaria => $composableBuilder(
      column: $table.corPrimaria, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get banco => $composableBuilder(
      column: $table.banco, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get agencia => $composableBuilder(
      column: $table.agencia, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get conta => $composableBuilder(
      column: $table.conta, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pix => $composableBuilder(
      column: $table.pix, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get regimeTributario => $composableBuilder(
      column: $table.regimeTributario,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get emitirNfce => $composableBuilder(
      column: $table.emitirNfce, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get certificadoA1Path => $composableBuilder(
      column: $table.certificadoA1Path,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get senhaA1 => $composableBuilder(
      column: $table.senhaA1, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => ColumnFilters(column));
}

class $$EmpresaConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $EmpresaConfigsTable> {
  $$EmpresaConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeEmpresa => $composableBuilder(
      column: $table.nomeEmpresa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeFantasia => $composableBuilder(
      column: $table.nomeFantasia,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipoEmpresa => $composableBuilder(
      column: $table.tipoEmpresa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get documento => $composableBuilder(
      column: $table.documento, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inscricaoEstadual => $composableBuilder(
      column: $table.inscricaoEstadual,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inscricaoMunicipal => $composableBuilder(
      column: $table.inscricaoMunicipal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endereco => $composableBuilder(
      column: $table.endereco, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get complemento => $composableBuilder(
      column: $table.complemento, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bairro => $composableBuilder(
      column: $table.bairro, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cep => $composableBuilder(
      column: $table.cep, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get celular => $composableBuilder(
      column: $table.celular, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get exibirLogo => $composableBuilder(
      column: $table.exibirLogo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get caminhoLogo => $composableBuilder(
      column: $table.caminhoLogo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mensagemRodape => $composableBuilder(
      column: $table.mensagemRodape,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get exibirQrCode => $composableBuilder(
      column: $table.exibirQrCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get corPrimaria => $composableBuilder(
      column: $table.corPrimaria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get banco => $composableBuilder(
      column: $table.banco, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get agencia => $composableBuilder(
      column: $table.agencia, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conta => $composableBuilder(
      column: $table.conta, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pix => $composableBuilder(
      column: $table.pix, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get regimeTributario => $composableBuilder(
      column: $table.regimeTributario,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get emitirNfce => $composableBuilder(
      column: $table.emitirNfce, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get certificadoA1Path => $composableBuilder(
      column: $table.certificadoA1Path,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get senhaA1 => $composableBuilder(
      column: $table.senhaA1, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm,
      builder: (column) => ColumnOrderings(column));
}

class $$EmpresaConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmpresaConfigsTable> {
  $$EmpresaConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nomeEmpresa => $composableBuilder(
      column: $table.nomeEmpresa, builder: (column) => column);

  GeneratedColumn<String> get nomeFantasia => $composableBuilder(
      column: $table.nomeFantasia, builder: (column) => column);

  GeneratedColumn<String> get tipoEmpresa => $composableBuilder(
      column: $table.tipoEmpresa, builder: (column) => column);

  GeneratedColumn<String> get documento =>
      $composableBuilder(column: $table.documento, builder: (column) => column);

  GeneratedColumn<String> get inscricaoEstadual => $composableBuilder(
      column: $table.inscricaoEstadual, builder: (column) => column);

  GeneratedColumn<String> get inscricaoMunicipal => $composableBuilder(
      column: $table.inscricaoMunicipal, builder: (column) => column);

  GeneratedColumn<String> get endereco =>
      $composableBuilder(column: $table.endereco, builder: (column) => column);

  GeneratedColumn<String> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<String> get complemento => $composableBuilder(
      column: $table.complemento, builder: (column) => column);

  GeneratedColumn<String> get bairro =>
      $composableBuilder(column: $table.bairro, builder: (column) => column);

  GeneratedColumn<String> get cidade =>
      $composableBuilder(column: $table.cidade, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get cep =>
      $composableBuilder(column: $table.cep, builder: (column) => column);

  GeneratedColumn<String> get telefone =>
      $composableBuilder(column: $table.telefone, builder: (column) => column);

  GeneratedColumn<String> get celular =>
      $composableBuilder(column: $table.celular, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<bool> get exibirLogo => $composableBuilder(
      column: $table.exibirLogo, builder: (column) => column);

  GeneratedColumn<String> get caminhoLogo => $composableBuilder(
      column: $table.caminhoLogo, builder: (column) => column);

  GeneratedColumn<String> get mensagemRodape => $composableBuilder(
      column: $table.mensagemRodape, builder: (column) => column);

  GeneratedColumn<bool> get exibirQrCode => $composableBuilder(
      column: $table.exibirQrCode, builder: (column) => column);

  GeneratedColumn<String> get corPrimaria => $composableBuilder(
      column: $table.corPrimaria, builder: (column) => column);

  GeneratedColumn<String> get banco =>
      $composableBuilder(column: $table.banco, builder: (column) => column);

  GeneratedColumn<String> get agencia =>
      $composableBuilder(column: $table.agencia, builder: (column) => column);

  GeneratedColumn<String> get conta =>
      $composableBuilder(column: $table.conta, builder: (column) => column);

  GeneratedColumn<String> get pix =>
      $composableBuilder(column: $table.pix, builder: (column) => column);

  GeneratedColumn<String> get regimeTributario => $composableBuilder(
      column: $table.regimeTributario, builder: (column) => column);

  GeneratedColumn<bool> get emitirNfce => $composableBuilder(
      column: $table.emitirNfce, builder: (column) => column);

  GeneratedColumn<String> get certificadoA1Path => $composableBuilder(
      column: $table.certificadoA1Path, builder: (column) => column);

  GeneratedColumn<String> get senhaA1 =>
      $composableBuilder(column: $table.senhaA1, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  GeneratedColumn<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => column);
}

class $$EmpresaConfigsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EmpresaConfigsTable,
    EmpresaConfigData,
    $$EmpresaConfigsTableFilterComposer,
    $$EmpresaConfigsTableOrderingComposer,
    $$EmpresaConfigsTableAnnotationComposer,
    $$EmpresaConfigsTableCreateCompanionBuilder,
    $$EmpresaConfigsTableUpdateCompanionBuilder,
    (
      EmpresaConfigData,
      BaseReferences<_$AppDatabase, $EmpresaConfigsTable, EmpresaConfigData>
    ),
    EmpresaConfigData,
    PrefetchHooks Function()> {
  $$EmpresaConfigsTableTableManager(
      _$AppDatabase db, $EmpresaConfigsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmpresaConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmpresaConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmpresaConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nomeEmpresa = const Value.absent(),
            Value<String?> nomeFantasia = const Value.absent(),
            Value<String> tipoEmpresa = const Value.absent(),
            Value<String> documento = const Value.absent(),
            Value<String?> inscricaoEstadual = const Value.absent(),
            Value<String?> inscricaoMunicipal = const Value.absent(),
            Value<String> endereco = const Value.absent(),
            Value<String> numero = const Value.absent(),
            Value<String?> complemento = const Value.absent(),
            Value<String> bairro = const Value.absent(),
            Value<String> cidade = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<String> cep = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<String?> celular = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<bool> exibirLogo = const Value.absent(),
            Value<String?> caminhoLogo = const Value.absent(),
            Value<String?> mensagemRodape = const Value.absent(),
            Value<bool> exibirQrCode = const Value.absent(),
            Value<String?> corPrimaria = const Value.absent(),
            Value<String?> banco = const Value.absent(),
            Value<String?> agencia = const Value.absent(),
            Value<String?> conta = const Value.absent(),
            Value<String?> pix = const Value.absent(),
            Value<String?> regimeTributario = const Value.absent(),
            Value<bool> emitirNfce = const Value.absent(),
            Value<String?> certificadoA1Path = const Value.absent(),
            Value<String?> senhaA1 = const Value.absent(),
            Value<DateTime?> criadoEm = const Value.absent(),
            Value<DateTime?> atualizadoEm = const Value.absent(),
          }) =>
              EmpresaConfigsCompanion(
            id: id,
            nomeEmpresa: nomeEmpresa,
            nomeFantasia: nomeFantasia,
            tipoEmpresa: tipoEmpresa,
            documento: documento,
            inscricaoEstadual: inscricaoEstadual,
            inscricaoMunicipal: inscricaoMunicipal,
            endereco: endereco,
            numero: numero,
            complemento: complemento,
            bairro: bairro,
            cidade: cidade,
            estado: estado,
            cep: cep,
            telefone: telefone,
            celular: celular,
            email: email,
            website: website,
            exibirLogo: exibirLogo,
            caminhoLogo: caminhoLogo,
            mensagemRodape: mensagemRodape,
            exibirQrCode: exibirQrCode,
            corPrimaria: corPrimaria,
            banco: banco,
            agencia: agencia,
            conta: conta,
            pix: pix,
            regimeTributario: regimeTributario,
            emitirNfce: emitirNfce,
            certificadoA1Path: certificadoA1Path,
            senhaA1: senhaA1,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nomeEmpresa,
            Value<String?> nomeFantasia = const Value.absent(),
            required String tipoEmpresa,
            required String documento,
            Value<String?> inscricaoEstadual = const Value.absent(),
            Value<String?> inscricaoMunicipal = const Value.absent(),
            required String endereco,
            required String numero,
            Value<String?> complemento = const Value.absent(),
            required String bairro,
            required String cidade,
            required String estado,
            required String cep,
            Value<String?> telefone = const Value.absent(),
            Value<String?> celular = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<bool> exibirLogo = const Value.absent(),
            Value<String?> caminhoLogo = const Value.absent(),
            Value<String?> mensagemRodape = const Value.absent(),
            Value<bool> exibirQrCode = const Value.absent(),
            Value<String?> corPrimaria = const Value.absent(),
            Value<String?> banco = const Value.absent(),
            Value<String?> agencia = const Value.absent(),
            Value<String?> conta = const Value.absent(),
            Value<String?> pix = const Value.absent(),
            Value<String?> regimeTributario = const Value.absent(),
            Value<bool> emitirNfce = const Value.absent(),
            Value<String?> certificadoA1Path = const Value.absent(),
            Value<String?> senhaA1 = const Value.absent(),
            Value<DateTime?> criadoEm = const Value.absent(),
            Value<DateTime?> atualizadoEm = const Value.absent(),
          }) =>
              EmpresaConfigsCompanion.insert(
            id: id,
            nomeEmpresa: nomeEmpresa,
            nomeFantasia: nomeFantasia,
            tipoEmpresa: tipoEmpresa,
            documento: documento,
            inscricaoEstadual: inscricaoEstadual,
            inscricaoMunicipal: inscricaoMunicipal,
            endereco: endereco,
            numero: numero,
            complemento: complemento,
            bairro: bairro,
            cidade: cidade,
            estado: estado,
            cep: cep,
            telefone: telefone,
            celular: celular,
            email: email,
            website: website,
            exibirLogo: exibirLogo,
            caminhoLogo: caminhoLogo,
            mensagemRodape: mensagemRodape,
            exibirQrCode: exibirQrCode,
            corPrimaria: corPrimaria,
            banco: banco,
            agencia: agencia,
            conta: conta,
            pix: pix,
            regimeTributario: regimeTributario,
            emitirNfce: emitirNfce,
            certificadoA1Path: certificadoA1Path,
            senhaA1: senhaA1,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EmpresaConfigsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EmpresaConfigsTable,
    EmpresaConfigData,
    $$EmpresaConfigsTableFilterComposer,
    $$EmpresaConfigsTableOrderingComposer,
    $$EmpresaConfigsTableAnnotationComposer,
    $$EmpresaConfigsTableCreateCompanionBuilder,
    $$EmpresaConfigsTableUpdateCompanionBuilder,
    (
      EmpresaConfigData,
      BaseReferences<_$AppDatabase, $EmpresaConfigsTable, EmpresaConfigData>
    ),
    EmpresaConfigData,
    PrefetchHooks Function()>;
typedef $$UsuarioTableTableCreateCompanionBuilder = UsuarioTableCompanion
    Function({
  Value<int> id,
  required String nome,
  required String email,
  required String senha,
  required String empresa,
  Value<String?> cnpj,
  Value<String?> telefone,
  Value<String?> endereco,
  Value<String?> cidade,
  Value<String?> estado,
  Value<String?> cep,
  Value<String?> logoPath,
  Value<String?> corPrimaria,
  Value<String?> corSecundaria,
  Value<String?> nomeFantasia,
  Value<String> role,
  Value<bool> ativo,
  Value<DateTime> criadoEm,
  Value<DateTime> atualizadoEm,
  Value<DateTime?> ultimoLogin,
});
typedef $$UsuarioTableTableUpdateCompanionBuilder = UsuarioTableCompanion
    Function({
  Value<int> id,
  Value<String> nome,
  Value<String> email,
  Value<String> senha,
  Value<String> empresa,
  Value<String?> cnpj,
  Value<String?> telefone,
  Value<String?> endereco,
  Value<String?> cidade,
  Value<String?> estado,
  Value<String?> cep,
  Value<String?> logoPath,
  Value<String?> corPrimaria,
  Value<String?> corSecundaria,
  Value<String?> nomeFantasia,
  Value<String> role,
  Value<bool> ativo,
  Value<DateTime> criadoEm,
  Value<DateTime> atualizadoEm,
  Value<DateTime?> ultimoLogin,
});

final class $$UsuarioTableTableReferences
    extends BaseReferences<_$AppDatabase, $UsuarioTableTable, Usuario> {
  $$UsuarioTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AssinaturaTableTable, List<Assinatura>>
      _assinaturaTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.assinaturaTable,
              aliasName: $_aliasNameGenerator(
                  db.usuarioTable.id, db.assinaturaTable.usuarioId));

  $$AssinaturaTableTableProcessedTableManager get assinaturaTableRefs {
    final manager =
        $$AssinaturaTableTableTableManager($_db, $_db.assinaturaTable)
            .filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_assinaturaTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsuarioTableTableFilterComposer
    extends Composer<_$AppDatabase, $UsuarioTableTable> {
  $$UsuarioTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get senha => $composableBuilder(
      column: $table.senha, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get empresa => $composableBuilder(
      column: $table.empresa, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cnpj => $composableBuilder(
      column: $table.cnpj, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endereco => $composableBuilder(
      column: $table.endereco, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cep => $composableBuilder(
      column: $table.cep, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logoPath => $composableBuilder(
      column: $table.logoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get corPrimaria => $composableBuilder(
      column: $table.corPrimaria, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get corSecundaria => $composableBuilder(
      column: $table.corSecundaria, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeFantasia => $composableBuilder(
      column: $table.nomeFantasia, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get ultimoLogin => $composableBuilder(
      column: $table.ultimoLogin, builder: (column) => ColumnFilters(column));

  Expression<bool> assinaturaTableRefs(
      Expression<bool> Function($$AssinaturaTableTableFilterComposer f) f) {
    final $$AssinaturaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assinaturaTable,
        getReferencedColumn: (t) => t.usuarioId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssinaturaTableTableFilterComposer(
              $db: $db,
              $table: $db.assinaturaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsuarioTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuarioTableTable> {
  $$UsuarioTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get senha => $composableBuilder(
      column: $table.senha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get empresa => $composableBuilder(
      column: $table.empresa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cnpj => $composableBuilder(
      column: $table.cnpj, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endereco => $composableBuilder(
      column: $table.endereco, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cep => $composableBuilder(
      column: $table.cep, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logoPath => $composableBuilder(
      column: $table.logoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get corPrimaria => $composableBuilder(
      column: $table.corPrimaria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get corSecundaria => $composableBuilder(
      column: $table.corSecundaria,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeFantasia => $composableBuilder(
      column: $table.nomeFantasia,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get ultimoLogin => $composableBuilder(
      column: $table.ultimoLogin, builder: (column) => ColumnOrderings(column));
}

class $$UsuarioTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuarioTableTable> {
  $$UsuarioTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get senha =>
      $composableBuilder(column: $table.senha, builder: (column) => column);

  GeneratedColumn<String> get empresa =>
      $composableBuilder(column: $table.empresa, builder: (column) => column);

  GeneratedColumn<String> get cnpj =>
      $composableBuilder(column: $table.cnpj, builder: (column) => column);

  GeneratedColumn<String> get telefone =>
      $composableBuilder(column: $table.telefone, builder: (column) => column);

  GeneratedColumn<String> get endereco =>
      $composableBuilder(column: $table.endereco, builder: (column) => column);

  GeneratedColumn<String> get cidade =>
      $composableBuilder(column: $table.cidade, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get cep =>
      $composableBuilder(column: $table.cep, builder: (column) => column);

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<String> get corPrimaria => $composableBuilder(
      column: $table.corPrimaria, builder: (column) => column);

  GeneratedColumn<String> get corSecundaria => $composableBuilder(
      column: $table.corSecundaria, builder: (column) => column);

  GeneratedColumn<String> get nomeFantasia => $composableBuilder(
      column: $table.nomeFantasia, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  GeneratedColumn<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => column);

  GeneratedColumn<DateTime> get ultimoLogin => $composableBuilder(
      column: $table.ultimoLogin, builder: (column) => column);

  Expression<T> assinaturaTableRefs<T extends Object>(
      Expression<T> Function($$AssinaturaTableTableAnnotationComposer a) f) {
    final $$AssinaturaTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assinaturaTable,
        getReferencedColumn: (t) => t.usuarioId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssinaturaTableTableAnnotationComposer(
              $db: $db,
              $table: $db.assinaturaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsuarioTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsuarioTableTable,
    Usuario,
    $$UsuarioTableTableFilterComposer,
    $$UsuarioTableTableOrderingComposer,
    $$UsuarioTableTableAnnotationComposer,
    $$UsuarioTableTableCreateCompanionBuilder,
    $$UsuarioTableTableUpdateCompanionBuilder,
    (Usuario, $$UsuarioTableTableReferences),
    Usuario,
    PrefetchHooks Function({bool assinaturaTableRefs})> {
  $$UsuarioTableTableTableManager(_$AppDatabase db, $UsuarioTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuarioTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuarioTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuarioTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> senha = const Value.absent(),
            Value<String> empresa = const Value.absent(),
            Value<String?> cnpj = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<String?> endereco = const Value.absent(),
            Value<String?> cidade = const Value.absent(),
            Value<String?> estado = const Value.absent(),
            Value<String?> cep = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<String?> corPrimaria = const Value.absent(),
            Value<String?> corSecundaria = const Value.absent(),
            Value<String?> nomeFantasia = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
            Value<DateTime> atualizadoEm = const Value.absent(),
            Value<DateTime?> ultimoLogin = const Value.absent(),
          }) =>
              UsuarioTableCompanion(
            id: id,
            nome: nome,
            email: email,
            senha: senha,
            empresa: empresa,
            cnpj: cnpj,
            telefone: telefone,
            endereco: endereco,
            cidade: cidade,
            estado: estado,
            cep: cep,
            logoPath: logoPath,
            corPrimaria: corPrimaria,
            corSecundaria: corSecundaria,
            nomeFantasia: nomeFantasia,
            role: role,
            ativo: ativo,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
            ultimoLogin: ultimoLogin,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nome,
            required String email,
            required String senha,
            required String empresa,
            Value<String?> cnpj = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<String?> endereco = const Value.absent(),
            Value<String?> cidade = const Value.absent(),
            Value<String?> estado = const Value.absent(),
            Value<String?> cep = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<String?> corPrimaria = const Value.absent(),
            Value<String?> corSecundaria = const Value.absent(),
            Value<String?> nomeFantasia = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
            Value<DateTime> atualizadoEm = const Value.absent(),
            Value<DateTime?> ultimoLogin = const Value.absent(),
          }) =>
              UsuarioTableCompanion.insert(
            id: id,
            nome: nome,
            email: email,
            senha: senha,
            empresa: empresa,
            cnpj: cnpj,
            telefone: telefone,
            endereco: endereco,
            cidade: cidade,
            estado: estado,
            cep: cep,
            logoPath: logoPath,
            corPrimaria: corPrimaria,
            corSecundaria: corSecundaria,
            nomeFantasia: nomeFantasia,
            role: role,
            ativo: ativo,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
            ultimoLogin: ultimoLogin,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UsuarioTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({assinaturaTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (assinaturaTableRefs) db.assinaturaTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (assinaturaTableRefs)
                    await $_getPrefetchedData<Usuario, $UsuarioTableTable,
                            Assinatura>(
                        currentTable: table,
                        referencedTable: $$UsuarioTableTableReferences
                            ._assinaturaTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsuarioTableTableReferences(db, table, p0)
                                .assinaturaTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.usuarioId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsuarioTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsuarioTableTable,
    Usuario,
    $$UsuarioTableTableFilterComposer,
    $$UsuarioTableTableOrderingComposer,
    $$UsuarioTableTableAnnotationComposer,
    $$UsuarioTableTableCreateCompanionBuilder,
    $$UsuarioTableTableUpdateCompanionBuilder,
    (Usuario, $$UsuarioTableTableReferences),
    Usuario,
    PrefetchHooks Function({bool assinaturaTableRefs})>;
typedef $$AssinaturaTableTableCreateCompanionBuilder = AssinaturaTableCompanion
    Function({
  Value<int> id,
  required int usuarioId,
  required TipoAssinatura tipo,
  Value<StatusAssinatura> status,
  required DateTime dataInicio,
  required DateTime dataFim,
  Value<DateTime> criadoEm,
  Value<DateTime> atualizadoEm,
  Value<double?> valor,
  Value<bool> pago,
  Value<DateTime?> dataPagamento,
  Value<String?> metodoPagamento,
  Value<String?> transacaoId,
  Value<String?> observacoes,
});
typedef $$AssinaturaTableTableUpdateCompanionBuilder = AssinaturaTableCompanion
    Function({
  Value<int> id,
  Value<int> usuarioId,
  Value<TipoAssinatura> tipo,
  Value<StatusAssinatura> status,
  Value<DateTime> dataInicio,
  Value<DateTime> dataFim,
  Value<DateTime> criadoEm,
  Value<DateTime> atualizadoEm,
  Value<double?> valor,
  Value<bool> pago,
  Value<DateTime?> dataPagamento,
  Value<String?> metodoPagamento,
  Value<String?> transacaoId,
  Value<String?> observacoes,
});

final class $$AssinaturaTableTableReferences
    extends BaseReferences<_$AppDatabase, $AssinaturaTableTable, Assinatura> {
  $$AssinaturaTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsuarioTableTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarioTable.createAlias($_aliasNameGenerator(
          db.assinaturaTable.usuarioId, db.usuarioTable.id));

  $$UsuarioTableTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<int>('usuario_id')!;

    final manager = $$UsuarioTableTableTableManager($_db, $_db.usuarioTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AssinaturaTableTableFilterComposer
    extends Composer<_$AppDatabase, $AssinaturaTableTable> {
  $$AssinaturaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TipoAssinatura, TipoAssinatura, int>
      get tipo => $composableBuilder(
          column: $table.tipo,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<StatusAssinatura, StatusAssinatura, int>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataFim => $composableBuilder(
      column: $table.dataFim, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valor => $composableBuilder(
      column: $table.valor, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pago => $composableBuilder(
      column: $table.pago, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataPagamento => $composableBuilder(
      column: $table.dataPagamento, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metodoPagamento => $composableBuilder(
      column: $table.metodoPagamento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transacaoId => $composableBuilder(
      column: $table.transacaoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnFilters(column));

  $$UsuarioTableTableFilterComposer get usuarioId {
    final $$UsuarioTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuarioTableTableFilterComposer(
              $db: $db,
              $table: $db.usuarioTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssinaturaTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AssinaturaTableTable> {
  $$AssinaturaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataFim => $composableBuilder(
      column: $table.dataFim, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valor => $composableBuilder(
      column: $table.valor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pago => $composableBuilder(
      column: $table.pago, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataPagamento => $composableBuilder(
      column: $table.dataPagamento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metodoPagamento => $composableBuilder(
      column: $table.metodoPagamento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transacaoId => $composableBuilder(
      column: $table.transacaoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnOrderings(column));

  $$UsuarioTableTableOrderingComposer get usuarioId {
    final $$UsuarioTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuarioTableTableOrderingComposer(
              $db: $db,
              $table: $db.usuarioTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssinaturaTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssinaturaTableTable> {
  $$AssinaturaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoAssinatura, int> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StatusAssinatura, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => column);

  GeneratedColumn<DateTime> get dataFim =>
      $composableBuilder(column: $table.dataFim, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  GeneratedColumn<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => column);

  GeneratedColumn<double> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);

  GeneratedColumn<bool> get pago =>
      $composableBuilder(column: $table.pago, builder: (column) => column);

  GeneratedColumn<DateTime> get dataPagamento => $composableBuilder(
      column: $table.dataPagamento, builder: (column) => column);

  GeneratedColumn<String> get metodoPagamento => $composableBuilder(
      column: $table.metodoPagamento, builder: (column) => column);

  GeneratedColumn<String> get transacaoId => $composableBuilder(
      column: $table.transacaoId, builder: (column) => column);

  GeneratedColumn<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => column);

  $$UsuarioTableTableAnnotationComposer get usuarioId {
    final $$UsuarioTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuarioTableTableAnnotationComposer(
              $db: $db,
              $table: $db.usuarioTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssinaturaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssinaturaTableTable,
    Assinatura,
    $$AssinaturaTableTableFilterComposer,
    $$AssinaturaTableTableOrderingComposer,
    $$AssinaturaTableTableAnnotationComposer,
    $$AssinaturaTableTableCreateCompanionBuilder,
    $$AssinaturaTableTableUpdateCompanionBuilder,
    (Assinatura, $$AssinaturaTableTableReferences),
    Assinatura,
    PrefetchHooks Function({bool usuarioId})> {
  $$AssinaturaTableTableTableManager(
      _$AppDatabase db, $AssinaturaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssinaturaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssinaturaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssinaturaTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> usuarioId = const Value.absent(),
            Value<TipoAssinatura> tipo = const Value.absent(),
            Value<StatusAssinatura> status = const Value.absent(),
            Value<DateTime> dataInicio = const Value.absent(),
            Value<DateTime> dataFim = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
            Value<DateTime> atualizadoEm = const Value.absent(),
            Value<double?> valor = const Value.absent(),
            Value<bool> pago = const Value.absent(),
            Value<DateTime?> dataPagamento = const Value.absent(),
            Value<String?> metodoPagamento = const Value.absent(),
            Value<String?> transacaoId = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
          }) =>
              AssinaturaTableCompanion(
            id: id,
            usuarioId: usuarioId,
            tipo: tipo,
            status: status,
            dataInicio: dataInicio,
            dataFim: dataFim,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
            valor: valor,
            pago: pago,
            dataPagamento: dataPagamento,
            metodoPagamento: metodoPagamento,
            transacaoId: transacaoId,
            observacoes: observacoes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int usuarioId,
            required TipoAssinatura tipo,
            Value<StatusAssinatura> status = const Value.absent(),
            required DateTime dataInicio,
            required DateTime dataFim,
            Value<DateTime> criadoEm = const Value.absent(),
            Value<DateTime> atualizadoEm = const Value.absent(),
            Value<double?> valor = const Value.absent(),
            Value<bool> pago = const Value.absent(),
            Value<DateTime?> dataPagamento = const Value.absent(),
            Value<String?> metodoPagamento = const Value.absent(),
            Value<String?> transacaoId = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
          }) =>
              AssinaturaTableCompanion.insert(
            id: id,
            usuarioId: usuarioId,
            tipo: tipo,
            status: status,
            dataInicio: dataInicio,
            dataFim: dataFim,
            criadoEm: criadoEm,
            atualizadoEm: atualizadoEm,
            valor: valor,
            pago: pago,
            dataPagamento: dataPagamento,
            metodoPagamento: metodoPagamento,
            transacaoId: transacaoId,
            observacoes: observacoes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AssinaturaTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({usuarioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (usuarioId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.usuarioId,
                    referencedTable:
                        $$AssinaturaTableTableReferences._usuarioIdTable(db),
                    referencedColumn:
                        $$AssinaturaTableTableReferences._usuarioIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AssinaturaTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AssinaturaTableTable,
    Assinatura,
    $$AssinaturaTableTableFilterComposer,
    $$AssinaturaTableTableOrderingComposer,
    $$AssinaturaTableTableAnnotationComposer,
    $$AssinaturaTableTableCreateCompanionBuilder,
    $$AssinaturaTableTableUpdateCompanionBuilder,
    (Assinatura, $$AssinaturaTableTableReferences),
    Assinatura,
    PrefetchHooks Function({bool usuarioId})>;
typedef $$WhatsAppMessagesTableTableCreateCompanionBuilder
    = WhatsAppMessagesTableCompanion Function({
  Value<int> id,
  required String clienteId,
  required String telefone,
  required String mensagem,
  required String tipo,
  Value<String> status,
  Value<DateTime?> dataEnvio,
  Value<DateTime?> dataEntrega,
  Value<DateTime?> dataLeitura,
  Value<String?> erro,
  Value<String?> metadata,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$WhatsAppMessagesTableTableUpdateCompanionBuilder
    = WhatsAppMessagesTableCompanion Function({
  Value<int> id,
  Value<String> clienteId,
  Value<String> telefone,
  Value<String> mensagem,
  Value<String> tipo,
  Value<String> status,
  Value<DateTime?> dataEnvio,
  Value<DateTime?> dataEntrega,
  Value<DateTime?> dataLeitura,
  Value<String?> erro,
  Value<String?> metadata,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$WhatsAppMessagesTableTableFilterComposer
    extends Composer<_$AppDatabase, $WhatsAppMessagesTableTable> {
  $$WhatsAppMessagesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mensagem => $composableBuilder(
      column: $table.mensagem, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataEnvio => $composableBuilder(
      column: $table.dataEnvio, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataEntrega => $composableBuilder(
      column: $table.dataEntrega, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataLeitura => $composableBuilder(
      column: $table.dataLeitura, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get erro => $composableBuilder(
      column: $table.erro, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$WhatsAppMessagesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WhatsAppMessagesTableTable> {
  $$WhatsAppMessagesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mensagem => $composableBuilder(
      column: $table.mensagem, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataEnvio => $composableBuilder(
      column: $table.dataEnvio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataEntrega => $composableBuilder(
      column: $table.dataEntrega, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataLeitura => $composableBuilder(
      column: $table.dataLeitura, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get erro => $composableBuilder(
      column: $table.erro, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WhatsAppMessagesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WhatsAppMessagesTableTable> {
  $$WhatsAppMessagesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clienteId =>
      $composableBuilder(column: $table.clienteId, builder: (column) => column);

  GeneratedColumn<String> get telefone =>
      $composableBuilder(column: $table.telefone, builder: (column) => column);

  GeneratedColumn<String> get mensagem =>
      $composableBuilder(column: $table.mensagem, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get dataEnvio =>
      $composableBuilder(column: $table.dataEnvio, builder: (column) => column);

  GeneratedColumn<DateTime> get dataEntrega => $composableBuilder(
      column: $table.dataEntrega, builder: (column) => column);

  GeneratedColumn<DateTime> get dataLeitura => $composableBuilder(
      column: $table.dataLeitura, builder: (column) => column);

  GeneratedColumn<String> get erro =>
      $composableBuilder(column: $table.erro, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WhatsAppMessagesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WhatsAppMessagesTableTable,
    WhatsAppMessagesTableData,
    $$WhatsAppMessagesTableTableFilterComposer,
    $$WhatsAppMessagesTableTableOrderingComposer,
    $$WhatsAppMessagesTableTableAnnotationComposer,
    $$WhatsAppMessagesTableTableCreateCompanionBuilder,
    $$WhatsAppMessagesTableTableUpdateCompanionBuilder,
    (
      WhatsAppMessagesTableData,
      BaseReferences<_$AppDatabase, $WhatsAppMessagesTableTable,
          WhatsAppMessagesTableData>
    ),
    WhatsAppMessagesTableData,
    PrefetchHooks Function()> {
  $$WhatsAppMessagesTableTableTableManager(
      _$AppDatabase db, $WhatsAppMessagesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WhatsAppMessagesTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$WhatsAppMessagesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WhatsAppMessagesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> clienteId = const Value.absent(),
            Value<String> telefone = const Value.absent(),
            Value<String> mensagem = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> dataEnvio = const Value.absent(),
            Value<DateTime?> dataEntrega = const Value.absent(),
            Value<DateTime?> dataLeitura = const Value.absent(),
            Value<String?> erro = const Value.absent(),
            Value<String?> metadata = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WhatsAppMessagesTableCompanion(
            id: id,
            clienteId: clienteId,
            telefone: telefone,
            mensagem: mensagem,
            tipo: tipo,
            status: status,
            dataEnvio: dataEnvio,
            dataEntrega: dataEntrega,
            dataLeitura: dataLeitura,
            erro: erro,
            metadata: metadata,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String clienteId,
            required String telefone,
            required String mensagem,
            required String tipo,
            Value<String> status = const Value.absent(),
            Value<DateTime?> dataEnvio = const Value.absent(),
            Value<DateTime?> dataEntrega = const Value.absent(),
            Value<DateTime?> dataLeitura = const Value.absent(),
            Value<String?> erro = const Value.absent(),
            Value<String?> metadata = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WhatsAppMessagesTableCompanion.insert(
            id: id,
            clienteId: clienteId,
            telefone: telefone,
            mensagem: mensagem,
            tipo: tipo,
            status: status,
            dataEnvio: dataEnvio,
            dataEntrega: dataEntrega,
            dataLeitura: dataLeitura,
            erro: erro,
            metadata: metadata,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WhatsAppMessagesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $WhatsAppMessagesTableTable,
        WhatsAppMessagesTableData,
        $$WhatsAppMessagesTableTableFilterComposer,
        $$WhatsAppMessagesTableTableOrderingComposer,
        $$WhatsAppMessagesTableTableAnnotationComposer,
        $$WhatsAppMessagesTableTableCreateCompanionBuilder,
        $$WhatsAppMessagesTableTableUpdateCompanionBuilder,
        (
          WhatsAppMessagesTableData,
          BaseReferences<_$AppDatabase, $WhatsAppMessagesTableTable,
              WhatsAppMessagesTableData>
        ),
        WhatsAppMessagesTableData,
        PrefetchHooks Function()>;
typedef $$WhatsAppConfigTableTableCreateCompanionBuilder
    = WhatsAppConfigTableCompanion Function({
  Value<int> id,
  required String apiUrl,
  required String apiToken,
  required String instanceId,
  Value<bool> ativo,
  Value<bool> enviarAgendamento,
  Value<bool> enviarLembretes,
  Value<bool> enviarConfirmacoes,
  Value<bool> enviarPromocoes,
  Value<int> horasAntesLembrete,
  Value<String> horarioInicioEnvio,
  Value<String> horarioFimEnvio,
  Value<String> diasSemanaEnvio,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$WhatsAppConfigTableTableUpdateCompanionBuilder
    = WhatsAppConfigTableCompanion Function({
  Value<int> id,
  Value<String> apiUrl,
  Value<String> apiToken,
  Value<String> instanceId,
  Value<bool> ativo,
  Value<bool> enviarAgendamento,
  Value<bool> enviarLembretes,
  Value<bool> enviarConfirmacoes,
  Value<bool> enviarPromocoes,
  Value<int> horasAntesLembrete,
  Value<String> horarioInicioEnvio,
  Value<String> horarioFimEnvio,
  Value<String> diasSemanaEnvio,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$WhatsAppConfigTableTableFilterComposer
    extends Composer<_$AppDatabase, $WhatsAppConfigTableTable> {
  $$WhatsAppConfigTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get apiUrl => $composableBuilder(
      column: $table.apiUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get apiToken => $composableBuilder(
      column: $table.apiToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enviarAgendamento => $composableBuilder(
      column: $table.enviarAgendamento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enviarLembretes => $composableBuilder(
      column: $table.enviarLembretes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enviarConfirmacoes => $composableBuilder(
      column: $table.enviarConfirmacoes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enviarPromocoes => $composableBuilder(
      column: $table.enviarPromocoes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get horasAntesLembrete => $composableBuilder(
      column: $table.horasAntesLembrete,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get horarioInicioEnvio => $composableBuilder(
      column: $table.horarioInicioEnvio,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get horarioFimEnvio => $composableBuilder(
      column: $table.horarioFimEnvio,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get diasSemanaEnvio => $composableBuilder(
      column: $table.diasSemanaEnvio,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$WhatsAppConfigTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WhatsAppConfigTableTable> {
  $$WhatsAppConfigTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get apiUrl => $composableBuilder(
      column: $table.apiUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get apiToken => $composableBuilder(
      column: $table.apiToken, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enviarAgendamento => $composableBuilder(
      column: $table.enviarAgendamento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enviarLembretes => $composableBuilder(
      column: $table.enviarLembretes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enviarConfirmacoes => $composableBuilder(
      column: $table.enviarConfirmacoes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enviarPromocoes => $composableBuilder(
      column: $table.enviarPromocoes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get horasAntesLembrete => $composableBuilder(
      column: $table.horasAntesLembrete,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get horarioInicioEnvio => $composableBuilder(
      column: $table.horarioInicioEnvio,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get horarioFimEnvio => $composableBuilder(
      column: $table.horarioFimEnvio,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get diasSemanaEnvio => $composableBuilder(
      column: $table.diasSemanaEnvio,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WhatsAppConfigTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WhatsAppConfigTableTable> {
  $$WhatsAppConfigTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get apiUrl =>
      $composableBuilder(column: $table.apiUrl, builder: (column) => column);

  GeneratedColumn<String> get apiToken =>
      $composableBuilder(column: $table.apiToken, builder: (column) => column);

  GeneratedColumn<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<bool> get enviarAgendamento => $composableBuilder(
      column: $table.enviarAgendamento, builder: (column) => column);

  GeneratedColumn<bool> get enviarLembretes => $composableBuilder(
      column: $table.enviarLembretes, builder: (column) => column);

  GeneratedColumn<bool> get enviarConfirmacoes => $composableBuilder(
      column: $table.enviarConfirmacoes, builder: (column) => column);

  GeneratedColumn<bool> get enviarPromocoes => $composableBuilder(
      column: $table.enviarPromocoes, builder: (column) => column);

  GeneratedColumn<int> get horasAntesLembrete => $composableBuilder(
      column: $table.horasAntesLembrete, builder: (column) => column);

  GeneratedColumn<String> get horarioInicioEnvio => $composableBuilder(
      column: $table.horarioInicioEnvio, builder: (column) => column);

  GeneratedColumn<String> get horarioFimEnvio => $composableBuilder(
      column: $table.horarioFimEnvio, builder: (column) => column);

  GeneratedColumn<String> get diasSemanaEnvio => $composableBuilder(
      column: $table.diasSemanaEnvio, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WhatsAppConfigTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WhatsAppConfigTableTable,
    WhatsAppConfigTableData,
    $$WhatsAppConfigTableTableFilterComposer,
    $$WhatsAppConfigTableTableOrderingComposer,
    $$WhatsAppConfigTableTableAnnotationComposer,
    $$WhatsAppConfigTableTableCreateCompanionBuilder,
    $$WhatsAppConfigTableTableUpdateCompanionBuilder,
    (
      WhatsAppConfigTableData,
      BaseReferences<_$AppDatabase, $WhatsAppConfigTableTable,
          WhatsAppConfigTableData>
    ),
    WhatsAppConfigTableData,
    PrefetchHooks Function()> {
  $$WhatsAppConfigTableTableTableManager(
      _$AppDatabase db, $WhatsAppConfigTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WhatsAppConfigTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WhatsAppConfigTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WhatsAppConfigTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> apiUrl = const Value.absent(),
            Value<String> apiToken = const Value.absent(),
            Value<String> instanceId = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<bool> enviarAgendamento = const Value.absent(),
            Value<bool> enviarLembretes = const Value.absent(),
            Value<bool> enviarConfirmacoes = const Value.absent(),
            Value<bool> enviarPromocoes = const Value.absent(),
            Value<int> horasAntesLembrete = const Value.absent(),
            Value<String> horarioInicioEnvio = const Value.absent(),
            Value<String> horarioFimEnvio = const Value.absent(),
            Value<String> diasSemanaEnvio = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WhatsAppConfigTableCompanion(
            id: id,
            apiUrl: apiUrl,
            apiToken: apiToken,
            instanceId: instanceId,
            ativo: ativo,
            enviarAgendamento: enviarAgendamento,
            enviarLembretes: enviarLembretes,
            enviarConfirmacoes: enviarConfirmacoes,
            enviarPromocoes: enviarPromocoes,
            horasAntesLembrete: horasAntesLembrete,
            horarioInicioEnvio: horarioInicioEnvio,
            horarioFimEnvio: horarioFimEnvio,
            diasSemanaEnvio: diasSemanaEnvio,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String apiUrl,
            required String apiToken,
            required String instanceId,
            Value<bool> ativo = const Value.absent(),
            Value<bool> enviarAgendamento = const Value.absent(),
            Value<bool> enviarLembretes = const Value.absent(),
            Value<bool> enviarConfirmacoes = const Value.absent(),
            Value<bool> enviarPromocoes = const Value.absent(),
            Value<int> horasAntesLembrete = const Value.absent(),
            Value<String> horarioInicioEnvio = const Value.absent(),
            Value<String> horarioFimEnvio = const Value.absent(),
            Value<String> diasSemanaEnvio = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WhatsAppConfigTableCompanion.insert(
            id: id,
            apiUrl: apiUrl,
            apiToken: apiToken,
            instanceId: instanceId,
            ativo: ativo,
            enviarAgendamento: enviarAgendamento,
            enviarLembretes: enviarLembretes,
            enviarConfirmacoes: enviarConfirmacoes,
            enviarPromocoes: enviarPromocoes,
            horasAntesLembrete: horasAntesLembrete,
            horarioInicioEnvio: horarioInicioEnvio,
            horarioFimEnvio: horarioFimEnvio,
            diasSemanaEnvio: diasSemanaEnvio,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WhatsAppConfigTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WhatsAppConfigTableTable,
    WhatsAppConfigTableData,
    $$WhatsAppConfigTableTableFilterComposer,
    $$WhatsAppConfigTableTableOrderingComposer,
    $$WhatsAppConfigTableTableAnnotationComposer,
    $$WhatsAppConfigTableTableCreateCompanionBuilder,
    $$WhatsAppConfigTableTableUpdateCompanionBuilder,
    (
      WhatsAppConfigTableData,
      BaseReferences<_$AppDatabase, $WhatsAppConfigTableTable,
          WhatsAppConfigTableData>
    ),
    WhatsAppConfigTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProdutoTableTableTableManager get produtoTable =>
      $$ProdutoTableTableTableManager(_db, _db.produtoTable);
  $$FornecedorTableTableTableManager get fornecedorTable =>
      $$FornecedorTableTableTableManager(_db, _db.fornecedorTable);
  $$PedidoCompraTableTableTableManager get pedidoCompraTable =>
      $$PedidoCompraTableTableTableManager(_db, _db.pedidoCompraTable);
  $$ItemCompraTableTableTableManager get itemCompraTable =>
      $$ItemCompraTableTableTableManager(_db, _db.itemCompraTable);
  $$VendaTableTableTableManager get vendaTable =>
      $$VendaTableTableTableManager(_db, _db.vendaTable);
  $$ItemVendaTableTableTableManager get itemVendaTable =>
      $$ItemVendaTableTableTableManager(_db, _db.itemVendaTable);
  $$ClienteTableTableTableManager get clienteTable =>
      $$ClienteTableTableTableManager(_db, _db.clienteTable);
  $$ServicosTableTableTableManager get servicosTable =>
      $$ServicosTableTableTableManager(_db, _db.servicosTable);
  $$OrcamentoTableTableTableManager get orcamentoTable =>
      $$OrcamentoTableTableTableManager(_db, _db.orcamentoTable);
  $$ItemOrcamentoTableTableTableManager get itemOrcamentoTable =>
      $$ItemOrcamentoTableTableTableManager(_db, _db.itemOrcamentoTable);
  $$OrdensServicoTableTableTableManager get ordensServicoTable =>
      $$OrdensServicoTableTableTableManager(_db, _db.ordensServicoTable);
  $$ItensOrdemServicoTableTableTableManager get itensOrdemServicoTable =>
      $$ItensOrdemServicoTableTableTableManager(
          _db, _db.itensOrdemServicoTable);
  $$AuditoriaTableTableTableManager get auditoriaTable =>
      $$AuditoriaTableTableTableManager(_db, _db.auditoriaTable);
  $$EmpresaConfigsTableTableManager get empresaConfigs =>
      $$EmpresaConfigsTableTableManager(_db, _db.empresaConfigs);
  $$UsuarioTableTableTableManager get usuarioTable =>
      $$UsuarioTableTableTableManager(_db, _db.usuarioTable);
  $$AssinaturaTableTableTableManager get assinaturaTable =>
      $$AssinaturaTableTableTableManager(_db, _db.assinaturaTable);
  $$WhatsAppMessagesTableTableTableManager get whatsAppMessagesTable =>
      $$WhatsAppMessagesTableTableTableManager(_db, _db.whatsAppMessagesTable);
  $$WhatsAppConfigTableTableTableManager get whatsAppConfigTable =>
      $$WhatsAppConfigTableTableTableManager(_db, _db.whatsAppConfigTable);
}
