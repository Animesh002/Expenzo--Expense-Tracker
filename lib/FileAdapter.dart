import 'dart:io';

import 'package:hive/hive.dart';

class FileAdapter extends TypeAdapter<File> {
  @override
  final int typeId = 1;

  @override
  File read(BinaryReader reader) {
    final filePath = reader.read();
    return File(filePath);
  }

  @override
  void write(BinaryWriter writer, File obj) {
    writer.write(obj.path);
  }
}
