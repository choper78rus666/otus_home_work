// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/cupertino.dart' as _i6;
import 'package:flutter/material.dart' as _i4;

import '../widgets/recipe_detail_page.dart' as _i2;
import '../widgets/recipients_list.dart' as _i1;
import 'auto_router.dart' as _i5;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    RecipeList.name: (routeData) {
      final args = routeData.argsAs<RecipeListArgs>(orElse: () => const RecipeListArgs());
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.RecipeList(key: args.key),
      );
    },
    RecipeDetailPage.name: (routeData) {
      final args = routeData.argsAs<RecipeDetailPageArgs>(orElse: () => const RecipeDetailPageArgs());
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i2.RecipeDetailPage(
          key: args.key,
          index: args.index,
        ),
        transitionsBuilder: _i5.slideRightRoutes,
        durationInMilliseconds: 800,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          RecipeList.name,
          path: '/',
        ),
        _i3.RouteConfig(
          RecipeDetailPage.name,
          path: '/recipe-detail-page',
        ),
      ];
}

/// generated route for
/// [_i1.RecipeList]
class RecipeList extends _i3.PageRouteInfo<RecipeListArgs> {
  RecipeList({_i6.Key? key})
      : super(
          RecipeList.name,
          path: '/',
          args: RecipeListArgs(key: key),
        );

  static const String name = 'RecipeList';
}

class RecipeListArgs {
  const RecipeListArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'RecipeListArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.RecipeDetailPage]
class RecipeDetailPage extends _i3.PageRouteInfo<RecipeDetailPageArgs> {
  RecipeDetailPage({
    _i6.Key? key,
    int? index,
  }) : super(
          RecipeDetailPage.name,
          path: '/recipe-detail-page',
          args: RecipeDetailPageArgs(
            key: key,
            index: index,
          ),
        );

  static const String name = 'RecipeDetailPage';
}

class RecipeDetailPageArgs {
  const RecipeDetailPageArgs({
    this.key,
    this.index,
  });

  final _i6.Key? key;

  final int? index;

  @override
  String toString() {
    return 'RecipeDetailPageArgs{key: $key, index: $index}';
  }
}
