import 'package:go_router/go_router.dart';
import 'package:ledgerly/core/router/routes.dart';
import 'package:ledgerly/features/onboarding/screen/onboarding_screen.dart';
class OnboardingRouter {
  static final routes = <GoRoute>[
    GoRoute(
      path: Routes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
  ];
}