import 'dart:io';

extension FileExtension on FileSystemEntity {
  String get name => path.split('\\').last;
}

extension MapExtension on Map<String, dynamic> {
  bool get isComponent => this['status'] != null;
  bool get isAsset => !isComponent;
  bool get isRoot => this['parentId'] == null && this['locationId'] == null;
}
