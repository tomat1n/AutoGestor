import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'orcamentos_service.dart';
import '../repositories/orcamentos_repository.dart';
import '../../data/repositories/orcamentos_repository_impl.dart';
import '../../../../core/providers/database_provider.dart';

final orcamentosServiceProvider = Provider<OrcamentosService>((ref) {
  final database = ref.watch(databaseProvider);
  final repository = OrcamentosRepositoryImpl(database);
  return OrcamentosService(repository);
});