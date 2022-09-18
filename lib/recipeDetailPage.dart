import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_work/helpers.dart';
import 'configs/recipients.dart';

class RecipeDetailPage extends StatelessWidget {
  final int? index;

  const RecipeDetailPage({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        foregroundColor: CupertinoColors.black,
        backgroundColor: CupertinoColors.white,
        leading: IconButton(
          padding: const EdgeInsets.all(17.0),
          icon: Image.asset('assets/icons/back.png', width: 24),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          tooltip: 'Назад',
        ),
        title: const Text(
          'Рецепт',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF165932),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            padding: const EdgeInsets.all(17.0),
            icon: Image.asset('assets/icons/megaphone.png'),
            tooltip: 'Рекомендовать',
            onPressed: () {},
          ),
        ],
      ),
      body: _buildDetail(context, index),
    );
  }

  Widget _buildDetail(BuildContext context, index) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              recipeList[index]['title'] ?? '',
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                height: 1,
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    key: UniqueKey(),
                    size: 16.0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: Text(
                      timeToString(recipeList[index]['time'] ?? 0),
                      style: const TextStyle(
                        color: Color(0xff2ECC71),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
