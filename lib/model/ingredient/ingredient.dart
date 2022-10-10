import 'package:hive/hive.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 2)
class Ingredient {
  Ingredient({
    required this.id,
    required this.name,
    required this.measureUnit,
    required this.recipeIngredients,
    required this.ingredientFreezer,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<int> measureUnit;

  @HiveField(3)
  Map<String, dynamic> recipeIngredients;

  @HiveField(4)
  Map<String, dynamic> ingredientFreezer;
}
