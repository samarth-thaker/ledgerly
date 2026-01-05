
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/buttons/menu_tile_button.dart';
import 'package:ledgerly/features/settings/components/settings_group_holder.dart';

class SettingsDataGroup extends ConsumerWidget {
  const SettingsDataGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsGroupHolder(
      title: 'Data Management',
      settingTiles: [
        MenuTileButton(
          label: 'Backup & Restore',
          icon: HugeIcons.strokeRoundedDatabaseSync01,
          onTap: () {
            context.push(Routes.backupAndRestore);
          },
        ),
        MenuTileButton(
          label: 'Delete My Data',
          icon: HugeIcons.strokeRoundedDelete01,
          onTap: () => context.push(Routes.accountDeletion),
        ),
      ],
    );
  }
}