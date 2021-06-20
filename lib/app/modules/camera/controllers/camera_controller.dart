import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraController extends GetxController {
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  late var status;

  // Crop code
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;

  // Compress code
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  //To get Image from the Gallery or Camera
  //ImageSource.Camera to pick from camera
  //ImageSource.Gallery to pick form gallery
  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";

      //Making Crop after selecting the image
      final cropImageFile = await ImageCropper.cropImage(
          sourcePath: selectedImagePath.value,
          maxWidth: 512,
          maxHeight: 512,
          compressFormat: ImageCompressFormat.jpg);
      cropImagePath.value = cropImageFile!.path;
      cropImageSize.value =
          ((File(cropImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";

      // We Compress the Image After cropping it

      final dir = await Directory.systemTemp;
      final targetPath = dir.absolute.path + "/temp.jpg";
      var compressedFile = await FlutterImageCompress.compressAndGetFile(
          cropImagePath.value, targetPath,
          quality: 90);
      compressImagePath.value = compressedFile!.path;
      compressImageSize.value =
          ((File(compressImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  //Saving the image to the gallery after picking The image cropping The image
  //and compressing The image
  save() async {
    final result = await ImageGallerySaver.saveFile(compressImagePath.value);
    print(result);
  }

  Future<bool> _checkPermission(PermissionStatus status) async {
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

//Show Rationale To inform the user why the storage is needed
  Future<void> rationale() async {
    status = await Permission.storage.status;
    var status1;
    await Permission.storage.isPermanentlyDenied
        .then((value) => status1 = value);
    print("THIS IS STATUS $status");
    print("THIS IS STATUS $status1");
    print("THIS IS STATUS ${status1}");
    if (status1 == true) {
      Get.dialog(
        AlertDialog(
          title:
              Text("Allow Storage Permission So you can download some file to"
                  " your Application Directory"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text('Go to Setting'),
                onPressed: () => {openAppSettings(), Get.back()},
                // ** result: returns this value up the call stack **
              ),
              SizedBox(
                width: 5,
              ),
              ElevatedButton(
                child: Text('Cancel'),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      );
    } else if (status == PermissionStatus.denied) {
      Get.dialog(
        AlertDialog(
          title:
              Text("Allow Storage Permission So you can download some file to"
                  " your Application Directory"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text('Ok'),
                onPressed: () => {_checkPermission(status), Get.back()},
                // ** result: returns this value up the call stack **
              ),
              SizedBox(
                width: 5,
              ),
              ElevatedButton(
                child: Text('Close'),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );
    }
  }
}
