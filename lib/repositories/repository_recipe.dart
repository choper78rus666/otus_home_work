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

      // Апи постоянно падает, вводим статично рецепт, чтобы можно было работать с домашкой
      if (globals.data['recipeList'].length == 0) {
        globals.data['recipeList'][0] = Recipe(
          id: 0,
          name: "Лосось в соусе терияки",
          duration: 45,
          photo:
              "https://s3-alpha-sig.figma.com/img/2a02/af01/3e816581720c9245aa5ffaad28e2d128?Expires=1670803200&Signature=c0HgKfIpvH7Rf-DUjO24cC~Khc264KbB5ysl44Rr03j7XsECUlVISdrSNlVo8QSRExwEGcRte2sWNeH7V~QrpDyON8QITXYlVlnGvF-0eLLLOHB8gRBSweOjAFZl~pCMaN~0HvCkbKy-vQ0rrWTINGmlB2zLoH9GtdN3SRhoMruckDKOJTRAmOhQeUnrIE6goKqJgS9oouBWVku4UavBrQqOtmrs3Cdt6vNLV50A~ukL18jvICv~2d5IAshY~0zkkeyHGzYTDNx6bRCZL-Bh-Md3DR-N1vIfioU~L24QOAOuvsmFlhhQD2OwQ1c~rf~oUiwxsCN8ll4xmJrPmOK10w__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
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
