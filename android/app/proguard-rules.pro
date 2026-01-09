# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep your models
-keep class com.nelc.songbook.core.models.** { *; }

# Keep SQLite
-keep class net.sqlcipher.** { *; }
-keep class net.sqlcipher.database.** { *; }

# Keep GetX
-keep class com.github.jonataslaw.** { *; }

# Keep Google Play Core classes (referenced by Flutter but optional)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

