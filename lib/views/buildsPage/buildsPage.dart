import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../../utils/http.dart';
import '../../routers/application.dart';
import 'package:flutter/material.dart';
import '../../model/build.dart';
import '../../model/artifact.dart';
import '../../utils/util.dart';
import '../../utils/fileDownloader.dart';

Future<List<Build>> fetchBuild(String projectId) async {
  List<Build> result = List<Build>();
  final response =
      await NetUtils.get('httpAuth/app/rest/buildTypes/$projectId/builds/');

  if (response != null && response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.data);
    var builds = jsonData['builds'];
    var build = builds['build'];
    if (build is Map) {
      result.add(Build.fromJson(build));
    } else {
      build.forEach((item) {
        result.add(Build.fromJson(item));
      });
    }
  } else {
    // If that call was not successful, throw an error.
    //throw Exception('Failed to load projects');
  }
  return result;
}

Future<List<Artifact>> fetchArtifact(String buildId) async {
  List<Artifact> result = List<Artifact>();
  final response = await NetUtils.get(
      'httpAuth/app/rest/builds/$buildId/artifacts/children/');

  if (response != null && response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.data);
    var files = jsonData['files'];
    var file = files['file'];

    if (file == null) {
      return result;
    } else if (file is Map) {
      result.add(Artifact.fromJson(file));
    } else {
      file.forEach((item) {
        result.add(Artifact.fromJson(item));
      });
    }
  } else {
    // If that call was not successful, throw an error.
    //throw Exception('Failed to load projects');
  }
  return result;
}

class BuildsPage extends StatefulWidget {
  BuildsPage(this.buildTypeId, this.buildTypeName);

  final String buildTypeId;
  final String buildTypeName;

  @override
  _BuildsPageState createState() =>
      new _BuildsPageState(buildTypeId, buildTypeName);
}

class _BuildsPageState extends State<BuildsPage> {
  String _buildTypeId;
  String _buildTypeName;

  String _taskId;

  bool _isLoading = false;
  //rio: 暂时不支持多任务下载
  bool _isDownloading = false;

  _BuildsPageState(buildTypeId, buildTypeName) {
    _buildTypeId = buildTypeId;
    _buildTypeName = buildTypeName;
  }

  @override
  initState() {
    super.initState();

    FileDownloader.registerCallback(
        (String id, DownloadTaskStatus status, int progress) {
      if (status == DownloadTaskStatus.complete) {
        FileDownloader.openAndPreview(id);
      }
      print(
          'Download task ($id) is in status ($status) and process ($progress)');

      setState(() {
        _isDownloading = (status == DownloadTaskStatus.running ||
            status == DownloadTaskStatus.enqueued ||
            status == DownloadTaskStatus.paused);
      });
    });
  }

  Future downloadFile(String buildId, String fileName) async {
    bool hasPermission = await CheckStoragePermission();

    if (!hasPermission) {
      //TODO: 提示
      return;
    }

    var baseUrl = await NetUtils.getBaseUrl();
    var authKey = await NetUtils.getAuthKey();
    var basicAuthHeader = 'Basic $authKey';

    var url = '${baseUrl}/app/rest/builds/480037/artifacts/content/${fileName}';
    // var forTest =
    //     'http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf';

    String savePath = await GetFileDownloadPath();

    _taskId = await FileDownloader.enqueue(
        url: url,
        headers: {'Authorization': basicAuthHeader},
        saveDir: savePath,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    FileDownloader.registerCallback(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Builds($_buildTypeName)'),
        ),
        body: FutureBuilder<List<Build>>(
          future: fetchBuild(_buildTypeId),
          builder: (context, snap) {
            if (snap.hasData && snap.data.length > 0) {
              var datas = snap.data.toList().take(5).toList();

              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  var item = datas[index];
                  var statusIcon, color;
                  if (item.status == 'SUCCESS') {
                    statusIcon = Icons.error;
                    color = Colors.redAccent;
                  } else if (item.status == 'FAILURE') {
                    statusIcon = Icons.error;
                    color = Colors.redAccent;
                  } else {
                    statusIcon = Icons.explore;
                    color = Colors.yellowAccent;
                  }

                  return ExpansionTile(
                    key: Key(item.id),
                    initiallyExpanded: index == 0,
                    onExpansionChanged: (bool isExpand) {},
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('#${item.number}'),
                        ),
                        Icon(statusIcon, color: color, size: 18.0),
                        Text(
                          ' ${item.status}',
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 13.0),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.chevron_right),
                    children: <Widget>[
                      Container(
                        child: FutureBuilder<List<Artifact>>(
                          future: fetchArtifact(item.id),
                          builder: (context, snap) {
                            if (snap.hasData && snap.data.length > 0) {
                              var datas = snap.data.toList();

                              var children = datas.map((currentFile) {
                                var sizeFormat =
                                    '${(currentFile.size / (1024 * 1024)).toStringAsFixed(2)}Mb';
                                DateTime modifeTime = DateTime.parse(
                                    currentFile.modificationTime);
                                String dateTimeStr = modifeTime
                                    .toIso8601String()
                                    .substring(0, 19)
                                    .replaceFirst('T', ' ');

                                return ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      currentFile.name.endsWith('apk')
                                          ? Icon(Icons.android, size: 16.0)
                                          : Icon(Icons.attach_file, size: 16.0),
                                      Text(' ${currentFile.name}')
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(dateTimeStr),
                                      ),
                                      Text(sizeFormat)
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.file_download),
                                    onPressed: () {
                                      return showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('File Download'),
                                              content: SingleChildScrollView(
                                                child: Text(
                                                    'Do you want to download the file ${currentFile.name}(${sizeFormat}) to device?'),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                    child: Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                FlatButton(
                                                  child: Text('Ok'),
                                                  onPressed: () {
                                                    setState(() {
                                                      _isLoading = true;
                                                    });
                                                    Navigator.of(context).pop();
                                                    downloadFile(item.id,
                                                        currentFile.name);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                );
                              }).toList();

                              List<Widget> allChildren = [];

                              if (_isLoading) {
                                allChildren.add(LinearProgressIndicator(
                                  semanticsLabel: 'Loading...',
                                ));
                              }

                              allChildren.addAll(children);

                              return Column(
                                children: allChildren,
                              );
                            } else if (snap.hasError) {
                              return Text(snap.error);
                            } else if (snap.hasData && snap.data.length == 0) {
                              //TODO： 把这个组件抽为共通的
                              return Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.warning,
                                      color: Colors.blueGrey,
                                    ),
                                    Text('  There is no Data')
                                  ],
                                ),
                              );
                            }

                            return LinearProgressIndicator();
                          },
                        ),
                      )
                    ],
                  );
                },
                itemCount: datas.length,
              );
            } else if (snap.hasError) {
              return Text(snap.error);
            }
            return LinearProgressIndicator();
          },
        ));
  }
}
