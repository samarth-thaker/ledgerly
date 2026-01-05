//part of '../../../settings/presentation/screens/backup_restore_screen.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/bottomsheets/alert_bottomsheet.dart';
import 'package:ledgerly/core/components/buttons/menu_tile_button.dart';
import 'package:ledgerly/core/components/dialogs/toast.dart';
import 'package:ledgerly/core/constants/app_colors.dart';
import 'package:ledgerly/core/constants/app_radius.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
import 'package:ledgerly/core/constants/app_text_styles.dart';
import 'package:ledgerly/core/extensions/date_time_extension.dart';
import 'package:ledgerly/core/extensions/pop_up_extension.dart';
import 'package:ledgerly/core/extensions/text_style_extensions.dart';
import 'package:ledgerly/features/backup_and_restore/components/backup_dialog.dart';
import 'package:ledgerly/features/backup_and_restore/components/restore_dialog.dart';
import 'package:ledgerly/features/backup_and_restore/riverpod/backup_controller.dart';
import 'package:ledgerly/main.dart' as Routes;
import 'package:toastification/toastification.dart';

class LocalBackupSection extends HookConsumerWidget {
  const LocalBackupSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(backupControllerProvider);

    return Column(
      spacing: AppSpacing.spacing8,
      children: [
        MenuTileButton(
          label: 'Backup Manually',
          subtitle: const Text('Create a backup of your data locally'),
          icon: HugeIcons.strokeRoundedDatabaseExport,
          suffixIcon: null,
          onTap: () {
            context.openBottomSheet(
              isScrollControlled: false,
              child: AlertBottomSheet(
                context: context,
                title: 'Backup Data',
                confirmText: 'Continue Backup',
                onConfirm: () async {
                  Toast.show(
                    'Starting backup...',
                    type: ToastificationType.info,
                  );

                  ref.read(backupControllerProvider.notifier).backupLocally();

                  context.pop();
                },
                showCancelButton: false,
                content: BackupDialog(),
              ),
            );
          },
        ),
        MenuTileButton(
          label: 'Restore Data',
          subtitle: const Text('Restore your data from a local backup'),
          icon: HugeIcons.strokeRoundedDatabaseImport,
          onTap: () {
            context.openBottomSheet(
              isScrollControlled: false,
              child: AlertBottomSheet(
                title: 'Restore Data',
                context: context,
                confirmText: 'Select Backup Folder',
                onConfirm: () async {
                  final success = await ref
                      .read(backupControllerProvider.notifier)
                      .restoreFromLocalFile();

                  if (success) {
                    if (context.mounted) {
                      context.pop();
                      context.replace(Routes.main as String);
                    }
                  }
                },
                showCancelButton: false,
                content: RestoreDialog(),
              ),
            );
          },
        ),
        // show local backup and restore info card. card contains backup directory and last action date time
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.spacing16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.radius12),
            border: Border.all(color: context.breakLineColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Local Backup Info',
                style: AppTextStyles.body4.bold,
              ),
              const Gap(AppSpacing.spacing8),
              Text(
                'Backup Directory: ${state.localDirectory ?? 'Not set'}',
                style: AppTextStyles.body4,
              ),
              const Gap(AppSpacing.spacing4),
              Text(
                'Last Backup Time: ${state.lastLocalBackupTime != null ? state.lastLocalBackupTime!.toDayMonthYearTime12Hour() : 'No backups yet'}',
                style: AppTextStyles.body4,
              ),
              // last restore time
              const Gap(AppSpacing.spacing4),
              Text(
                'Last Restore Time: ${state.lastLocalRestoreTime != null ? state.lastLocalRestoreTime!.toDayMonthYearTime12Hour() : 'No restores yet'}',
                style: AppTextStyles.body4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}