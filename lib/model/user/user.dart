import 'package:hive/hive.dart';
import 'package:home_work/model/favorite/favorite.dart';
import 'package:home_work/model/freezer/freezer.dart';
import 'package:home_work/model/comment/comment.dart';

part 'user.g.dart';

@HiveType(typeId: 7)
class User {
  User({
    required this.id,
    required this.login,
    required this.password,
    required this.token,
    required this.userFreezer,
    required this.favoriteRecipes,
    required this.comments,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String login;

  @HiveField(2)
  String password;

  @HiveField(3)
  String token;

  @HiveField(4)
  List<Freezer> userFreezer;

  @HiveField(5)
  List<Favorite> favoriteRecipes;

  @HiveField(6)
  List<Comment> comments;
}
