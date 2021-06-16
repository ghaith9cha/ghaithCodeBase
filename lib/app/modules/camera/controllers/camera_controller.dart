import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class CameraController extends GetxController {
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // Crop code
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;

  // Compress code
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";

      // Crop
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

      // Compress

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

  save() async {
    final result = await ImageGallerySaver.saveFile(compressImagePath.value);
    print(result);
  }
}
