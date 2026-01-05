import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/loading_indicator/loading_indicator.dart';
import 'package:ledgerly/core/constants/app_colors.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
import 'package:ledgerly/core/constants/app_text_styles.dart';
import 'package:ledgerly/core/extensions/text_style_extensions.dart';
class SecondaryButton extends OutlinedButton {
  SecondaryButton({
    super.key,
    required BuildContext context,
    required super.onPressed,
    String? label,
    List<List<dynamic>>? icon,
    bool isLoading = false,
  }) : super(
         style: OutlinedButton.styleFrom(
           backgroundColor: context.purpleBackground,
           side: BorderSide(color: context.purpleBorderLighter),
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(AppSpacing.spacing8),
           ),
           padding: const EdgeInsets.symmetric(
             vertical: AppSpacing.spacing16,
           ),
         ),
         child: isLoading
             ? SizedBox.square(dimension: 22, child: LoadingIndicator())
             : Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   if (icon != null)
                     HugeIcon(
                       icon: icon,
                       size: 22,
                       color: context.purpleIcon,
                     ),
                   if (label != null) const Gap(AppSpacing.spacing8),
                   if (label != null)
                     Padding(
                       padding: const EdgeInsets.only(top: 1),
                       child: Text(
                         label,
                         style: AppTextStyles.body3.semibold.copyWith(
                           color: context.secondaryText,
                         ),
                       ),
                     ),
                 ],
               ),
       );
}