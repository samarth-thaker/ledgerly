import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/bottomsheets/alert_bottomsheet.dart';
import 'package:ledgerly/core/components/buttons/custom_icon_button.dart';
import 'package:ledgerly/core/components/dialogs/toast.dart';
import 'package:ledgerly/core/components/scaffold/custom_scaffold.dart';
import 'package:ledgerly/core/constants/app_colors.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
import 'package:ledgerly/core/constants/app_text_styles.dart';
import 'package:ledgerly/core/database/database_provider.dart';
import 'package:ledgerly/core/extensions/pop_up_extension.dart';
import 'package:ledgerly/features/budget/presentation/riverpod/date_picker_provider.dart';
import 'package:ledgerly/features/goal/data/model/goal_model.dart';
import 'package:ledgerly/features/goal/presentation/riverpod/checklist_item_provider.dart';
import 'package:ledgerly/features/goal/presentation/riverpod/goal_detail_provider.dart';
import 'package:ledgerly/features/goal/presentation/screens/goal_form_dialog.dart';
import 'package:ledgerly/features/wallets/riverpod/wallet_provider.dart';
import 'package:toastification/toastification.dart';

/* part '../components/goal_checklist_holder.dart';
part '../components/goal_checklist_item.dart';
part '../components/goal_checklist_title.dart';
part '../components/goal_checklist.dart';
part '../components/goal_title_card.dart'; */

class GoalDetailsScreen extends ConsumerWidget {
  final int goalId;
  const GoalDetailsScreen({super.key, required this.goalId});

  @override
  Widget build(BuildContext context, ref) {
    final wallet = ref.watch(activeWalletProvider);
    final goalAsync = ref.watch(goalDetailsProvider(goalId));
    final checklistItemsAsync = ref.watch(checklistItemsProvider(goalId));

    return CustomScaffold(
      context: context,
      title: 'My Goals',
      showBalance: false,
      actions: [
        if (goalAsync.value != null)
          CustomIconButton(
            context,
            onPressed: () async {
              final db = ref.read(databaseProvider);
              final goal = goalAsync.value!;
              if (goal.pinned) {
                await db.goalDao.unpinGoal(goalId);
              } else {
                await db.goalDao.pinGoal(goalId);
              }
              Toast.show(
                'Goal ${goal.pinned ? 'unpinned' : 'pinned'}',
                type: ToastificationType.success,
              );
            },
            icon: goalAsync.value!.pinned
                ? HugeIcons.strokeRoundedPinOff
                : HugeIcons.strokeRoundedPin,
            active: goalAsync.value!.pinned,
            themeMode: context.themeMode,
          ),
        Gap(AppSpacing.spacing8),
        CustomIconButton(
          context,
          onPressed: () {
            if (goalAsync.value != null) {
              ref
                  .read(datePickerProvider.notifier)
                  .setDate(goalAsync.value!.goalDates.first);

              // if goalDates contains a range and you need filterDatePickerProvider,
              // use that provider instead. The original code set datePickerProvider to goalDates;
              // adjust as needed depending on expected shape.

              context.openBottomSheet(
                child: GoalFormDialog(goal: goalAsync.value!),
              );
            }
          },
          icon: HugeIcons.strokeRoundedEdit02,
          themeMode: context.themeMode,
        ),
        Gap(AppSpacing.spacing8),
        if (goalAsync.value != null)
          CustomIconButton(
            context,
            onPressed: () {
              context.openBottomSheet(
                child: AlertBottomSheet(
                  context: context,
                  title: 'Delete Goal',
                  content: Text(
                    'Are you sure want to delete this goal?',
                    style: AppTextStyles.body2,
                  ),
                  confirmText: 'Delete',
                  onConfirm: () {
                    final db = ref.read(databaseProvider);
                    db.goalDao.deleteGoal(goalId);
                    context.pop(); // Close the bottom sheet
                    context.pop(); // Close the goal details screen
                  },
                ),
              );
            },
            icon: HugeIcons.strokeRoundedDelete02,
            themeMode: context.themeMode,
          ),
      ],
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.spacing16,
              AppSpacing.spacing12,
              AppSpacing.spacing16,
              150,
            ),
            child: goalAsync.when(
              data: (GoalModel goal) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GoalTitleCard(goal: goal),
                    GoalChecklistHolder(goalId: goalId),
                  ],
                );
              },
              error: (Object error, StackTrace stackTrace) {
                return Center(child: Text('Error: $error'));
              },
              loading: () {
                return Center(child: LoadingIndicator());
              },
            ),
          ),
          PrimaryButton(
            label: 'Add Checklist Item',
            state: ButtonState.outlinedActive,
            themeMode: context.themeMode,
            onPressed: () {
              context.openBottomSheet(
                child: GoalChecklistFormDialog(goalId: goalId),
              );
            },
          ).floatingBottomWithContent(
            content: Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.spacing8),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: AppTextStyles.body2),
                  checklistItemsAsync.when(
                    data: (items) {
                      final total = items.fold<double>(
                        0.0,
                        (sum, item) => sum + item.amount,
                      );
                      return Text(
                        '${wallet.value?.currencyByIsoCode(ref).symbol} ${total.toPriceFormat()}',
                        style: AppTextStyles.numericLarge,
                      );
                    },
                    error: (e, _) => Container(),
                    loading: () => Container(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}