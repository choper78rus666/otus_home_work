import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_work/model/icons/my_icons.dart';

import '../bloc/auth.dart';
import '../controller/globals.dart';

// Навигация
class BottomNavigation extends StatelessWidget {
  final int pageIndex;
  final Globals global = Globals();
  final List pages = [
    '/recipe',
    '/freezer-page',
    '/favorite-list',
    '/auth',
  ];

  BottomNavigation({Key? key, this.pageIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StateAuthPageCubit(),
      child: BlocBuilder<StateAuthPageCubit, bool>(
        builder: (context, authState) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              backgroundColor: Color(0xFFFFFFFF),
              icon: Icon(
                MyIcons.pizzaSlice,
                size: 18,
              ),
              label: 'Рецепты',
            ),
            if (global.data['auth']['status'])
              const BottomNavigationBarItem(
                backgroundColor: Color(0xFFFFFFFF),
                icon: Icon(
                  MyIcons.refrigerator,
                  size: 18,
                ),
                label: 'Холодильник',
              ),
            if (global.data['auth']['status'])
              const BottomNavigationBarItem(
                backgroundColor: Color(0xFFFFFFFF),
                icon: Icon(
                  MyIcons.heart,
                  size: 18,
                ),
                label: 'Избранное',
              ),
            BottomNavigationBarItem(
              backgroundColor: const Color(0xFFFFFFFF),
              icon: const Icon(
                MyIcons.user,
                size: 18,
              ),
              label: global.data['auth']['status'] ? 'Профиль' : 'Вход',
            )
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
          onTap: (index) {
            if (!global.data['auth']['status'] && index == 1) index = 3;

            if (index != pageIndex) {
              context.router.navigateNamed(pages[index]);
            }
          },
        ),
      ),
    );
  }
}
