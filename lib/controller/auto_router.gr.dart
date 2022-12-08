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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/cupertino.dart' as _i7;
import 'package:flutter/material.dart' as _i5;

import '../widgets/favorite_list.dart' as _i2;
import '../widgets/recipe_detail_page.dart' as _i3;
import '../widgets/recipients_list.dart' as _i1;
import 'auto_router.dart' as _i6;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    RecipeListRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeListRouteArgs>(
          orElse: () => const RecipeListRouteArgs());
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.RecipeList(
          key: args.key,
          isFavorite: args.isFavorite,
        ),
      );
    },
    FavoriteListRoute.name: (routeData) {
      final args = routeData.argsAs<FavoriteListRouteArgs>(
          orElse: () => const FavoriteListRouteArgs());
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.FavoriteList(key: args.key),
      );
    },
    RecipeDetailPageRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeDetailPageRouteArgs>(
          orElse: () => const RecipeDetailPageRouteArgs());
      return _i4.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.RecipeDetailPage(
          key: args.key,
          index: args.index,
        ),
        transitionsBuilder: _i6.slideRightRoutes,
        durationInMilliseconds: 800,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          RecipeListRoute.name,
          path: '/',
        ),
        _i4.RouteConfig(
          FavoriteListRoute.name,
          path: '/favorite-list',
        ),
        _i4.RouteConfig(
          RecipeDetailPageRoute.name,
          path: '/recipe-detail-page',
        ),
      ];
}

/// generated route for
/// [_i1.RecipeList]
class RecipeListRoute extends _i4.PageRouteInfo<RecipeListRouteArgs> {
  RecipeListRoute({
    _i7.Key? key,
    bool isFavorite = false,
  }) : super(
          RecipeListRoute.name,
          path: '/',
          args: RecipeListRouteArgs(
            key: key,
            isFavorite: isFavorite,
          ),
        );

  static const String name = 'RecipeListRoute';
}

class RecipeListRouteArgs {
  const RecipeListRouteArgs({
    this.key,
    this.isFavorite = false,
  });

  final _i7.Key? key;

  final bool isFavorite;

  @override
  String toString() {
    return 'RecipeListRouteArgs{key: $key, isFavorite: $isFavorite}';
  }
}

/// generated route for
/// [_i2.FavoriteList]
class FavoriteListRoute extends _i4.PageRouteInfo<FavoriteListRouteArgs> {
  FavoriteListRoute({_i7.Key? key})
      : super(
          FavoriteListRoute.name,
          path: '/favorite-list',
          args: FavoriteListRouteArgs(key: key),
        );

  static const String name = 'FavoriteListRoute';
}

class FavoriteListRouteArgs {
  const FavoriteListRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'FavoriteListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.RecipeDetailPage]
class RecipeDetailPageRoute
    extends _i4.PageRouteInfo<RecipeDetailPageRouteArgs> {
  RecipeDetailPageRoute({
    _i7.Key? key,
    int? index,
  }) : super(
          RecipeDetailPageRoute.name,
          path: '/recipe-detail-page',
          args: RecipeDetailPageRouteArgs(
            key: key,
            index: index,
          ),
        );

  static const String name = 'RecipeDetailPageRoute';
}

class RecipeDetailPageRouteArgs {
  const RecipeDetailPageRouteArgs({
    this.key,
    this.index,
  });

  final _i7.Key? key;

  final int? index;

  @override
  String toString() {
    return 'RecipeDetailPageRouteArgs{key: $key, index: $index}';
  }
}
