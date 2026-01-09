import 'package:flutter/material.dart';
import '../../../core/models/song.dart';
import '../../../core/widgets/base_song_card.dart';

class SearchResultCard extends StatelessWidget {
  final Song song;
  final String searchQuery;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const SearchResultCard({
    super.key,
    required this.song,
    required this.searchQuery,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return BaseSongCard(
      song: song,
      onTap: onTap,
      onFavoriteTap: onFavoriteTap,
      variant: SongCardVariant.search,
      searchQuery: searchQuery,
    );
  }
}

