import 'package:dio/dio.dart';

class DioManager {
  dynamic dio;

  DioManager() {
    dio = Dio();
    dio.options.baseUrl = "http://foodapi.dzolotov.tech/";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
  }

  getHttp(String path, {String method = 'GET'}) async {
    Response<dynamic>? response;
    try {
      response = await dio.request(
        path,
        options: Options(
          method: method,
          responseType: ResponseType.json,
        ),
      );

    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }

    return response;
  }
}
