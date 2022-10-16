import 'package:hive/hive.dart';

part 'recipe_ingredient.g.dart';

@HiveType(typeId: 4)
class RecipeIngredients {
  RecipeIngredients({
    required this.id,
    required this.count,
    required this.ingredient,
    required this.recipe,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  int count;

  @HiveField(2)
  Map<String, dynamic> ingredient;

  @HiveField(3)
  Map<String, dynamic> recipe;
}
