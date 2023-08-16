import 'package:hive/hive.dart';

part 'passbookentry.g.dart';

@HiveType(typeId: 0)
class Entry extends HiveObject {
  @HiveField(0)
  String name;

  Entry(this.name);
}
