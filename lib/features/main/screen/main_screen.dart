import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
import 'package:ledgerly/core/extensions/screen_util_extension.dart';
import 'package:ledgerly/features/budget/presentation/screens/budget_screen.dart';
import 'package:ledgerly/features/dashboard/screens/dashboard_screen.dart';
import 'package:ledgerly/features/goal/presentation/screens/goal_screen.dart';
import 'package:ledgerly/features/main/components/custom_bottom_app_bar.dart';
import 'package:ledgerly/features/main/riverpod/main_page_view_riverpod.dart';
import 'package:ledgerly/features/transactions/presentation/screens/transaction_filter.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentPage = ref.watch(pageControllerProvider);

    final pageController = PageController(initialPage: currentPage);

    final Widget pageViewWidget = PageView(
      controller: pageController,
      onPageChanged: (value) {
        ref.read(pageControllerProvider.notifier).setPage(value);
      },
      children: const [
        DashboardScreen(),
        TransactionScreen(),
        GoalScreen(),
        BudgetScreen(),
      ],
    );

    final Widget navigationControls = CustomBottomAppBar(
      pageController: pageController,
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: Material(
        child: context.isDesktopLayout
            ? Row(
                children: [
                  navigationControls, // This will render as a sidebar
                  Expanded(child: pageViewWidget),
                ],
              )
            : Stack(
                children: [
                  pageViewWidget,
                  Positioned(
                    bottom: AppSpacing.spacing8,
                    left: AppSpacing.spacing16,
                    right: AppSpacing.spacing16,
                    child: navigationControls,
                  ),
                ],
              ),
      ),
    );
  }
}
