import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_work/helpers.dart';
import 'package:home_work/favorite.dart';
import 'package:home_work/executionSteps.dart';
import 'package:home_work/comments.dart';
import 'configs/recipients.dart';
import 'configs/ingredients.dart';
import 'globals.dart';

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
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                  ),
                ),
                // Избранное
                Favorite(index: index),
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  recipeList[index]['imagePaths']['detail'].toString().isEmpty
                      ? 'assets/images/no_image.png'
                      : recipeList[index]['imagePaths']['detail'],
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 3, 0, 18),
              child: Text(
                'Ингредиенты',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF165932),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: const Color(0XFF797676),
                  width: 3,
                ),
              ),
              // список ингредиентов
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...(recipeList[index]['ingredientsList'] != null
                      ? [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...(recipeList[index]['ingredientsList']
                                  .map(
                                    (value) => SizedBox(
                                      height: 27,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '\u2022',
                                            style: TextStyle(
                                              letterSpacing: 5,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            ingredientsList[value['id']],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList())
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...(recipeList[index]['ingredientsList'].map(
                                (value) => SizedBox(
                                  height: 27,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        value['count'] == ''
                                            ? 'по вкусу'
                                            : value['count'],
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF797676),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )).toList()
                            ],
                          ),
                        ]
                      : [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text('Ингредиенты отсутствуют'),
                          ),
                        ]),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              // child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 232,
                    height: 48,
                    //padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                        color: const Color(0xFF165932),
                        width: 3,
                      ),
                    ),
                    // список ингредиентов
                    child: OutlinedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const StadiumBorder()),
                          minimumSize:
                              MaterialStateProperty.all(const Size(232, 48))),
                      child: const Text(
                        "Проверить наличие",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF165932),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        debugPrint("Clicked!!!");
                      },
                    ),
                  ),
                ],
              ),
              // ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 18),
              child: Text(
                'Шаги приготовления',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF165932),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Шаги приготовления - чекбоксы - Начать готовить
            StartProcess(index: index),
            Comments(index: index),
            const Text('end')
          ],
        ),
      ),
    );
  }
}
