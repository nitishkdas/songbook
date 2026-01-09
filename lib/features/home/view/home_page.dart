import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controller/home_controller.dart';
import '../widget/song_card.dart';
import '../widget/alphabet_filter.dart';
import '../widget/search_bar.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/skeleton_loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.backgroundDark : AppColors.white,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Boroni Rwjabnai ni Bijab',
                          style: AppTextStyles.heading2(context).copyWith(
                            color: isDark ? AppColors.white : AppColors.textMainLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Symbols.arrow_circle_left,
                          color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                        ),
                        onPressed: () => controller.navigateToSongbookSelection(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SearchBarWidget(controller: controller),
                ],
              ),
            ),
            
            // Alphabet Filter
            Obx(() => AlphabetFilter(
              chars: ['All', ...controller.allChars],
              selectedChar: controller.selectedChar.value,
              onCharSelected: controller.filterByChar,
            )),
            
            // Song List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const SongListSkeleton();
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

                if (controller.filteredSongs.isEmpty) {
                  return Center(
                    child: Text(
                      'No songs found',
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: controller.filteredSongs.length,
                  itemBuilder: (context, index) {
                    final song = controller.filteredSongs[index];
                    return SongCard(
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
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}

