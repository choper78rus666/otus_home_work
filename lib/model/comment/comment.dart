import 'package:hive/hive.dart';

part 'comment.g.dart';

@HiveType(typeId: 8)
class Comment {
  Comment({
    required this.id,
    required this.text,
    required this.photo,
    required this.datetime,
    required this.user,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String text;

  @HiveField(2)
  String photo;

  @HiveField(3)
  String datetime;

  @HiveField(4)
  Map<String, dynamic> user;

}
