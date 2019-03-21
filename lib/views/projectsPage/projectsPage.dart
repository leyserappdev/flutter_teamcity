import 'package:flutter/material.dart';

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
      child: Text('Projects content'),
    );
  }
}
