// Кастомный BottomSheet с загрузкой файлов
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../bloc/comments.dart';

class CustomBottomSheetFileUploads {
  String _photoIcon = '';
  String _photoIconName = '';

  CustomBottomSheetFileUploads();

  showSheet(BuildContext context2, mounted) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color(0x00000000),
      context: context2,
      builder: (BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
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
                  var photo =
                      await ImagePicker().pickImage(source: ImageSource.camera);

                  if (photo == null) return;

                  if (photo.path.isNotEmpty) {
                    _photoIcon = (photo.path).toString();
                    _photoIconName = (photo.name).toString();
                  }
                  if (!mounted) return;
                  context2.read<CommentsFileUploadCubit>().changeState();
                  context.router.pop(context2);
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
                    _photoIcon = (photo.path).toString();
                    _photoIconName = (photo.name).toString();

                    if (!mounted) return;
                    context2.read<CommentsFileUploadCubit>().changeState();
                    context.router.pop(context2);
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
                _photoIcon = '';
                if (!mounted) return;
                context2.read<CommentsFileUploadCubit>().changeState();
                context.router.pop(context2);
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
                  onPressed: () => context.router.pop(context2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Сохранение вреименного файла в память
  saveFile() async {
    String pathFile = '';
    File file = File(_photoIcon);

    if (await file.exists()) {
      final Directory directory = await getApplicationDocumentsDirectory();
      file.copy('${directory.path}/$_photoIconName');
      pathFile = '${directory.path}/$_photoIconName';
    }
    addPhotoIcon = '';
    addIconName = '';

    return pathFile;
  }

  set addPhotoIcon(String val) => _photoIcon = val;

  set addIconName(String val) => _photoIconName = val;

  get photoIcon => _photoIcon;

  get photoIconName => _photoIconName;
}
