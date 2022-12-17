import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/globals.dart';
import '../controller/receiver.dart';
import '../model/freezer/freezer.dart';
import '../model/ingredient/ingredient.dart';
import '../model/recipe_ingredient/recipe_ingredient.dart';

class RepositoryIngredient {
  Globals globals = Globals();
  DioManager dioManager = DioManager();

  // Загрузка ингредиентов
  Future<void> ingredientList() async {
    var result = await dioManager.getHttp('ingredient');
    final Directory directory = await getApplicationDocumentsDirectory();
    var ingredientList =
        await Hive.openBox<Ingredient>('ingredientList', path: directory.path);

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
}
