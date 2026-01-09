import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class AlphabetFilter extends StatelessWidget {
  final List<String> chars;
  final String selectedChar;
  final Function(String) onCharSelected;

  const AlphabetFilter({
    super.key,
    required this.chars,
    required this.selectedChar,
    required this.onCharSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: chars.map((char) {
            final isSelected = char == selectedChar;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Material(
                color: AppColors.transparent,
                child: InkWell(
                  onTap: () => onCharSelected(char),
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : (isDark ? AppColors.gray800 : AppColors.gray100),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      char,
                      style: AppTextStyles.button(context).copyWith(
                        color: isSelected
                            ? AppColors.white
                            : (isDark ? AppColors.textSubDark : AppColors.textSubLight),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

