import 'package:flutter/material.dart';
import 'package:home_work/controller/globals.dart';
import 'package:rive/rive.dart';

// Виджет добавления в избранное
class Favorite extends StatefulWidget {
  final int index;

  const Favorite({super.key, required this.index});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool _isSelected = false;
  bool _isAnimated = false;

  @override
  Widget build(BuildContext context) {
    Globals globals = Globals();
    _isSelected = globals.myVariable[widget.index]['is_favorite'] ?? false;

    return IconButton(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 23),
      icon: _isSelected
          ? (_isAnimated // Проверка на запуск анимации, иначе просто иконка
              ? const RiveAnimation.asset(
                  'assets/animations/active_heart.riv',
                  alignment: Alignment.topCenter,
                  fit: BoxFit.contain,
                )
              : Image.asset('assets/icons/heart_active.png'))
          : Image.asset('assets/icons/heart.png'),
      tooltip: 'Избранное',
      onPressed: () {
        globals.myVariable[widget.index]['is_favorite'] = !_isSelected;
        setState(() {
          _isAnimated = true;
        });
      },
    );
  }
}
