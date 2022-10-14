import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:home_work/globals.dart';
import 'package:home_work/model/recipe/recipe.dart';
import 'dart:convert';

import '../controller/receiver.dart';

// Загрузка, обновление , подготовка работы с данными
class Init {
  Globals globals = Globals();

  updateData() async {

    var result = await DioManager().getHttp('recipe');
    var recipeList = await Hive.openBox('recipeList');

print(recipeList);
    if (result.statusCode != 200) {
      result.data = recipeList;
    } else {
      recipeList.clear();
    }

    // Загрузка рецептов

    //if (result.data) {
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

      print(globals.data['recipeList']);
    //}
  }
}
