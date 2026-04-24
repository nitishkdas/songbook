class Song {
  final int id;
  final String char;
  final String songTitle;
  final String lyric;
  final int? suggestIntentDataId;
  final bool favorite;

  Song({
    required this.id,
    required this.char,
    required this.songTitle,
    required this.lyric,
    this.suggestIntentDataId,
    required this.favorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'char': char,
      'song_title': songTitle,
      'lyric': lyric,
      'suggest_intent_data_id': suggestIntentDataId,
      'favorite': favorite ? 1 : 0,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    // Helper function to safely convert to int
    int? toInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    // Helper function to safely convert to bool
    bool toBool(dynamic value) {
      if (value == null) return false;
      if (value is bool) return value;
      if (value is int) return value == 1;
      if (value is String) {
        return value == '1' || value.toLowerCase() == 'true';
      }
      return false;
    }

    return Song(
      id: toInt(map['id']) ?? 0,
      char: map['char']?.toString() ?? '',
      songTitle: map['song_title']?.toString().replaceAll(RegExp(r"^['\s]+"), '') ?? '',
      lyric: map['lyric']?.toString() ?? '',
      suggestIntentDataId: toInt(map['suggest_intent_data_id']),
      favorite: toBool(map['favorite']),
    );
  }

  Song copyWith({
    int? id,
    String? char,
    String? songTitle,
    String? lyric,
    int? suggestIntentDataId,
    bool? favorite,
  }) {
    return Song(
      id: id ?? this.id,
      char: char ?? this.char,
      songTitle: songTitle ?? this.songTitle,
      lyric: lyric ?? this.lyric,
      suggestIntentDataId: suggestIntentDataId ?? this.suggestIntentDataId,
      favorite: favorite ?? this.favorite,
    );
  }
}
