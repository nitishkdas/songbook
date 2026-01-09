import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controller/song_detail_controller.dart';
import '../widget/verse_block_widget.dart';
import '../widget/chorus_block_widget.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/skeleton_loader.dart';

class SongDetailPage extends StatelessWidget {
  const SongDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SongDetailController>();
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
                color: isDark ? AppColors.backgroundDark.withValues(alpha: 0.95) : AppColors.white.withValues(alpha: 0.95),
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
                      color: AppColors.primary,
                      size: 24,
                    ),
                    onPressed: () => Get.back(),
                  ),
                  Expanded(
                    child: Obx(() => Text(
                      controller.song.value?.songTitle ?? '',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ),
                  Obx(() => IconButton(
                    icon: Icon(
                      controller.song.value?.favorite == true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: controller.song.value?.favorite == true
                          ? AppColors.primary
                          : (isDark ? AppColors.textSubDark : AppColors.textSubLight),
                      size: 26,
                    ),
                    onPressed: controller.toggleFavorite,
                  )),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const SongDetailSkeleton();
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

                final currentSong = controller.song.value;
                if (currentSong == null) {
                  return Center(
                    child: Text(
                      'Song not found',
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        currentSong.songTitle,
                        style: AppTextStyles.heading2(context).copyWith(
                          color: isDark ? AppColors.white : AppColors.textMainLight,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Metadata (optional - can be removed if not in database)
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.gray800 : AppColors.gray200.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Hymn #${currentSong.id}',
                              style: AppTextStyles.label(context).copyWith(
                                color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Lyrics Blocks
                      Obx(() {
                        final blocks = controller.lyricsBlocks;
                        if (blocks.isEmpty) {
                          return Text(
                            'No lyrics available',
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                            ),
                          );
                        }
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: blocks.map((block) {
                            if (block.isChorus) {
                              return ChorusBlockWidget(
                                text: block.text,
                                isDark: isDark,
                              );
                            } else {
                              return VerseBlockWidget(
                                verseNumber: block.verseNumber ?? 0,
                                text: block.text,
                                isDark: isDark,
                              );
                            }
                          }).toList(),
                        );
                      }),
                      const SizedBox(height: 32),
                    ],
                  ),
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

