import 'package:hive/hive.dart';

import '../controller/globals.dart';
import '../controller/receiver.dart';
import '../model/recipe/recipe.dart';

class RepositoryRecipe {
  Globals globals = Globals();
  DioManager dioManager = DioManager();

  // Загрузка рецептов
  Future<void> recipeList() async {
    var result = await dioManager.getHttp('recipe');
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
}
