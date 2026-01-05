import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/buttons/custom_icon_button.dart';
import 'package:ledgerly/core/components/progress_indicators/custom_progress_indicator.dart';
import 'package:ledgerly/core/constants/app_colors.dart';
import 'package:ledgerly/core/constants/app_radius.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
import 'package:ledgerly/core/constants/app_text_styles.dart';
import 'package:ledgerly/core/utils/color_generator.dart';
import 'package:ledgerly/features/currency_picker/presentation/riverpod/currency_picker_provider.dart';
import 'package:ledgerly/features/dashboard/components/analytic_chart_report.dart';
import 'package:ledgerly/features/transactions/data/model/transaction_model.dart';
import 'package:ledgerly/features/transactions/presentation/riverpod/transaction_provider.dart';
import 'package:ledgerly/features/wallet_switcher/screens/wallet_switcher_dropdown.dart';
import 'package:ledgerly/features/wallets/data/model/wallet_model.dart';
import 'package:ledgerly/features/wallets/riverpod/wallet_provider.dart';
import 'package:ledgerly/features/wallets/screens/wallet_form_bottom_sheet.dart';
part '../components/action_button.dart';
part '../components/balance_card.dart';
part '../components/wallet_amount_visibility_button.dart';
part '../components/wallet_amount_edit_button.dart';
part '../components/cash_flow_cards.dart';
part '../components/greeting_card.dart';
part '../components/header.dart';
part '../components/recent_transaction_list.dart';
part '../components/spending_progress_chart.dart';
part '../components/transaction_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(85),
          child: Header(),
        ),
        body: ListView(
          padding: EdgeInsets.only(bottom: 100),
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(
                AppSpacing.spacing16,
                0,
                AppSpacing.spacing16,
                AppSpacing.spacing20,
              ),
              child: const Column(
                children: [
                  BalanceCard(),
                  Gap(AppSpacing.spacing12),
                  CashFlowCards(),
                  Gap(AppSpacing.spacing12),
                  SpendingProgressChart(),
                ],
              ),
            ),
            Gap(AppSpacing.spacing12),
            const RecentTransactionList(),
            Gap(AppSpacing.spacing12),
            const AnalyticChartReports(),
          ],
        ),
      ),
    );
  }
}