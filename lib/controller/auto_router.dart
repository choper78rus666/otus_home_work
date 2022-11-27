import 'package:auto_route/annotations.dart';

import '../main.dart';
import '../widgets/recipe_detail_page.dart';
import '../widgets/recipients_list.dart';

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@MaterialAutoRouter(
  replaceInRouteName: 'recipe,recipe-detail',
  routes: <AutoRoute>[
    AutoRoute(page: RecipeList, initial: true),
    CustomRoute(
      page: RecipeDetailPage,
      durationInMilliseconds: 800,
      transitionsBuilder: slideRightRoutes,
    ),
  ],
)
class $AppRouter {}
