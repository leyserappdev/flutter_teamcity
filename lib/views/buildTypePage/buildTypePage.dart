import 'dart:async';
import 'dart:convert';
import '../../utils/http.dart';
import 'package:flutter/material.dart';
import '../../routers/application.dart';
import '../../model/buildType.dart';
import '../../widgets/components/dataEmptyTip.dart';

String extractBuildTypeStr(String input) {
  var startIndex = input.indexOf('"buildTypes');
  var stack = [];
  var counter = 0;
  var hasPushedSign = false;
  var result = "";

  while (!hasPushedSign || (hasPushedSign && stack.isNotEmpty)) {
    var curChar = input[startIndex + counter];
    counter++;
    result += curChar;
    if (curChar == '{' || curChar == '}') {
      hasPushedSign = true;
      if (stack.length >= 1 && stack.last == '{' && curChar == '}') {
        stack.removeLast();
      } else {
        stack.add(curChar);
      }
    }
  }

  return '{$result}';
}

Future<List<BuildType>> fetchBuildTypes(String projectId) async {
  List<BuildType> result = List<BuildType>();
  final response =
      await NetUtils.get('httpAuth/app/rest/projects/id:$projectId');

  if (response != null && response.statusCode == 200) {
    //xml2json转buildType接口的命令等值的时候 没有处理好转义双引号。 干脆直接把buildType的数据提取出来处理 抛弃无用数据
    //https://github.com/shamblett/xml2json/issues/16
    Map<String, dynamic> jsonData =
        json.decode(extractBuildTypeStr(response.data));
    var buildTypes = jsonData['buildTypes']['buildType'];
    if (buildTypes == null){
      return result;
    }
    buildTypes.forEach((item) {
      result.add(BuildType.fromJson(item));
    });
  } else {
    // If that call was not successful, throw an error.
    //throw Exception('Failed to load projects');
  }

  return result;
}

class BuildTypePage extends StatefulWidget {
  BuildTypePage(this.projectId, this.projectName);

  final String projectId;
  final String projectName;

  @override
  _BuildTypePageState createState() =>
      new _BuildTypePageState(projectId, projectName);
}

class _BuildTypePageState extends State<BuildTypePage> {
  String _projectId;
  String _projectName;

  _BuildTypePageState(String projectId, String projectName) {
    _projectId = projectId;
    _projectName = projectName;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text(_projectName)),
        body: FutureBuilder<List<BuildType>>(
          future: fetchBuildTypes(_projectId),
          builder: (context, snap) {
            if (snap.hasData && snap.data.length > 0) {
              var datas = snap.data.toList();
              //把安卓应用的BuildType标记 并且提前
              var androidAppReg = new RegExp(r'(Android\s*APP | Android)', caseSensitive: false);
              datas.sort((pre, next){
                int preAndroidApp = androidAppReg.allMatches(pre.name).length;
                int nextAndroidApp = androidAppReg.allMatches(next.name).length;
                return nextAndroidApp - preAndroidApp;
              });

              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  var item = datas[index];
                  var isAndroidAppBuildType = androidAppReg.hasMatch(item.name);
                  return ListTile(
                    key: Key(item.id),
                    title: Text(item.name),
                    trailing: Icon(Icons.chevron_right),
                    leading: isAndroidAppBuildType ? Icon(Icons.android, color: Colors.lightGreen,) : null,
                    onTap: () => Application.router
                        .navigateTo(context, '/builds/${item.id}/${item.name}'),
                  );
                },
                itemCount: datas.length,
              );
            } else if (snap.hasError) {
              return Text(snap.error);
            } else if (snap.hasData && snap.data.length == 0){
              return DataEmptyTip();
            }
            return Center(child: CircularProgressIndicator(),);
          },
        ));
  }
}
