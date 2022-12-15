import 'package:hive/hive.dart';

part 'freezer.g.dart';

@HiveType(typeId: 6)
class Freezer {
  Freezer({
    required this.id,
    required this.count,
    required this.user,
    required this.ingredient,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  double count;

  @HiveField(2)
  Map<String, dynamic> user;

  @HiveField(3)
  Map<String, dynamic> ingredient;
}
