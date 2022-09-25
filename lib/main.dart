import 'package:flutter/material.dart';
import 'package:home_work/recipeDetailPage.dart';
import 'package:home_work/recipients_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (BuildContext context) => RecipeList(key: key)},
      onGenerateRoute: (routeSettings) {
        var path = routeSettings.name.toString().split('/');
        if (path[1] == "recipe-detail" &&
            path.length > 2 &&
            path[2].isNotEmpty) {
          return MaterialPageRoute(
            builder: (BuildContext context) =>
                RecipeDetailPage(index: int.parse(path[2])),
            settings: routeSettings,
          );
        }
      },
    );
  }
}
