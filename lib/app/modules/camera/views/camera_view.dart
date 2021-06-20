import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/camera/controllers/camera_controller.dart';
import 'package:ghaith_project/app/utility/main_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraView extends GetView<CameraController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Camera'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => controller.compressImagePath.value == ''
                    ? Center(
                        child: Text(
                          'Select image from camera/galley',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : Image.file(
                        File(controller.compressImagePath.value),
                        width: double.infinity,
                        height: 300,
                      ),
              ),

              SizedBox(
                height: 10,
              ),
              Obx(() => Text(
                    controller.compressImageSize.value == ''
                        ? ''
                        : controller.compressImageSize.value,
                    style: TextStyle(fontSize: 20),
                  )),

              //Crop

              ElevatedButton(
                onPressed: () {
                  controller.getImage(ImageSource.camera);
                },
                child: Text("Camera"),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.getImage(ImageSource.gallery);
                },
                child: Text("Gallery"),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (controller.status == PermissionStatus.denied) {
                    await controller.rationale();
                  }
                  if (controller.status != PermissionStatus.denied) {
                    controller.save();
                  } else {
                    Get.snackbar(
                        "Permission Required",
                        "Please Allow Storage Permission "
                            "so you can save the Image to your gallery",
                        duration: Duration(seconds: 2));
                  }
                },
                child: Text("Save Image"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
