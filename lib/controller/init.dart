import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_work/globals.dart';
import 'package:home_work/model/comment/comment.dart';
import 'package:home_work/model/recipe/recipe.dart';
import 'dart:convert';

import 'receiver.dart';

// Загрузка, обновление , подготовка работы с данными
class Init {
  Globals globals = Globals();

  updateData() {
    // Загрузка рецептов
    _recipeList();

    // Загрузка комментариев
    _commentList();
  }

  // Загрузка рецептов
  void _recipeList() async {
    var result = await DioManager().getHttp('recipe');
    Hive.registerAdapter(RecipeAdapter());
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
        var isresipe = recipeList.get(recipeData.id);
        print(isresipe?.photo);
        globals.data['recipeList'][recipeData.id] = recipeData;
      });
    }
    print(globals.data['recipeList']);
  }

  // Загрузка комментариев
  void _commentList() async {
    var result = await DioManager().getHttp('comment');
    Hive.registerAdapter(CommentAdapter());
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
          user: value['user'] ?? <Map<String, int>>{},
        );

        // Запишем в hive
        commentList.put(commentData.id, commentData);
        var test = commentList.get(commentData.id);
        print(test?.user);
        globals.data['commentList'][commentData.id] = commentData;
      });
    }
    print(globals.data['commentList']);
  }
}
