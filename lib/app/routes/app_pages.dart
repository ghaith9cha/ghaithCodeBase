import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/camera/bindings/camera_binding.dart';
import 'package:ghaith_project/app/modules/camera/views/camera_view.dart';
import 'package:ghaith_project/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:ghaith_project/app/modules/dashboard/views/dashboard_view.dart';
import 'package:ghaith_project/app/modules/download_manager/views/downloader.dart';
import 'package:ghaith_project/app/modules/home/bindings/home_binding.dart';
import 'package:ghaith_project/app/modules/home/views/home_view.dart';
import 'package:ghaith_project/app/modules/map/bindings/map_binding.dart';
import 'package:ghaith_project/app/modules/map/views/map_view.dart';
import 'package:ghaith_project/app/modules/movie/views/movie_view.dart';
import 'package:ghaith_project/app/modules/splash/views/splash_view.dart';
import 'package:ghaith_project/app/modules/walk_through/binding/walk_through_binidng.dart';
import 'package:ghaith_project/app/modules/walk_through/views/walk_through_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.FIRST_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(name: _Paths.SPLASH, page: () => SplashView()),
    GetPage(name: _Paths.MAP, page: () => Map(), binding: MapBinding()),
    GetPage(
      name: _Paths.DOWNLOADER,
      page: () => Downloader(),
    ),
    GetPage(
        name: _Paths.CAMERA,
        page: () => CameraView(),
        binding: CameraBinding()),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.WALK_THROUGH,
      page: () => WalkThroughView(),
      binding: WalkThroughBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE,
      page: () => MovieView(),
    ),
  ];
}
