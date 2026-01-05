import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:ledgerly/core/router/routes.dart';
import 'package:ledgerly/features/developer_portal_screen.dart';
import 'package:ledgerly/features/settings/screens/account_delete_screen.dart';
import 'package:ledgerly/features/settings/screens/backup_restore_screen.dart';
import 'package:ledgerly/features/settings/screens/personal_detail_screen.dart';
import 'package:ledgerly/features/settings/screens/settings_screen.dart';
class SettingsRouter {
  static final routes = <GoRoute>[
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: Routes.personalDetails,
      builder: (context, state) => const PersonalDetailsScreen(),
    ),
    GoRoute(
      path: Routes.backupAndRestore,
      builder: (context, state) => const BackupRestoreScreen(),
    ),
    GoRoute(
      path: Routes.accountDeletion,
      builder: (context, state) => const AccountDeletionScreen(),
    ),
    if (kDebugMode)
      GoRoute(
        path: Routes.developerPortal,
        builder: (context, state) => const DeveloperPortalScreen(),
      ),
  ];
}