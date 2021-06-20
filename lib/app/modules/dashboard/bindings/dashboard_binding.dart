import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/camera/controllers/camera_controller.dart';
import 'package:ghaith_project/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:ghaith_project/app/modules/home/controllers/home_controller.dart';
import 'package:ghaith_project/app/modules/map/controllers/map_controller.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(()=>HomeController());
    Get.lazyPut<MapController>(()=>MapController());
    Get.lazyPut<CameraController>(()=>CameraController());
    Get.lazyPut<DashBoardController>(()=>DashBoardController());
  }

}