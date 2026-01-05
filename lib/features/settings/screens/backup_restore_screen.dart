import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';
import 'package:ledgerly/core/components/scaffold/custom_scaffold.dart';
import 'package:ledgerly/core/constants/app_colors.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
import 'package:ledgerly/features/backup_and_restore/components/drive_backup_section.dart';
import 'package:ledgerly/features/backup_and_restore/components/local_backup_section.dart';


enum BackupSchedule { daily, weekly, monthly }

class BackupRestoreScreen extends StatelessWidget {
  const BackupRestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      context: context,
      title: 'Backup & Restore',
      showBalance: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
        child: Column(
          spacing: AppSpacing.spacing8,
          children: [
            LocalBackupSection(),
            Divider(color: context.breakLineColor),
            DriveBackupSection(),
          ],
        ),
      ),
    );
  }
}