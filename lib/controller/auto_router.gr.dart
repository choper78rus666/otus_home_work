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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/cupertino.dart' as _i8;
import 'package:flutter/material.dart' as _i6;

import '../widgets/auth_page.dart' as _i4;
import '../widgets/favorite_list.dart' as _i2;
import '../widgets/recipe_detail_page.dart' as _i3;
import '../widgets/recipients_list.dart' as _i1;
import 'auto_router.dart' as _i7;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    RecipeListRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeListRouteArgs>(
          orElse: () => const RecipeListRouteArgs());
      return _i5.MaterialPageX<dynamic>(
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
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.FavoriteList(key: args.key),
      );
    },
    RecipeDetailPageRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeDetailPageRouteArgs>(
          orElse: () => const RecipeDetailPageRouteArgs());
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.RecipeDetailPage(
          key: args.key,
          index: args.index,
          typeCard: args.typeCard,
        ),
        transitionsBuilder: _i7.slideRightRoutes,
        durationInMilliseconds: 800,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AuthPageRoute.name: (routeData) {
      final args = routeData.argsAs<AuthPageRouteArgs>(
          orElse: () => const AuthPageRouteArgs());
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.AuthPage(key: args.key),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/recipe',
          fullMatch: true,
        ),
        _i5.RouteConfig(
          RecipeListRoute.name,
          path: '/recipe',
        ),
        _i5.RouteConfig(
          FavoriteListRoute.name,
          path: '/favorite-list',
        ),
        _i5.RouteConfig(
          RecipeDetailPageRoute.name,
          path: '/recipe-detail-page',
        ),
        _i5.RouteConfig(
          AuthPageRoute.name,
          path: '/auth',
        ),
      ];
}

/// generated route for
/// [_i1.RecipeList]
class RecipeListRoute extends _i5.PageRouteInfo<RecipeListRouteArgs> {
  RecipeListRoute({
    _i8.Key? key,
    bool isFavorite = false,
  }) : super(
          RecipeListRoute.name,
          path: '/recipe',
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

  final _i8.Key? key;

  final bool isFavorite;

  @override
  String toString() {
    return 'RecipeListRouteArgs{key: $key, isFavorite: $isFavorite}';
  }
}

/// generated route for
/// [_i2.FavoriteList]
class FavoriteListRoute extends _i5.PageRouteInfo<FavoriteListRouteArgs> {
  FavoriteListRoute({_i8.Key? key})
      : super(
          FavoriteListRoute.name,
          path: '/favorite-list',
          args: FavoriteListRouteArgs(key: key),
        );

  static const String name = 'FavoriteListRoute';
}

class FavoriteListRouteArgs {
  const FavoriteListRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'FavoriteListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.RecipeDetailPage]
class RecipeDetailPageRoute
    extends _i5.PageRouteInfo<RecipeDetailPageRouteArgs> {
  RecipeDetailPageRoute({
    _i8.Key? key,
    int? index,
    String typeCard = 'recipe',
  }) : super(
          RecipeDetailPageRoute.name,
          path: '/recipe-detail-page',
          args: RecipeDetailPageRouteArgs(
            key: key,
            index: index,
            typeCard: typeCard,
          ),
        );

  static const String name = 'RecipeDetailPageRoute';
}

class RecipeDetailPageRouteArgs {
  const RecipeDetailPageRouteArgs({
    this.key,
    this.index,
    this.typeCard = 'recipe',
  });

  final _i8.Key? key;

  final int? index;

  final String typeCard;

  @override
  String toString() {
    return 'RecipeDetailPageRouteArgs{key: $key, index: $index, typeCard: $typeCard}';
  }
}

/// generated route for
/// [_i4.AuthPage]
class AuthPageRoute extends _i5.PageRouteInfo<AuthPageRouteArgs> {
  AuthPageRoute({_i8.Key? key})
      : super(
          AuthPageRoute.name,
          path: '/auth',
          args: AuthPageRouteArgs(key: key),
        );

  static const String name = 'AuthPageRoute';
}

class AuthPageRouteArgs {
  const AuthPageRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'AuthPageRouteArgs{key: $key}';
  }
}
