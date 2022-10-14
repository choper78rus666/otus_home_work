import 'package:flutter/services.dart';
import 'package:home_work/globals.dart';
import 'package:home_work/model/recipe/recipe.dart';
import 'dart:convert';

import '../controller/receiver.dart';

// Загрузка, обновление , подготовка работы с данными
class Init {
  updateData() async {
    Globals globals = Globals();
    var result = await DioManager().getHttp('recipe');

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
      print(value);
      _recipe.add(recipeData);
    });
    print(_recipe);
  }

  List<Recipe> _recipe = [];

  get recipe => _recipe;

  set recipe(value) => _recipe = value;
}
