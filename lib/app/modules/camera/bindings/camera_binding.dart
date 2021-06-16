import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/camera/controllers/camera_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<CameraController>(
      () => CameraController(),
    );


    _toastInfo(String info) {
      Get.snackbar("Message", info.toString(), duration: Duration(seconds: 2));
    }


      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();

      final info = statuses[Permission.storage].toString();
      print(info);
      _toastInfo(info);




  }
}
