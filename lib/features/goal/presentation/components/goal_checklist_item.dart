import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/chips/custom_chip.dart';
import 'package:ledgerly/core/constants/app_colors.dart';
import 'package:ledgerly/core/constants/app_radius.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
import 'package:ledgerly/core/constants/app_text_styles.dart';
import 'package:ledgerly/core/extensions/pop_up_extension.dart';
import 'package:ledgerly/core/utils/logger.dart';
import 'package:ledgerly/features/goal/data/model/checklist_item_model.dart';
import 'package:ledgerly/features/goal/presentation/screens/goal_checklist_form_dialog.dart';
import 'package:ledgerly/features/goal/presentation/service/goal_form_service.dart';
import 'package:ledgerly/features/wallets/data/model/wallet_model.dart';
import 'package:ledgerly/features/wallets/riverpod/wallet_provider.dart';
import 'package:url_launcher/url_launcher.dart' as LinkLauncher;

class GoalChecklistItem extends ConsumerWidget {
  final bool isOdd;
  final ChecklistItemModel item;
  const GoalChecklistItem({super.key, required this.item, this.isOdd = false});

  @override
  Widget build(BuildContext context, ref) {
    final defaultCurrency = ref
        .read(activeWalletProvider)
        .value
        ?.currencyByIsoCode(ref)
        .symbol;

    // Odd-even background
    final bgColor = isOdd
        ? context.purpleBackground.withAlpha(50)
        : context.purpleBackground.withAlpha(50);

    return InkWell(
      onTap: () {
        int goalId = item.goalId;
        Log.d(goalId, label: 'open goal id');
        context.openBottomSheet(
          child: GoalChecklistFormDialog(
            goalId: goalId,
            checklistItemModel: item,
          ),
        );
      },
      onDoubleTap: () => toggle(context, ref),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.spacing8,
          horizontal: AppSpacing.spacing8,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: context.purpleBorderLighter),
          borderRadius: BorderRadius.circular(AppRadius.radius16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Checklist icon to the left
                IconButton(
                  icon: HugeIcon(
                    icon: item.completed
                        ? HugeIcons.strokeRoundedCheckmarkSquare02
                        : HugeIcons.strokeRoundedSquare,
                    color: item.completed
                        ? AppColors.green200
                        : context.secondaryText,
                    size: 22,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => toggle(context, ref),
                  tooltip: item.completed
                      ? 'Mark as incomplete'
                      : 'Mark as complete',
                ),
                const SizedBox(width: AppSpacing.spacing8),
                // Title
                Expanded(
                  child: Text(
                    item.title,
                    style: AppTextStyles.body4.copyWith(
                      fontWeight: item.completed
                          ? FontWeight.w400
                          : FontWeight.w500,
                      decoration: item.completed
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Amount and link chips, right-aligned
                Gap(AppSpacing.spacing8),
                CustomChip(
                  label: '$defaultCurrency ${item.amount.toPriceFormat()}',
                  background: context.purpleBackground,
                  foreground: context.purpleText,
                  borderColor: context.purpleBorderLighter,
                ),
              ],
            ),
            if (item.link.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.spacing12,
                  bottom: AppSpacing.spacing4,
                ),
                child: CustomChip(
                  label: item.link,
                  background: context.secondaryBackground,
                  foreground: context.secondaryText,
                  borderColor: context.secondaryBorder,
                  onTap: () {
                    if (item.link.isLink) {
                      LinkLauncher.launch(item.link);
                    }
                  },
                  onLongPress: () {
                    KeyboardService.copyToClipboard(item.link);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void toggle(
    BuildContext context,
    WidgetRef ref,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: context.dialogBackground,
        title: Text(
          'Mark as ${item.completed ? 'Incomplete' : 'Complete'}',
          style: AppTextStyles.body2,
        ),
        content: Text(
          'Are you sure you want to mark this item as ${item.completed ? 'incomplete' : 'complete'}?',
          style: AppTextStyles.body3,
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style: AppTextStyles.body3.copyWith(color: context.purpleText),
            ),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              final updatedItem = item.toggleCompleted();
              GoalFormService().toggleComplete(
                ref,
                checklistItem: updatedItem,
              );
            },
            child: Text(
              'OK',
              style: AppTextStyles.body3.copyWith(color: context.purpleText),
            ),
          ),
        ],
      ),
    );
  }
}