import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/progress_indicators/progress_bar.dart';
import 'package:ledgerly/core/constants/app_colors.dart';
import 'package:ledgerly/core/constants/app_radius.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
import 'package:ledgerly/core/constants/app_text_styles.dart';
import 'package:ledgerly/core/extensions/double_extension.dart';
import 'package:ledgerly/core/extensions/router_extension.dart';
import 'package:ledgerly/core/extensions/text_style_extensions.dart';
import 'package:ledgerly/core/router/routes.dart';
import 'package:ledgerly/core/utils/logger.dart';
import 'package:ledgerly/features/budget/data/model/budget_model.dart';
import 'package:ledgerly/features/budget/presentation/riverpod/budget_providers.dart';
import 'package:ledgerly/features/category_picker/components/category_tile.dart';
import 'package:ledgerly/features/wallets/data/model/wallet_model.dart';
import 'package:ledgerly/features/wallets/riverpod/wallet_provider.dart';

class BudgetCard extends ConsumerWidget {
  final BudgetModel budget;
  final bool editing;
  const BudgetCard({super.key, required this.budget, this.editing = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.read(activeWalletProvider);
    final currency = wallet.value?.currencyByIsoCode(ref).symbol;

    Log.d(budget.toJson(), label: 'budget');
    final spentAmountAsync = ref.watch(budgetSpentAmountProvider(budget));

    final double spentAmount = spentAmountAsync.maybeWhen(
      data: (amount) => amount,
      orElse: () => 0.0, // Default to 0 if loading or error
    );
    final double remainingAmount = budget.amount - spentAmount;
    final double progress = budget.amount > 0
        ? (spentAmount / budget.amount).clamp(0.0, 1.0)
        : 0.0;

    return InkWell(
      onTap: () {
        Log.d(context.currentRoute, label: 'route');
        if (context.currentRoute != '${Routes.budgetDetails}/:budgetId') {
          context.push('${Routes.budgetDetails}/${budget.id}');
        }
      },
      borderRadius: BorderRadius.circular(AppRadius.radius8),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spacing12),
        decoration: BoxDecoration(
          color: context.secondaryBackground,
          borderRadius: BorderRadius.circular(AppRadius.radius12),
          border: Border.all(color: context.secondaryBorderLighter),
        ),
        child: Column(
          children: [
            AbsorbPointer(
              child: CategoryTile(
                category: budget.category,
                suffixIcon: editing
                    ? null
                    : HugeIcons.strokeRoundedArrowRight01,
              ),
            ),
            const Gap(AppSpacing.spacing8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$currency ${remainingAmount.toPriceFormat()} left',
                  style: AppTextStyles.body4.bold.copyWith(
                    color: remainingAmount < 0
                        ? AppColors.red
                        : AppColors.green200,
                  ),
                ),
                Text(
                  '$currency ${spentAmount.toPriceFormat()} of ${budget.amount.toPriceFormat()}',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.body4.bold,
                ),
              ],
            ),
            const Gap(AppSpacing.spacing8),
            if (spentAmountAsync is AsyncLoading)
              const SizedBox(
                height: 4,
                child: LinearProgressIndicator(),
              ) // Small loader for progress
            else
              ProgressBar(value: progress),
          ],
        ),
      ),
    );
  }
}