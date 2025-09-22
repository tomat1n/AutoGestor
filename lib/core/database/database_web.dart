import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'database.dart';

AppDatabase constructDb() {
  return AppDatabase(_openConnection());
}

DatabaseConnection _openConnection() {
  return DatabaseConnection.delayed(Future(() async {
    try {
      // Usar WasmDatabase (API moderna recomendada)
      final result = await WasmDatabase.open(
        databaseName: 'autogestor_db',
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
      );
      return result.resolvedExecutor;
    } catch (e) {
      // Fallback para IndexedDB usando WasmDatabase
      final result = await WasmDatabase.open(
        databaseName: 'autogestor_db_fallback',
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
        // Usar IndexedDB como storage quando FileSystem Access API não estiver disponível
      );
      return result.resolvedExecutor;
    }
  }));
}