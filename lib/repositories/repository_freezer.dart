import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/globals.dart';
import '../controller/receiver.dart';
import '../model/freezer/freezer.dart';

class RepositoryFreezer {
  Globals globals = Globals();
  DioManager dioManager = DioManager();

  // Загрузка продуктов в холодильнике
  Future<void> freezerList() async {
    var result = await dioManager.getHttp('freezer');
    final Directory directory = await getApplicationDocumentsDirectory();
    var freezerList =
        await Hive.openBox<Freezer>('freezerList', path: directory.path);

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
          count: value['count'] ?? 0.0,
          user: value['user'] ?? <Map<String, dynamic>>{},
          ingredient: value['ingredient'] ?? <Map<String, dynamic>>{},
        );

        // Запишем в hive
        freezerList.put(freezerData.id, freezerData);
        globals.data['freezerList'][freezerData.id] = freezerData;
      });
    }
  }
}
