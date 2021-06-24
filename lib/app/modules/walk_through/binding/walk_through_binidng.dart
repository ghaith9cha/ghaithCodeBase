import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/walk_through/controllers/walk_through_controller.dart';

class WalkThroughBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalkThroughController>(
          () => WalkThroughController(),
    );

  }
}