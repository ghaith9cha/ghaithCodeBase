import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/walk_through/controllers/walk_through_controller.dart';
import 'package:ghaith_project/app/modules/walk_through/views/list_logo.dart';

class WalkThroughView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalkThroughController>(
      init: WalkThroughController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                CarouselSlider(
                  carouselController: controller.carouselController,
                  items: imageList,
                  options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      onPageChanged: controller.onPageChange,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height),
                ),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map(
                      (entry) {
                        return GestureDetector(
                          onTap: () {
                            controller.carouselController
                                .animateToPage(entry.key);
                          },
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(controller.current == entry.key
                                        ? 0.9
                                        : 0.4)),
                          ),
                        );
                      },
                    ).toList(),
                  );
                }),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/dashboard");
                  },
                  child: Text("Go to Home screen"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
