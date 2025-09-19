import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database.dart';
import '../../../core/providers/database_provider.dart';
import '../repositories/ordens_servico_repository.dart';
import 'ordens_servico_service.dart';

final ordensServicoServiceProvider = Provider<OrdensServicoService>((ref) {
  final database = ref.read(databaseProvider);
  final repository = OrdensServicoRepositoryImpl(database);
  return OrdensServicoService(repository);
});