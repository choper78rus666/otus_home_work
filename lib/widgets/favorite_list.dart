import 'package:flutter/material.dart';
import 'package:home_work/widgets/recipe_card.dart';
import '../controller/globals.dart';

import 'bottom_navigation.dart';

// Вывод списка рецептов Избранных
class FavoriteList extends StatelessWidget {
  final Globals globals = Globals();

  FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffececec),
      body: _buildList(context),
      bottomNavigationBar: BottomNavigation(pageIndex: 2),
    );
  }

  Widget _buildList(BuildContext context) {
    List recipeKeys = [];

    for (var value in globals.data['recipeList'].keys.toList()) {
      if (globals.myVariable[value - 1]['is_favorite'] == true) recipeKeys.add(value - 1);
    }

    if (recipeKeys.isNotEmpty && recipeKeys.length > 0) {
      return SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          itemCount: recipeKeys.length,
          itemBuilder: (BuildContext context, int index) {
            return RecipeCard(index: recipeKeys[index], typeCard: 'recipeList');
          },
        ),
      );
    } else {
      return const Center(
        child: Text('Нет избранного'),
      );
    }
  }
}
