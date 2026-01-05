import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:ledgerly/core/components/placeholders/placeholder_screen.dart';
import 'package:ledgerly/core/router/auth_router.dart';
import 'package:ledgerly/core/router/budget_router.dart';
import 'package:ledgerly/core/router/category_router.dart';
import 'package:ledgerly/core/router/currency_router.dart';
import 'package:ledgerly/core/router/goal_router.dart';
import 'package:ledgerly/core/router/onboarding_router.dart';
import 'package:ledgerly/core/router/report_router.dart';
import 'package:ledgerly/core/router/routes.dart';
import 'package:ledgerly/core/router/settings_router.dart';
import 'package:ledgerly/core/router/transaction_router.dart';
import 'package:ledgerly/core/router/wallet_router.dart';
import 'package:ledgerly/features/splash/splash_screen.dart';
import 'package:ledgerly/main.dart';
final rootNavKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavKey,
  initialLocation: Routes.splash,
  observers: <NavigatorObserver>[MyApp.observer],
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.comingSoon,
      builder: (context, state) => const PlaceholderScreen(),
    ),

    // feature‐specific sub‐routers:
    ...OnboardingRouter.routes,
    ...AuthenticationRouter.routes,
    ...TransactionRouter.routes,
    ...CategoryRouter.routes,
    ...GoalRouter.routes,
    ...BudgetRouter.routes,
    ...SettingsRouter.routes,
    ...CurrencyRouter.routes,
    ...WalletRouter.routes,
    ...ReportRouter.routes,
  ],
);