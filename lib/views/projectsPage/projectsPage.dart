import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../../model/project.dart';
import '../../utils/http.dart';

Future<List<Project>> fetchProjects() async {
  List<Project> result = List<Project>();
  final response = await NetUtils.get('httpAuth/app/rest/projects');

  if (response != null && response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.data);
    var projects = jsonData['projects']['project'];

    projects.forEach((item) {
      result.add(Project.fromJson(item));
    });
  } else {
    // If that call was not successful, throw an error.
    //throw Exception('Failed to load projects');
  }

  print("result is ${result.toString()}");

  return result;
}

class ProjectsPage extends StatefulWidget {
  ProjectsPage(this.isFavorite);

  bool isFavorite;

  @override
  _ProjectsPageState createState() => new _ProjectsPageState(this.isFavorite);
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool _isFavorite;

  _ProjectsPageState(this._isFavorite);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new FutureBuilder<List<Project>>(
        future: fetchProjects(),
        builder: (context, snap) {
          if (snap.hasData && snap.data.length > 0) {
             return ListView.builder(
                 itemBuilder: (BuildContext context, int index){
                   var item = snap.data[index];
                   return ListTile(
                     key: Key(item.id),
                     title: Text(item.name),
                     subtitle: Text(item.description),
                     leading: Icon(Icons.alarm_on),
                   );
                 },
                  itemCount: snap.data.length,
             );
            //return Text('sadsda');
          } else if (snap.hasError) {
            return Text(snap.error);
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
