import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgerly/core/database/database_provider.dart';
class CategoriesActions {
  final Future<Category> Function(CategoriesCompanion) add;
  final Future<bool> Function(Category) update;
  final Future<int> Function(int) delete;

  CategoriesActions({
    required this.add,
    required this.update,
    required this.delete,
  });
}

/// Expose your CRUD methods via Riverpod
final categoriesActionsProvider = Provider<CategoriesActions>((ref) {
  final db = ref.watch(databaseProvider);
  return CategoriesActions(
    add: db.categoryDao.addCategory,
    update: db.categoryDao.updateCategory,
    delete: db.categoryDao.deleteCategoryById,
  );
});