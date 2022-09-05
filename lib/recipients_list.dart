import 'package:flutter/material.dart';
import 'configs/recipients.dart';
import 'package:home_work/helpers.dart';

// Вывод списка рецептов
class RecipeList extends StatelessWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildList(context));
  }

  Widget _buildList(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 68.0, horizontal: 16.0),
          itemCount: recipientsList.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildCard(index);
          }),
    );
  }

  // Формирование карточки
  Widget _buildCard(index) {
    return Card(
      elevation: 10.0,
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
                recipientsList[index]['imagePath'].toString().isEmpty ? 'assets/images/no_image.png' : recipientsList[index]['imagePath'],
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
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
                        Padding(
                          padding: const EdgeInsets.only(left: 11.0),
                          child: Text(
                            timeToString(recipientsList[index]['time'] ?? 0),
                            style: const TextStyle(
                              color: Color(0xff2ECC71),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
