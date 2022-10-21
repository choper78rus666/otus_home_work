import 'package:flutter/material.dart';
import 'package:home_work/widgets/recipe_card.dart';
import '../controller/globals.dart';

// Вывод списка рецептов
class RecipeList extends StatelessWidget {
  final Globals globals = Globals();

  RecipeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffececec),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    List recipeKeys = globals.data['recipeList'].keys.toList();

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 33, 16, 69),
        itemCount: recipeKeys.length,
        itemBuilder: (BuildContext context, int index) {
          return RecipeCard(index: index, typeCard: 'recipeList');
        },
      ),
    );
  }
}
