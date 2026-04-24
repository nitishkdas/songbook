import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controller/search_controller.dart' as search_controller;
import '../widget/search_result_card.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/skeleton_loader.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<search_controller.SearchController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Search Bar
            Container(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.backgroundDark.withValues(alpha: 0.95) : AppColors.white.withValues(alpha: 0.95),
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.gray800 : AppColors.gray100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        autofocus: true,
                        onChanged: controller.search,
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          color: isDark ? AppColors.white : AppColors.textMainLight,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search by title or song number...',
                          hintStyle: AppTextStyles.bodyMedium(context).copyWith(
                            color: isDark ? AppColors.textSubDark : AppColors.gray500,
                          ),
                          prefixIcon: Icon(
                            Symbols.search,
                            color: isDark ? AppColors.textSubDark : AppColors.gray500,
                            size: 20,
                          ),
                          suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Symbols.cancel,
                                    color: isDark ? AppColors.textSubDark : AppColors.gray500,
                                    size: 20,
                                  ),
                                  onPressed: controller.clearSearch,
                                )
                              : const SizedBox.shrink()),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.button(context).copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Results
            Expanded(
              child: Obx(() {
                if (controller.searchQuery.value.isEmpty) {
                  return Center(
                    child: Text(
                      'Start typing to search...',
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                      ),
                    ),
                  );
                }

                if (controller.isLoading.value) {
                  return const SearchResultSkeleton();
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

                if (controller.searchResults.isEmpty) {
                  return Center(
                    child: Text(
                      'No results found',
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    // Results Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Matches for "${controller.searchQuery.value}"',
                            style: AppTextStyles.label(context).copyWith(
                              color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                            ),
                          ),
                          Text(
                            '${controller.searchResults.length} results',
                            style: AppTextStyles.labelSmall(context).copyWith(
                              color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Results List
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {
                          final song = controller.searchResults[index];
                          return SearchResultCard(
                            song: song,
                            searchQuery: controller.searchQuery.value,
                            onTap: () => controller.navigateToSongDetail(song.id),
                            onFavoriteTap: () => controller.toggleFavorite(song),
                          );
                        },
                      ),
                    ),
                  ],
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

