import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  ProjectsPage(this.isFavorite);

  final bool isFavorite;

  @override
  _ProjectsPageState createState() => new _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage>{
  @override
  Widget build(BuildContext context){
    return new Container(
      child: new Text('Build'),
    );
  }
}