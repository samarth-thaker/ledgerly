import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgerly/core/extensions/screen_util_extension.dart';
import 'package:ledgerly/features/main/components/desktop_side_bar.dart';
import 'package:ledgerly/features/main/components/mobile_bottom_app_bar.dart';
class CustomBottomAppBar extends ConsumerWidget {
  final PageController pageController;
  const CustomBottomAppBar({super.key, required this.pageController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (context.isDesktopLayout) {
      return DesktopSidebar(pageController: pageController);
    } else {
      return MobileBottomAppBar(pageController: pageController);
    }
  }
}