import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../../features/songbook_selection/binding/songbook_selection_binding.dart';
import '../../features/songbook_selection/view/songbook_selection_page.dart';
import '../../features/home/binding/home_binding.dart';
import '../../features/home/view/home_page.dart';
import '../../features/song_detail/binding/song_detail_binding.dart';
import '../../features/song_detail/view/song_detail_page.dart';
import '../../features/favorites/binding/favorites_binding.dart';
import '../../features/favorites/view/favorites_page.dart';
import '../../features/search/binding/search_binding.dart';
import '../../features/search/view/search_page.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.songbookSelection,
      page: () => const SongbookSelectionPage(),
      binding: SongbookSelectionBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.noTransition, // No transition for bottom nav switching
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: AppRoutes.songDetail,
      page: () => const SongDetailPage(),
      binding: SongDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesPage(),
      binding: FavoritesBinding(),
      transition: Transition.noTransition, // No transition for bottom nav switching
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchPage(),
      binding: SearchBinding(),
    ),
  ];
}

