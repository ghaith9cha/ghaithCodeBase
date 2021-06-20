import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SplashView extends GetView {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () => Get.offNamed("/dashboard"));

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: SvgPicture.asset('assets/logo.svg'),
      ),
    );
  }
}
