import 'dart:async';

abstract class BuildInterface {
  String get id;

  String get buildTypeId;

  String get number;

  String get status;

  String get state;

  String get href;

  String get webUrl;
}

class Build implements BuildInterface {
  String id;

  String buildTypeId;

  String number;

  String status;

  String state;

  String href;

  String webUrl;

  Build(
      {this.id,
      this.buildTypeId,
      this.number,
      this.status,
      this.state,
      this.href,
      this.webUrl});

  factory Build.fromJson(Map<String, dynamic> json) {
    return Build(
      id: json['id'],
      buildTypeId: json['buildTypeId'],
      number: json['number'],
      status: json['status'],
      state: json['state'],
      href: json['href'],
      webUrl: json['webUrl'],
    );
  }
}
