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
    MyService myService = MyService();
    _isSelected = myService.myVariable[widget.index]['is_favorite'] ?? false;

    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      icon: Image.asset(_isSelected
          ? 'assets/icons/heart_active.png'
          : 'assets/icons/heart.png'),
      tooltip: 'Избранное',
      onPressed: () {
        myService.myVariable[widget.index]['is_favorite'] = !_isSelected;
        setState(() {});
      },
    );
  }
}
