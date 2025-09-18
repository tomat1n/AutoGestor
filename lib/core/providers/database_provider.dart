import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../database/database_web.dart' if (dart.library.io) '../database/database_native.dart';

// Provider para o banco de dados
final databaseProvider = Provider<AppDatabase>((ref) {
  return constructDb();
});