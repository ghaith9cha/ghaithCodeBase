import 'package:get/get.dart';

class DashBoardController extends GetxController {
  var indexTap = 0;

  void changeTabIndex(int index) {
    indexTap = index;
    update();
  }
}
