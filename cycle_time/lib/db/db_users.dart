import 'package:hive/hive.dart';
part 'db_users.g.dart';

@HiveType(typeId: 0)
class DBUser extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String status;

  DBUser(
      {required this.id,
      required this.name,
      required this.password,
      required this.status});
}
