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

class CategoryDescriptionField extends StatelessWidget {
  const CategoryDescriptionField({
    super.key,
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      context: context,
      label: 'Description (max. 50)',
      hint: 'Write simple description...',
      controller: descriptionController, // Use the controller
      prefixIcon: HugeIcons.strokeRoundedNote,
      minLines: 1,
      maxLines: 3,
      maxLength: 50,
      customCounterText: '',
    );
  }
}