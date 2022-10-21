import 'package:flutter/material.dart';
import 'package:home_work/controller/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'helpers.dart';

// Виджет карточки в списке рецептов
class RecipeCard extends StatelessWidget {
  final Globals globals = Globals();
  final String typeCard;
  final int index;

  RecipeCard({Key? key, this.typeCard = 'recipeList', this.index = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCard(context);
  }

  // Формирование карточки
  Widget _buildCard(BuildContext context) {
    final recipeKeys = globals.data['recipeList'].keys.toList();

    // клик для дальнейшего перехода в карточку
    return recipeKeys.isEmpty
        ? const Text('')
        : GestureDetector(
            key: key,
            child: Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              child: SizedBox(
                height: 136,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 149,
                      height: 136,
                      // кешируем картинки
                      child: CachedNetworkImage(
                        imageUrl:
                            globals.data['recipeList'][recipeKeys[index]].photo,
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
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16.0, 30, 23, 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 52,
                              child: Text(
                                globals.data['recipeList'][recipeKeys[index]]
                                        .name ??
                                    '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 22,
                                  height: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                                softWrap: true,
                              ),
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
                                      timeToString(globals
                                              .data['recipeList']
                                                  [recipeKeys[index]]
                                              .duration ??
                                          0),
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
                    ),
                  ],
                ),
              ),
            ),
            // Навигация для перехода в карточку
            onTap: () => Navigator.pushNamed(
              context,
              '/recipe-detail/$index',
            ),
          );
  }
}
