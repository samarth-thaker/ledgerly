import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/buttons/menu_tile_button.dart';
import 'package:ledgerly/features/settings/components/settings_group_holder.dart';

class SettingsFinanceGroup extends StatelessWidget {
  const SettingsFinanceGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsGroupHolder(
      title: 'Finance',
      settingTiles: [
        MenuTileButton(
          label: 'Wallets',
          icon: HugeIcons.strokeRoundedWallet03,
          onTap: () => context.push(Routes.manageWallets),
        ),
        MenuTileButton(
          label: 'Categories',
          icon: HugeIcons.strokeRoundedStructure01,
          onTap: () => context.push(Routes.manageCategories),
        ),
      ],
    );
  }
}