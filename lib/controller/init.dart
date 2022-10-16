import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_work/globals.dart';
import 'package:home_work/model/comment/comment.dart';
import 'package:home_work/model/favorite/favorite.dart';
import 'package:home_work/model/freezer/freezer.dart';
import 'package:home_work/model/ingredient/ingredient.dart';
import 'package:home_work/model/recipe/recipe.dart';
import 'package:home_work/model/recipe_ingredient/recipe_ingredient.dart';

import '../model/measure_unit/measure_unit.dart';
import 'receiver.dart';

// Загрузка, обновление , подготовка работы с данными
class Init {
  Globals globals = Globals();

  updateData() {
    // Инициализация адаптеров
    Hive.registerAdapter(RecipeAdapter());
    Hive.registerAdapter(CommentAdapter());
    Hive.registerAdapter(IngredientAdapter());
    Hive.registerAdapter(RecipeIngredientsAdapter());
    Hive.registerAdapter(FreezerAdapter());
    Hive.registerAdapter(MeasureUnitAdapter());
    Hive.registerAdapter(FavoriteAdapter());

    // Загрузка рецептов
    _recipeList();

    // Загрузка комментариев
    _commentList();

    // Загрузка ингредиентов
    _ingredientList();

    // Загрузка списка мерных измерений
    _measureUnitList();

    // Загрузка продуктов в холодильнике
    _freezerList();

    // Загрузка избранного
    _favoriteList();
  }

  // Загрузка рецептов
  void _recipeList() async {
    var result = await DioManager().getHttp('recipe');
    var recipeList = await Hive.openBox<Recipe>('recipeList');

    // Если нет соединения или не получены данные, загружаем с Hive
    if (result == null || result.statusCode != 200) {
      recipeList.toMap().forEach((key, value) {
        globals.data['recipeList'][value.id] = value;
      });
    } else {
      recipeList.clear();
      result.data.forEach((value) {
        Recipe recipeData = Recipe(
          id: value['id'],
          name: value['name'],
          duration: value['duration'],
          photo: value['photo'],
          recipeIngredients: value['recipeIngredients'] ?? [],
          recipeStepLinks: value['recipeStepLinks'] ?? [],
          favoriteRecipes: value['favoriteRecipes'] ?? [],
        );

        // Запишем в hive
        recipeList.put(recipeData.id, recipeData);
        globals.data['recipeList'][recipeData.id] = recipeData;
      });
    }
  }

  // Загрузка комментариев
  void _commentList() async {
    var result = await DioManager().getHttp('comment');
    var commentList = await Hive.openBox<Comment>('commentList');

    // Если нет соединения или не получены данные, загружаем с Hive
    if (result == null || result.statusCode != 200) {
      commentList.toMap().forEach((key, value) {
        globals.data['commentList'][value.id] = value;
      });
    } else {
      commentList.clear();
      result.data.forEach((value) {
        Comment commentData = Comment(
          id: value['id'],
          text: value['text'],
          photo: value['photo'],
          datetime: value['datetime'],
          user: value['user'] ?? <Map<String, dynamic>>{},
        );

        // Запишем в hive
        commentList.put(commentData.id, commentData);
        globals.data['commentList'][commentData.id] = commentData;
      });
    }
  }

