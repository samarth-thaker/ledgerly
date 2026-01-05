import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';
import 'package:ledgerly/core/components/buttons/custom_icon_button.dart';
import 'package:ledgerly/core/components/scaffold/custom_scaffold.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
import 'package:ledgerly/core/extensions/date_time_extension.dart';
import 'package:ledgerly/features/report/presentation/components/spending_pie_chart.dart';
import 'package:ledgerly/features/report/presentation/components/weekly_income_vs_expense_chart.dart';
import 'package:ledgerly/features/report/presentation/riverpod/filtered_transaction_provider.dart';
import 'package:ledgerly/features/transactions/data/model/transaction_model.dart';

class BasicMonthlyReportScreen extends HookConsumerWidget {
  const BasicMonthlyReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = GoRouterState.of(context).extra as DateTime;
    final selectedDate = useState(date);
    final transactionsAsync = ref.watch(
      monthlyTransactionsProvider(selectedDate.value),
    );

    return CustomScaffold(
      context: context,
      title: '${selectedDate.value.toMonthYear()} Report',
      actions: [
        CustomIconButton(
          context,
          onPressed: () {
            selectedDate.value = selectedDate.value.subtract(
              const Duration(days: 30),
            );
          },
          icon: HugeIconsStrokeRounded.arrowLeft02,
        ),
        Gap(AppSpacing.spacing4),
        CustomIconButton(
          context,
          onPressed: () {
            selectedDate.value = selectedDate.value.add(
              const Duration(days: 30),
            );
          },
          icon: HugeIconsStrokeRounded.arrowRight02,
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.spacing20),
        children: [
          SpendingPieChart(
            expenseData: transactionsAsync.value?.chartDataList ?? [],
            totalExpenses: transactionsAsync.value?.totalExpenses ?? 0,
            isLoading: transactionsAsync.isLoading,
          ),
          Gap(AppSpacing.spacing20),
          WeeklyIncomeExpenseChart(
            transactions: transactionsAsync.value ?? [],
          ),
        ],
      ),
    );
  }
}