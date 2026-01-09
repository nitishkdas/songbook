# NELC Songbook Collection

A digital hymnal collection app for NELC songbooks, built with Flutter and GetX. This app provides an intuitive interface for browsing, searching, and viewing hymns with lyrics, supporting both light and dark themes.

## Features

- **Songbook Selection**: Choose from different hymn collections including the main Bodo Christian Hymnal and supplementary songbooks.
- **Song Browsing**: Browse songs alphabetically with a filter system.
- **Search Functionality**: Search songs by title or lyrics with highlighting.
- **Favorites**: Mark and manage favorite songs.
- **Song Details**: View complete lyrics with verse and chorus blocks.
- **Dark/Light Theme**: Automatic theme switching based on system preferences.
- **Offline Support**: Local SQLite database for offline access.

## Screenshots

- Songbook selection screen with available collections
- Home page with alphabetical song list and search bar
- Search results with highlighted matches
- Song detail view with formatted lyrics
- Favorites page with starred songs

## Installation

### Prerequisites

- Flutter SDK (^3.10.4)
- Dart SDK (^3.10.4)
- Android Studio or VS Code with Flutter extensions

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/songbook.git
   cd songbook
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Building for Production

- **Android APK**:
  ```bash
  flutter build apk --release
  ```

- **Web**:
  ```bash
  flutter build web
  ```

## Project Structure

```
lib/
├── app/
│   ├── routes/
│   ├── theme/
│   └── bindings/
├── features/
│   ├── songbook_selection/
│   ├── home/
│   ├── search/
│   ├── favorites/
│   └── song_detail/
├── core/
│   ├── models/
│   ├── services/
│   ├── utils/
│   ├── widgets/
│   └── constants/
└── main.dart
```

## Dependencies

- **State Management**: GetX (^4.6.6)
- **Database**: SQLite with sqflite (^2.3.0)
- **UI**: Material Symbols Icons (^4.2892.0), Google Fonts (^6.1.0)
- **Utilities**: Path Provider (^2.1.1), Shimmer (^3.0.0)

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit changes (`git commit -am 'Add new feature'`)
4. Push to branch (`git push origin feature/new-feature`)
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Credits

- Built with Flutter and GetX
- Icons from Material Symbols
- Fonts from Google Fonts
- Database design for hymn collections

---

**NELC Songbook Collection v2.1** • Created with Love