  // Загрузка ингредиентов
  void _ingredientList() async {
    var result = await DioManager().getHttp('ingredient');
    var ingredientList = await Hive.openBox<Ingredient>('ingredientList');

    // Если нет соединения или не получены данные, загружаем с Hive
    if (result == null || result.statusCode != 200) {
      ingredientList.toMap().forEach((key, value) {
        globals.data['ingredientList'][value.id] = value;
      });
    } else {
      ingredientList.clear();
      result.data.forEach((value) {
        List<RecipeIngredients> recipeIngredients = [];

        if (value['recipeIngredients'] != null) {
          value['recipeIngredients'].forEach((valueIngredient) {
            RecipeIngredients recipeIngredient = RecipeIngredients(
              id: valueIngredient['id'],
              count: valueIngredient['count'],
              ingredient:
                  valueIngredient['ingredient'] ?? <Map<String, dynamic>>{},
              recipe: valueIngredient['recipe'] ?? <Map<String, dynamic>>{},
            );

            recipeIngredients.add(recipeIngredient);
          });
        }

        List<Freezer> ingredientFreezer = [];

        if (value['ingredientFreezer'] != null) {
          value['ingredientFreezer'].forEach((valueFreezer) {
            Freezer freezer = Freezer(
              id: valueFreezer['id'],
              count: valueFreezer['count'],
              user: valueFreezer['user'] ?? <Map<String, dynamic>>{},
              ingredient:
                  valueFreezer['ingredient'] ?? <Map<String, dynamic>>{},
            );

            ingredientFreezer.add(freezer);
          });
        }

        Ingredient ingredientData = Ingredient(
          id: value['id'],
          name: value['name'],
          measureUnit: value['measureUnit'] ?? <Map<String, dynamic>>{},
          recipeIngredients: recipeIngredients,
          ingredientFreezer: ingredientFreezer,
        );

        // Запишем в hive
        ingredientList.put(ingredientData.id, ingredientData);
        globals.data['ingredientList'][ingredientData.id] = ingredientData;
      });
    }
  }

  // Загрузка списка мерных измерений
  void _measureUnitList() async {
    var result = await DioManager().getHttp('measure_unit');
    var measureUnitList = await Hive.openBox<MeasureUnit>('measureUnitList');

    // Если нет соединения или не получены данные, загружаем с Hive
    if (result == null || result.statusCode != 200) {
      measureUnitList.toMap().forEach((key, value) {
        globals.data['measureUnitList'][value.id] = value;
      });
    } else {
      measureUnitList.clear();
      result.data.forEach((value) {
        List<Ingredient> ingredients = [];

        if (value['ingredients'] != null) {
          value['ingredients'].forEach((valueIngredient) {
            if (globals.data['ingredientList'][valueIngredient['id']] != null) {
              ingredients
                  .add(globals.data['ingredientList'][valueIngredient['id']]);
            }
          });
        }
        MeasureUnit measureUnitData = MeasureUnit(
          id: value['id'],
          one: value['one'],
          few: value['few'],
          many: value['many'],
          ingredients: ingredients,
        );

        // Запишем в hive
        measureUnitList.put(measureUnitData.id, measureUnitData);
        globals.data['measureUnitList'][measureUnitData.id] = measureUnitData;
      });
    }
  }

  // Загрузка продуктов в холодильнике
  void _freezerList() async {
    var result = await DioManager().getHttp('freezer');
    var freezerList = await Hive.openBox<Freezer>('freezerList');

    // Если нет соединения или не получены данные, загружаем с Hive
    if (result == null || result.statusCode != 200) {
      freezerList.toMap().forEach((key, value) {
        globals.data['freezerList'][value.id] = value;
      });
    } else {
      freezerList.clear();
      result.data.forEach((value) {
        Freezer freezerData = Freezer(
          id: value['id'],
          count: value['count'],
          user: value['user'] ?? <Map<String, dynamic>>{},
          ingredient: value['ingredient'] ?? <Map<String, dynamic>>{},
        );

        // Запишем в hive
        freezerList.put(freezerData.id, freezerData);
        globals.data['freezerList'][freezerData.id] = freezerData;
      });
    }
  }

  // Загрузка избранного
  void _favoriteList() async {
    var result = await DioManager().getHttp('favorite');
    var favoriteList = await Hive.openBox<Favorite>('favoriteList');

    // Если нет соединения или не получены данные, загружаем с Hive
    if (result == null || result.statusCode != 200) {
      favoriteList.toMap().forEach((key, value) {
        globals.data['favoriteList'][value.id] = value;
      });
    } else {
      favoriteList.clear();
      result.data.forEach((value) {
        Favorite favoriteData = Favorite(
          id: value['id'],
          recipe: value['recipe'] ?? <Map<String, int>>{},
          user: value['user'] ?? <Map<String, int>>{},
        );

        // Запишем в hive
        favoriteList.put(favoriteData.id, favoriteData);
        globals.data['favoriteList'][favoriteData.id] = favoriteData;
      });
    }
  }
}
