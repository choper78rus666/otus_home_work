import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_work/helpers.dart';
import 'configs/recipients.dart';
import 'configs/ingredients.dart';

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
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 38),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    recipeList[index]['title'] ?? '',
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  icon: Image.asset('assets/icons/heart.png'),
                  tooltip: 'Избранное',
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: 32,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Image.asset(
                recipeList[index]['imagePaths']['detail'].toString().isEmpty
                    ? 'assets/images/no_image.png'
                    : recipeList[index]['imagePaths']['detail'],
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(3, 0, 0, 18),
              child: Text(
                'Ингредиенты',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF165932),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: const Color(0XFF797676),
                  width: 3,
                ),
              ),
              // список ингредиентов
              child: Column(
                children: [
                  ...(recipeList[index]['ingredientsList'] != null
                      ? recipeList[index]['ingredientsList']
                          .map(
                            (value) => ListTile(minLeadingWidth:5,
                              leading: const Text('\u2022',style: TextStyle(
                                fontSize: 24,
                              ),),
                              title: Text( ingredientsList[value['id']], style:
                              const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,),),
                               trailing: Text(value['count'] == ''
                                  ? 'по вкусу'
                                  : value['count']),
                            ),
                          )
                          .toList()
                      : [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Ингредиенты отсутствуют'
                            ),
                          ),
                        ])
                ],
              ),
            ),
            const Text('end')
          ],
        ),
      ),
    );
  }
}
