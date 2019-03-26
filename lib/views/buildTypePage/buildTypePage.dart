import 'dart:async';
import 'dart:convert';
import '../../utils/http.dart';
import 'package:flutter/material.dart';
import '../../model/buildType.dart';


Future<List<BuildType>> fetchBuildTypes(String projectId) async {
  List<BuildType> result = List<BuildType>();
  final response = await NetUtils.get('httpAuth/app/rest/projects/id:$projectId');

  if (response != null && response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.data);
    var buildTypes = jsonData['buildTypes']['buildType'];

    buildTypes.forEach((item) {
      result.add(BuildType.fromJson(item));
    });
  } else {
    // If that call was not successful, throw an error.
    //throw Exception('Failed to load projects');
  }

  print("result is ${result.toString()}");

  return result;
}

class BuildTypePage extends StatefulWidget {
  BuildTypePage(this.projectId);

  final String projectId;

  @override
  _BuildTypePageState createState() => new _BuildTypePageState(projectId);
}

class _BuildTypePageState extends State<BuildTypePage>{

  String _projectId;

  _BuildTypePageState(String projectId){
    _projectId =projectId;
  }

  @override
  Widget build(BuildContext context){
    return new Container(
      child: FutureBuilder<List<BuildType>>(
        future: fetchBuildTypes(_projectId),
        builder: (context, snap){
          if (snap.hasData && snap.data.length > 0){
            return Text('asdsads');
          } else if (snap.hasError){
            return Text(snap.error);
          }
          return CircularProgressIndicator();
        },
      )
    );
  }
}