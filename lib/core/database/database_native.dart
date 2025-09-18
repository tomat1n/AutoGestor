import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'database.dart';

AppDatabase constructDb() {
  return AppDatabase(DatabaseConnection(createDatabaseConnection()));
}

QueryExecutor createDatabaseConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'autogestor.db'));
    return NativeDatabase.createInBackground(file);
  });
}