import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ledgerly/core/components/bottomsheets/alert_bottomsheet.dart';
import 'package:ledgerly/core/components/buttons/custom_icon_button.dart';
import 'package:ledgerly/core/components/loading_indicator/loading_indicator.dart';
import 'package:ledgerly/core/components/scaffold/photo_viewer.dart';
import 'package:ledgerly/core/constants/app_colors.dart';
import 'package:ledgerly/core/constants/app_spacing.dart';
import 'package:ledgerly/core/constants/app_text_styles.dart';
import 'package:ledgerly/core/extensions/pop_up_extension.dart';
import 'package:ledgerly/core/utils/logger.dart';
class TransactionImagePreview extends ConsumerWidget {
  const TransactionImagePreview({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final imageState = ref.watch(imageProvider);

    Log.d(imageState.imageFile?.path, label: 'imageState.imageFile');
    Log.d(imageState.savedPath, label: 'imageState.savedPath');

    if (imageState.imageFile == null) {
      return Container();
    }

    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (imageState.imageFile == null) {
              return;
            }

            showAdaptiveDialog(
              context: context,
              builder: (context) =>
                  PhotoViewer(image: Image.file(imageState.imageFile!)),
            );
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: context.purpleBackground,
              borderRadius: BorderRadius.circular(AppSpacing.spacing8),
              border: Border.all(color: context.purpleBorderLighter),
              image: DecorationImage(
                image: Image.file(
                  imageState.imageFile!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedImageNotFound01,
                    ),
                  ),
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) => Center(
                        child: LoadingIndicator(),
                      ),
                ).image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: 2,
          top: 2,
          child: CustomIconButton(
            context,
            onPressed: () {
              context.openBottomSheet(
                child: AlertBottomSheet(
                  title: 'Delete Image',
                  content: Text(
                    'Are you sure you want to delete this image?',
                    style: AppTextStyles.body2,
                  ),
                  onConfirm: () {
                    context.pop(); // close dialog
                    ref.read(imageProvider.notifier).clearImage();
                  },
                ),
              );
            },
            icon: HugeIcons.strokeRoundedCancel01,
            backgroundColor: AppColors.red50,
            borderColor: AppColors.redAlpha10,
            color: AppColors.red,
            iconSize: IconSize.tiny,
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    );
  }
}