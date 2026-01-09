import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../controller/songbook_selection_controller.dart';
import '../widget/songbook_card.dart';

class SongbookSelectionPage extends StatelessWidget {
  const SongbookSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SongbookSelectionController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'Select Songbook',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading3(context).copyWith(
                    color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
                  ),
                ),
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Hero Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Praise & Worship',
                          style: AppTextStyles.heading2(context).copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Welcome to the NELC Songbook Collection. Please choose a songbook to begin worship.',
                          style: AppTextStyles.bodyMedium(context).copyWith(
                            color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Songbook Cards
                    Obx(() {
                      final count = controller.songCount.value;
                      return Column(
                        children: [
                          SongbookCard(
                            title: 'Boroni Rwjabnai ni Bijab',
                            subtitle: 'Standard Edition',
                            description: controller.isLoading.value 
                                ? 'Loading...' 
                                : '$count ${count == 1 ? 'Hymn' : 'Hymns'} • Main Service',
                            icon: Symbols.library_music,
                            iconColor: AppColors.primary,
                            gradientColors: [AppColors.gradientBlueStart, AppColors.gradientBlueEnd],
                            onTap: controller.navigateToHome,
                          ),
                          const SizedBox(height: 16),
                          SongbookCard(
                            title: 'Youth Songbook',
                            subtitle: 'Supplementary',
                            description: '150 Songs • Youth Fellowship',
                            icon: Symbols.music_note,
                            iconColor: AppColors.accentOrange,
                            gradientColors: [AppColors.gradientOrangeStart, AppColors.gradientOrangeEnd],
                            onTap: controller.showComingSoon,
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            
            // Footer
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                AppConstants.appFooterText,
                style: AppTextStyles.labelSmall(context).copyWith(
                  color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

