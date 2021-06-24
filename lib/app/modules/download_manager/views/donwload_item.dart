// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:get/get.dart';
// import 'package:ghaith_project/app/modules/download_manager/controllers/downloader_controller.dart';
// import 'package:ghaith_project/app/utility/tasks_classes.dart';
//
// class DownloadItem extends GetView<DownloaderController> {
//   final ItemHolder? data;
//   final Function(TaskInfo?)? onItemClick;
//   final Function(TaskInfo?)? onActionClick;
//
//   DownloadItem({this.data, this.onItemClick, this.onActionClick});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 16.0, right: 8.0),
//       child: InkWell(
//         onTap: data?.task?.status == DownloadTaskStatus.complete
//             ? () {
//                 onItemClick!(data?.task);
//               }
//             : null,
//         child: Stack(
//           children: <Widget>[
//             Container(
//               width: double.infinity,
//               height: 64.0,
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: Text(
//                       (data?.name == null) ? "No name" : data!.name!,
//                       maxLines: 1,
//                       softWrap: true,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: buildActionForTask(data?.task),
//                   ),
//                 ],
//               ),
//             ),
//             data?.task?.status == DownloadTaskStatus.running ||
//                     data?.task?.status == DownloadTaskStatus.paused
//                 ? Positioned(
//                     left: 0.0,
//                     right: 0.0,
//                     bottom: 0.0,
//                     child: LinearProgressIndicator(
//                       value: data!.task!.progress! / 100,
//                     ),
//                   )
//                 : Container()
//           ].toList(),
//         ),
//       ),
//     );
//   }
//
//   Widget buildActionForTask(TaskInfo? task) {
//     return Obx(() {
//       if (controller.didChange.value >= 0) {
//         if (task?.status == DownloadTaskStatus.undefined) {
//           return RawMaterialButton(
//             onPressed: () {
//               onActionClick!(task);
//               controller.update();
//             },
//             child: Icon(Icons.file_download),
//             shape: CircleBorder(),
//             constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
//           );
//         } else if (task?.status == DownloadTaskStatus.running) {
//           return RawMaterialButton(
//             onPressed: () {
//               onActionClick!(task);
//               controller.update();
//             },
//             child: Icon(
//               Icons.pause,
//               color: Colors.red,
//             ),
//             shape: CircleBorder(),
//             constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
//           );
//         } else if (task?.status == DownloadTaskStatus.paused) {
//           return RawMaterialButton(
//             onPressed: () {
//               onActionClick!(task);
//               controller.update();
//             },
//             child: Icon(
//               Icons.play_arrow,
//               color: Colors.green,
//             ),
//             shape: CircleBorder(),
//             constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
//           );
//         } else if (task?.status == DownloadTaskStatus.complete) {
//           return Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text(
//                 'Ready',
//                 style: TextStyle(color: Colors.green),
//               ),
//               RawMaterialButton(
//                 onPressed: () {
//                   onActionClick!(task);
//                   controller.update();
//                 },
//                 child: Icon(
//                   Icons.delete_forever,
//                   color: Colors.red,
//                 ),
//                 shape: CircleBorder(),
//                 constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
//               )
//             ],
//           );
//         } else if (task?.status == DownloadTaskStatus.canceled) {
//           return Text('Canceled', style: TextStyle(color: Colors.red));
//         } else if (task?.status == DownloadTaskStatus.failed) {
//           return Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text('Failed', style: TextStyle(color: Colors.red)),
//               RawMaterialButton(
//                 onPressed: () {
//                   onActionClick!(task);
//                   controller.update();
//                 },
//                 child: Icon(
//                   Icons.refresh,
//                   color: Colors.green,
//                 ),
//                 shape: CircleBorder(),
//                 constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
//               )
//             ],
//           );
//         } else if (task?.status == DownloadTaskStatus.enqueued) {
//           return Text('Pending', style: TextStyle(color: Colors.orange));
//         } else {
//           return Text("NON");
//         }
//       } else {
//         return Container();
//       }
//     });
//   }
// }
