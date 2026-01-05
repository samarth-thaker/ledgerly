import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgerly/features/goal/data/model/goal_model.dart';
final goalsListProvider = StreamProvider.autoDispose<List<GoalModel>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.goalDao.watchAllGoals().map(
    (event) => event.map((e) => e.toModel()).toList(),
  );
});

final pinnedGoalsProvider = StreamProvider.autoDispose((ref) {
  final db = ref.watch(databaseProvider);
  return db.goalDao.watchPinnedGoals().map(
    (list) => list.map((e) => e.toModel()).toList(),
  );
});