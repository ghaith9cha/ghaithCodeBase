import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/map/controllers/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(
      () => MapController(),
    );
  }
}
