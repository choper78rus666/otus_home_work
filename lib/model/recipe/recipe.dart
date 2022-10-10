import 'dart:io';
import 'package:home_work/model/recipe_ingredient/recipe_ingredient.dart';
import 'package:home_work/model/recipe_step_link/recipe_step_link.dart';
import 'package:home_work/model/favorite/favorite.dart';
import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 1)
class Recipe {
  Recipe(
      {required this.id,
      required this.name,
      required this.duration,
      required this.photo,
      required this.recipeIngredients,
      required this.recipeStepLinks,
      required this.favoriteRecipes,
});

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int duration;

  @HiveField(3)
  String photo;

  @HiveField(4)
  List<RecipeIngredients> recipeIngredients;

  @HiveField(5)
  List<RecipeStepLink> recipeStepLinks;

  @HiveField(6)
  List<Favorite> favoriteRecipes;
}
