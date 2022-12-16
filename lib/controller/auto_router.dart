import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_work/widgets/auth_page.dart';

import '../widgets/favorite_list.dart';
import '../widgets/recipe_detail_page.dart';
import '../widgets/recipients_list.dart';

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@MaterialAutoRouter(
  replaceInRouteName: 'recipe,favorite-list,recipe-detail,auth',
  routes: <AutoRoute>[
    AutoRoute(page: RecipeList, initial: true),
    AutoRoute(page: FavoriteList),
    CustomRoute(
      page: RecipeDetailPage,
      durationInMilliseconds: 800,
      transitionsBuilder: slideRightRoutes,
    ),
    AutoRoute(page: AuthPage),
  ],
)
class $AppRouter {}

// Анимация перехода
Widget slideRightRoutes(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
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
  );
}
