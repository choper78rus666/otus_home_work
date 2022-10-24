import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_work/model/comment/comment.dart';
import 'package:home_work/model/favorite/favorite.dart';
import 'package:home_work/model/freezer/freezer.dart';
import 'package:home_work/model/ingredient/ingredient.dart';
import 'package:home_work/model/recipe/recipe.dart';
import 'package:home_work/model/recipe_ingredient/recipe_ingredient.dart';
import 'package:home_work/repositories/repository_comment.dart';
import 'package:home_work/repositories/repository_favorite.dart';
import 'package:home_work/repositories/repository_freezer.dart';
import 'package:home_work/repositories/repository_ingredient.dart';
import 'package:home_work/repositories/repository_measure_unit.dart';
import '../model/measure_unit/measure_unit.dart';
import '../repositories/repository_recipe.dart';

// Загрузка, обновление , подготовка работы с данными
class Init {

  Future<void> loadData() async {
    // Инициализация адаптеров
    Hive.registerAdapter(RecipeAdapter());
    Hive.registerAdapter(CommentAdapter());
    Hive.registerAdapter(IngredientAdapter());
    Hive.registerAdapter(RecipeIngredientsAdapter());
    Hive.registerAdapter(FreezerAdapter());
    Hive.registerAdapter(MeasureUnitAdapter());
    Hive.registerAdapter(FavoriteAdapter());

    await Future.wait([
      // Загрузка рецептов
      RepositoryRecipe().recipeList(),
      // Загрузка комментариев
      RepositoryComment().commentList(),
      // Загрузка ингредиентов
      RepositoryIngredient().ingredientList(),
      // Загрузка списка мерных измерений
      RepositoryMeasureUnit().measureUnitList(),
      // Загрузка продуктов в холодильнике
      RepositoryFreezer().freezerList(),
      // Загрузка избранного
      RepositoryFavorite().favoriteList(),
    ]);
  }
}
