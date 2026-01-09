import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark.withValues(alpha: 0.95) : AppColors.white.withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: Symbols.home,
                label: 'Home',
                isSelected: currentIndex == 0,
                onTap: () {
                  if (currentIndex != 0) {
                    // Use offNamed to replace route (no stack buildup)
                    // Route-level fadeIn transition makes it smooth
                    Get.offNamed(AppRoutes.home);
                  }
                },
              ),
              _buildNavItem(
                context,
                icon: Symbols.favorite,
                label: 'Favorites',
                isSelected: currentIndex == 1,
                onTap: () {
                  if (currentIndex != 1) {
                    // Use offNamed to replace route (no stack buildup)
                    // Route-level fadeIn transition makes it smooth
                    Get.offNamed(AppRoutes.favorites);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? AppColors.primary
                    : (isDark ? AppColors.gray500 : AppColors.gray400),
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTextStyles.labelSmall(context).copyWith(
                  color: isSelected
                      ? AppColors.primary
                      : (isDark ? AppColors.gray500 : AppColors.gray400),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

