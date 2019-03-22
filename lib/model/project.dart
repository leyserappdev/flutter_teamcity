import 'dart:async';

abstract class ProjectInterface {
  String get id;

  String get name;

  String get description;

  String get href;

  String get parentProjectId;
}

class Project implements ProjectInterface {
  String id;

  String name;

  String description;

  String href;

  String parentProjectId;

  Project(
      {this.id, this.name, this.description, this.href, this.parentProjectId});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        href: json['href'],
        parentProjectId: json['parentProjectId']);
  }
}
