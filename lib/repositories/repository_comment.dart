import 'package:hive/hive.dart';

import '../controller/globals.dart';
import '../controller/receiver.dart';
import '../model/comment/comment.dart';

class RepositoryComment {
  Globals globals = Globals();
  DioManager dioManager = DioManager();

  // Загрузка комментариев
  Future<void> commentList() async {
    var result = await dioManager.getHttp('comment');
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
}
