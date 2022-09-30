import 'configs/recipients.dart';
import 'package:flutter/material.dart';

// Отображение и ввод комментариев
class Comments extends StatefulWidget {
  final int index;

  const Comments({super.key, required this.index});

  @override
  State<Comments> createState() => _CommentState();
}

class _CommentState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TODO: Отзывы - перенести в отдельный виждет
        Column(children: [
          ...(recipeList[widget.index]['comments'] == null
              ? []
              : recipeList[widget.index]['comments']
                  .map((value) => Column(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF797676), width: 1),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              value['avatar'].toString().isEmpty
                                  ? 'assets/images/no_image.png'
                                  : value['avatar'],
                              height: 63,
                              width: 80,
                              fit: BoxFit.contain,
                              alignment: Alignment.topLeft,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          (value['name'] ?? ''),
                                          style: const TextStyle(
                                            color: Color(0xFF2ECC71),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          (value['date'] ?? ''),
                                          style: const TextStyle(
                                            color: Color(0xFFC2C2C2),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    (value['text'] ?? ''),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Container(
                                    //alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 48),
                                    child: Image.asset(
                                      value['image'].toString().isEmpty
                                          ? 'assets/images/no_image.png'
                                          : value['image'],
                                      fit: BoxFit.contain,
                                      width:
                                          700, // Максимально растягиваемая ширина
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ]))
                  .toList())
        ]),
        // Ввод коментария
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              color: const Color(0xFF165932),
              width: 3,
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  minLines: 2,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.light,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                    filled: false,
                    isDense: true,
                    hintText: 'оставить комментарий',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFC2C2C2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                child: IconButton(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 0),
                  icon: Image.asset(
                    'assets/icons/image_downloads.png',
                    width: 24,
                    height: 19,
                    fit: BoxFit.contain,
                  ),
                  tooltip: 'Загрузить фото',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
