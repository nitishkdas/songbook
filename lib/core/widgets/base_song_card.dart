import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/models/song.dart';
import '../../core/utils/helpers.dart';
import '../../core/constants/app_constants.dart';

enum SongCardVariant {
  list,      // Simple list item (home page)
  favorite,  // Card with number badge (favorites page)
  search,    // Search result with highlighting
}

class BaseSongCard extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final SongCardVariant variant;
  final String? searchQuery; // For search variant

  const BaseSongCard({
    super.key,
    required this.song,
    required this.onTap,
    required this.onFavoriteTap,
    this.variant = SongCardVariant.list,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case SongCardVariant.list:
        return _buildListCard(context);
      case SongCardVariant.favorite:
        return _buildFavoriteCard(context);
      case SongCardVariant.search:
        return _buildSearchCard(context);
    }
  }

  Widget _buildListCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingXXL,
          vertical: AppConstants.spacingMD,
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: AppConstants.cardIconSize,
              height: AppConstants.cardIconSize,
              decoration: BoxDecoration(
                color: song.favorite
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : (isDark ? AppColors.gray800 : AppColors.gray100),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
              ),
              child: Icon(
                Symbols.music_note,
                color: song.favorite
                    ? AppColors.primary
                    : (isDark ? AppColors.gray500 : AppColors.gray500),
                size: AppConstants.iconSizeMedium,
              ),
            ),
            const SizedBox(width: AppConstants.spacingLG),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.songTitle,
                    style: AppTextStyles.songTitle(context).copyWith(
                      color: isDark ? AppColors.white : AppColors.textMainLight,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppConstants.spacingXS),
                  Text(
                    Helpers.getPreviewText(song.lyric, maxLength: AppConstants.songPreviewLength),
                    style: AppTextStyles.songPreview(context).copyWith(
                      color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Favorite Button
            IconButton(
              icon: Icon(
                song.favorite ? Icons.favorite : Icons.favorite_border,
                color: song.favorite
                    ? AppColors.primary
                    : (isDark ? AppColors.gray400 : AppColors.gray400),
                size: AppConstants.iconSizeMedium,
              ),
              style: IconButton.styleFrom(
                padding: const EdgeInsets.all(AppConstants.spacingSM),
                minimumSize: const Size(40, 40),
              ),
              onPressed: onFavoriteTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMD),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
          child: Container(
            padding: const EdgeInsets.all(AppConstants.spacingMD),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.white,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                // Number Badge
                Container(
                  width: AppConstants.favoriteCardIconSize,
                  height: AppConstants.favoriteCardIconSize,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                  ),
                  child: Center(
                    child: Text(
                      '${song.id}',
                      style: AppTextStyles.heading3(context).copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.spacingLG),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.songTitle,
                        style: AppTextStyles.songTitle(context).copyWith(
                          color: isDark ? AppColors.white : AppColors.textMainLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppConstants.spacingXS),
                      Text(
                        Helpers.getPreviewText(song.lyric, maxLength: AppConstants.songPreviewLength),
                        style: AppTextStyles.songPreview(context).copyWith(
                          color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Favorite Button
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: AppColors.primary,
                    size: AppConstants.iconSizeLarge,
                  ),
                  onPressed: onFavoriteTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingLG,
          vertical: AppConstants.spacingMD,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
        ),
        child: Row(
          children: [
            // Number Badge
            Container(
              width: AppConstants.cardIconSize,
              height: AppConstants.cardIconSize,
              decoration: BoxDecoration(
                color: song.favorite
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : (isDark ? AppColors.gray800 : AppColors.gray100),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
              ),
              child: Center(
                child: Text(
                  '${song.id}',
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: song.favorite
                        ? AppColors.primary
                        : (isDark ? AppColors.textSubDark : AppColors.textSubLight),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.spacingLG),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHighlightedText(
                    context,
                    song.songTitle,
                    searchQuery ?? '',
                    isDark,
                  ),
                  const SizedBox(height: AppConstants.spacingXS),
                  _buildHighlightedText(
                    context,
                    Helpers.getPreviewText(song.lyric, maxLength: AppConstants.searchPreviewLength),
                    searchQuery ?? '',
                    isDark,
                    isSubtitle: true,
                  ),
                ],
              ),
            ),
            // Favorite Button
            IconButton(
              icon: Icon(
                song.favorite ? Icons.favorite : Icons.favorite_border,
                color: song.favorite
                    ? AppColors.primary
                    : (isDark ? AppColors.gray500 : AppColors.gray400),
                size: AppConstants.iconSizeMedium,
              ),
              onPressed: onFavoriteTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(
    BuildContext context,
    String text,
    String query,
    bool isDark, {
    bool isSubtitle = false,
  }) {
    if (query.isEmpty) {
      return Text(
        text,
        style: isSubtitle
            ? AppTextStyles.songPreview(context).copyWith(
                color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
              )
            : AppTextStyles.songTitle(context).copyWith(
                color: isDark ? AppColors.white : AppColors.textMainLight,
              ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final index = lowerText.indexOf(lowerQuery);

    if (index == -1) {
      return Text(
        text,
        style: isSubtitle
            ? AppTextStyles.songPreview(context).copyWith(
                color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
              )
            : AppTextStyles.songTitle(context).copyWith(
                color: isDark ? AppColors.white : AppColors.textMainLight,
              ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: isSubtitle
            ? AppTextStyles.songPreview(context).copyWith(
                color: isDark ? AppColors.textSubDark : AppColors.textSubLight,
              )
            : AppTextStyles.songTitle(context).copyWith(
                color: isDark ? AppColors.white : AppColors.textMainLight,
              ),
        children: [
          TextSpan(text: text.substring(0, index)),
          TextSpan(
            text: text.substring(index, index + query.length),
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: text.substring(index + query.length)),
        ],
      ),
    );
  }
}

