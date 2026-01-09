import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../app/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.gray800 : AppColors.gray200,
      highlightColor: isDark ? AppColors.gray700 : AppColors.gray100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? AppColors.gray800 : AppColors.gray200,
          borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
      ),
    );
  }
}

class SongListSkeleton extends StatelessWidget {
  const SongListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _SongCardSkeleton();
      },
    );
  }
}

class _SongCardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingXXL,
        vertical: AppConstants.spacingMD,
      ),
      child: Row(
        children: [
          // Icon skeleton
          SkeletonLoader(
            width: AppConstants.cardIconSize,
            height: AppConstants.cardIconSize,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          ),
          const SizedBox(width: AppConstants.spacingLG),
          // Content skeleton
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(
                  width: double.infinity,
                  height: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: AppConstants.spacingXS),
                SkeletonLoader(
                  width: 200,
                  height: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppConstants.spacingSM),
          // Favorite button skeleton
          SkeletonLoader(
            width: 40,
            height: 40,
            borderRadius: BorderRadius.circular(20),
          ),
        ],
      ),
    );
  }
}

class FavoriteCardSkeleton extends StatelessWidget {
  const FavoriteCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMD),
      padding: const EdgeInsets.all(AppConstants.spacingMD),
      child: Row(
        children: [
          // Number badge skeleton
          SkeletonLoader(
            width: AppConstants.favoriteCardIconSize,
            height: AppConstants.favoriteCardIconSize,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          ),
          const SizedBox(width: AppConstants.spacingLG),
          // Content skeleton
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(
                  width: double.infinity,
                  height: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: AppConstants.spacingXS),
                SkeletonLoader(
                  width: 180,
                  height: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppConstants.spacingSM),
          // Favorite button skeleton
          SkeletonLoader(
            width: 40,
            height: 40,
            borderRadius: BorderRadius.circular(20),
          ),
        ],
      ),
    );
  }
}

class FavoriteListSkeleton extends StatelessWidget {
  const FavoriteListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingLG),
      itemCount: 8,
      itemBuilder: (context, index) {
        return const FavoriteCardSkeleton();
      },
    );
  }
}

class SongDetailSkeleton extends StatelessWidget {
  const SongDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingXXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title skeleton
          SkeletonLoader(
            width: double.infinity,
            height: 32,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: AppConstants.spacingLG),
          // Lyrics skeleton - multiple lines
          ...List.generate(15, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.spacingMD),
              child: SkeletonLoader(
                width: index % 3 == 0 ? double.infinity : (index % 3 == 1 ? 300 : 250),
                height: 20,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class SearchResultSkeleton extends StatelessWidget {
  const SearchResultSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLG,
            vertical: AppConstants.spacingMD,
          ),
          child: Row(
            children: [
              // Number badge skeleton
              SkeletonLoader(
                width: AppConstants.cardIconSize,
                height: AppConstants.cardIconSize,
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
              ),
              const SizedBox(width: AppConstants.spacingLG),
              // Content skeleton
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLoader(
                      width: double.infinity,
                      height: 20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: AppConstants.spacingXS),
                    SkeletonLoader(
                      width: 220,
                      height: 16,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.spacingSM),
              // Favorite button skeleton
              SkeletonLoader(
                width: 40,
                height: 40,
                borderRadius: BorderRadius.circular(20),
              ),
            ],
          ),
        );
      },
    );
  }
}

