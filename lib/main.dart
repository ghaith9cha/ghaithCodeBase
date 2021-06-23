import 'dart:async';
import 'dart:isolate';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ghaith_project/app/widgets/strings.dart';
import 'package:ghaith_project/main/main_binding.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'app/routes/app_pages.dart';

final logger = Logger();
late SharedPreferences prefs;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();



  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );



  //Must Initialize Firebase before using any firebase tool
  await Firebase.initializeApp();

  //Initializing firebase messaging instance
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  //getting firebase message token to store it at the firebase
  firebaseMessaging
      .getToken()
      .then((value) => print("THIS IS FCM TOKEN $value"));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //checking if we are not using web platform to handle firebase messaging for android and ios
  if (!kIsWeb) {
    //creating notification channel so we can send messages throw it
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  prefs = await SharedPreferences.getInstance();

  //creating A Zoned Guarded to handle exception that Flutter can't catch it and send it to crashlytics
  runZonedGuarded<Future<void>>(() async {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    //creating an isolate to catch to catch error that are out side of flutter context
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort);

    //Initializing  flutter analytics
    FirebaseAnalytics analytics = FirebaseAnalytics();
    //using firebase on error to catch error that are under the flutter context
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    // FirebaseCrashlytics.instance.crash();

    FirebaseAnalyticsObserver observer =
        FirebaseAnalyticsObserver(analytics: analytics);
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
  }, FirebaseCrashlytics.instance.recordError);
}
