import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_work/controller/globals.dart';
import 'package:rive/rive.dart';

import '../bloc/favorite.dart';

// Виджет добавления в избранное
class Favorite extends StatelessWidget {
  final int index;

  const Favorite({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    Globals globals = Globals();
    bool isSelected = globals.myVariable[index]['is_favorite'] ?? false;
    bool isAnimated = false;

    return BlocProvider(
      create: (_) => FavoriteSelectCubit(isSelected),
      child: BlocBuilder<FavoriteSelectCubit, bool>(
        builder: (context, isSelect) => IconButton(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(horizontal: 23),
          icon: isSelect
              ? (isAnimated // Проверка на запуск анимации, иначе просто иконка
                  ? const RiveAnimation.asset(
                      'assets/animations/active_heart.riv',
                      alignment: Alignment.topCenter,
                      fit: BoxFit.contain,
                    )
                  : Image.asset('assets/icons/heart_active.png'))
              : Image.asset('assets/icons/heart.png'),
          tooltip: (isSelect ? 'В избранном': 'Избранное'),
          onPressed: () {
            globals.myVariable[index]['is_favorite'] = !isSelect;
            isAnimated = true;
            context.read<FavoriteSelectCubit>().favoriteSelect();
          },
        ),
      ),
    );
  }
}
