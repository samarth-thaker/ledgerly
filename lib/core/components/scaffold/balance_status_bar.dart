part of 'custom_scaffold.dart';

class BalanceStatusBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BalanceStatusBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(35);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.spacing8,
        bottom: AppSpacing.spacing8,
      ),
      child: const BalanceStatusBarContent(),
    );
  }
}