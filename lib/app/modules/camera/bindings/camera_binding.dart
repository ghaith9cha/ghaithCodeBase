import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/camera/controllers/camera_controller.dart';

class CameraBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<CameraController>(
      () => CameraController(),
    );

    CameraController controller = Get.find();

    controller.rationale();
  }
}
