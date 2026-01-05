import 'package:flutter/material.dart';
/* import 'package:gap/gap.dart'; */
import 'package:hooks_riverpod/hooks_riverpod.dart';
/* import 'package:ledgerly/core/components/chips/custom_currency_chip.dart'; */
import 'package:ledgerly/core/components/scaffold/custom_scaffold.dart';
/* import 'package:ledgerly/core/constants/app_colors.dart'; */
import 'package:ledgerly/core/constants/app_spacing.dart';
/* import 'package:ledgerly/core/constants/app_text_styles.dart'; */
import 'package:ledgerly/features/settings/components/settings_Session_group.dart';
import 'package:ledgerly/features/settings/components/settings_app_group_info.dart';
import 'package:ledgerly/features/settings/components/settings_data_group.dart';
import 'package:ledgerly/features/settings/components/settings_finance_group.dart';
import 'package:ledgerly/features/settings/components/settings_preferences_group.dart';
import 'package:ledgerly/features/settings/components/settings_profile_group.dart';
import 'package:ledgerly/features/theme_switcher/components/theme_mode_switcher.dart';
/* import 'package:ledgerly/features/wallets/data/model/wallet_model.dart';
import 'package:ledgerly/features/wallets/data/repo/wallet_repo.dart';
import 'package:ledgerly/features/wallets/riverpod/wallet_provider.dart'; */

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      context: context,
      title: 'Settings',
      showBackButton: true,
      actions: [ThemeModeSwitcher()],
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
        child: Column(
          children: [
            ProfileCard(),
            SettingsProfileGroup(),
            SettingsPreferencesGroup(),
            SettingsFinanceGroup(),
            SettingsDataGroup(),
            SettingsAppInfoGroup(),
            SettingsSessionGroup(),
            AppVersionInfo(),
          ],
        ),
      ),
    );
  }
}