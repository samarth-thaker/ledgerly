//part of '../../screens/category_form_screen.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgerly/core/components/bottomsheets/alert_bottomsheet.dart';
import 'package:ledgerly/core/constants/app_colors.dart';
import 'package:ledgerly/core/constants/app_text_styles.dart';
import 'package:ledgerly/core/utils/logger.dart';
import 'package:ledgerly/features/categories/data/model/category_model.dart';
import 'package:ledgerly/features/categories/presentation/riverpod/category_form_service.dart';
import 'package:ledgerly/features/categories/presentation/riverpod/category_provider.dart';

class CategoryDeleteButton extends ConsumerWidget {
  const CategoryDeleteButton({
    super.key,
    required this.categoryFuture,
    required this.categoryId,
  });

  final AsyncSnapshot<Category?> categoryFuture;
  final int? categoryId;

  @override
  Widget build(BuildContext context, ref) {
    return TextButton(
      child: Text(
        'Delete',
        style: AppTextStyles.body2.copyWith(color: AppColors.red),
      ),
      onPressed: () {
        context.openBottomSheet(
          child: AlertBottomSheet(
            title: 'Delete Category',
            content: Text(
              'Deleting this category will also remove all sub-categories as well as transactions related to it. '
              'Continue?\n\nThis action cannot be undone.',
              style: AppTextStyles.body2,
              textAlign: TextAlign.center,
            ),
            onConfirm: () {
              final categories = ref.read(hierarchicalCategoriesProvider).value;

              CategoryModel categoryModel = categoryFuture.data!.toModel();

              if (categories != null) {
                categoryModel = categories.firstWhere(
                  (e) => e.id == categoryId,
                );

                Log.d(
                  categoryModel.subCategories
                      ?.map((e) => '${e.id} => ${e.title}')
                      .toList(),
                  label: 'sub categories',
                );
              }

              CategoryFormService().delete(
                context,
                ref,
                categoryModel: categoryModel,
              );
              context.pop();
              context.pop();
            },
          ),
        );
      },
    );
  }
}