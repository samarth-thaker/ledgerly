

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/buttons/menu_tile_button.dart';
import 'package:ledgerly/core/constants/app_constants.dart';
import 'package:ledgerly/core/extensions/pop_up_extension.dart';
import 'package:ledgerly/features/settings/components/report_log_file.dart';
import 'package:ledgerly/features/settings/components/settings_group_holder.dart';
import 'package:ledgerly/features/user_activity/riverpod/user_activity_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as LinkLauncher;

final logoutKey = GlobalKey<NavigatorState>();

class SettingsAppInfoGroup extends ConsumerWidget {
  const SettingsAppInfoGroup({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SettingsGroupHolder(
      title: 'App Info',
      settingTiles: [
        MenuTileButton(
          label: 'Privacy Policy',
          icon: HugeIcons.strokeRoundedLegalHammer,
          suffixIcon: HugeIcons.strokeRoundedSquareArrowUpRight,
          onTap: () {
            LinkLauncher.launch(AppConstants.privacyPolicyUrl);
          },
        ),
        MenuTileButton(
          label: 'Terms and Conditions',
          icon: HugeIcons.strokeRoundedFileExport,
          suffixIcon: HugeIcons.strokeRoundedSquareArrowUpRight,
          onTap: () {
            LinkLauncher.launch(AppConstants.termsAndConditionsUrl);
          },
        ),
        MenuTileButton(
          label: 'Report Log File',
          icon: HugeIcons.strokeRoundedFileCorrupt,
          onTap: () => context.openBottomSheet(child: ReportLogFileDialog()),
          onLongPress: () {
            ref.read(userActivityServiceProvider).shareLogActivities();
          },
        ),
        if (kDebugMode)
          MenuTileButton(
            label: 'Developer Portal',
            icon: HugeIcons.strokeRoundedCode,
            onTap: () => context.push(Routes.developerPortal),
          ),
      ],
    );
  }
}
