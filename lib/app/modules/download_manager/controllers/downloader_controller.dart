// import 'dart:io';
// import 'dart:isolate';
// import 'dart:ui';
//
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:get/get.dart';
// import 'package:ghaith_project/app/utility/tasks_classes.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class DownloaderController extends GetxController {
//   final documents = [
//     {
//       'name': 'Learning Android Studio',
//       'link':
//           'http://barbra-coco.dyndns.org/student/learning_android_studio.pdf'
//     },
//     {
//       'name': 'Android Programming Cookbook',
//       'link':
//           'http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf'
//     },
//     {
//       'name': 'iOS Programming Guide',
//       'link':
//           'http://darwinlogic.com/uploads/education/iOS_Programming_Guide.pdf'
//     },
//     {
//       'name': 'Objective-C Programming (Pre-Course Workbook',
//       'link':
//           'https://www.bignerdranch.com/documents/objective-c-prereading-assignment.pdf'
//     },
//   ];
//
//   final images = [
//     {
//       'name': 'Arches National Park',
//       'link':
//           'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg'
//     },
//     {
//       'name': 'Canyonlands National Park',
//       'link':
//           'https://upload.wikimedia.org/wikipedia/commons/7/78/Canyonlands_National_Park%E2%80%A6Needles_area_%286294480744%29.jpg'
//     },
//     {
//       'name': 'Death Valley National Park',
//       'link':
//           'https://upload.wikimedia.org/wikipedia/commons/b/b2/Sand_Dunes_in_Death_Valley_National_Park.jpg'
//     },
//     {
//       'name': 'Gates of the Arctic National Park and Preserve',
//       'link':
//           'https://upload.wikimedia.org/wikipedia/commons/e/e4/GatesofArctic.jpg'
//     }
//   ];
//
//   final videos = [
//     {
//       'name': 'Big Buck Bunny',
//       'link':
//           'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
//     },
//     {
//       'name': 'Elephant Dream',
//       'link':
//           'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
//     }
//   ];
//
//   List<TaskInfo>? taskss;
//   late List<ItemHolder> items;
//   Rx<bool> isLoading = Rx<bool>(true).obs();
//   Rx<bool> permissionReady = Rx<bool>(false).obs();
//   late String localPath;
//   ReceivePort port = ReceivePort();
//   Rx<bool> debug = Rx<bool>(true);
//   Rx<int> didChange = Rx<int>(0);
//
//   @override
//   onInit() {
//     super.onInit();
//     isLoading.value = true;
//     permissionReady.value = false;
//
//     bindBackgroundIsolate();
//     FlutterDownloader.registerCallback(downloadCallback);
//
//     prepare();
//   }
//
//   @override
//   void dispose() {
//     unbindBackgroundIsolate();
//     super.dispose();
//   }
//
//   void bindBackgroundIsolate() {
//     bool isSuccess = IsolateNameServer.registerPortWithName(
//         port.sendPort, 'downloader_send_port');
//     if (!isSuccess) {
//       unbindBackgroundIsolate();
//       bindBackgroundIsolate();
//       return;
//     }
//     port.listen((dynamic data) {
//       if (debug.value) {
//         print('UI Isolate Callback: $data');
//       }
//       String? id = data[0];
//       DownloadTaskStatus? status = data[1];
//       int? progress = data[2];
//
//       if (taskss != null && taskss!.isNotEmpty) {
//         Rx<TaskInfo?> task = TaskInfo().obs;
//         task.value = (taskss!.firstWhere((task) => task.taskId == id));
//         task.value?.status = status;
//         task.value?.progress = progress;
//       }
//     });
//   }
//
//   void unbindBackgroundIsolate() {
//     IsolateNameServer.removePortNameMapping('downloader_send_port');
//   }
//
//   static void downloadCallback(
//       String id, DownloadTaskStatus status, int progress) {
//     // if (debug.value == true) {
//     //   print(
//     //       'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
//     // }
//     final SendPort send =
//         IsolateNameServer.lookupPortByName('downloader_send_port')!;
//     send.send([id, status, progress]);
//   }
//
//   Future<void> prepareSaveDir() async {
//     localPath = (await findLocalPath())! + Platform.pathSeparator + 'Download';
//
//     final savedDir = Directory(localPath);
//     bool hasExisted = await savedDir.exists();
//     if (!hasExisted) {
//       savedDir.create();
//     }
//   }
//
//   Future<String?> findLocalPath() async {
//     final directory = await getExternalStorageDirectory();
//     return directory?.path;
//   }
//
//   void requestDownload(TaskInfo task) async {
//     task.taskId = await FlutterDownloader.enqueue(
//         url: task.link!,
//         headers: {"auth": "test_for_sql_encoding"},
//         savedDir: localPath,
//         showNotification: true,
//         openFileFromNotification: true);
//   }
//
//   void cancelDownload(TaskInfo task) async {
//     await FlutterDownloader.cancel(taskId: task.taskId!);
//   }
//
//   void pauseDownload(TaskInfo task) async {
//     await FlutterDownloader.pause(taskId: task.taskId!);
//   }
//
//   void resumeDownload(TaskInfo task) async {
//     String? newTaskId = await FlutterDownloader.resume(taskId: task.taskId!);
//     task.taskId = newTaskId;
//   }
//
//   void retryDownload(TaskInfo task) async {
//     String? newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
//     task.taskId = newTaskId;
//   }
//
//   Future<bool> openDownloadedFile(TaskInfo? task) {
//     if (task != null) {
//       return FlutterDownloader.open(taskId: task.taskId!);
//     } else {
//       return Future.value(false);
//     }
//   }
//
//   void delete(TaskInfo task) async {
//     await FlutterDownloader.remove(
//         taskId: task.taskId!, shouldDeleteContent: true);
//     await prepare();
//   }
//
//   Future<bool> checkPermission() async {
//     final status = await Permission.storage.status;
//     if (status != PermissionStatus.granted) {
//       final result = await Permission.storage.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     } else {
//       return true;
//     }
//     return false;
//   }
//
//   Future<Null> prepare() async {
//     final tasks = await FlutterDownloader.loadTasks();
//     int count = 0;
//     taskss = [];
//     items = [];
//
//     taskss!.addAll(documents.map((document) =>
//         TaskInfo(name: document['name'], link: document['link'])));
//
//     items.add(ItemHolder(name: 'Documents'));
//     for (int i = count; i < taskss!.length; i++) {
//       items.add(ItemHolder(name: taskss![i].name, task: taskss![i]));
//       count++;
//     }
//
//     taskss!.addAll(images
//         .map((image) => TaskInfo(name: image['name'], link: image['link'])));
//
//     items.add(ItemHolder(name: 'Images'));
//     for (int i = count; i < taskss!.length; i++) {
//       items.add(ItemHolder(name: taskss![i].name, task: taskss![i]));
//       count++;
//     }
//
//     taskss!.addAll(videos
//         .map((video) => TaskInfo(name: video['name'], link: video['link'])));
//
//     items.add(ItemHolder(name: 'Videos'));
//     for (int i = count; i < taskss!.length; i++) {
//       items.add(ItemHolder(name: taskss![i].name, task: taskss![i]));
//       count++;
//     }
//
//     tasks!.forEach((task) {
//       for (TaskInfo info in taskss!) {
//         if (info.link == task.url) {
//           info.taskId = task.taskId;
//           info.status = task.status;
//           info.progress = task.progress;
//         }
//       }
//     });
//
//     permissionReady.value = await checkPermission();
//
//     if (permissionReady.value) {
//       await prepareSaveDir();
//     }
//     isLoading.value = false;
//   }
//
//   Future<void> retryRequestPermission() async {
//     final hasGranted = await checkPermission();
//
//     if (hasGranted) {
//       await prepareSaveDir();
//     }
//     permissionReady.value = hasGranted;
//   }
// }
