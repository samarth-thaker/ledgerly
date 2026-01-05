import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/buttons/menu_tile_button.dart';
import 'package:ledgerly/features/settings/components/settings_group_holder.dart';
class SettingsProfileGroup extends StatelessWidget {
  const SettingsProfileGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsGroupHolder(
      title: 'Profile',
      settingTiles: [
        MenuTileButton(
          label: 'Personal Details',
          icon: HugeIcons.strokeRoundedUser,
          onTap: () => context.push(Routes.personalDetails),
        ),
      ],
    );
  }
}