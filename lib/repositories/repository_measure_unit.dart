import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/globals.dart';
import '../controller/receiver.dart';
import '../model/ingredient/ingredient.dart';
import '../model/measure_unit/measure_unit.dart';

class RepositoryMeasureUnit {
  Globals globals = Globals();
  DioManager dioManager = DioManager();

  // Загрузка списка мерных измерений
  Future<void> measureUnitList() async {
    var result = await dioManager.getHttp('measure_unit');
    final Directory directory = await getApplicationDocumentsDirectory();
    var measureUnitList = await Hive.openBox<MeasureUnit>('measureUnitList', path: directory.path);

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
              ingredients.add(globals.data['ingredientList'][valueIngredient['id']]);
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
}
