import 'dart:nativewrappers/_internal/vm/bin/vmservice_io.dart' as Routes;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/bottomsheets/alert_bottomsheet.dart';
import 'package:ledgerly/core/components/bottomsheets/custom_bottom_sheet.dart';
import 'package:ledgerly/core/components/buttons/custom_icon_button.dart';
import 'package:ledgerly/core/components/buttons/primary_button.dart';
import 'package:ledgerly/core/components/form_fields/custom_text_field.dart';
import 'package:ledgerly/core/components/scaffold/custom_scaffold.dart';
import 'package:ledgerly/core/constants/app_colors.dart';
import 'package:ledgerly/core/constants/app_constants.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
import 'package:ledgerly/core/constants/app_text_styles.dart';
import 'package:ledgerly/core/extensions/pop_up_extension.dart';
import 'package:ledgerly/core/services/image_service/domain/image_state.dart';
import 'package:ledgerly/core/services/image_service/image_service.dart';
import 'package:ledgerly/core/services/keyboard_service/virtual_keyboard_service.dart';
import 'package:ledgerly/features/authentication/presentation/components/create_first_wallet_field.dart';
import 'package:ledgerly/features/authentication/presentation/components/google_signin_button.dart';
import 'package:ledgerly/features/authentication/presentation/riverpod/auth_provider.dart';
import 'package:ledgerly/features/backup_and_restore/components/restore_dialog.dart';
import 'package:ledgerly/features/backup_and_restore/riverpod/backup_controller.dart';
import 'package:ledgerly/features/image_picker/image_picker_dialog.dart';
import 'package:ledgerly/features/settings/components/report_log_file.dart';
import 'package:ledgerly/features/theme_switcher/components/theme_mode_switcher.dart';
import 'package:ledgerly/main.dart' show Routes;
import 'package:url_launcher/url_launcher.dart' as LinkLauncher;
part '../components/form.dart';
part '../components/get_started_description.dart';
part '../components/login_image_picker.dart';
part '../components/login_info.dart';
part '../components/logo.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final nameField = useTextEditingController();

    void restoreData() {
      context.openBottomSheet(
        child: AlertBottomSheet(
          title: 'Restore Data',
          context: context,
          confirmText: 'Continue Restore',
          showCancelButton: false,
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
          content: RestoreDialog(
            onSuccess: () async {
              await Future.delayed(Duration(milliseconds: 1500));

              if (context.mounted) {
                context.replace(Routes.main as String);
              }
            },
          ),
        ),
      );
    }

    return CustomScaffold(
      context: context,
      showBackButton: false,
      showBalance: false,
      actions: [
        CustomIconButton(
          context,
          onPressed: () =>
              context.openBottomSheet(child: ReportLogFileDialog()),
          icon: HugeIcons.strokeRoundedAlertDiamond,
          themeMode: context.themeMode,
        ),
        Gap(AppSpacing.spacing8),
        CustomIconButton(
          context,
          onPressed: restoreData,
          icon: HugeIcons.strokeRoundedDatabaseImport,
          themeMode: context.themeMode,
        ),
        Gap(AppSpacing.spacing8),
        ThemeModeSwitcher(),
      ],
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            // color: Colors.yellow,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(nameField: nameField),
          ),
          PrimaryButton(
            label: 'Start Journey',
            isLoading: ref.watch(authStateProvider.notifier).isLoading,
            onPressed: () => ref
                .read(authStateProvider.notifier)
                .startJourney(
                  context: context,
                  username: nameField.text,
                  profilePicture: ref.read(loginImageProvider).savedPath,
                ),
          ).floatingBottomContained,
        ],
      ),
    );
  }
}
