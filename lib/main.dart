import 'package:flutter/material.dart';
import 'package:home_work/controller/init.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_work/widgets/recipe_detail_page.dart';
import 'package:home_work/widgets/recipients_list.dart';

void main() async {
  await Future.wait([
    Hive.initFlutter(),
    Init().loadData(),
  ]);
  runApp(const MyApp());
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: const Cubic(0.18, -0.15, 0.165, 1.25),
                    ),
                  ),
                  child: child,
                ));
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
          return SlideRightRoute(
            page: RecipeDetailPage(index: int.parse(path[2])),
          );
        }
      },
    );
  }
}
