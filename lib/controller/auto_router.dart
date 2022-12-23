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
  routes: <AutoRoute>[
    AutoRoute(
      page: RecipeList,
      initial: true,
      path: '/recipe',
    ),
    AutoRoute(
      page: FavoriteList,
      path: '/favorite-list',
      children: [
        CustomRoute(
          page: RecipeDetailPage,
          durationInMilliseconds: 800,
          transitionsBuilder: slideRightRoutes,
          path: '/recipe-detail',
        ),
      ]
    ),

    AutoRoute(
      page: AuthPage,
      path: '/auth',
    ),
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
