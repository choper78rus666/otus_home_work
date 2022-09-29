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
        Container(
          //padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              color: const Color(0xFF165932),
              width: 3,
            ),
          ),
          // список комментариев
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
                  icon: Image.asset('assets/icons/image_downloads.png',width: 24,height: 19, fit: BoxFit.contain,),
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
