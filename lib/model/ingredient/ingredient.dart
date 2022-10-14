import 'package:hive/hive.dart';
import 'package:home_work/model/recipe_ingredient/recipe_ingredient.dart';
import 'package:home_work/model/freezer/freezer.dart';

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
  List<RecipeIngredients> recipeIngredients;

  @HiveField(4)
  List<Freezer> ingredientFreezer;
}
