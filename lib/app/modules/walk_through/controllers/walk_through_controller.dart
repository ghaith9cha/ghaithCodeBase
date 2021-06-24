import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';

class WalkThroughController extends GetxController {
  final CarouselController carouselController = CarouselController();
  Rx<int> current = Rx<int>(0);

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    current.value = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }
}
