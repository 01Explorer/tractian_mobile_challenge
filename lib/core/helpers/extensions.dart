import 'dart:io';

extension FileExtension on FileSystemEntity {
  String get name => path.split('\\').last;
}
