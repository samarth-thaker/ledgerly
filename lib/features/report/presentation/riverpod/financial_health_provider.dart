
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgerly/features/report/data/models/daily_net_flow_model.dart';
import 'package:ledgerly/features/report/data/models/monthly_financial_summary_model.dart';
import 'package:ledgerly/features/report/data/repo/financial_health_repository.dart';
import 'package:ledgerly/features/transactions/presentation/riverpod/transaction_provider.dart';


// State can be a simple AsyncValue list
final sixMonthSummaryProvider =
    FutureProvider.autoDispose<List<MonthlyFinancialSummary>>((ref) async {
      final repo = ref.watch(financialHealthRepositoryProvider);
      // Fetch last 6 months of data
      return repo.getLastMonthsSummary(6);
    });

final dailyNetFlowProvider =
    FutureProvider.autoDispose<List<DailyNetFlowSummary>>((ref) async {
      final repo = ref.watch(financialHealthRepositoryProvider);
      return repo.getCurrentMonthDailyNetFlow();
    });

final financialHealthRepositoryProvider = Provider<FinancialHealthRepository>((
  ref,
) {
  final transactionsAsync = ref.watch(transactionListProvider);
  return FinancialHealthRepository(transactionsAsync.value ?? []);
});
