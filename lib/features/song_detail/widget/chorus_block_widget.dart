import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class ChorusBlockWidget extends StatelessWidget {
  final String text;
  final bool isDark;

  const ChorusBlockWidget({
    super.key,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.only(left: 24, right: 8, top: 25, bottom: 1),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 3,
            color: AppColors.primary.withValues(alpha: isDark ? 0.6 : 0.4),
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // "Chorus" label
          Positioned(
            left: -3,
            top: -24,
            child: Text(
              'Chorus',
              style: AppTextStyles.label(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 2,
              ),
            ),
          ),
          // Chorus text (italic, medium weight)
          Text(
            text,
            style: AppTextStyles.lyrics(context).copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.white : AppColors.textMainLight,
            ),
          ),
        ],
      ),
    );
  }
}

