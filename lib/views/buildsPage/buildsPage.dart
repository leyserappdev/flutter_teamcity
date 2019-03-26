import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../../utils/http.dart';
import 'package:flutter/material.dart';
import '../../model/build.dart';

Future<List<Build>> fetchBuild(String projectId) async {
  List<Build> result = List<Build>();
  final response =
      await NetUtils.get('httpAuth/app/rest/projects/id:$projectId/builds/');

  if (response != null && response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.data);
    var builds = jsonData['builds']['build'];

    builds.forEach((item) {
      result.add(Build.fromJson(item));
    });
  } else {
    // If that call was not successful, throw an error.
    //throw Exception('Failed to load projects');
  }

  print("result is ${result.toString()}");

  return result;
}

class BuildsPage extends StatefulWidget {
  BuildsPage(this.buildTypeId);

  final String buildTypeId;

  @override
  _BuildsPageState createState() => new _BuildsPageState(buildTypeId);
}

class _BuildsPageState extends State<BuildsPage> {
  String _buildTypeId;

  _BuildsPageState(buildTypeId) {
    _buildTypeId = buildTypeId;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: FutureBuilder<List<Build>>(
      future: fetchBuild(_buildTypeId),
      builder: (context, snap) {
        if (snap.hasData && snap.data.length > 0) {
        } else if (snap.hasError) {
          return Text(snap.error);
        }
        return CircularProgressIndicator();
      },
    ));
  }
}
