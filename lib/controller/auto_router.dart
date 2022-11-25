import 'package:auto_route/annotations.dart';

import '../widgets/recipe_detail_page.dart';
import '../widgets/recipients_list.dart';

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@MaterialAutoRouter(
  replaceInRouteName: 'recipe,recipe-detail',
  routes: <AutoRoute>[
    AutoRoute(page: RecipeList, initial: true),
    AutoRoute(page: RecipeDetailPage),
  ],
)
class $AppRouter {}