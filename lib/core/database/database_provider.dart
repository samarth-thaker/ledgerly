import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgerly/core/database/ledgerly_database.dart';
import 'package:ledgerly/core/utils/logger.dart';
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  Log.d(db.schemaVersion, label: 'database schema version');
  ref.onDispose(() => db.close());
  return db;
});