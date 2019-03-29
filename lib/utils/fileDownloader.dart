import 'package:flutter_downloader/flutter_downloader.dart';

export 'package:flutter_downloader/flutter_downloader.dart';

// typedef void DownloadCallback(String id, DownloadTaskStatus status, int progress);

class FileDownloader {
  static Future<String> enqueue(
      {String url,
      String saveDir,
      bool showNotification,
      bool openFileFromNotification,
      String fileName,
      Map<String, String> headers}) async {
    final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: saveDir,
        showNotification: showNotification,
        openFileFromNotification: openFileFromNotification,
        fileName: fileName,
        headers: headers);

    return taskId;
  }

  static Future loadAllTask() async {
    await FlutterDownloader.loadTasks();
  }

  static Future openAndPreview(String taskId) async {
    await FlutterDownloader.open(taskId: taskId);
  }

  static Future registerCallback(DownloadCallback callback) {
    FlutterDownloader.registerCallback(callback);
  }
}
