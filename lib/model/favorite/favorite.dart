import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 3)
class Favorite {
  Favorite({
    required this.id,
    required this.recipe,
    required this.user,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  Map<String,int> recipe;

  @HiveField(2)
  Map<String,int> user;
}