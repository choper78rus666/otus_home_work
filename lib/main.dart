import 'package:flutter/material.dart';
import 'package:home_work/recipe_detail_page.dart';
import 'package:home_work/recipients_list.dart';
import 'package:home_work/model/init.dart';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  //var path = Directory.current.path;
 // print(path);
  //Hive.init(path);
  Init().updateData();
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
