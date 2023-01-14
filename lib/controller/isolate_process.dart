import 'dart:isolate';

import 'package:path_provider/path_provider.dart';

import '../widgets/custom_bottom_sheet_file_uploads.dart';
import 'globals.dart';

// Обработка изолятов
class ProcessIsolate {
  Globals globals = Globals();

  ProcessIsolate();

  // Сохранение файла через изолят
  Future<void> saveFileIsolate(int indexComments, indexWidget,
      Map<String, dynamic> params, callBack) async {
    ReceivePort receivePort = ReceivePort();
    final directory = await getApplicationDocumentsDirectory();

    Isolate isolate = await Isolate.spawn(saveFileProcess, [
      directory.path,
      params['photoIcon'],
      params['photoIconName'],
      receivePort.sendPort
    ]);

    receivePort.listen((localPath) {
      globals.myVariable[indexWidget]['comments'][indexComments]['image'] =
          localPath;
      isolate.kill(priority: Isolate.immediate);
      callBack();
    });
  }

  // Процесс работы изолята
  Future<void> saveFileProcess(data) async {
    final customBottomSheet = CustomBottomSheetFileUploads();
    customBottomSheet.addPhotoIcon = data[1];
    customBottomSheet.addIconName = data[2];

    String localPath = await customBottomSheet.saveFile(data[0]);
    Isolate.exit(data[3], localPath);
  }
}
