class Helpers {
  /// Removes HTML tags from text and returns clean text
  static String removeHtmlTags(String htmlText) {
    return htmlText
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  /// Gets preview text from lyrics with specified max length
  static String getPreviewText(String lyric, {int maxLength = 30}) {
    final text = removeHtmlTags(lyric);
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }
}

