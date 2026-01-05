import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/bottomsheets/alert_bottomsheet.dart';
import 'package:ledgerly/core/components/buttons/menu_tile_button.dart';
import 'package:ledgerly/core/constants/app_text_styles.dart';
import 'package:ledgerly/core/extensions/pop_up_extension.dart';
import 'package:ledgerly/features/settings/components/settings_group_holder.dart';

class SettingsSessionGroup extends ConsumerWidget {
  const SettingsSessionGroup({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SettingsGroupHolder(
      title: 'Session',
      settingTiles: [
        MenuTileButton(
          label: 'Logout',
          icon: HugeIcons.strokeRoundedLogout01,
          onTap: () {
            // show confirm dialog then perform logout
            context.openBottomSheet(
              child: AlertBottomSheet(
                context: context,
                title: 'Logout',
                confirmText: 'Logout',
                content: Text(
                  'Continue logging out from this device?',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body2,
                ),
                onConfirm: () {
                  context.pop(); // close this dialog
                  ref.read(authStateProvider.notifier).logout();
                  context.go(Routes.getStarted);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}