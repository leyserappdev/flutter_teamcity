import 'package:flutter/material.dart';
import 'package:flutter_teamcity/widgets/components/bottomNavigationBar.dart';

class ProjectsPage extends StatefulWidget {
  ProjectsPage(this.isFavorite);

  bool isFavorite;

  @override
  _ProjectsPageState createState() => new _ProjectsPageState(this.isFavorite);
}

class _ProjectsPageState extends State<ProjectsPage>{
  bool _isFavorite;

  _ProjectsPageState(this._isFavorite);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _isFavorite ? Text('Favorite Projects') : Text('Projects')
      ),
      body: Container(
        child: Text('Projects content'),
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}