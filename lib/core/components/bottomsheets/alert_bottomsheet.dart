import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ledgerly/core/components/bottomsheets/custom_bottom_sheet.dart';
import 'package:ledgerly/core/components/buttons/button_state.dart';
import 'package:ledgerly/core/components/buttons/primary_button.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
class AlertBottomSheet extends CustomBottomSheet {
  final BuildContext? context;
  final Widget content;
  final bool showCancelButton;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  AlertBottomSheet({
    super.key,
    required super.title,
    required this.content,
    this.context,
    this.showCancelButton = true,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
  }) : super(
         child: Column(
           spacing: AppSpacing.spacing32,
           children: [
             ...[content],
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               spacing: AppSpacing.spacing12,
               children: [
                 showCancelButton
                     ? Expanded(
                         child: PrimaryButton(
                           label: cancelText ?? 'Cancel',
                           isOutlined: true,
                           state: ButtonState.outlinedActive,
                           onPressed: () {
                             context?.pop();
                             onCancel?.call();
                           },
                         ),
                       )
                     : const SizedBox.shrink(),
                 Expanded(
                   child: PrimaryButton(
                     label: confirmText ?? 'Yes',
                     onPressed: onConfirm,
                   ),
                 ),
               ],
             ),
           ],
         ),
       );
}