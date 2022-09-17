import 'package:flutter/material.dart';
import 'configs/recipients.dart';
import 'package:home_work/helpers.dart';

// Виджет карточки в списке рецептов
class RecipeCard extends StatelessWidget {
  final String typeCard;
  final int index;

  const RecipeCard({Key? key, this.typeCard = 'recipeList', this.index = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCard();
  }

  // Формирование карточки
  Widget _buildCard() {
    return GestureDetector(
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
                child: Image.asset(
                  recipientsList[index]['imagePath'].toString().isEmpty
                      ? 'assets/images/no_image.png'
                      : recipientsList[index]['imagePath'],
                  fit: BoxFit.fill,
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
                          recipientsList[index]['title'] ?? '',
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
                                timeToString(
                                    recipientsList[index]['time'] ?? 0),
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
      onTap: () => debugPrint('open $index'),
    );
  }
}
