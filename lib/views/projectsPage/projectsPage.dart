import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../../model/project.dart';
import '../../utils/http.dart';
import '../../utils/sharedPreferences.dart';

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

  SpUtil _spUtil;

  _ProjectsPageState(bool isFavorite) {
    _isFavorite = isFavorite;
    init();
  }

  Future init() async {
    _spUtil = await SpUtil.getInstance();
  }

  List<String> getFavoriteProjectIds() {
    var ids = _spUtil.getStringList(SharedPreferencesKeys.favoriteProjectIds);
    return ids ?? [];
  }

  void addFavoriteProjectId(String id) {
    var ids = getFavoriteProjectIds();
    if (ids != null && !ids.contains(id)) {
      ids.add(id);
      _spUtil.putStringList(SharedPreferencesKeys.favoriteProjectIds, ids);
    }
  }

  void removeFavoriteProjectId(String id) {
    var ids = getFavoriteProjectIds();
    if (ids != null && ids.contains(id)) {
      ids.removeWhere((item) => item == id);
      _spUtil.putStringList(SharedPreferencesKeys.favoriteProjectIds, ids);
    }
  }

  Project _generateTree(List<Project> projects) {
    var rootNode =
        projects.firstWhere((project) => project.parentProjectId == null);

    _generateSubTree(projects, rootNode);

    return rootNode;
  }

  _generateSubTree(List<Project> projects, Project curNode) {
    var children = projects
        .where((project) => project.parentProjectId == curNode.id)
        .toList(growable: false);

    if (children != null && children.length > 0) {
      curNode.children = children;
      children.forEach((child) => _generateSubTree(projects, child));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new FutureBuilder<List<Project>>(
        future: fetchProjects(),
        builder: (context, snap) {
          if (snap.hasData && snap.data.length > 0) {
            var datas = snap.data.toList();
            _generateTree(datas);

            var favoriteIds = getFavoriteProjectIds();

            //only show leaf node
            var leafNodesIter = datas.where(
                (data) => data.children == null || data.children.length == 0);

            if (_isFavorite) {
              leafNodesIter =
                  leafNodesIter.where((node) => favoriteIds.contains(node.id));
            }
            var leafNodes = leafNodesIter.toList();

            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                var item = leafNodes[index];
                bool alreadyFavorite = favoriteIds.contains(item.id);
                return ListTile(
                  key: Key(item.id),
                  title: Text(item.name),
                  subtitle:
                      item.description == null ? null : Text(item.description),
                  trailing: _isFavorite
                      ? null
                      : (alreadyFavorite
                          ? IconButton(
                              icon: Icon(Icons.favorite),
                              onPressed: () {
                                setState(() {
                                  removeFavoriteProjectId(item.id);
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {
                                setState(() {
                                  addFavoriteProjectId(item.id);
                                });
                              },
                            )),
                  onTap: () {},
                );
              },
              itemCount: leafNodes.length,
            );
          } else if (snap.hasError) {
            return Text(snap.error);
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
