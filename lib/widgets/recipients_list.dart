import 'package:flutter/material.dart';
import 'package:home_work/widgets/recipe_card.dart';
import '../controller/globals.dart';
import 'package:home_work/model/icons/my_icons.dart';

// Вывод списка рецептов
class RecipeList extends StatelessWidget {
  final Globals globals = Globals();

  RecipeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffececec),
      body: _buildList(context),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color(0xFFFFFFFF),
            icon: Icon(
              MyIcons.pizzaSlice,
              size: 18,
            ),
            label: 'Рецепты',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFFFFFFFF),
            icon: Icon(
              MyIcons.refrigerator,
              size: 18,
            ),
            label: 'Холодильник',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFFFFFFFF),
            icon: Icon(
              MyIcons.heart,
              size: 18,
            ),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFFFFFFFF),
            icon: Icon(
              MyIcons.user,
              size: 18,
            ),
            label: 'Профиль',
          ),
        ],
        currentIndex: 0,
        showUnselectedLabels: true,
        backgroundColor: const Color(0xFFFFFFFF),
        unselectedItemColor: const Color(0xFFC2C2C2),
        selectedItemColor: const Color(0xFF2ECC71),
        selectedLabelStyle: const TextStyle(
          color: Color(0xFF2ECC71),
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Color(0xFFC2C2C2),
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
         onTap: (index){
          switch(index){
            case 0:
            break;
            default:
            }
         },
      ),
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
