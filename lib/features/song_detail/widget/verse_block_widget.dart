import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class VerseBlockWidget extends StatelessWidget {
  final int verseNumber;
  final String text;
  final bool isDark;

  const VerseBlockWidget({
    super.key,
    required this.verseNumber,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.only(top: 24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Verse number label (absolute positioned)
          Positioned(
            left: 0,
            top: -24,
            child: Text(
              '$verseNumber',
              style: AppTextStyles.label(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                letterSpacing: 2,
              ),
            ),
          ),
          // Verse text
          Text(
            text,
            style: AppTextStyles.lyrics(context).copyWith(
              color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
            ),
          ),
        ],
      ),
    );
  }
}

