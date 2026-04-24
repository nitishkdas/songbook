import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controller/home_controller.dart';

class SearchBarWidget extends StatelessWidget {
  final HomeController controller;

  const SearchBarWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: isDark ? AppColors.gray800.withValues(alpha: 0.5) : AppColors.gray100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.gray700 : AppColors.gray200,
        ),
      ),
      child: TextField(
        onChanged: controller.search,
        style: AppTextStyles.bodyMedium(context).copyWith(
          color: isDark ? AppColors.white : AppColors.textMainLight,
        ),
        decoration: InputDecoration(
          hintText: 'Search by title or song number...',
          hintStyle: AppTextStyles.bodyMedium(context).copyWith(
            color: isDark ? AppColors.textSubDark : AppColors.gray400,
          ),
          prefixIcon: Icon(
            Symbols.search,
            color: isDark ? AppColors.textSubDark : AppColors.gray400,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}

