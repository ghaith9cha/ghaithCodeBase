import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/camera/bindings/camera_binding.dart';
import 'package:ghaith_project/app/modules/camera/views/camera_view.dart';
import 'package:ghaith_project/app/modules/download_manager/views/downloader.dart';

import 'package:ghaith_project/app/modules/home/bindings/home_binding.dart';
import 'package:ghaith_project/app/modules/home/views/home_view.dart';
import 'package:ghaith_project/app/modules/map/views/Map.dart';
import 'package:ghaith_project/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(name: _Paths.SPLASH, page: () => SplashView()),
    GetPage(name: _Paths.MAP, page: () => Map()),
    GetPage(name: _Paths.DOWNLOADER, page: () => Downloader()),
    GetPage(name: _Paths.CAMERA,page: ()=>CameraView(),binding: CameraBinding()),
  ];
}
