import 'package:flutter/material.dart';
import 'package:home_work/widgets/recipe_card.dart';
import '../controller/globals.dart';

import 'bottom_navigation.dart';

// Вывод списка рецептов
class RecipeList extends StatelessWidget {
  final Globals globals = Globals();
  final bool isFavorite;

  RecipeList({Key? key, this.isFavorite = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffececec),
      body: _buildList(context),
      bottomNavigationBar: BottomNavigation(pageIndex: 0),
    );
  }

  Widget _buildList(BuildContext context) {
    List recipeKeys = globals.data['recipeList'].keys.toList();

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        itemCount: recipeKeys.length,
        itemBuilder: (BuildContext context, int index) {
          return RecipeCard(index: index, typeCard: 'recipeList');
        },
      ),
    );
  }
}
