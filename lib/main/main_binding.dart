import 'package:get/get.dart';
import 'package:ghaith_project/app/utility/network_conectivity.dart';
import 'package:ghaith_project/main/main_controller.dart';

class Main_binding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController(), permanent: true);
    Get.put(NetworkConnectivity(), permanent: true);

  }
}
