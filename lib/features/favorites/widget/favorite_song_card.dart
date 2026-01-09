import 'package:flutter/material.dart';
import '../../../core/models/song.dart';
import '../../../core/widgets/base_song_card.dart';

class FavoriteSongCard extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const FavoriteSongCard({
    super.key,
    required this.song,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return BaseSongCard(
      song: song,
      onTap: onTap,
      onFavoriteTap: onFavoriteTap,
      variant: SongCardVariant.favorite,
    );
  }
}

