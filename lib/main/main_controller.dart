import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ghaith_project/app/repo/app_repository.dart';
import 'package:ghaith_project/app/repo/data_source/services/data_source.dart';
import 'package:ghaith_project/main.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxService {
  late final AppRepository repo;
  late SharedPreferences prefs;

  @override
  Future<void> onInit() async {
    repo = AppRepository();
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }
}
