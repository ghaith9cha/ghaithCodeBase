import 'package:flutter_downloader/flutter_downloader.dart';

class TaskInfo {
  final String? name;
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;

  TaskInfo({this.name, this.link});
}

class ItemHolder {
  final String? name;
  final TaskInfo? task;

  ItemHolder({this.name, this.task});
}
