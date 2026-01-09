import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class SongbookCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color iconColor;
  final List<Color> gradientColors;
  final VoidCallback onTap;
  final double opacity;

  const SongbookCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.gradientColors,
    required this.onTap,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Opacity(
      opacity: opacity,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.transparent,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                // Text Content
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.heading3(context).copyWith(
                          color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            icon,
                            size: 18,
                            color: iconColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            subtitle,
                            style: AppTextStyles.bodySmall(context).copyWith(
                              color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: AppTextStyles.labelSmall(context).copyWith(
                          color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Image/Icon Container
                Container(
                  width: 96,
                  height: 128,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: gradientColors,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              gradientColors[0].withValues(alpha: 0.8),
                              gradientColors[1].withValues(alpha: 0.8),
                            ],
                          ),
                        ),
                      ),
                      // Icon
                      Center(
                        child: Icon(
                          icon,
                          color: AppColors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

