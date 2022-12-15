import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:home_work/model/icons/my_icons.dart';

// Навигация
class BottomNavigation extends StatelessWidget {
  final int pageIndex;
  final List pages = [
    '/',
    '/freezer',
    '/favorite-list',
    '/auth'
  ];

  BottomNavigation({Key? key, this.pageIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
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
        currentIndex: pageIndex,
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

          if(index != pageIndex){
              context.router.navigateNamed(pages[index]);
          }
        },
      );
  }
}
