import 'package:go_router/go_router.dart';
import 'package:ledgerly/core/router/routes.dart';
import 'package:ledgerly/features/wallets/screens/wallet_screen.dart';
class WalletRouter {
  static final routes = <GoRoute>[
    GoRoute(
      path: Routes.manageWallets,
      builder: (context, state) {
        return WalletsScreen();
      },
    ),
  ];
}