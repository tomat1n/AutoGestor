import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:drift/web.dart';
import 'database.dart';

AppDatabase constructDb() {
  return AppDatabase(_openConnection());
}

DatabaseConnection _openConnection() {
  return DatabaseConnection.delayed(Future(() async {
    try {
      // Tentar usar WasmDatabase primeiro
      print('Tentando configurar WasmDatabase');
      final result = await WasmDatabase.open(
        databaseName: 'autogestor_db',
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
      );
      print('WasmDatabase configurado com sucesso');
      return result.resolvedExecutor;
    } catch (e) {
      // Fallback para IndexedDB
      print('WasmDatabase falhou, usando IndexedDB: $e');
      final webDb = WebDatabase.withStorage(
        DriftWebStorage.indexedDb('autogestor_db', migrateFromLocalStorage: false),
      );
      return DatabaseConnection.fromExecutor(webDb);
    }
  }));
}