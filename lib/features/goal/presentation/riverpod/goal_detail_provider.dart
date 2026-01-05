import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgerly/features/goal/data/model/goal_model.dart';
final goalDetailsProvider = StreamProvider.autoDispose.family<GoalModel, int>((
  ref,
  id,
) {
  final db = ref.watch(databaseProvider);
  return db.goalDao.watchGoalByID(id).map((event) => event.toModel());
});