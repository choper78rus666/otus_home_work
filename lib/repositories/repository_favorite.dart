import 'package:hive/hive.dart';

import '../controller/globals.dart';
import '../controller/receiver.dart';
import '../model/favorite/favorite.dart';

class RepositoryFavorite {
  Globals globals = Globals();
  DioManager dioManager = DioManager();

  // Загрузка избранного
  Future<void> favoriteList() async {
    var result = await dioManager.getHttp('favorite');
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
