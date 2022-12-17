import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/globals.dart';
import '../controller/receiver.dart';
import '../model/recipe/recipe.dart';

class RepositoryRecipe {
  Globals globals = Globals();
  DioManager dioManager = DioManager();

  // Загрузка рецептов
  Future<void> recipeList() async {
    var result = await dioManager.getHttp('recipe');
    final Directory directory = await getApplicationDocumentsDirectory();
    var recipeList =
        await Hive.openBox<Recipe>('recipeList', path: directory.path);

    // Если нет соединения или не получены данные, загружаем с Hive
    if (result == null || result.statusCode != 200) {
      recipeList.toMap().forEach((key, value) {
        globals.data['recipeList'][value.id] = value;
      });

      // Апи постоянно падает, вводим статично рецепт, чтобы можно было работать с домашкой
      if (globals.data['recipeList'].length == 0) {
        globals.data['recipeList'][0] = Recipe(
          id: 0,
          name: "Лосось в соусе терияки",
          duration: 45,
          photo:
              "https://s3-alpha-sig.figma.com/img/2a02/af01/3e816581720c9245aa5ffaad28e2d128?Expires=1672012800&Signature=K7hW1Ig6Ud94-w0wAVPWJYbRuvItwG35NpCG1XG3vcfg6lln5ZzaiIiut~O4uvyB~2rgKxQCsonQcAjSUmKv3Wck9Wh9Gi1q3chYb7FjDVweDpGAT-~~3CgjMteuWMg-R7EaH4d8taVbd2-GuGiTtk7ihjGKV3AeJ4YvijEMLTjOdnm7hxoLNDMRiBtRuxruXCpaKFYrxIBsM8f2PlXJiogAVAvG6pnR0nhTiMiA4J4YbrCIT6QZCaE171jwkVh8IKHrviZO8S-CYFgd6F0tcIELsw2FFWrL2P5laov1RppBnFUcQlR7Z01ppNCLqGLv7c5ZhSpAemNLlmeiSCXVlA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
          recipeIngredients: [],
          recipeStepLinks: [],
          favoriteRecipes: [],
        );
      }
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
}
