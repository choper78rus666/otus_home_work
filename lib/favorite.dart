import 'package:flutter/material.dart';
import 'package:home_work/globals.dart';

// Виджет добавления в избранное
class Favorite extends StatefulWidget {
  final int index;

  const Favorite({super.key, required this.index});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    Globals globals = Globals();
    _isSelected = globals.myVariable[widget.index]['is_favorite'] ?? false;

    return IconButton(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 23),
      icon: Image.asset(_isSelected
          ? 'assets/icons/heart_active.png'
          : 'assets/icons/heart.png'),
      tooltip: 'Избранное',
      onPressed: () {
        globals.myVariable[widget.index]['is_favorite'] = !_isSelected;
        setState(() {});
      },
    );
  }
}
