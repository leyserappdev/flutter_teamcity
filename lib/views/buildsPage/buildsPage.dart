import 'package:flutter/material.dart';

class BuildsPage extends StatefulWidget {
  BuildsPage(this.projectId);

  final int projectId;

  @override
  _BuildsPageState createState() => new _BuildsPageState();
}

class _BuildsPageState extends State<BuildsPage>{
  @override
  Widget build(BuildContext context){
    return new Container(
      child: new Text('Build12312'),
    );
  }
}