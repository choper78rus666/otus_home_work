import 'dart:io';
import 'dart:isolate';
import 'package:path_provider/path_provider.dart';

import '../bloc/comments.dart';
import '../configs/recipients.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:home_work/controller/globals.dart';
import 'carousel_slider.dart';
import 'custom_bottom_sheet_file_uploads.dart';

// Отображение и ввод комментариев
class Comments extends StatefulWidget {
  final int index;

  const Comments({super.key, required this.index});

  @override
  State<Comments> createState() => _CommentState();
}

class _CommentState extends State<Comments> {
  final TextEditingController _controller = TextEditingController();
  String photoIcon = '';
  String photoIconName = '';
  File? pathFile;

  CustomBottomSheetFileUploads customBottomSheet = CustomBottomSheetFileUploads();

  @override
  Widget build(BuildContext context) {
    Globals globals = Globals();
    //Прибавляем сохраненное к статитке в конфиге ( потом все будет в БД)
    final viewComments = [];
    final viewImages = [];

    if (recipeList[widget.index]['comments'] != null) {
      recipeList[widget.index]['comments'].forEach((value) {
        viewComments.add(value);
      });
    }

    globals.myVariable[widget.index]['comments'].forEach((value) {
      viewComments.add(value);
    });

    if (viewComments.isNotEmpty) {
      for (var element in viewComments) {
        if (element['image'].toString().isNotEmpty) {
          viewImages.add(element['image']);
        }
      }
    }

    return Column(
      children: [
        Row(children: [
          if (viewImages.isNotEmpty)
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: CarouselSliderImage(imagesList: viewImages),
              ),
            )
        ]),
        //TODO: Отзывы - перенести в отдельный виждет
        Column(children: [
          ...(viewComments
              .map((value) => Column(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF797676), width: 1),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          value['avatar'].toString().isEmpty ? 'assets/images/no_image.png' : value['avatar'],
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  padding: const EdgeInsets.only(top: 12, bottom: 48),
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
        if (customBottomSheet.photoIcon.isNotEmpty)
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Image.file(
              File(customBottomSheet.photoIcon),
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
                      if (customBottomSheet.photoIcon.isNotEmpty) {
                        // Ставим заглушку на время загрузки файла
                        photoIcon = 'assets/images/no_image.png';
                        int indexComments = globals.myVariable[widget.index]['comments'].length;
                        ProcessIsolate(customBottomSheet.photoIcon, customBottomSheet.photoIconName).saveFileIsolate(indexComments, widget.index, () {
                          // Освобождаем временный файл
                          customBottomSheet.addPhotoIcon = '';
                          customBottomSheet.addIconName = '';
                          context.read<CommentsFileUploadCubit>().changeState();
                        });
                        //viewImages.add(photoIcon);
                      }
                      Map<String, String> addComment = {
                        'date': '$day.$month.${currentDay.year}',
                        'name': globals.data['auth']['user_name'],
                        'text': text,
                        'image': photoIcon,
                        'avatar': 'assets/images/avatar.png',
                      };

                      globals.myVariable[widget.index]['comments'].add(addComment);

                      // Освобождаем временный файл
                      photoIcon = '';
                      photoIconName = '';
                      _controller.clear();
                      //viewComments.add(addComment);

                      //Прибавляем сохраненное к статитке в конфиге ( потом все будет в БД)
                      //if (!mounted) return;
                      context.read<CommentsFileUploadCubit>().changeState();
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
                  onPressed: () => customBottomSheet.showSheet(context, mounted),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomObject {
  String photoIcon;
  String photoIconName;
  SendPort sendPort;

  CustomObject(this.photoIcon, this.photoIconName, this.sendPort);
}

class ProcessIsolate {

  String photoIcon;
  String photoIconName;
  Globals globals = Globals();

  ProcessIsolate(this.photoIcon, this.photoIconName);

  // Сохранение файла через изолят
  Future<void> saveFileIsolate(int indexComments, indexWidget, callBack) async {

    ReceivePort receivePort = ReceivePort();
    final directory = await getApplicationDocumentsDirectory();

    Isolate isolate = await Isolate.spawn(saveFileProcess, [directory.path, photoIcon, photoIconName, receivePort.sendPort]);

    receivePort.listen((localPath) {
      print(localPath);
      globals.myVariable[indexWidget]['comments'][indexComments]['image'] = localPath;
      isolate.kill(priority: Isolate.immediate);
      callBack();
    });
  }


}
// Процесс работы изолята
void saveFileProcess(data) async {
  final customBottomSheet = CustomBottomSheetFileUploads();
  customBottomSheet.addPhotoIcon = data[1];
  customBottomSheet.addIconName = data[2];
  print(customBottomSheet.photoIcon);
  print(customBottomSheet.photoIconName);

  String localPath = await customBottomSheet.saveFile(data[0]);
  Isolate.exit(data[3], localPath);
  //data[2].send(localPath);
}