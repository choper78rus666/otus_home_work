import 'package:dio/dio.dart';

Future<void> getHttp() async {
  try {
    var dio = Dio();
    var response = await dio.get('http://foodapi.dzolotov.tech/recipe');
    print(response);
  } catch (e) {
    print(e);
  }
}