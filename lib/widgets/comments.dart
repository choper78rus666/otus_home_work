import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../configs/recipients.dart';
import 'package:flutter/material.dart';
import 'package:home_work/controller/globals.dart';

// Отображение и ввод комментариев
class Comments extends StatefulWidget {
  final int index;
  String photoIcon = '';
  String photoIconName = '';
  File? pathFile;

  Comments({super.key, required this.index});

  @override
  State<Comments> createState() => _CommentState();
}

class _CommentState extends State<Comments> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Globals globals = Globals();
    //Прибавляем сохраненное к статитке в конфиге ( потом все будет в БД)
    final viewComments = [];

    if (recipeList[widget.index]['comments'] != null) {
      recipeList[widget.index]['comments'].forEach((value) {
        viewComments.add(value);
      });
    }

    globals.myVariable[widget.index]['comments'].forEach((value) {
      viewComments.add(value);
    });

    return Column(
      children: [
        //TODO: Отзывы - перенести в отдельный виждет
        Column(children: [
          ...(viewComments
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              if (value['image'].toString().isNotEmpty)
                                Container(
                                  //alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 48),
                                  child: (value['image'].contains('assets')
                                      ? Image.asset(
                                          value['image'],
                                          fit: BoxFit.contain,
                                          width: 700,
                                        )
                                      : Image.file(
                                          File(value['image']),
                                          fit: BoxFit.contain,
                                          width: 700, // Максимально ширина
                                          height: 150,
                                        )),
                                ),
                              if (value['image'].toString().isEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(top: 48),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ]))
              .toList())
        ]),
        if (widget.photoIcon.isNotEmpty)
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Image.file(
              File(widget.photoIcon),
              fit: BoxFit.contain,
              height: 200,
              width: 300,
            ),
          ),
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
              Expanded(
                child: TextField(
                  controller: _controller,
                  onSubmitted: (text) async {
                    if (text.isNotEmpty) {
                      var currentDay = DateTime.now();
                      var day = currentDay.day.toString().padLeft(2, '0');
                      var month = currentDay.month.toString().padLeft(2, '0');

                      // Сохраним локально файл
                      if (widget.photoIcon.isNotEmpty) {
                        widget.photoIcon = await saveFile(
                            widget.photoIcon, widget.photoIconName);
                      }

                      Map<String, String> addComment = {
                        'date': '$day.$month.${currentDay.year}',
                        'name': 'this user name',
                        'text': text,
                        'image': widget.photoIcon,
                        'avatar': 'assets/images/avatar.png',
                      };

                      globals.myVariable[widget.index]['comments']
                          .add(addComment);
                      setState(() {
                        // Освобождаем временный файл
                        widget.photoIcon = '';
                        widget.photoIconName = '';
                        _controller.clear();
                      });
                    }
                  },
                  minLines: 2,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.light,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                    filled: false,
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
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: const Color(0x00000000),
                    context: context,
                    builder: (BuildContext context) => Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFC6C6C6),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(
                                  top: 22,
                                  bottom: 22,
                                ),
                              ),
                              child: const Text(
                                'Сфотографировать',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () async {
                                var photo = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);

                                if (photo == null) return;

                                if (photo.path.isNotEmpty) {
                                  setState(() {
                                    widget.photoIcon = (photo.path).toString();
                                    widget.photoIconName =
                                        (photo.name).toString();
                                    Navigator.pop(context);
                                  });
                                }
                              },
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFC6C6C6),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(
                                  top: 22,
                                  bottom: 22,
                                ),
                              ),
                              child: const Text(
                                'Выбрать из альбома',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () async {
                                var photo = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (photo == null) return;

                                if (photo.path.isNotEmpty) {
                                  setState(() {
                                    widget.photoIcon = (photo.path).toString();
                                    widget.photoIconName =
                                        (photo.name).toString();
                                    Navigator.pop(context);
                                  });
                                }
                              },
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(
                                top: 22,
                                bottom: 22,
                              ),
                            ),
                            child: const Text(
                              'Удалить',
                              style: TextStyle(
                                color: Color(0xFFF54848),
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                widget.photoIcon = '';
                                Navigator.pop(context);
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 36,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 30.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF0EEEE),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 12,
                                  ),
                                ),
                                child: const Text(
                                  'Отмена',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Сохранение вреименного файла в память
  saveFile(filePath, fileName) async {
    String pathFile = '';
    File file = File(filePath);

    if (await file.exists()) {
      final Directory directory = await getApplicationDocumentsDirectory();
      file.copy('${directory.path}/$fileName');
      pathFile = '${directory.path}/$fileName';
    }

    return pathFile;
  }
}
