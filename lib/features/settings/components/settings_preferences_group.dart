
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/buttons/menu_tile_button.dart';
import 'package:ledgerly/features/settings/components/settings_group_holder.dart';

class SettingsPreferencesGroup extends StatelessWidget {
  const SettingsPreferencesGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsGroupHolder(
      title: 'Preferences',
      settingTiles: [
        MenuTileButton(
          label: 'Notifications',
          icon: HugeIcons.strokeRoundedNotification01,
          onTap: () => context.push(Routes.comingSoon),
        ),
      ],
    );
  }
}