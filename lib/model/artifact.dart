import 'dart:async';

abstract class ArtifactInterface {
  int get size;

  String get modificationTime;

  String get name;

  String get href;
}

class Artifact implements ArtifactInterface {
  int size;

  String modificationTime;

  String name;

  String href;

  Artifact({
    this.size,
    this.modificationTime,
    this.name,
    this.href,
  });

  factory Artifact.fromJson(Map<String, dynamic> json) {
    return Artifact(
      size: int.tryParse(json['size']),
      modificationTime: json['modificationTime'],
      name: json['name'],
      href: json['href'],
    );
  }
}
