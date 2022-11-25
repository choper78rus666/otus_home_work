import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_work/widgets/comments.dart';
import 'package:home_work/widgets/favorite.dart';

import '../configs/recipients.dart';
import '../controller/globals.dart';
import 'execution_steps.dart';
import 'helpers.dart';

// Основная карточка рецепта

class RecipeDetailPage extends StatelessWidget {
  final int? index;
  final Globals globals = Globals();

  RecipeDetailPage({Key? key, this.index}) : super(key: key);

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
    final recipeKeys = globals.data['recipeList'].keys.toList();

    return SafeArea(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 38),
          children: [
            // Заголовок + избранное
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    globals.data['recipeList'][recipeKeys[index]].name ?? '',
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
              height: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.access_time,
                    key: UniqueKey(),
                    size: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: Text(
                      timeToString(globals.data['recipeList'][recipeKeys[index]].duration ?? 0),
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
            // Картинка рецепта основная
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                // кешируем картинки
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: 220,
                  key: key,
                  imageUrl: globals.data['recipeList'][recipeKeys[index]].photo,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/no_image.png',
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
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
              // TODO: список ингредиентов вынести в отдельный виджет
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...(globals.data['recipeList'][recipeKeys[index]].recipeIngredients.isNotEmpty
                      ? [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...(globals.data['recipeList'][recipeKeys[index]].recipeIngredients
                                  .map(
                                    (value) => SizedBox(
                                      height: 27,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '\u2022',
                                            style: TextStyle(
                                              letterSpacing: 5,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            globals.data['ingredientList'][value.id].name,
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
                              ...(globals.data['recipeList'][recipeKeys[index]].recipeIngredients.map(
                                (value) => SizedBox(
                                  height: 27,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        value['count'] == ''
                                            ? 'по вкусу'
                                            : convertNumString(value.count, [
                                                globals.data['measureUnitList'][globals.data['ingredientList'][value.id].measureUnit['id']].one,
                                                globals.data['measureUnitList'][globals.data['ingredientList'][value.id].measureUnit['id']].few,
                                                globals.data['measureUnitList'][globals.data['ingredientList'][value.id].measureUnit['id']].many
                                              ]),
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
            //TODO: Кнопка проверки наличия - вынести со списком ингредиентов в отдельный стетфул
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 232,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                        color: const Color(0xFF165932),
                        width: 3,
                      ),
                    ),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const StadiumBorder()),
                        minimumSize: MaterialStateProperty.all(const Size(232, 48)),
                      ),
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
            ),
            // Шаги приготовления
            if (recipeList[index]['steps'] != null) ...[
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
              StartProcess(index: index)
            ],
            Comments(index: index),
          ],
        ),
      ),
    );
  }
}
