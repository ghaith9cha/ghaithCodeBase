import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ghaith_project/app/widgets/strings.dart';
import 'package:ghaith_project/main/main_binding.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

final logger = Logger();
late SharedPreferences prefs;

Future<void> main() async {
   FirebaseAnalytics analytics = FirebaseAnalytics();
   FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  print("THIS IS LOCALE ${Get.locale}");
  runApp(GetMaterialApp(
    title: "Application",
    navigatorObservers: <NavigatorObserver>[observer],
    translations: Messages(),
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    locale: Locale(prefs.getString('language_code').toString(),
        prefs.getString('country_code').toString()),
    initialBinding: Main_binding(),
  ));
}
