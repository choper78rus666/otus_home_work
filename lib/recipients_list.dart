import 'package:flutter/material.dart';
import 'configs/recipients.dart';
import 'package:home_work/recipeCard.dart';

// Вывод списка рецептов
class RecipeList extends StatelessWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffececec),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 33, 16, 69),
          itemCount: recipeList.length,
          itemBuilder: (BuildContext context, int index) {
            return RecipeCard(index: index, typeCard: 'recipeList');
          }),
    );
  }
}
