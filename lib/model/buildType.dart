import 'dart:async';

abstract class BuildTypeInterface {
  String get id;

  String get name;

  String get projectName;

  String get projectId;

  String get href;

  String get webUrl;
}

class BuildType implements BuildTypeInterface {
  String id;

  String name;

  String projectName;

  String projectId;

  String href;

  String webUrl;

  BuildType(
      {this.id,
      this.name,
      this.projectName,
      this.projectId,
      this.href,
      this.webUrl});

  factory BuildType.fromJson(Map<String, dynamic> json) {
    return BuildType(
      id: json['id'],
      name: json['name'],
      projectName: json['projectName'],
      projectId: json['projectId'],
      href: json['href'],
      webUrl: json['webUrl'],
    );
  }
}
