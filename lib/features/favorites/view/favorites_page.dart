import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controller/favorites_controller.dart';
import '../widget/favorite_song_card.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/skeleton_loader.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavoritesController>();
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
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Symbols.arrow_back_ios_new,
                      color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
                    ),
                    onPressed: () => Get.back(),
                  ),
                  Expanded(
                    child: Text(
                      'Favorites',
                      style: AppTextStyles.heading3(context).copyWith(
                        color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
                      ),
                    ),
                  ),
                  Obx(() => Text(
                    '${controller.songs.length} songs',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                    ),
                  )),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const FavoriteListSkeleton();
                }

                if (controller.hasError.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error',
                          style: AppTextStyles.heading3(context).copyWith(
                            color: AppColors.error,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.errorMessage.value,
                          style: AppTextStyles.bodyMedium(context).copyWith(
                            color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                if (controller.songs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Symbols.favorite_border,
                          size: 64,
                          color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No favorites yet',
                          style: AppTextStyles.bodyMedium(context).copyWith(
                            color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: controller.navigateToHome,
                          icon: Icon(
                            Symbols.library_music,
                            color: AppColors.primary,
                          ),
                          label: Text(
                            'Browse more songs',
                            style: AppTextStyles.button(context).copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 20),
                  itemCount: controller.songs.length,
                  itemBuilder: (context, index) {
                    final song = controller.songs[index];
                    return FavoriteSongCard(
                      song: song,
                      onTap: () => controller.navigateToSongDetail(song.id),
                      onFavoriteTap: () => controller.toggleFavorite(song),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}

